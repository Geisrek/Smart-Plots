

import 'package:flutter/material.dart';
import './HistoryItem.dart';
import './AppBar.dart';
import './Controle.dart';
class TasksScreen extends StatelessWidget  {
  const TasksScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    const color=Color(0xFFD9D9D9);
    return Scaffold(
      appBar: MyBar(Title: "Tasks",).MyAppBarr(),
      body: Container(margin: EdgeInsets.all(5),child:Column(children: [ Stack(children:[Container(
        height: 400,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,child:  Column(children: [
              Infos(C: "12", EC: "12", Date: "12", Lux: "12", PH: "12",color:color ,),
              Infos(C: "12", EC: "12", Date: "12", Lux: "12", PH: "12",color:color ,),
              Infos(C: "12", EC: "12", Date: "12", Lux: "12", PH: "12",color:color ,),
              Infos(C: "12", EC: "12", Date: "12", Lux: "12", PH: "12",color:color ,)],)),
      ),
     Positioned(
     
      top:800
      ,
      left: 0,
      right: 0,
      child: Controle(),
    )])
            ])),

    );
  }
}

class Infos extends HistoryItem{
 
  Infos({required super.C,required super.EC, required super.Date,required super.Lux,required super.PH,super.color});
  
  @override
  Widget build(BuildContext context){
   return Container( 
    margin: EdgeInsets.only(top: 5,bottom: 5),
    decoration: BoxDecoration(color:this.color,borderRadius: BorderRadius.circular(7)),
   child:  Column(
    children: [
      super.build(context),
      Row(children:[SizedBox(width: 260,),
      ElevatedButton(onPressed: (){}, child: Text("Cansel",style: TextStyle(fontFamily: 'Nunito',fontSize: 12),))])
    ],
      ));
  }
  
}