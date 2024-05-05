import 'package:flutter/material.dart';
import '../comon/Button.dart';
import '../comon/TextInputs.dart';
import '../comon/Logo.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(toolbarHeight: 200,title:Container(child:Center(child: Column(children: [Logo(),],)),)),
      body: Container(child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Column(children:<Widget>[Text("Welcome Back",style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold),),Text("Please Enter Your Personal data",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,fontFamily: 'Nunito'))],),Button(onPress:(){
        Navigator.of(context).pushNamed("/signin");
      }, text:"Get Started"),],),),
    ));
  }
}