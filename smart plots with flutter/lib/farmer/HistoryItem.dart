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
  final Color color;
  final int id;
 
  const HistoryItem({super.key,required this.id,required this.Date,required this.EC,required this.PH,required this.Lux, required this.C,this.color=Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 70,
      
      decoration:BoxDecoration(border: Border(left: BorderSide(
                            color: Color(0xFF00651F),
                            width: 40
                          ),),color: Color.fromARGB(99, 200, 255, 0),borderRadius: BorderRadius.circular(7),),
      margin: EdgeInsets.only(top: 10,bottom: 10),
      padding: EdgeInsets.all(5),
      
    
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        
        children: [
          Text(this.Date,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
          ,Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:[MyText(text: "EC="+this.EC,),MyText(text: "PH="+this.PH),
         MyText(text: "C="+this.C),MyText(text: "Lux="+this.Lux)],)],
      ),
    );
  }
}
