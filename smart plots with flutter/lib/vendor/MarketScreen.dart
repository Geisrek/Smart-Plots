import 'dart:convert';

import 'package:Smart_pluts/comon/MyText.dart';
import 'package:Smart_pluts/constants/constants.dart';
import 'package:Smart_pluts/farmer/AppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Marketscreen extends StatefulWidget {
  const Marketscreen({super.key});

  @override
  State<Marketscreen> createState() => _MarketscreenState();
}

class _MarketscreenState extends State<Marketscreen> {
  @override
  void initState(){
    super.initState();
    setData();
  }
  @override void dispose() {
     _product.dispose(); 
     super.dispose(); 
     }
  dynamic current_user={};
  final TextEditingController _product = TextEditingController(); 
  List<dynamic> product=[];
  Future<void> setData()async{
    await getUser();
   // await getProduct(_product.text);
  }
  Future<void> getUser()async{
   SharedPreferences preferences= await SharedPreferences.getInstance();
  
   print(preferences.getKeys());
   Map user=jsonDecode(await preferences.getString('user')!);
  
   setState(() {
     this.current_user=user;
   });
  }
  Future<List> getProduct(String value)async{
   
    try{
      print(value);
      if(value==''){
      dynamic response= await http.post(
        Uri.parse("http://$IP:8000/api/getProducts"),
        headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',},
            body: jsonEncode({
              "user_id":this.current_user["id"]
            }));
            if(response.statusCode==200){
             
                 this.product=jsonDecode(response.body);
                 print("done");
                 return jsonDecode(response.body);
             
            
            }
            else{
              print(response.statusCode);
            }}
            else{
              SharedPreferences preferences=await SharedPreferences.getInstance();
              dynamic user=jsonDecode(preferences.getString("user")!);
                dynamic response= await http.post(
        Uri.parse("http://$IP:8000/api/search"),
        headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',},
            body: jsonEncode({
              "product":_product.text,
              "id":user["id"]
            }));
            if(response.statusCode==200){
             
                 this.product=jsonDecode(response.body);
                 print(jsonDecode(response.body));
                 return jsonDecode(response.body);
             
            
            }
            else{
              print('---${response.statusCode} : ${response.body.message}');
            }
            }
            return [];
    }
    catch(e){
      print("fetch products error:$e");
    }
    return [];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBar(Title: "Market").MyAppBarr(),
      body:Container(
        padding: EdgeInsets.all(20),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Container(width: 250,
    height: 48
      ,child: TextFormField(
      controller: _product,
       onChanged:(value){
        
          
             setState(() {
               
             });
       
        }
        ,
      decoration: InputDecoration(
        labelText: "product",
        labelStyle: TextStyle(fontFamily: 'Nunito',fontSize: 18,fontFamilyFallback: ['Nunito', 'Arial', 'sans-serif']),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(7))),
    ),)
            ,Expanded(child: 
            SingleChildScrollView(
              child: FutureBuilder(future: getProduct(_product.text),builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return MyText(text: "pending...");
                }
                else if(snapshot.hasError){
                  return const MyText(text: "Oooops something went wrong");
                }
                else{
                  List<dynamic> data=[];
                  
                    data=snapshot.data!;
                    print(data);
                  return Wrap(
                    children: data.map((item)=>InkWell(
                      child:Container(
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
                            Text( item["name"],style: TextStyle(
                              color:  Color(0xFFC6E976),
                              fontSize: 13,
                              
                            ),)

                          ],
                        ),
                      )])),onTap: ()async{
                          SharedPreferences preferences=await SharedPreferences.getInstance();
                          preferences.setString('basket', jsonEncode(item));
                          Navigator.of(context).pushNamed("/basket");
                      },)).toList(),
                  );
                }
              },),
            ))
          ],),
      )
    );
  }
}