import 'dart:convert';

import 'package:Smart_pluts/comon/MyText.dart';
import 'package:Smart_pluts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../comon/MyTitle.dart';
import './StoreItem.dart';
import 'package:http/http.dart' as http;
class VendorStoreScreen extends StatefulWidget {
  const VendorStoreScreen({super.key});

  @override
  State<VendorStoreScreen> createState() => _VendorStoreScreenState();
}

class _VendorStoreScreenState extends State<VendorStoreScreen> {

Future<List> getUserSales()async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  final user=jsonDecode(preferences.getString("user")!);
  print(user);
  dynamic response=await http.post(
    Uri.parse("http://$IP:8000/api/getUserSale"),
     headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',},
            body: jsonEncode({
              "user_id":user["id"]
            })
  );
  if(response.statusCode==200){
    print(response.body);
    return jsonDecode(response.body);
  }
  else{
    print(response.body.toString().substring(0,700));
  }
  return[];
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Center(child: MyTitle(text: "Stored product",),),),
       body:
       FutureBuilder(future: getUserSales(), builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return MyText(text: "pending...");
        }
        else if(snapshot.hasError){
          return MyText(text: "Oooops something went wrong: ${snapshot.error}");
        }
        else{
          final data=snapshot.data;
          return Container(
        width:400 ,
        height: 600,
        child:Flex(direction: Axis.vertical,children: [Expanded(
          child:  SingleChildScrollView(
             scrollDirection:Axis.vertical,
             child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:data!.map((item)=>StoreItem(price:" ${item["cost"].toString()} ${item["currency_unit"]}", 
              product_name:item["product"]
              ,serial: item["product_serial"]
              ,product_id:  item["product_id"]
              ,sale_id: item["id"],)).toList()
              ,
             ),
          )

        )] ,),
       ) ;
        }
       })
       ,
    );
  }
}