import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:triyumm_seller_app/authentication/auth_screen.dart';
import 'package:triyumm_seller_app/global/global.dart';
import 'package:triyumm_seller_app/mainScreens/home_screen.dart';
import 'package:triyumm_seller_app/model/menus.dart';
import 'package:triyumm_seller_app/splashScreen/splash_screen.dart';
import 'package:triyumm_seller_app/uploadScreens/menus_upload_screen.dart';
import 'package:triyumm_seller_app/widgets/info_design.dart';
import 'package:triyumm_seller_app/widgets/my_drawer.dart';
import 'package:triyumm_seller_app/widgets/progress_bar.dart';
import 'package:triyumm_seller_app/widgets/text_widget_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen>
{
  restrictBlockedSellersFromUsingApp() async
  {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(firebaseAuth.currentUser!.uid)
        .get().then((snapshot)
    {
      if(snapshot.data()!["status"] != "approved")
      {
        Fluttertoast.showToast(msg: "You have been blocked.");

        firebaseAuth.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
      }
    });
  }

  @override
  void initState() {

    super.initState();
    restrictBlockedSellersFromUsingApp();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.cyan,
                  Colors.amber,
                ],
                begin:  FractionalOffset(0.0, 0.0),
                end:  FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        title: Text(
          sharedPreferences!.getString("name")!,
          style: const TextStyle(fontSize: 30, fontFamily: "Lobster"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.post_add, color: Colors.cyan,),
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder:(c)=> const MenusUploadScreen()));
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true,
              delegate: TextWidgetHeader(title: "My Menus")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(sharedPreferences!.getString("uid"))
                .collection("menus").snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                child: Center(child:
                circularProgress(),),
              )
                  : SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c) =>
                    StaggeredTile.fit(1),
                itemBuilder: (context, index)
                {
                  Menus model = Menus.fromJson(
                    snapshot.data!.docs[index].
                    data()! as Map<String, dynamic>,
                  );
                  return InfoDesignWidget(
                    model: model,
                    context: context,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
