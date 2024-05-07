import 'package:flutter/material.dart';
import '../comon/MyText.dart';
class MyWidget extends StatelessWidget {
  final String path;
  final String name;
  final int id;
  final function;
  const MyWidget({super.key,required this.path,required this.name,required this.function,required this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(child: Container(height: 60,width: 60,child: Column(
      children: [
        Container(height: 45,width: 45,child: Image.asset(this.path),),Text(this.name,style: TextStyle(fontFamily: 'Nunito',fontSize:16),),
      ],
    ),),onTap: ()=>this.function(this.id),);
  }
}