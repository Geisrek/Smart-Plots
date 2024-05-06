import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  final String text;
  final color;
  const MyTitle({super.key,required this.text, this.color=Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(this.text,style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold,color: this.color),overflow: TextOverflow.visible,softWrap: true,textAlign: TextAlign.center,);
  }
}