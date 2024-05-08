import 'package:flutter/material.dart';
import '../comon/MyTitle.dart';
import '../comon/TextInputs.dart';
import '../comon/MyText.dart';
class VendorScreen extends StatefulWidget {
   VendorScreen({super.key});
   final serial=InputText(text:"Enter your serial number" );
   final price=InputText(text: "Enter the purchasing price");
  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100 ,
        title: MyTitle(text: "Vendor"),
      ),
      body:Container(
        padding: EdgeInsets.only(left:30)
        ,
        child:Column(children: [
          widget.serial,
          SizedBox(height: 10,),
          widget.price,
          SizedBox(height: 10,),
          Container(width: 300,
          height: 60 ,
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(color: Color(0xFFD9D9D9),borderRadius:BorderRadius.circular(7)),
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: [
              MyText(text: "Strawbary, "),
              SizedBox(width: 8,),
              MyText(text: "Bikaa"),
              Expanded(child: ,)
            ],
          )
          ),
        ],) ,
      ) ,
    );
  }
}