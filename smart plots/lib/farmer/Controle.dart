import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 300
    ,height: 70,
    child: Row(crossAxisAlignment: CrossAxisAlignment.center,
    children:[
      InkWell(onTap: (){},child: Column(crossAxisAlignment: CrossAxisAlignment.center,children:[SvgPicture.asset("./images/invironment.svg"),SizedBox(height:5),Text("environment",style:TextStyle(fontSize: 16,fontFamily: 'Nunito'))],),)]),
    );
  }
}