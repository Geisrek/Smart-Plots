import 'dart:html';

import 'package:flutter/material.dart';
import './HistoryItem.dart';
import './AppBar.dart';
class TasksScreen extends StatelessWidget  {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBar(Title: "Tasks",).MyAppBarr(),
      body: Column(children: [Infos(C: "12", EC: "12", Date: "12", Lux: "12", PH: "12")],),

    );
  }
}

class Infos extends HistoryItem{
  Infos({required super.C,required super.EC, required super.Date,required super.Lux,required super.PH});
  
  @override
  Widget build(BuildContext context){
   return Container( child:  super.build(context));
  }
  
}