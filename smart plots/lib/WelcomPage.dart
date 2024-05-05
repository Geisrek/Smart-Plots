import 'package:flutter/material.dart';
import './Button.dart';
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(toolbarHeight: 200,title:Container(child:Center(child: Column(children: [Container(height: 100,child:ClipRRect(
        child:Image.asset("./images/Smartplots.png"),
        
      )),],)),)),
      body: Container(child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Column(children:<Widget>[Text("Welcome Back",style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold),),Text("Please Enter Your Personal data",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,fontFamily: 'Nunito'))],),Button(onPress:(){}, text:"Get Started")],),),
    ));
  }
}