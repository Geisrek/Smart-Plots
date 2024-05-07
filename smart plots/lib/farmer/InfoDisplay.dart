import 'package:Smart_pluts/comon/MyText.dart';
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
      margin: EdgeInsets.only(bottom: 5,top: 1),
      width: 350,
      height: 58,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),border: Border.all(width: 1.0)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center,children: [SizedBox(width: 5,),Container(height: 30,width:30,child: SvgPicture.asset(widget.path)),SizedBox(width: 10,),MyText(text: widget.label),Expanded(child: SizedBox(width: 200,)),MyText(text: widget.value),SizedBox(width: 10,),MyText(text: widget.unit)],),
      );
  }
}