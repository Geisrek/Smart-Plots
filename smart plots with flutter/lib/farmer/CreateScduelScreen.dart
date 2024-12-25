import 'dart:convert';

import 'package:Smart_pluts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'AppBar.dart';
import '../comon/MyText.dart';
import '../comon/TextInputs.dart';
import '../comon/Button.dart';
class CreateScduelScreen extends StatelessWidget {
  final Yeare=InputText(text: "YYYY-MM-DD",);
  final EC=InputText(text: "",);
  final Water=InputText(text: "",);
  final Temperature=InputText(text: "",);
  final Lux=InputText(text: "",);
  final Air=InputText(text: "",);
   CreateScduelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBar(Title: "Create a new sceduel",).MyAppBarr(),
      body:Expanded(
        child:SingleChildScrollView(child: 
         Container(
        padding: EdgeInsets.only(left: 5,right: 5),
        child: Column(children: [SizedBox(height: 20,),
          Row(children: [MyText(text: "Date"),Expanded(child: SizedBox(width: 40,)),SizedBox(width: 10,),this.Yeare],
          ),
          SizedBox(height: 40,),
          Row(children: [MyText(text: "EC"),Expanded(child: SizedBox(width: 40,)),this.EC]),
          SizedBox(height: 10,),
          Row(children: [MyText(text: "PH"),Expanded(child: SizedBox(width: 40,)),this.Water]),
          SizedBox(height: 10,),
          Row(children: [MyText(text: "C"),Expanded(child: SizedBox(width: 40,)),this.Temperature]),
          
          SizedBox(height: 10,),
          Row(children: [MyText(text: "Lux"),Expanded(child: SizedBox(width: 40,)),this.Lux]),
          SizedBox(height: 10,),
          Row(children: [MyText(text: "Air"),Expanded(child: SizedBox(width: 40,)),this.Air]),
          
          SizedBox(height: 30,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: 
          [
          Container(width: 100,child: ElevatedButton(onPressed: ()async{
             try{
              final infos= await SharedPreferences.getInstance();
              final int _id=await infos.getInt('plot')!;
              final String? data=await infos.getString('user');
              final user=jsonDecode(data!);
              
              final response=await http.post(
                Uri.parse('http://$IP:8000/api/createTask'),
                headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json'
                },
                body:jsonEncode(<String, dynamic>{
              'light':Lux.getText(),
            'sol_humidity':EC.getText(),
            'air_humidity':Air.getText(),
            'temperature':Temperature.getText(),
            'schedule_date':Yeare.getText(),
            'plot_id':_id,
            'user_id':user["id"]
    }) 
              );
              if(response.statusCode==200){
              print(jsonDecode(response.body));
              Navigator.of(context).pushReplacementNamed('/dashboard');}
              else{
                print(response.statusCode);
                 print(user);
                final data=await response;
                print(data.body);
              }
             }catch(err){
              print(err);
             }
          },child: Text("Save"),),),
          Container(width: 100,child: ElevatedButton(onPressed: (){},child: Text("Default"),),)
          ],),
        ],),),
    )));
  }
}