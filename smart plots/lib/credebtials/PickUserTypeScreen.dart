import 'package:flutter/material.dart';
import '../comon/MyTitle.dart';
import './UserType.dart';
import '../comon/Button.dart';
class PickUserType extends StatelessWidget {
  const PickUserType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(toolbarHeight: 80,
    title: Center(child: MyTitle(text: "Pick your user type",)
    ,)
    ,)
    ,
    body: Center(child: 
    Column(children: [SizedBox(height: 30,),UserType(color: Color(0x9900651F),text: "Farmer",path: "./images/farmer-avatar.png",),SizedBox(height: 20,),UserType(color: Color(0x995508D1),text: "Vendor",path: "./images/vendor-avatar.png",),SizedBox(height: 20,),UserType(color: Color(0x99FFAA00),text: "Client",path: "./images/client-avatar.png",),SizedBox(height: 10,),Button(onPress: (){}, text: "Signup")],),),);
  }
}