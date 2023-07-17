import 'package:flutter/material.dart';
import 'package:triyumm_users_app/mainScreens/items_screen.dart';
import 'package:triyumm_users_app/models/menus.dart';
import 'package:triyumm_users_app/models/sellers.dart';


class MenusDesignwidget extends StatefulWidget
{
  Menus? model;
  BuildContext? context;

  MenusDesignwidget({this.model, this.context});

  @override
  _MenusDesignwidgetState createState() => _MenusDesignwidgetState();
}



class _MenusDesignwidgetState extends State<MenusDesignwidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 280,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 220.0,
                width: 320.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 1.0,),
              Text(
                widget.model!.menuTitle!,
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                  fontFamily: "Train",
                ),
              ),
              Text(
                widget.model!.menuInfo!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Divider(
                height: 4,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
