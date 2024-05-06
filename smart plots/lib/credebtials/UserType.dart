import 'package:flutter/material.dart';

class UserType extends StatelessWidget {
  final  color;
  const UserType({super.key,required this.color});
 
  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: (){print("bruh");
      
      }, 
      child:  Container(height: 170,
    width: 350,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(7),color:this.color ),),
      );
  }
}