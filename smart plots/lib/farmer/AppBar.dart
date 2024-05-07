import 'package:flutter/material.dart';
import '../comon/MyTitle.dart';
class MyWidget extends StatelessWidget {
  final String title;
  final child;
  const MyWidget({super.key,required this.title, this.child=""});

  @override
  Widget build(BuildContext context) {
    return AppBar(toolbarHeight: 211,shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),backgroundColor: Color(0xFF00651F),title: Column(
       children: [
         Container(margin: EdgeInsets.only(right: 120,bottom: 70),child: MyTitle(text: "Dashboard",color: Colors.white,),),
         SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: this.child)
       ],
     ),);
  }
}