import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../comon/Logo.dart';
import '../comon/TextInputs.dart';
import '../comon/MyTitle.dart';
import '../comon/MyText.dart';
import '../comon/Button.dart';
class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});
   final   userName=InputText(text: "Username",);
  final   email=InputText(text: "Email",);
  final  password=PasswordInput();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      appBar: AppBar(toolbarHeight: 200,title: Center(child: Logo(),),),
      body: Container(padding: EdgeInsets.only(bottom: 10),child: Center(child:
       Column(children:
        <Widget>[
          MyTitle(text: "Welcome back !"),
          MyText(text: "Glad to See you !"),
          SizedBox(height: 20,),
          userName
          ,
          SizedBox(height: 20,),
          email,
          SizedBox(height: 20,),
          password,
          SizedBox(height: 20,),
          Button(onPress: (){Navigator.of(context).pushNamed("/pickuser");}, text: "Login"),
          Container(padding: 
          EdgeInsets.only(left: 10,right: 10), margin: EdgeInsets.only(bottom: 10,left: 10),height: 40,child:
            Row(crossAxisAlignment: CrossAxisAlignment.center,children: 
            [
              Text( "do you want to create an account?",style: TextStyle(fontSize: 16,fontFamily: 'Nunito') ,),
            TextButton(style: TextButton.styleFrom(fixedSize: Size(75, 80)),child: 
            Text("Signin",style:TextStyle(fontSize: 16,color: Colors.black,fontFamily: 'Nunito')),onPressed: (){Navigator.of(context).pushReplacementNamed("/signin");},)],)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:
             [Container(width: 120,child: Divider(thickness: 2,),)
             ,MyText(text: "Sign Up with"),
             Container(width: 120,child: Divider(thickness: 2,),)]),
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