import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final color;
  const MyText({super.key,required this.text,this.color=Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(this.text,style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,fontFamily: 'Nunito',color: this.color,),textAlign: TextAlign.center,);
  }
}