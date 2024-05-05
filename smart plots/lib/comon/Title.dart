import 'package:flutter/material.dart';

class Title extends StatelessWidget {
  final String text;
  const Title({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Text("Welcome Back",style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold));
  }
}