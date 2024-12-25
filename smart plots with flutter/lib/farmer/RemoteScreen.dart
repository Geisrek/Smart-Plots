import 'dart:convert';

import 'package:Smart_pluts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "AppBar.dart";
import './Controle.dart';
import './Plot.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class RemoteScreen extends StatefulWidget {
  const RemoteScreen({super.key});

  @override
  State<RemoteScreen> createState() => _RemoteScreenState();
}

class _RemoteScreenState extends State<RemoteScreen> {
  @override
  void initState(){
    super.initState();
    setPlot();
  }
  Map current_plot={"IP":"0000"};
 Future<void> setPlot()async{
    final infos= await SharedPreferences.getInstance();
    
    setState(() {
      current_plot=jsonDecode(infos.getString("plot")!);
    });
    }

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
                    Uri.parse('http://${current_plot[IP]}/fan'));
                },path: "images/fan.svg"),
               PlotWidget(name: "Light",id: 0,function: (int id){
                 http.get(
                    Uri.parse('http://${current_plot[IP]}/light'));
               },path: "images/sun-black.svg"),
                PlotWidget(name: "Water",id: 0,function: (int id){ http.get(
                    Uri.parse('http://${current_plot[IP]}/water'));},path: "images/water.svg"),
                 PlotWidget(name: "Tent",id: 0,function: (int id){ http.get(
                    Uri.parse('http://${current_plot[IP]}/tent'));},path: "images/open.svg"),
                  PlotWidget(name: "condition",id: 0,function: (int id){
                          http.get(
                    Uri.parse('http://${current_plot[IP]}/condition'));
                  },path: "images/steame.svg")],
              ),
            ),
            )
            ,Controle()],),) ,
    );;
  }
}