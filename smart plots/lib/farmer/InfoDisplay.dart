import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class MyWidget extends StatefulWidget {
  final String unit;
  final String path;
  final String value;
  final String label;
  const MyWidget({super.key,required this.path,required this.label,required this.value,required this.unit});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(width: 350,height: 58,decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Color(0xFFEAEAEA)),);
  }
}