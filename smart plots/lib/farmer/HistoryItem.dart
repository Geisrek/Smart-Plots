import 'package:flutter/material.dart';
import '../comon/MyText.dart';
import "../comon/MyText.dart";
import "../comon/MyTitle.dart";
class HistoryItem extends StatelessWidget {
  final String Date;
  final String EC;
  final String PH;
  final String Lux;
  final String C;
  
  const HistoryItem({super.key,required this.Date,required this.EC,required this.PH,required this.Lux, required this.C});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(7))
      ,
      child:  Column(
        
        children: [
          Text(this.Date,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
          ,Row(children:[MyText(text: "EC="+this.EC,),MyText(text: "PH="+this.PH)]),
          Row(children: [MyText(text: "C="+this.C),MyText(text: "Lux="+this.Lux)],)],
      ),
    );
  }
}