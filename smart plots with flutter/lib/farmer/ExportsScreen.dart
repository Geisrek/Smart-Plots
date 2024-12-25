import 'package:Smart_pluts/comon/MyText.dart';
import 'package:Smart_pluts/comon/MyTitle.dart';
import 'package:Smart_pluts/comon/TextInputs.dart';
import 'package:Smart_pluts/constants/constants.dart';
import 'package:Smart_pluts/farmer/AppBar.dart';
import 'package:Smart_pluts/farmer/chatgpt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
class ExportsScreen extends StatefulWidget {
  const ExportsScreen({super.key});

  @override
  State<ExportsScreen> createState() => _ExportsScreenState();
}

class _ExportsScreenState extends State<ExportsScreen> {
 dynamic selectedUnit;
 dynamic random = Random();
 String error="";
  List<dynamic> Units= ["\$","L.L","SAR","AED","JOD","SYP","IQD"];
    
  Map product={"plot_id":"N/A","supplier_id":"N/A","product":"N/A","address":"N/A"};
  
  final Cost=InputText(text: "Cost",width: 120,);
  @override
 void initState() {
    super.initState();
    setProduct();
  }
  void callBackUnitsDropDown(dynamic selectedUnit){
    if(selectedUnit is String){
      setState((){
      this.selectedUnit=selectedUnit;
      });
    }
  }
  Future<void> setProduct()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState((){
     this.product =jsonDecode(preferences.getString("product")!);
     
    });
 
   
  }
  List<DropdownMenuItem>  UnitsItems(List Units){
    List<DropdownMenuItem> items=[];
    
    for(var Unit in Units){
      items.add(DropdownMenuItem(child: Text( Unit),value:  Unit,));
    }
    return items;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBar(Title: "${product["product"]} Sale").MyAppBarr(),
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children:[this.product["product"]!="N/A"? FutureBuilder(future: callChatGPT("give me the best price for the ${this.product["product"]} group that developed in ${this.product["address"]} base on the sol and weather quality where the last banana price is 63 cents in USA give it to me in USD direct price dont write more than 3 lines withe comparisons between ${this.product["address"]}& USA"), 
            builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting  )
               { 
                return MyText(text: "--");
                 }
               else if 
               (snapshot.hasError) 
               { 
                print("gpt errore:${this.product}");
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
            
            ):MyText(text: "Please select a plot")
          ,MyTitle(text: error ,color: Colors.red,),
          Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [MyText(text: "Products: "),
          SizedBox(width: 10,),
          MyText(text: product["product"])],),),
          SizedBox(height: 10,),
      Cost,SizedBox(height: 10,), 
       DropdownButton(
              hint: Text("Select Unit"),
              items:UnitsItems(Units),
              value: selectedUnit,
               onChanged: callBackUnitsDropDown
               )
      ,SizedBox(height: 10,),ElevatedButton(onPressed: ()async{
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        String getCharacter() { 
          return characters[random.nextInt(characters.length)]; 
          }
        bool isCostInteger = int.tryParse(Cost.getText()) != null;
        String product_serial="${getCharacter()}${getCharacter()}${getCharacter()}${getCharacter()}-${getCharacter()}${getCharacter()}${getCharacter()}${getCharacter()}";
        if(isCostInteger){
        final response=await http.post(
              Uri.parse("http://$IP:8000/api/Sale"),
                    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept':'application/json',
    },
              body: jsonEncode({
                'plot_id':product["plot_id"],
                'product':product["product"],
                'supplier_id':product["supplier_id"],
                'cost':int.tryParse(Cost.getText()),
                'currency_unit':selectedUnit,
                'product_serial':product_serial
              }));
        if(response.statusCode==200){
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.remove("product");
        Navigator.of(context).pushReplacementNamed("/dashboard");}
        else{
          setState(() {
            error="Export failed error:${response.statusCode}";
          });
        }}
      }, child: MyText(text: "dashboard"))])),);
    
  }
}

/**
 * product.entries.map((e) => Container( child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [ MyText(text: "${e.key}: "), SizedBox(width: 8,height: 10,), MyText(text: "${e.value}"), ], ), )).toList()
 */