import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/AddScreen.dart';
import 'ViewScreen.dart';

class SplashScreen extends StatefulWidget
{
  const SplashScreen({Key? key,}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
{
  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    Timer(Duration (seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ViewScreen(),
          ));
    });

  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 120.0,
          height:120.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(60.0),
              boxShadow:[
                BoxShadow(
                  color:  Colors.yellow.shade800,
                  spreadRadius: 5.0,
                  blurRadius: 15.0,
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 10.0,),
                 Image.asset("img/logo.png",width: 100.0,height: 100.0,),
              ],
            ),
        ),
      ),
    );
  }
}
