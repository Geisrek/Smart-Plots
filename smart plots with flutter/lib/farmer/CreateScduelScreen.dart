import 'package:flutter/material.dart';
import 'AppBar.dart';
import '../comon/MyText.dart';
import '../comon/TextInputs.dart';
import '../comon/Button.dart';
class CreateScduelScreen extends StatelessWidget {
  final Yeare=InputText(text: "DD/MM/YYYY",);
  final EC=InputText(text: "",);
  final Water=InputText(text: "",);
  final Temperature=InputText(text: "",);
  final Lux=InputText(text: "",);
  final Air=InputText(text: "",);
   CreateScduelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBar(Title: "Create a new sceduel",).MyAppBarr(),
      body: Container(
        padding: EdgeInsets.only(left: 5,right: 5),
        child: Column(children: [SizedBox(height: 20,),
          Row(children: [MyText(text: "Date"),Expanded(child: SizedBox(width: 40,)),SizedBox(width: 10,),this.Yeare],
          ),
          SizedBox(height: 40,),
          Row(children: [MyText(text: "EC"),Expanded(child: SizedBox(width: 40,)),this.EC]),
          SizedBox(height: 10,),
          Row(children: [MyText(text: "PH"),Expanded(child: SizedBox(width: 40,)),this.Water]),
          SizedBox(height: 10,),
          Row(children: [MyText(text: "C"),Expanded(child: SizedBox(width: 40,)),this.Temperature]),
          
          SizedBox(height: 10,),
          Row(children: [MyText(text: "Lux"),Expanded(child: SizedBox(width: 40,)),this.Temperature]),
          SizedBox(height: 10,),
          Row(children: [MyText(text: "Air"),Expanded(child: SizedBox(width: 40,)),this.Temperature]),
          
          SizedBox(height: 30,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Container(width: 100,child: ElevatedButton(onPressed: (){},child: Text("Save"),),),Container(width: 100,child: ElevatedButton(onPressed: (){},child: Text("Default"),),)],),
        ],),),
    );
  }
}