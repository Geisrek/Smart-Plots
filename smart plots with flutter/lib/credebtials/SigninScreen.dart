import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../comon/Logo.dart';
import '../comon/TextInputs.dart';
import '../comon/MyTitle.dart';
import '../comon/MyText.dart';
import '../comon/Button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SigninScreen extends StatelessWidget {
   SigninScreen({super.key});
   
  final   email=InputText(text: "Email");
  final  password=PasswordInput();
  void setBearer (value) async{
       final data=await SharedPreferences.getInstance();
       data.setString('credential',value);
  }
   getBearer() async{
    final data=await SharedPreferences.getInstance();
    
    return data.getString('credential');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 200,title: Center(child: Logo(),),),
      body: Container(child: Center(child:
       Column(children:
        <Widget>[
          MyTitle(text: "Welcome back ",color: Colors.black,),
          MyText(text: "Glad to See you "),
          SizedBox(height: 20,),
          email,
          SizedBox(height: 20,),
          password,
          SizedBox(height: 20,),
          Button(onPress: ()async{//Navigator.of(context).pushReplacementNamed("/dashboard")
          try{
          final data=await SharedPreferences.getInstance();
    
           final token= data.getString('credential');
           if(token==null){
          dynamic response=await http.post(
          
            Uri.parse("http://192.168.0.100:8000/api/login"),
             headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email.getText(),
      'password':password.getText()
    }),
           );
           final data=jsonDecode(response.body);
           
            if(data['status']=='success'){
              
              final info=await SharedPreferences.getInstance();
              info.setString('credential',data['authorisation']['token']);
              Navigator.of(context).pushReplacementNamed("/dashboard");
            };}
            else{
              print(token);
              dynamic response=await http.post(
          
            Uri.parse("http://192.168.0.100:8000/api/login"),
             headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',
            'Authorization': 'Bearer $token'  
        },
   
           );
           final data=jsonDecode(response.body);
           print('----->$data');
            if(data['status']=='success'){
              Navigator.of(context).pushReplacementNamed("/dashboard");
            };
            }
           }
            catch(err){
              print(err);
            }
            }, text: "Login"),
          Container(padding: 
          EdgeInsets.only(left: 10,right: 10), margin: EdgeInsets.only(bottom: 10,left: 50),height: 40,child:
            Row(crossAxisAlignment: CrossAxisAlignment.center,children: 
            [Text( "Dont have an account?",style: TextStyle(fontSize: 16,fontFamily: 'Nunito') ,),
            TextButton(style: TextButton.styleFrom(fixedSize: Size(90, 80)),child: 
            Text("Sign Up",style:TextStyle(fontSize: 16,color: Colors.black,fontFamily: 'Nunito')),onPressed: (){Navigator.of(context).pushReplacementNamed("/signup");},)],)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:
             [Container(width: 130,child: Divider(thickness: 2,),)
             ,MyText(text: "Login with"),
             Container(width: 130,child: Divider(thickness: 2,),)]),
             Container(margin: EdgeInsets.only(left: 80,top: 10),child: 
             Row(children:
              [Container(width: 85,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Color(0xFF000000)),child: 
              ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0,backgroundColor: Color(0x0000)),onPressed: (){},child: 
              SvgPicture.asset('./images/google.svg',),),),
              SizedBox(width: 20,),
              Container(width: 85,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Color(0xFF000000)),child:
               ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0,backgroundColor: Color(0x0000)),onPressed: (){},child: SvgPicture.asset('./images/facebook.svg',),)
               )
               ],
               )),
               ]))
               ,)
    );
  }
}