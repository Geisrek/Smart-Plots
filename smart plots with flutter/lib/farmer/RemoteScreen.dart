import 'package:flutter/material.dart';
import "AppBar.dart";
import './Controle.dart';
import './Plot.dart';
import 'package:flutter_svg/flutter_svg.dart';
class RemoteScreen extends StatelessWidget {
  const RemoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBar(Title: "Remote").MyAppBarr(),
      body:Container(width: 400,
      height: 600,
      child: Column(
        children: [
          Container(
            height: 460
            ,width: 390,
            child: Center(
              child: Wrap(
                spacing: 7,
                runSpacing: 7,
                alignment: WrapAlignment.center,
                children: [PlotWidget(name: "fan",id: 0,function: (int id){},path: "images/fan.svg"),
               PlotWidget(name: "Light",id: 0,function: (int id){},path: "images/sun-black.svg"),
                PlotWidget(name: "Water",id: 0,function: (int id){},path: "images/water.svg"),
                 PlotWidget(name: "Tent",id: 0,function: (int id){},path: "images/open.svg"),
                  PlotWidget(name: "spraying",id: 0,function: (int id){},path: "images/steame.svg")],
              ),
            ),
            )
            ,Controle()],),) ,
    );
  }
}