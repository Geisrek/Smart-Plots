import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../comon/Logo.dart';
import '../comon/TextInputs.dart';
class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 200,title: Center(child: Logo(),),),
      body: Container(child: Column(children: <Widget>[InputText(),PasswordInput()],),),
    );
  }
}