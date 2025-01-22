import 'dart:convert';

import 'package:Smart_pluts/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Marketscreeb extends StatefulWidget {
  const Marketscreeb({super.key});

  @override
  State<Marketscreeb> createState() => _MarketscreebState();
}

class _MarketscreebState extends State<Marketscreeb> {
  @override
  void initState(){
    super.initState();
    setData();
  }
  dynamic current_user={};
  dynamic product={};
  Future<void> setData()async{
    await getUser();
    await getProduct();
  }
  Future<void> getUser()async{
   SharedPreferences preferences= await SharedPreferences.getInstance();
  
   print(preferences.getKeys());
   Map user=jsonDecode(await preferences.getString('user')!);
  
   setState(() {
     this.current_user=user;
   });
  }
  Future<void> getProduct()async{
    print('in');
    try{
      dynamic response= await http.post(
        Uri.parse("http://$IP:8000/api/Products"),
        headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',},
            body: jsonEncode({
              "user_id":this.current_user["id"]
            }));
            if(response.statusCode==200){
              print(response.body);
            }
    }
    catch(e){
      print("fetch products error:$e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}