import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "../comon/MyTitle.dart";
class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar: AppBar(toolbarHeight: 211,shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),backgroundColor: Color(0xFF00651F),title: Column(
       children: [
         Container(margin: EdgeInsets.only(right: 120,bottom: 70),child: MyTitle(text: "Dashboard"),),
         Row(children: [],)
       ],
     ),),
    );
  }
}