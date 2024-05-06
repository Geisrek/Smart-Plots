import 'package:flutter/material.dart';
import '../comon/MyTitle.dart';
import './UserType.dart';
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
    Column(children: [SizedBox(height: 30,),UserType(color: Color(0x9900651F))],),),);
  }
}