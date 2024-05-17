import 'package:flutter/material.dart';

class UserType extends StatefulWidget {
  final  Color color;
  final String  text;
  final String  path;
  final rout;
  final onCardTap; 
  final isSlected;
  UserType({
      super.key,
      this.rout="/",
      required this.color,
      required this.text,
      required this.path,
      required this.onCardTap,
      required this.isSlected
  });
  State<UserType> createState() => _UserType();
  }
  class _UserType extends State<UserType> {
   
  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap:(){ 
       widget.onCardTap(!widget.isSlected);
        //Navigator.of(context).pushReplacementNamed(widget.rout);
        ;},
      child:  Container(height: 170,
    width: 310,
    padding: EdgeInsets.only(left: 5),
    
    decoration: BoxDecoration(
      border: Border.all(
        width: widget.isSlected?2:0,
        color: Color.fromARGB(225, 100, 200, 150),
        ),
      borderRadius: BorderRadius.circular(7),color:widget.color ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Container(height: 50,
        width: 50,
         child: ClipRRect(
          child: Image.asset(widget.path),borderRadius:BorderRadius.circular(100) ,),),SizedBox(height: 5,),
         Text(this.widget.text,style: TextStyle(color: Colors.white,
         fontFamily: 'Nunito',
         fontSize: 18,
         fontWeight: FontWeight.bold),)],),
        ),
      );
  }
}