import 'package:flutter/material.dart';
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
     appBar: AppBar(toolbarHeight: 100,backgroundColor: Color(0xFF00651F),title: Column(
       children: [
         Center(child: MyTitle(text: "Dashboard"),),
         Row(children: [],)
       ],
     ),),
    );
  }
}