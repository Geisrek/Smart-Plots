import 'dart:convert';

import 'package:Smart_pluts/comon/MyText.dart';
import 'package:Smart_pluts/constants/constants.dart';
import 'package:Smart_pluts/farmer/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Addtobasketscreen extends StatefulWidget {
  const Addtobasketscreen({super.key});

  @override
  State<Addtobasketscreen> createState() => _AddtobasketscreenState();
}

class _AddtobasketscreenState extends State<Addtobasketscreen> {
  dynamic product_id;
  @override
  Future<Map> getSale()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    dynamic data=jsonDecode(preferences.getString("basket")!);
    
    
                  product_id=data["plot_id"];
                
    return data;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBar(Title: "Add to bar").MyAppBarr(),
    body: Flex(direction: Axis.vertical,
   crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: 
      SingleChildScrollView(child: 
      FutureBuilder(future: getSale(), builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return MyText(text: "pending...");
        }
        else if(snapshot.hasError){
          return MyText(text: "Oooops something went wrong!");
        }else{
          final data=snapshot.data;
          return Container(child:  Column(
            children: data!.entries.map((entry){
              if(entry.key!="sales_id"&&entry.key!="supplier_id"){
              return Row(children: [MyText(text: "${entry.key}:"),SizedBox(width: 10,),MyText(text: "${entry.value}")],);
              }
            
              return Container();
              }).toList()
    ));
        }
      }),))
    ,ElevatedButton(onPressed: ()async{
      final preferences = await SharedPreferences.getInstance(); 
  final dynamic userData= jsonDecode(preferences.getString('user')!); 
      dynamic response=await http.post(
        Uri.parse("http://$IP:8000/api/addToCard"),
          headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',},
            body: jsonEncode({
              "client_id":userData["id"],
              "product_id":product_id
            })
           
      );
       if(response.statusCode==200){
        Navigator.of(context).pushReplacementNamed("/market");
       }
       else{
        print("user:${userData} , product_id:${product_id}");
        print(response.statusCode);
       }
    }, child: MyText(text: "Add to basket"))],),);
  }
}