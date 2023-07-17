import 'dart:async';

import 'package:flutter/material.dart';
import 'package:triyumm_riders_app/authentication/auth_screen.dart';
import 'package:triyumm_riders_app/global/global.dart';
import 'package:triyumm_riders_app/mainScreens/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();

}

class _MySplashScreenState extends State<MySplashScreen>
{

  startTimer()
  {
    Timer(const Duration(seconds: 8), () async
    {
      //if seller is logged in already
      if(firebaseAuth.currentUser != null)
      {
         Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
      }
      //if seller is not loggedin already
      else
      {
         Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
      }

    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Image.asset("images/logo.png"),
                 ),

                const SizedBox(height: 10,),

                const Padding(
                  padding:  EdgeInsets.all(18.0),
                  child: Text(
                    "Online Food Delivery App",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontFamily: "Signatra",
                      letterSpacing: 2,
                    ),
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
}
