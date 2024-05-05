import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Button extends StatelessWidget {
  final onPress;
  final text;
  const Button({super.key,required this.onPress,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(height: 48,width: 350,child:  ElevatedButton(onPressed: this.onPress, child: Text(this.text)),decoration: BoxDecoration(),);
  }
}