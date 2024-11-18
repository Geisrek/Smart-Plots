import 'package:Smart_pluts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
class Controle extends StatelessWidget {
  const Controle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.only(left:12,right: 15,top: 15),
      width: 400
    ,height: 70,
    
    decoration: BoxDecoration(color:Color(0xAAFFAA00),borderRadius: BorderRadius.circular(7),),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    
    children:[
      Container(width: 95,height: 70,child: InkWell(onTap: (){Navigator.of(context).pushReplacementNamed("/dashboard");},child: Column(crossAxisAlignment: CrossAxisAlignment.center,children:[SvgPicture.asset("./images/environment.svg"),SizedBox(height:5),Text("Environment",style:TextStyle(fontSize: 16,fontFamily: 'Nunito'))],),))
      ,Container(padding: EdgeInsets.only(left: 5),width: 95,height: 70,child: InkWell(onTap: (){Navigator.of(context).pushReplacementNamed("/remote");},child: Column(crossAxisAlignment: CrossAxisAlignment.center,children:[SvgPicture.asset("./images/remote.svg"),SizedBox(height:5),Text("Remote",style:TextStyle(fontSize: 16,fontFamily: 'Nunito'))],),)),
      Container(padding: EdgeInsets.only(top: 4),width: 95,height: 70,child: InkWell(onTap: (){Navigator.of(context).pushReplacementNamed("/tasks");},child: Column(crossAxisAlignment: CrossAxisAlignment.center,children:[SvgPicture.asset("./images/tasks.svg"),SizedBox(height:5),Text("Tasks",style:TextStyle(fontSize: 16,fontFamily: 'Nunito'))],),)),
      ]),
    );
  }
}