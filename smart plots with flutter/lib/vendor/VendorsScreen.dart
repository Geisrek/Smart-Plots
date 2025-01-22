import 'dart:convert';

import 'package:Smart_pluts/constants/constants.dart';
import 'package:Smart_pluts/farmer/chatgpt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../comon/MyTitle.dart';
import '../comon/TextInputs.dart';
import '../comon/MyText.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../comon/Button.dart';
import 'package:http/http.dart' as http;
class VendorScreen extends StatefulWidget {
   VendorScreen({super.key});
   final serial=InputText(text:"Enter your serial code" );
   final purchasing_price=InputText(text: "Enter the purchasing price");
   final selling_price=InputText(text: "Enter the selling price in \$");
  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
    bool isSet=false;
    dynamic product_id;
    dynamic cost;
  @override
  Widget build(BuildContext context) {
   
  
    void toggle(){
      setState(() {
        isSet=!isSet;
      });
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
          "serial":widget.serial.getText()
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
      print("$isSet");
      if(isSet){   
          try{
        print("2");
    dynamic response=await http.post(
      Uri.parse("http://$IP:8000/api/getSaleBySerial"),
       headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',},
        body: jsonEncode({
          "serial":widget.serial.getText()
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
      print("error in get sale by serial :$e");
      print(widget.purchasing_price.getText());
    }}
    return {};
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100 ,
        title: Row(
          children: [
            MyTitle(text: "Vendor"),
            SizedBox(width: 135,),
            
          ],
        ),
      ),
      body:Container(
        width: 350,
        height: 800,
        child:Flex(
        direction: Axis.vertical,
        children:[Expanded(child:
        SingleChildScrollView(
          child: 
        Container(
        
        padding: EdgeInsets.all(10),
        child:Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [IconButton(onPressed: (){Navigator.of(context).pushNamed("/vendor_storage");}, icon: SvgPicture.asset("./images/saved.svg")),
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
          Icon(Icons.logout_outlined,size: 23,color: Colors.black,)],)), IconButton(onPressed: (){
            Navigator.of(context).pushReplacementNamed("/profile");
          }, icon: Icon(
            Icons.person,
            size: 23,
            color: Colors.black
          ))],),
          SizedBox(height: 10,),
          widget.serial,
          SizedBox(height: 10,),
          widget.purchasing_price,
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
          ),
        Container(
          margin: EdgeInsets.only(top: 10,bottom: 10),
          width: 250,
          height: 100,
          child: Column(
            children: [
              Expanded(child: 
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: isSet&&widget.purchasing_price.getText()!=""&&widget.purchasing_price.getText()!=null? FutureBuilder(future: callChatGPT("with this purchase price ${widget.purchasing_price} for vegetables and fruit give me a good persentage for make benifits and atract the clients"), 
            builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting  )
               { 
                return MyText(text: "--");
                 }
               else if 
               (snapshot.hasError) 
               { 
                
                return Text('Error: ${snapshot.error}'); 
                } 
                else if 
                (snapshot.hasData)
                 { 
                  return
                 Flex(direction: Axis.horizontal,
                 children: [ Expanded(child:  SingleChildScrollView (
                     scrollDirection: Axis.vertical,
                child:MyText(text: snapshot.data!)
                    ))]);
                   } else {
                     return  Text('No data');
                      }
            }
            
            ):MyText(text: "No such product"),
              )
              ,),
            ],
          ),
        ),
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
        widget.selling_price,
        SizedBox(height: 10,) 
        ,Container(
          width: 300
          ,child:Row (
          mainAxisAlignment: MainAxisAlignment.spaceBetween
          ,children:[
           Container(decoration: BoxDecoration(color: Color(0xFF00651F)
            ,borderRadius: BorderRadius.all(Radius.circular(8))),
          height: 40
          ,width: 40
          ,child: IconButton(onPressed: (){
           Navigator.of(context).pushNamed("/make_Deale");
        }, icon: Icon(Icons.storage),iconSize: 25,color: Color(0xEEFFAA00)))
            ,Container(decoration: BoxDecoration(color: Color(0xFF00651F)
            ,borderRadius: BorderRadius.all(Radius.circular(8))),
          height: 40
          ,width: 40
          ,child: IconButton(onPressed: () async{
            SharedPreferences preferences= await SharedPreferences.getInstance();
            dynamic userData=jsonDecode(preferences.getString("user")!);
            if(!isSet){
              print("ddd");
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
                               "cost":widget.selling_price.getText()
                              
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
                            
        
        }, icon: Icon(Icons.save),iconSize: 25,color: Color(0xEEFFAA00))),
        Container(
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
        }, icon: Icon(Icons.store),iconSize: 25,color: Color(0xEEFFAA00),))]))],) ,
      )))] )),
    );
  }
}

