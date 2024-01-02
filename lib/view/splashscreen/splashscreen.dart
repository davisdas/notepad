import 'package:flutter/material.dart';
import 'package:mynotepad/constant/constant.dart';
import 'package:mynotepad/view/homescreen/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Future.delayed(Duration(seconds:4)).then((value) => 
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => 
    HomeScreen())
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.primarycolor,
      body: Center(child:
       Container(height: 300,width: double.infinity,
       child: Image.asset("assets/notepad.gif"),
       )
       ),
    );
  }
}