import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../comon/MyTitle.dart';
import 'package:http/http.dart'as http;

import '../constants/constants.dart';
class MyAppBar extends StatelessWidget  {
  final String title;
  final child;
   MyAppBar({super.key,required this.title, this.child=""});

  @override
  Widget build(BuildContext context) {
    return AppBar(toolbarHeight: 211,shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),backgroundColor: Color(0xFF00651F),title: Column(
       children: [
         Container(margin: EdgeInsets.only(right: 120,bottom: 70),child: Row(
           children: [
             MyTitle(text: "Dashboard",color: Colors.white,),SizedBox(width: 10,),MyTitle(text: 'rrrrrr'),
             
           ],
         ),),
         SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: this.child is Widget? this.child :Container(child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [],
          ),))
       ],
     ),);
  }
}
class MyBar extends AppBar{
  final String Title;
  final child;
  MyBar({super.key,required this.Title, this.child=""});
   MyAppBarr(){
    return AppBar(toolbarHeight: 211,shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),backgroundColor: Color(0xFF00651F),title: Column(
       children: [
         Container(margin: EdgeInsets.only(right: 120,bottom: 70),child: MyTitle(text: this.Title,color: Colors.white,),),
         SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: this.child is Widget? this.child :Container())
       ],
     ),);
  }

}