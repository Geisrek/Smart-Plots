import 'package:flutter/material.dart';
import '../comon/MyTitle.dart';
import './HistoryItem.dart';
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: MyTitle(text: "History"),
        ),
      ),
      body: Container(height: 600
      ,width: 400,
      decoration: BoxDecoration(color: Color(0xFFD9D9D9),borderRadius: BorderRadius.circular(
        7
      ))
      ,padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(top: 40,right: 5,left: 5)
      ,
      child:  SingleChildScrollView(
          scrollDirection: Axis.vertical,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center
        ,children: [
          Container(margin: EdgeInsets.only(right: 250),child: MyTitle(text: "Plot 1")),
          HistoryItem(Date: "11/3/2015", EC: "10", PH: "12", Lux: "100", C: "24"),
           HistoryItem(Date: "11/4/2015", EC: "20", PH: "5", Lux: "100", C: "24"),
           HistoryItem(Date: "11/3/2015", EC: "10", PH: "12", Lux: "100", C: "24"),
           HistoryItem(Date: "11/4/2015", EC: "20", PH: "5", Lux: "100", C: "24"),
        ],),
      ),
      ),
    );
  }
}