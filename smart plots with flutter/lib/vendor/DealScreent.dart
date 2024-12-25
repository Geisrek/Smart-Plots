import 'dart:convert';

import 'package:Smart_pluts/comon/MyText.dart';
import 'package:Smart_pluts/comon/TextInputs.dart';
import 'package:Smart_pluts/constants/constants.dart';
import 'package:Smart_pluts/farmer/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Deal extends StatefulWidget {
  const Deal({super.key});

  @override
  State<Deal> createState() => _DealState();
}

class _DealState extends State<Deal> {
  final cost=InputText(text: "Enter thw new cost");
  dynamic saledetail_id;
  Future<Map> getDeal()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    Map saledetail=jsonDecode(preferences.getString("deal")!);
    print(saledetail);
    saledetail_id=saledetail["id"];
    return saledetail;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBar(Title: "Deal").MyAppBarr(),
      body: Container(
        child: Column(
          children: [
            FutureBuilder(future: getDeal(), builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return MyText(text: "pending...");
              }
              else if(snapshot.hasError){
                print(snapshot.error);
                return MyText(text: "Ooops something went wrong!");
              }
              else{
                final data=snapshot.data;
                return Flex(direction: Axis.vertical,
                children: data!.entries.map((item){
                  if(item.key!="product_id"&&item.key!="sales_id"&&item.key!="suplier_id"){
                    return MyText(text: "${item.key}:${item.value}");
                  }
                  return Container();
                }).toList(),);
              }
            })
         ,cost, ElevatedButton(onPressed: ()async{
               
                         dynamic response=await http.post(
                        Uri.parse("http://$IP:8000/api/makeDeal"),
                          headers:<String,String> {
                            'Content-Type': 'application/json; charset=UTF-8',
                            'Accept':'application/json',},
                            body: jsonEncode({
                              "saledetail_id":saledetail_id,
                              "cost":cost.getText()
                              
                            }));
                            if(response.statusCode==200){
                              Navigator.of(context).pushReplacementNamed("/market");
                            }
         }, child: MyText(text: "Deal"))],
        ),
      ),
    );
  }
}