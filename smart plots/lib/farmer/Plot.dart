import 'package:flutter/material.dart';
import '../comon/MyText.dart';
import 'package:flutter_svg/flutter_svg.dart';
class PlotWidget extends StatelessWidget {
  final String path;
  final String name;
  final int id;
  final function;
  const PlotWidget({super.key,required this.path,required this.name,required this.function,required this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(child: Container(margin: EdgeInsets.only(left: 5),padding: EdgeInsets.all(5),decoration: BoxDecoration(color: Color(0xEEFFAA00),borderRadius: BorderRadius.circular(7)),height: 80,width: 80,child: Column(
      children: [
        Container(height: 45,width: 45,child: SvgPicture.asset(this.path),),Text(this.name,style: TextStyle(fontFamily: 'Nunito',fontSize:16),),
      ],
    ),),onTap: ()=>this.function(this.id),);
  }
}