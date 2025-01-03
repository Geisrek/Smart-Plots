import 'dart:convert';

import 'package:Smart_pluts/comon/MyText.dart';
import 'package:Smart_pluts/comon/MyTitle.dart';
import 'package:Smart_pluts/constants/constants.dart';
import 'package:Smart_pluts/farmer/AppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Makedealscreen extends StatefulWidget {
  const Makedealscreen({super.key});

  @override
  State<Makedealscreen> createState() => _MakedealscreenState();
}

class _MakedealscreenState extends State<Makedealscreen> {
  dynamic product_id;
  dynamic products;
  @override
  Future<List > getUser()async{
    final preferences = await SharedPreferences.getInstance(); 
  final dynamic userData= jsonDecode(preferences.getString('user')!);
    dynamic response=await http.post(
        Uri.parse("http://$IP:8000/api/geteDeals"),
          headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',},
            body: jsonEncode({
              "client_id":userData["id"],
              
            })
           
      );
       if(response.statusCode==200){
        
        return jsonDecode(response.body);
       }
       else{
        print("error");
        print(response.statusCode);
        print(userData);
        return [];
       }
    
                
   
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBar(Title: "Your basket").MyAppBarr(),
    body: Flex(direction: Axis.vertical,
   crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: 
      SingleChildScrollView(child: 
      FutureBuilder(future: getUser(), builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return MyText(text: "pending...");
        }
        else if(snapshot.hasError){
          print(snapshot.error);
          return MyText(text: "Oooops something went wrong! ${snapshot.error}");
        }else{
          final data = snapshot.data ;
          products=snapshot.data;
          return Container(child:  Column(
            children:data!.map((item)=>Container(
                         height: 220,
                      width: 170,
                      margin: EdgeInsets.all(10),
                      
                      decoration: BoxDecoration(border: Border.all(
                        color: Color(0xFF00651F),
                        width: 1,
                        
                      ) ,borderRadius: BorderRadius.all(Radius.circular(10)), ),
                        child:Column(
                        children:[Container(
                       padding: EdgeInsets.all(2),
                       height: 170,
                       width: 170,
                      decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(8)),
                        image:DecorationImage(image: AssetImage("./images/Smartplots.png"),
                      fit: BoxFit.cover)),
                      
                      child:Text(item["product"],style: TextStyle(
                        fontSize: 12
                      ),),),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(borderRadius: 
                        BorderRadius.only(bottomLeft: Radius.circular(8)
                        ,bottomRight: Radius.circular(8)),
                        color: Color(0x99566500)),
                        padding: EdgeInsets.all(2),
                        
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           Row(children: [Text( item["cost"].toString(),style: TextStyle(
                              color:  Color(0xFFC6E976),
                              fontSize: 15,
                              fontWeight: FontWeight.bold

                            ),),Text( item["currency_unit"].toString(),style: TextStyle(
                              color:  Color(0xFFC6E976),
                              fontSize: 15,
                              fontWeight: FontWeight.bold

                            ),)],) ,
                           

                          IconButton(onPressed: ()async{


                                                  dynamic response=await http.post(
                          Uri.parse("http://$IP:8000/api/removeSale"),
                          headers:<String,String> {
                                  'Content-Type': 'application/json; charset=UTF-8',
                                  'Accept':'application/json',},
                                  body: jsonEncode({
                                    "id":item["id"]
                                  })
                                  
                        );
                        if(response.statusCode==200){
                          setState(() {
                            
                          });
                        }
                          }, icon: Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                            size: 25,
                          ))],
                        ),
                      )]))).toList()
    ));
        }
      }),))
    ,ElevatedButton(onPressed: ()async{
       SharedPreferences preferences=await SharedPreferences.getInstance();
       dynamic userData=jsonDecode(preferences.getString("user")!);
      if(products==null){
         return showDialog(context: context, builder: (BuildContext contex){
                    return Container(
                      width: 300,
                      height:400,
                      child:  CupertinoAlertDialog(
                    title: MyTitle(text: "Value missing"),
                    content: MyText(text: "There are no deals to execute"),
                    
                  ));
                  }) ;
      }
      print(products);
      for(var item in products){
        
        Future.delayed(Duration(milliseconds: 25),()async{
          print(item);
          try{
           dynamic response=await http.post(
        Uri.parse("http://$IP:8000/api/makeDeal"),
          headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',},
            body: jsonEncode({
              "saledetail_id":item["id"],
              "cost":item["cost"]
            })
           
      );
      print(response.body);
       if(response.statusCode==200){
        setState(() {
          
        });
       }
       else{
        print("user:${userData} , product_id:${product_id}");
        print(response.statusCode);
       }}
       catch(e){
        print(e);
       }
        });

        
      };
     
    }, child: MyText(text: "Add to basket"))],),);
  }
}