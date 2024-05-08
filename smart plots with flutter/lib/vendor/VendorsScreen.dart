import 'package:flutter/material.dart';
import '../comon/MyTitle.dart';
import '../comon/TextInputs.dart';
class VendorScreen extends StatefulWidget {
   VendorScreen({super.key});
   final serial=InputText(text:"Enter your serial number" );
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
        padding: EdgeInsets.all(10)
        ,
        child:Column(children: [
          InputText(text: text)
        ],) ,
      ) ,
    );
  }
}