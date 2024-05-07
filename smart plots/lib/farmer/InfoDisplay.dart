import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class InfoDisplayer extends StatefulWidget {
  final String unit;
  final String path;
  final String value;
  final String label;
  const InfoDisplayer({super.key,required this.path,required this.label,required this.value,required this.unit});

  @override
  State<InfoDisplayer> createState() => _InfoDisplayer();
}

class _InfoDisplayer extends State<InfoDisplayer
> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 58,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),border: Border.all(width: 1.0)),
      child: Row(children: [],),
      );
  }
}