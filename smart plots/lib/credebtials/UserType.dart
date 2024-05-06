import 'package:flutter/material.dart';

class UserType extends StatelessWidget {
  final  color;
  final  text;
  const UserType({super.key,required this.color,required this.text});
 
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
        children: [Text(this.text,style: TextStyle(color: Colors.white,fontFamily: 'Nunito',fontSize: 18,fontWeight: FontWeight.bold),)],),
        ),
      );
  }
}