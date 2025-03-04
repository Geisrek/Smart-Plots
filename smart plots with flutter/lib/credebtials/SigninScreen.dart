import 'dart:io';

import 'package:Smart_pluts/constants/constants.dart';
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
    void navigate(id)async{
      
    try{
   dynamic response=await http.post(
      Uri.parse("http://$IP:8000/api/checkUser"),
       headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
       body: jsonEncode({
        'user_id':id
       })
    );
    final user_type=jsonDecode(response.body);
  
    if(user_type["type"]=="farmer"){
      Navigator.of(context).pushReplacementNamed("/dashboard");
    }
    else if(user_type["type"]=="vendor"){
      Navigator.of(context).pushReplacementNamed("/vendor");
    }
    else if(user_type["type"]=="client"){
      Navigator.of(context).pushReplacementNamed("/client");
    }
    }catch(e){
      print("check user error:$e");
    }

  }
    return Scaffold(
      appBar: AppBar(toolbarHeight: 200,title: Center(child: Logo(),),),
      body: Container(child: Center(child:
       Column(children:
        <Widget>[
          MyTitle(text: "Welcome back ",color: Colors.black,),
          MyText(text: "Glad to See you "),
          SizedBox(height: 10,),
          email,
          SizedBox(height: 10,),
          password,
          SizedBox(height: 10,),
          Button(onPress: ()async{
          try{
          final data=await SharedPreferences.getInstance();
          data.remove("credential");
          final token= data.getString('credential');
          if(token==null){
          dynamic response=await http.post(
          
            Uri.parse("http://$IP:8000/api/login"),
             headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email.getText(),
      'password':password.getText()
    }),
           );
           final _data=jsonDecode(response.body);
            if(_data['status']=='success'){
              final info=await SharedPreferences.getInstance();
              info.setString('credential',jsonEncode(_data['authorisation']['token']));
              info.setString('user', jsonEncode(_data['user']));
         //     print('---$token####${jsonEncode(_data['authorisation'])}');
             print(jsonEncode(_data));
             navigate(_data['user']['id']);
            }
            else{
              Navigator.of(context).pushReplacementNamed("/");
            }
         }  else{
             
              dynamic response=await http.post(
          
            Uri.parse("http://$IP:8000/api/login"),
             headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',
            'Authorization': 'Bearer $token'  
        },
   
           );
           final data=jsonDecode(response.body);
           
           
            if(data['status']=='success'){
              print('token exist:$data');
              final preferance=await SharedPreferences.getInstance();
               preferance.setString("user", jsonEncode(data["user"]));
             navigate(data['user']['id']);
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
            Text("Sign Up",style:TextStyle(fontSize: 16,color: Colors.black,fontFamily: 'Nunito')),onPressed: ()async{
              Navigator.of(context).pushReplacementNamed("/signup");
              },)],)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:
             [Container(width: 130,child: Divider(thickness: 2,),)
             ,MyText(text: "Login with"),
             Container(width: 130,child: Divider(thickness: 2,),)]),
             Container(margin: EdgeInsets.only(left: 80,top: 10),child: 
             Row(children:
              [Container(width: 85,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Color(0xFF000000)),child: 
              ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0,backgroundColor: Color(0x0000)),onPressed: (){
                Navigator.of(context).pushReplacementNamed('/profile');
              },child: 
              SvgPicture.asset('./images/google.svg',),),),
              SizedBox(width: 20,),
              Container(width: 85,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Color(0xFF000000)),child:
               ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0,backgroundColor: Color(0x0000)),onPressed: (){ Navigator.of(context).pushReplacementNamed("/dashboard");},child: SvgPicture.asset('./images/facebook.svg',),)
               )
               ],
               )),
               ]))
               ,)
    );
  }
}