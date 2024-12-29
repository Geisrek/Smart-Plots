import 'dart:convert';

import 'package:Smart_pluts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../comon/MyText.dart';
import 'package:http/http.dart' as http;
class StoreItem extends StatelessWidget {
  final String price;
  final String product_name;
  final String serial;
  final int product_id;
  final int sale_id;
  
  const StoreItem({super.key, required this.price,required this.product_name,required this.serial,required this.product_id,required this.sale_id});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF00651F),borderRadius: BorderRadius.circular(7)),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(10),
       child:Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween ,
        children: [Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           InkWell(child: Container(height: 60,width: 60,child: SvgPicture.asset("images/usd.svg")),
           onTap: ()async{
            SharedPreferences preferences= await SharedPreferences.getInstance();
            preferences.setString("sale", jsonEncode({
              "product_id":product_id,
              "product_name":product_name,
              "price":price,
              "serial":serial
            })
            );
             Navigator.of(context).pushNamed("/updateStore");
           },),
          MyText(text: this.price)
          ],
        ),Container(height: 75,width:200 ,
        padding:EdgeInsets.all(10) ,
        decoration: BoxDecoration(color: Color(0x88FFAA00),borderRadius: BorderRadius.circular(7))
        ,child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween 
        ,crossAxisAlignment: CrossAxisAlignment.center
        ,children: [Column(children:[MyText(text: this.product_name,),MyText(text: this.serial,)]),
        IconButton(onPressed: ()async{
          Navigator.of(context).pushNamed("/history");
          SharedPreferences preferences= await SharedPreferences.getInstance();
          preferences.setInt("plot_id", product_id);
          
          }, icon: SvgPicture.asset("images/history.svg"))],))
        ,Container(width: 40,height: 40,child: IconButton(onPressed: ()async{
          dynamic response=await http.post(
    Uri.parse("http://$IP:8000/api/removeSale"),
     headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',},
            body: jsonEncode({
              "id":this.sale_id
            })
  );
  if(response.statusCode==200){
    print(response.body);
   Navigator.of(context).pushReplacementNamed("/vendor_storage");
  }
  else{
    print(response.body.toString().substring(0,700));
  }

        }, icon: SvgPicture.asset("./images/remove.svg")))],
       ) ,
    );
  }
}