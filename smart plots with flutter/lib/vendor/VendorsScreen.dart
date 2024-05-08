import 'package:flutter/material.dart';
import '../comon/MyTitle.dart';
import '../comon/TextInputs.dart';
import '../comon/MyText.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../comon/Button.dart';
class VendorScreen extends StatefulWidget {
   VendorScreen({super.key});
   final serial=InputText(text:"Enter your serial number" );
   final purchasing_price=InputText(text: "Enter the purchasing price");
   final selling_price=InputText(text: "Enter the selling price in \$");
  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100 ,
        title: Row(
          children: [
            MyTitle(text: "Vendor"),
            SizedBox(width: ,)
          ],
        ),
      ),
      body:Container(
        padding: EdgeInsets.only(left:30)
        ,
        child:Column(children: [
          widget.serial,
          SizedBox(height: 10,),
          widget.purchasing_price,
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
              Expanded(child: SizedBox(width: 200,),),
              IconButton(onPressed: (){Navigator.of(context).pushNamed("/history");}, icon: SvgPicture.asset("images/history.svg"))
            ],
          )
          ),
        Container(
          margin: EdgeInsets.only(top: 10,bottom: 10),
          width: 300,
          height: 100,
          child: Column(
            children: [
              Expanded(child: 
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: MyText(text: "Roma, Roma, O Roma! Legio, aeterna, aeterna victrix!Legio, aeterna, aeterna victrix!Verti est sua aeterniordanosta solum tibi Verti est sua aeterni Vita nostra solum tibi Roma, Roma, O Roma!Legio, aeterna, aeterna victrix! Legio, aeterna, aeterna victrix! Legio, aeterna, aeterna victrix! Legio, aeterna, aeterna victrix!!"),
              )
              ,),
            ],
          ),
        ),
        SizedBox(height: 210,)
        ,
        widget.selling_price,
        SizedBox(height: 10,)
        ,Button(onPress: (){}, text: "Save")],) ,
      ) ,
    );
  }
}