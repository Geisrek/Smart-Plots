import 'package:flutter/material.dart';
import '../comon/MyTitle.dart';
import './StoreItem.dart';
class VendorStoreScreen extends StatefulWidget {
  const VendorStoreScreen({super.key});

  @override
  State<VendorStoreScreen> createState() => _VendorStoreScreenState();
}

class _VendorStoreScreenState extends State<VendorStoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Center(child: MyTitle(text: "Sored product",),),),
       body:Container(
        width:400 ,
        height: 600,
        child: Expanded(
          child:  SingleChildScrollView(,
        ),
       ) ,
    );
  }
}