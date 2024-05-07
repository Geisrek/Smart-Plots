import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "../comon/MyTitle.dart";
import '../comon/MyText.dart';
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
          child: Row(children: [PlotWidget(path: "./images/plot.svg", name: "plot1", function:updateIndex, id: 0),PlotWidget(path: "./images/plot.svg", name: "plot2", function:updateIndex, id: 1),PlotWidget(path: "./images/plot.svg", name: "plot3", function:updateIndex, id: 2),PlotWidget(path: "./images/plot.svg", name: "plot4", function:updateIndex, id: 2),],))
       ],
     ),),
     body: Container(
      margin:EdgeInsets.only(left: 10,top: 20),
      height: 500,
      width: 340,
      decoration: BoxDecoration(color: Color(0xFFDEDEDE),borderRadius: BorderRadius.circular(7)),
      child:Column(
        children: [
          Row(
            children: [SizedBox(width: 300,),Container(height: 40,width: 40,decoration: BoxDecoration(color: const Color.fromARGB(255, 54, 53, 53)),child: Text("icon"),)],),
            Row(children: [Container(margin: EdgeInsets.only(left: 10),child: MyText(text: "Plot 1"),),
            ],),
            SizedBox(height: 5,)
            ,
            Container(margin: EdgeInsets.only(left: 40),child: Container(width: 170,child: MyText(text: "Ai recomandation",),),)
        ],
        
      )
     ,),
    );
  }
}