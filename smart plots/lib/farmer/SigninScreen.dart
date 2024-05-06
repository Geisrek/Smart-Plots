import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../comon/Logo.dart';
import '../comon/TextInputs.dart';
import '../comon/MyTitle.dart';
import '../comon/MyText.dart';
import '../comon/Button.dart';
class SigninScreen extends StatelessWidget {
   SigninScreen({super.key});
  final   email=InputText(text: "Email");
  final  password=PasswordInput();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 200,title: Center(child: Logo(),),),
      body: Container(child: Center(child:
       Column(children:
        <Widget>[
          MyTitle(text: "Welcome back !"),
          MyText(text: "Glad to See you !"),
          SizedBox(height: 20,),
          email,
          SizedBox(height: 20,),
          password,
          SizedBox(height: 20,),
          Button(onPress: (){}, text: "Login"),
          Container(padding: 
          EdgeInsets.only(left: 10,right: 10), margin: EdgeInsets.only(bottom: 25,left: 5),height: 40,child:
            Row(crossAxisAlignment: CrossAxisAlignment.center,children: 
            [Text( "do you want to create an account?",style: TextStyle(fontSize: 16,fontFamily: 'Nunito') ,),
            TextButton(style: TextButton.styleFrom(fixedSize: Size(85, 80)),child: 
            Text("Signup",style:TextStyle(fontSize: 18,color: Colors.black,fontFamily: 'Nunito')),onPressed: (){Navigator.of(context).pushReplacementNamed("/signup");},)],)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:
             [Container(width: 130,child: Divider(thickness: 2,),)
             ,MyText(text: "Signin with"),
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