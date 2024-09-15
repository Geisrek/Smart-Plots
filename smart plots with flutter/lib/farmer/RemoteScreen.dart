import 'package:flutter/material.dart';
import "AppBar.dart";
import './Controle.dart';
import './Plot.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
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
                children: [PlotWidget(name: "fan",id: 0,function: (int id)async{
                   http.get(
                    Uri.parse('http://192.168.1.8/fan'));
                },path: "images/fan.svg"),
               PlotWidget(name: "Light",id: 0,function: (int id){
                 http.get(
                    Uri.parse('http://192.168.1.8/light'));
               },path: "images/sun-black.svg"),
                PlotWidget(name: "Water",id: 0,function: (int id){ http.get(
                    Uri.parse('http://192.168.1.8/water'));},path: "images/water.svg"),
                 PlotWidget(name: "Tent",id: 0,function: (int id){ http.get(
                    Uri.parse('http://192.168.1.8/tent'));},path: "images/open.svg"),
                  PlotWidget(name: "condition",id: 0,function: (int id){
                          http.get(
                    Uri.parse('http://192.168.1.8/condition'));
                  },path: "images/steame.svg")],
              ),
            ),
            )
            ,Controle()],),) ,
    );
  }
}