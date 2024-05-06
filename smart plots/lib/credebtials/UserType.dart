import 'package:flutter/material.dart';

class UserType extends StatefulWidget {
  final  Color color;
  final String  text;
  final String  path;
  UserType({super.key,required this.color,required this.text,required this.path});
  State<UserType> createState() => _UserType();
  }
  class _UserType extends State<UserType> {
   double width=0;
  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: (){
        setState(() {
           this.width=this.width>0?0:3;
        });
       
        print(this.width);
      }, 
      child:  Container(height: 170,
    width: 350,
    padding: EdgeInsets.only(left: 5),
    
    decoration: BoxDecoration(
      border: Border.all(width: this.width,color: Color.fromARGB(225, 100, 200, 150)),
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

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}