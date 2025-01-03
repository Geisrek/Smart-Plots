import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../comon/Button.dart';
import '../comon/TextInputs.dart';
import '../comon/Logo.dart';
import '../comon/MyTitle.dart';
import '../comon/MyText.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar:AppBar(toolbarHeight: 200,title:Container(child:Center(child: Column(children: [Logo(),],)),)),
      body: Container(child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Column(children:<Widget>[MyTitle(text: "Welcome Back"),MyText(text: "Please Enter Your Personal data"),],),Button(onPress:(){
        Navigator.of(context).pushReplacementNamed("/signin");
      }, text:"Get Started"),],),),
    ));
  }
}