import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../comon/Logo.dart';
import '../comon/TextInputs.dart';
import '../comon/MyTitle.dart';
import '../comon/MyText.dart';
import '../comon/Button.dart';
class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 200,title: Center(child: Logo(),),),
      body: Container(child: Center(child: Column(children: <Widget>[MyTitle(text: "Welcome back !"),MyText(text: "Glad to See you !"),SizedBox(height: 20,),InputText(),SizedBox(height: 20,),PasswordInput(),SizedBox(height: 20,),Button(onPress: (){}, text: "Login")],)),),
    );
  }
}