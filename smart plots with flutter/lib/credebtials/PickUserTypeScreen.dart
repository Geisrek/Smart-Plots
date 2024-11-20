import 'dart:convert';

import 'package:Smart_pluts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../comon/MyTitle.dart';
import './UserType.dart';
import '../comon/Button.dart';
import 'package:http/http.dart' as http;
class PickUserType extends StatefulWidget {
   PickUserType({super.key});
    State<PickUserType> createState() => _PickUserType();
}
class _PickUserType extends State<PickUserType> {
  List<List> userTypes=[
      ["Farmer",Color(0xFF00651F),"/dashboard","images/farmer-avatar.png"],
      ["Vendor",Color(0xFF8400FF),'/vendor',"images/vendor-avatar.png"],
      ["Client",Color(0xFFFFAA00),'/client',"images/client-avatar.png"]
    ];
  Map<String,bool>selectedType={
    "Farmer":false,
    "Vendor":false,
    "Client":false
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(toolbarHeight: 30,
    title: Center(child: MyTitle(text: "Pick your user type",color: Colors.black,)
    ,)
    ,)
    ,
    body:Column(
      children: [
        Expanded(
          child: ListView.builder(
                itemCount: userTypes.length,
                itemBuilder:
                (context,index){
                  final userType=userTypes[index][0];
                  final userColor=userTypes[index][1];
                  final userRoot=userTypes[index][2];
                  final userPath=userTypes[index][3];
                  final isSelected=selectedType[userType];
                  
                  return Container(
                    margin: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 0),
                    child: UserType(
                      color:userColor ,
                       text: userType, 
                       rout: userRoot,
                       path: userPath,
                       isSlected: isSelected,
                       onCardTap:(value){
                        setState(() {
                          selectedType[userType]=value;
                          for(String user in selectedType.keys){
                            if (user != userType){
                             
                              selectedType[user]=false;
                            }
                          }
                        });
                       } ,),
                  );
                }
                 ),
        ),
      Button(onPress:() async{
       final storage=await SharedPreferences.getInstance();
 
      final String? isNull=storage.getString("user_information");
      final String user_information=isNull??'';
      final Map infos= json.decode(user_information);
      for (String type in selectedType.keys){
            if(selectedType[type]==true){
               infos["type"]=type;
            }
      }
       print( infos);
       try{
       final response=await http.post(
        Uri.parse("http://$IP:8000/api/register"),
        headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',
            },
        body: jsonEncode(<String, String>{
          "name":infos["name"],
          "email":infos["email"],
          "password":infos["password"],
          "user_address":"Saida"

        })
       
       );
       if(response.statusCode==200){
          final user=jsonDecode(response.body);
         
          
          final type_res=await http.post(
            Uri.parse("http://$IP:8000/api/register"),
            headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',}
            ,
            body:jsonEncode(<String, dynamic> {
              "user_id":user["user"]["id"],
            "user_type":infos["type"],
            })
          );
         
          if(type_res.statusCode==200){
            
            if(infos["type"]=="Farmer"){
             Navigator.of(context).pushReplacementNamed("/dashboard");
            }
            else if(infos["type"]=="Vendor"){
             Navigator.of(context).pushReplacementNamed("/vendor");

            }
            else {
             Navigator.of(context).pushReplacementNamed("/client");

            }
          }
          else{
            print(type_res.body);
          }

       }
       else{
        print(response.body);
       };}
       catch(err){
        print(err);
       }
      } , text: "Sign up") ],
    ),
  );
  }
}
/**
 * try{
          
          dynamic response=await http.post(
            //https://official-joke-api.appspot.com/random_joke
            Uri.parse("http://192.168.0.100:8000/api/register"),
             headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name':userName.getText(),
      'email': email.getText(),
      'password':password.getText(),
      'user_address':"Saida"
    }),
           );
          
           final data=jsonDecode(response.body);
            if(data['status']=='success'){
              print("success");
              Navigator.of(context).pushReplacementNamed("/pickuser");
            };}
            catch(err){
              print(err);
            }
 */