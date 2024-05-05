import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Button extends StatelessWidget {
  final onPress;
  final text;
  const Button({super.key,required this.onPress,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.only(bottom: 7),height: 48,width: 350,child:  ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0,backgroundColor: Color(0x0000)),onPressed: this.onPress,child: Text(this.text,style: TextStyle(fontSize: 16,fontFamily: 'Nunito',fontWeight: FontWeight.w100,color: Colors.black ),)),decoration: BoxDecoration(color: Color(0xFFDEDEDE),borderRadius: BorderRadius.circular(7)),);
  }
}