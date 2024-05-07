import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "../comon/MyTitle.dart";
import 'Plot.dart';
import './Plot.dart';
class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {
  int index=0;
  List data=["yow","bruh","pst"];
  void updateIndex(int i){
    setState(() {
      index=i;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar: AppBar(toolbarHeight: 211,shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),backgroundColor: Color(0xFF00651F),title: Column(
       children: [
         Container(margin: EdgeInsets.only(right: 120,bottom: 70),child: MyTitle(text: "Dashboard",color: Colors.white,),),
         SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [PlotWidget(path: "./images/farmer-avatar.png", name: "plot1", function:updateIndex, id: 2),InkWell(child: Container(height: 60,width: 60,color: Colors.blue,),onTap: ()=>updateIndex(0),),InkWell(child: Container(height: 60,width: 60,color: const Color.fromARGB(255, 243, 75, 33),),onTap: ()=>updateIndex(1),),InkWell(child: Container(height: 60,width: 60,color: const Color.fromARGB(255, 243, 33, 208),),onTap: ()=>updateIndex(2),),],))
       ],
     ),),
     body: Container(
      margin:EdgeInsets.only(left: 10,top: 20),
      height: 500,
      width: 340,
      decoration: BoxDecoration(color: Color(0xFFDEDEDE),borderRadius: BorderRadius.circular(7))
     ,),
    );
  }
}