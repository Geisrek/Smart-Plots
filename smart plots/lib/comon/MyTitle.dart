import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  final String text;
  final color;
  const MyTitle({super.key,required this.text,required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(this.text,style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold,),overflow: TextOverflow.visible,softWrap: true,textAlign: TextAlign.center,);
  }
}