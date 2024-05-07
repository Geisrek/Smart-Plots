import 'package:flutter/material.dart';

class UserType extends StatefulWidget {
  final  Color color;
  final String  text;
  final String  path;
  final toggle;
  double width;
  UserType({super.key,required this.color,required this.text,required this.path,required this.toggle,required this.width});
  State<UserType> createState() => _UserType();
  }
  class _UserType extends State<UserType> {
   
  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: widget.toggle(),
      child:  Container(height: 170,
    width: 310,
    padding: EdgeInsets.only(left: 5),
    
    decoration: BoxDecoration(
      border: Border.all(width: widget.width,color: Color.fromARGB(225, 100, 200, 150)),
      borderRadius: BorderRadius.circular(7),color:widget.color ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Container(height: 50,
        width: 50,
         child: ClipRRect(
          child: Image.asset(widget.path),borderRadius:BorderRadius.circular(100) ,),),SizedBox(width: 200,),
         Text(this.widget.text,style: TextStyle(color: Colors.white,
         fontFamily: 'Nunito',
         fontSize: 18,
         fontWeight: FontWeight.bold),)],),
        ),
      );
  }
}