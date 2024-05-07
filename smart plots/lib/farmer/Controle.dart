import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Controle extends StatelessWidget {
  const Controle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(5),
      width: 400
    ,height: 70,
    decoration: BoxDecoration(color:Color(0xAAFFAA00),borderRadius: BorderRadius.circular(7)),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center,
    children:[
      InkWell(onTap: (){},child: Column(crossAxisAlignment: CrossAxisAlignment.center,children:[SvgPicture.asset("./images/environment.svg"),SizedBox(height:5),Text("environment",style:TextStyle(fontSize: 16,fontFamily: 'Nunito'))],),)]),
    );
  }
}