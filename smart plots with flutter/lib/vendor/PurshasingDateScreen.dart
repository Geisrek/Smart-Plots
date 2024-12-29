import 'dart:convert';

import 'package:Smart_pluts/comon/MyText.dart';
import 'package:Smart_pluts/constants/constants.dart';
import 'package:Smart_pluts/farmer/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Purshasingdatescreen extends StatefulWidget {
  const Purshasingdatescreen({super.key});

  @override
  State<Purshasingdatescreen> createState() => _PurshasingdatescreenState();
}

class _PurshasingdatescreenState extends State<Purshasingdatescreen> {
  Future<List> getUserSale()async{
    try{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    final userData=jsonDecode(preferences.getString("user")!);
    dynamic response=await http.post(
      Uri.parse("http://$IP:8000/api/getUserSale"),
       headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',},
        body: jsonEncode({
          "user_id":userData["id"]
        })
    );
    if(response.statusCode==200){
      return jsonDecode(response.body);
    }
    else{
      print(response.body.message);
    }
    }
   
    catch(e){
      print(e);
    }
    return[];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBar(Title: "Purchase Table").MyAppBarr(),
      body:FutureBuilder(future: getUserSale(), builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return MyText(text: "Pending...");
        }
        else if(snapshot.hasError){
           return MyText(text: " Oooops smething went wrong");
        }
        else{
          final data= snapshot.data;
          return DataTable(columns: [
        DataColumn(label:  MyText(text: "date")),
         DataColumn(label:  MyText(text: "product")),
         DataColumn(label:  MyText(text: "cost")),
         DataColumn(label: MyText(text: "Currency")),
           DataColumn(label: MyText(text: "Supplier")),
        
        ]
       
      , rows: data!.map((item)=>DataRow(cells: [
        DataCell(MyText(text: item["created_at"],)),
        DataCell(MyText(text: item["product"].toString().trim(),)),
         DataCell(MyText(text: item["cost"].toString(),)),
          DataCell(MyText(text: item["currency_unit"],)),
           DataCell(MyText(text: item["name"],))
      ])).toList()
      );
        }
      }) ,
    );
  }
}