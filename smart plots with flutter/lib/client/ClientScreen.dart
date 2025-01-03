import 'dart:convert';

import 'package:Smart_pluts/comon/MyText.dart';
import 'package:Smart_pluts/comon/MyTitle.dart';
import 'package:Smart_pluts/comon/TextInputs.dart';
import 'package:Smart_pluts/constants/constants.dart';
import 'package:Smart_pluts/farmer/chatgpt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../comon/MyText.dart';
import 'package:http/http.dart' as http;
class ClientScreen extends StatefulWidget {
  
   const ClientScreen({super.key});
@override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
    dynamic user;
    bool isSet=false;
    dynamic product_id;
    dynamic cost;
   final serial=InputText(text:"Enter your serial code" );
   final selling_price=InputText(text: "Enter the purchasing price");
    String formattedDate = "";
    @override
    void initState(){
      super.initState();
      getUser();
      print(user);
       DateTime now = DateTime.now();
       formattedDate="${now.year}-${now.month}-${now.day}";
    }
     Future<List> getHistoryBySerial()async{
      print("$isSet");
      if(isSet){   
          try{
        print("2");
    dynamic response=await http.post(
      Uri.parse("http://$IP:8000/api/getHistorySaleBySerial"),
       headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',},
        body: jsonEncode({
          "serial":serial.getText()
        })
    );
    if(response.statusCode==200){
      print(response.body);
      return jsonDecode(response.body) ;
    }
    else{
       print(response.body.message);
    }}
    catch(e){
      print("error:$e");
    }}
    return [];
    }
    Future<Map> getSaleBySerial()async{
      if(isSet){   
          try{
        print("2");
    dynamic response=await http.post(
      Uri.parse("http://$IP:8000/api/getSaleBySerial"),
       headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',},
        body: jsonEncode({
          "serial":serial.getText()
        })
    );
    if(response.statusCode==200){
      print(response.body);
      return jsonDecode(response.body) ;
    }
    else{
       print(response.body.message);
    }}
    catch(e){
    print(e);
    }}
    return {};
    }
    void toggle(){
      setState(() {
        isSet=!isSet;
      });
    }
    Future<void> getUser()async{
      SharedPreferences preferences=await SharedPreferences.getInstance();
      if(user==null){
        print(preferences.getKeys());
        print(preferences.getString("user"));
      setState(() {
        user=  jsonDecode( preferences.getString("user")!);
      });}
      
    }
     @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: [
              Container(
                width: 300 ,
                height:100,
                child: MyTitle(text: "Welcom ${user["name"]}",color:  Color(0xFF00651F),),
              )
            ],
          ),
        ),),
        body: Container(
          height: 800,
          width: 300,
          child:Flex(direction: Axis.vertical,children: [
            Expanded(child: 
            SingleChildScrollView(
              child:Flex(
            direction: Axis.vertical,
          children: [
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          IconButton(onPressed: (){Navigator.of(context).pushNamed("/purchase");}, icon: Icon(
            Icons.archive
          )),InkWell(onTap: ()async{
        try{
          final credentials=await SharedPreferences.getInstance();
          
           final response=await http.post(
            Uri.parse('http://$IP:8000/api/logout')
           );
           credentials.remove('credential');
           credentials.remove('user');
           Navigator.of(context).pushReplacementNamed('/');
           
      }catch(err){
         print('Error:$err');
      }},child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Icon(Icons.logout_outlined,size: 23,color: Colors.black,)],))],)
           ,Container(
            height: 200,
            width: 300,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(color:  Color(0xFF00651F)
            ,borderRadius: BorderRadius.all(Radius.circular(8)),
            image: DecorationImage(image: AssetImage("./images/vegetables-bg.jpg"),
            fit: BoxFit.cover)
            ),
            child:user!=null? FutureBuilder(future:  callChatGPT("what the vegan recipe belong to my country :${user["user_address"]}"), builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return MyText(text: "Pending...");
              }
              else if(snapshot.hasError){
                return MyText(text: "Oooops something went wrong");
              }else{
                return Column(children: [
                 const Text("Your daley Recipe suggestion",style: TextStyle(fontFamily: 'Nunito',fontSize: 18,fontWeight: FontWeight.w900),) ,
                  SizedBox(height: 10,)
                  ,Expanded(child:
                SingleChildScrollView(child:MyText(text: snapshot.data!,color: Colors.white,))
                )],
                ) ;
              }
            }):MyText(text: "Pending...") ,
           ),SizedBox(height: 40,),
           Container(
            height: 200,
            width: 300,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(color:  Color(0xFF00651F)
            ,borderRadius: BorderRadius.all(Radius.circular(8)),
            image: DecorationImage(image: AssetImage("./images/fruit-bg.jpg"),
            fit: BoxFit.cover)
            ),
            child:user!=null? FutureBuilder(future:  callChatGPT("what is the fruit of this season season:${formattedDate} belong to my country :${user["user_address"]}"), builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return MyText(text: "Pending...");
              }
              else if(snapshot.hasError){
                return MyText(text: "Oooops something went wrong");
              }else{
                return Column(children: [
                 const Text("Your daley fruit suggestion",style: TextStyle(fontFamily: 'Nunito',fontSize: 18,fontWeight: FontWeight.w900),) ,
                  SizedBox(height: 10,)
                  ,Expanded(child:
                SingleChildScrollView(child:MyText(text: snapshot.data!,color: Colors.white,))
                )],
                ) ;
              }
            }):MyText(text: "Pending...") ,
           ),
          SizedBox(height: 10,),
          serial,
          SizedBox(height: 10,),
          selling_price,
           SizedBox(height: 10,),
         isSet? FutureBuilder(future: getSaleBySerial(), builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Container(width: 300,
          height: 60 ,
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(color: Color(0xFFD9D9D9),borderRadius:BorderRadius.circular(7)),
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: [
              MyText(text: "Pending.. "),
              SizedBox(width: 8,),
              MyText(text: "--"),
              Expanded(child: SizedBox(width: 200,),),
              
            ],
          )
          );
            }
            else if(snapshot.hasError){
              print(snapshot.error);
              return Container(width: 300,
          height: 60 ,
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(color: Color(0xFFD9D9D9),borderRadius:BorderRadius.circular(7)),
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: [
              MyText(text: "Something went wrong, "),
              SizedBox(width: 8,),
              MyText(text: "ಥ_ಥ"),
              Expanded(child: SizedBox(width: 200,),),
              
            ],
          )
          );
            }
            else{
              final data= snapshot.data;
            product_id=data!["plot_id"];
            cost=data["cost"];
              return Container(width: 300,
          height: 60 ,
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(color: Color(0xFFD9D9D9),borderRadius:BorderRadius.circular(7)),
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: [
              MyText(text:"${data!["product"]} , "),
              SizedBox(width: 8,),
              MyText(text: "🌽🥕🍅"),
              Expanded(child: SizedBox(width: 200,),),
              
            ],
          )
          );
            }
          }):Container(width: 300,
          height: 60 ,
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(color: Color(0xFFD9D9D9),borderRadius:BorderRadius.circular(7)),
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: [
              MyText(text: "No such serial yet, "),
              SizedBox(width: 8,),
              MyText(text: ";)"),
              Expanded(child: SizedBox(width: 200,),),
              
            ],
          )
          ),SizedBox(height: 10,),
          Container(height: 210,
        child: Flex(direction: Axis.vertical,children: [
          Expanded(child: 
          SingleChildScrollView(
            child: 
            FutureBuilder(future: getHistoryBySerial(), builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return MyText(text: "Pending...");
              }
              else if(snapshot.hasError){
                return MyText(text: "Oooops something went wrong:${snapshot.error}");
              }
              else {
                final data= snapshot.data;
                if(data!.length==0){
                   return const MyText(text: "No such history");
                }
                else{
                return Column(
                  children: data!.map((item)=>Container(
                    width: 300,
                    height: 80,
                    decoration: BoxDecoration(
                      
                      color: Color(0xFF00651F),
                      borderRadius: BorderRadius.all(Radius.circular(7))
                    ),
                    padding: EdgeInsets.all(5),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,  
                    children: [MyTitle(text: "Date:${item["schedule_date"]}",color: Colors.white,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [MyText(text: "C:${item["temperature"]}",color: Colors.white)
                    ,MyText(text: "EC:${item["air_humidity"]}",color: Colors.white)
                    ,MyText(text: "PH:${item["sol_humidity"]}",color: Colors.white)
                     ,MyText(text: "Lux:${item["light"]}",color: Colors.white)],)],)
                  )
                  
                  ).toList() ,
                );}
              }
            }),
          ))
        ],),)
          ,
          SizedBox(height: 10,),
          Container(
            width: 300,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                        Container(decoration: BoxDecoration(color: Color(0xFF00651F)
            ,borderRadius: BorderRadius.all(Radius.circular(8))),
          height: 40
          ,width: 40
          ,child: IconButton(onPressed: (){
           Navigator.of(context).pushNamed("/make_Deale");
        }, icon: Icon(Icons.storage),iconSize: 25,color: Color(0xEEFFAA00))),Container(decoration: BoxDecoration(color: Color(0xFF00651F)
            ,borderRadius: BorderRadius.all(Radius.circular(8))),
          height: 40
          ,width: 40
          ,child: IconButton(onPressed: () async{
            SharedPreferences preferences= await SharedPreferences.getInstance();
            dynamic userData=jsonDecode(preferences.getString("user")!);
            if(!isSet){
            
              return;
            }
               try{
                print(cost);
                if(cost==null||product_id==null){
                 
                  return showDialog(context: context, builder: (BuildContext contex){
                    return Container(
                      width: 300,
                      height:400,
                      child:  CupertinoAlertDialog(
                    title: MyTitle(text: "Value missing"),
                    content: MyText(text: "Please fill the following form\nby the expected cost and serial"),
                    
                  ));
                  }) ;
                 
                }
               
                         dynamic response=await http.post(
                        Uri.parse("http://$IP:8000/api/addToCard"),
                          headers:<String,String> {
                            'Content-Type': 'application/json; charset=UTF-8',
                            'Accept':'application/json',},
                            body: jsonEncode({
                              "client_id":userData["id"],
                              "product_id":product_id,
                              "cost":cost
                              
                            }));
                           
                             dynamic deal=await http.post(
                        Uri.parse("http://$IP:8000/api/geteDeals"),
                          headers:<String,String> {
                            'Content-Type': 'application/json; charset=UTF-8',
                            'Accept':'application/json',},
                            body: jsonEncode({
                              "client_id":userData["id"],
                             
                              
                            }));
                           
                            dynamic deal_map=jsonDecode(deal.body);
                          //  print(deal_map['id']);
                            dynamic sale= await http.post(
                        Uri.parse("http://$IP:8000/api/makeDeal"),
                          headers:<String,String> {
                            'Content-Type': 'application/json; charset=UTF-8',
                            'Accept':'application/json',},
                            body: jsonEncode({
                              "saledetail_id":deal_map[0]["id"],
                               "cost":selling_price.getText()
                              
                            }));
                            print(sale.statusCode);
                            if(sale.statusCode==200){
                              return showDialog(context: context, builder: (BuildContext contex){
                    return  Container(
                      width: 300,
                      height:400,
                      child:  const CupertinoAlertDialog(
                    title: MyTitle(text: "Success"),
                    content: MyText(text: "Sale is done successfully"),
                    
                  ));});
                            }
                            else{
                              print(sale.body);
                            }
                            }
                            catch(err){
                              print("err:$err");
                            }
                            
        
        }, icon: Icon(Icons.save),iconSize: 25,color: Color(0xEEFFAA00))),Container(
          decoration: BoxDecoration(color: Color(0xFF00651F)
            ,borderRadius: BorderRadius.all(Radius.circular(8))),
          width: 40,
          height: 40,
          child: IconButton(
          
          onPressed: (){
          toggle();
        }, icon: Icon(Icons.stream),iconSize: 25,color: Color(0xEEFFAA00))),
                Container(
          decoration: BoxDecoration(color: Color(0xFF00651F)
            ,borderRadius: BorderRadius.all(Radius.circular(8))),
          width: 40,
          height: 40
          ,child: IconButton(onPressed: (){
         Navigator.of(context).pushNamed("/market");
        }, icon: Icon(Icons.store),iconSize: 25,color: Color(0xEEFFAA00),))
              ],
            ),
          )],) ,
            ))

          ],) ,
        )
    );
  }
}