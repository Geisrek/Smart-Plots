import 'dart:convert';

import 'package:Smart_pluts/comon/MyText.dart';
import 'package:Smart_pluts/comon/TextInputs.dart';
import 'package:Smart_pluts/constants/constants.dart';
import 'package:Smart_pluts/farmer/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Updatestoreitemscreen extends StatefulWidget {
  const Updatestoreitemscreen({super.key});

  @override
  State<Updatestoreitemscreen> createState() => _UpdatestoreitemscreenState();
}

class _UpdatestoreitemscreenState extends State<Updatestoreitemscreen> {
  final Cost=InputText(text: "Enter the new cost");
  Future<Map> getProduct()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    dynamic product=jsonDecode(preferences.getString("sale")!);
    return product;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBar(Title:  "Update product price").MyAppBarr(),
      body: Container(
        child: FutureBuilder(future: getProduct(), builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return MyText(text: "pending...");
          }
          else if(snapshot.hasError){
            return MyText(text: "Oooops something went wrong");
          }
          else{
            final data=snapshot.data;
            return Column( children:  [Column(children:  data!.entries.map((item)=>Container(
              child: Column(children: [MyText(text: "${item.key}: ${item.value}"),SizedBox(height: 10,)],),
            )).toList()),SizedBox(height: 10,),Cost,SizedBox(height: 10,),ElevatedButton(onPressed: ()async{
              try{
                dynamic response=await http.post(
                  Uri.parse("http://$IP:8000/api/updateCost"),
                  headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',},
            body: jsonEncode({
              "product_id":data["product_id"],
              "cost":Cost.getText()
            })
                );
                if(response.statusCode==200){
                  Navigator.of(context).pushReplacementNamed("/vendor");
                }
                else{
                  print(response.body.message);
                }
              }
              catch(e){
                print(e);
              }
            }, child: MyText(text: "Update"))]);
          }
        }),
      ),
    );
  }
}