import 'package:flutter/material.dart';

class UserType extends StatelessWidget {
  final  Color color;
  final String  text;
  final String  path;
  const UserType({super.key,required this.color,required this.text,required this.path});
 
  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: (){print("bruh");
      
      }, 
      child:  Container(height: 170,
    width: 350,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(7),color:this.color ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Container(height: 60,width: 60,child: ClipRRect(child: Image.asset(this.path),),),Text(this.text,style: TextStyle(color: Colors.white,fontFamily: 'Nunito',fontSize: 18,fontWeight: FontWeight.bold),)],),
        ),
      );
  }
}