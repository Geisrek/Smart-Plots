import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "../comon/MyTitle.dart";
import '../comon/MyText.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Plot.dart';
import './Plot.dart';
import 'InfoDisplay.dart';
import 'Controle.dart';
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
          child: Row(children: [PlotWidget(path: "./images/plot.svg", name: "plot1", function:updateIndex, id: 0),PlotWidget(path: "./images/plot.svg", name: "plot2", function:updateIndex, id: 1),PlotWidget(path: "./images/plot.svg", name: "plot3", function:updateIndex, id: 2),PlotWidget(path: "./images/plot.svg", name: "plot4", function:updateIndex, id: 2),PlotWidget(path: "./images/add.svg", name: "", function:updateIndex, id: 2)],))
       ],
     ),),
     body: Container(
      margin:EdgeInsets.only(left: 10,top: 20),
      height: 500,
      width: 340,
      decoration: BoxDecoration(color: Color(0xFFFFFF),borderRadius: BorderRadius.circular(7)),
      child:Column(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center,
            children: [MyText(text: "Plot 1",color: Color(0xFF00651F)),SizedBox(width: 230,),Container(width: 45,height: 45,child: IconButton(icon: SvgPicture.asset("./images/settings.svg"),onPressed: (){},))],),
          
            
            SizedBox(height: 5,)
            ,
            Container(margin: EdgeInsets.only(left: 10),child: Container(width: 170,child: MyText(text: "Ai recomandation",),),)
            ,SizedBox(height: 20,),Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [MyText(text:"Air humidity"),SizedBox(width: 20,),MyText(text: "Sol humidity")],),)
            ,
            SizedBox(height: 20,)
            ,
            Column(children: [
              InfoDisplayer(path: "./images/soil.svg", label: "EC", value: "123", unit: ""),
               InfoDisplayer(path: "./images/drop.svg", label: "PH", value: "123", unit: "")
              ,
              InfoDisplayer(path: "./images/temperature.svg", label: "Temperature", value: "123", unit: "")
              ,
              InfoDisplayer(path: "./images/sun.svg", label: "light", value: "123", unit: ""),


            ],)
        ],
        
      )
     ,),
    );
  }
}