import 'dart:convert';

import 'package:Smart_pluts/comon/MyText.dart';
import 'package:Smart_pluts/comon/TextInputs.dart';
import 'package:Smart_pluts/constants/constants.dart';
import 'package:Smart_pluts/farmer/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  List<dynamic> register=[];
   dynamic selectedCity;
   String? country="";
   List<String> Cities= [];
   @override
  initState(){
    super.initState();
    setAddress();
  }

  
    void callBackCitiesDropDown(dynamic selectedType){
    if(selectedType is String){
      setState((){
      this.selectedCity=selectedType;
      });
    }
  }
  
  final plant= InputText(text: "Your plant type",width:200);
  fetchEspInfo() async{
    try{
     final response=await http.get(Uri.http("plot.local","/register"));
     dynamic the_plot=json.decode( response.body);
     register.add(the_plot) ;
    }catch(e){
         register.add("error") ;
         print("Errore:$e");
    }
  }
  List<DropdownMenuItem>  CitiesItems(List Cities){
    List<DropdownMenuItem> items=[];
    
    for(var city in Cities){
      items.add(DropdownMenuItem(child: Text( city),value:  city,));
    }
    return items;
  }
  Future<void> setAddress()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    dynamic country=jsonDecode(preferences.getString('user')!)["user_address"].split("-")[0];
    
     
    setState(() {
      Cities=cities[country]??[];
    });
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(appBar: MyBar(Title: "Add plot").MyAppBarr(),
    body: Flex(direction:Axis.vertical ,children: [ Expanded(
                      child: 
                            SingleChildScrollView(
                                child:Column(children: <Widget>[ FutureBuilder(future: fetchEspInfo(), builder: (context,snapshot){
                                  if(snapshot.connectionState==ConnectionState.waiting) {
                                    return CircularProgressIndicator(color:Color(0xEEFFAA00),strokeWidth: 4.0,);
                                  }
                                  else{
                                    if(register.length==0){
                                  return Center(child: MyText(text: "No data"),);}
                                  else if(register[0]=="error"){
                                    return Center(child: MyText(text: "Some thing went wrong"),);}
                                    else{
                                    return  Center(child: Column(
                                      children: [Container(child: MyText(text: register[0]["IP"]),),
                                      SizedBox( height:5),
                                     
                                      SizedBox( height:5),
                                      DropdownButton(
              hint: Text("Select City"),
              items:CitiesItems(Cities),
              value: selectedCity,
               onChanged: callBackCitiesDropDown
               )
                                     ],
                                    ));
                                  }
                                  }
                                  
                                  }
                                  
                                ), 
                                plant ,
                                      SizedBox( height:5),
                                      Row(children:[ElevatedButton(onPressed: (){
                                        register.removeLast();
                                      } , child: MyText(text: "reject")),SizedBox(width: 10),
                                      ElevatedButton(onPressed: ()async{
                                         final preferances= await SharedPreferences.getInstance();
                                         final dynamic data=preferances.getString("user")!;
                                         final dynamic user=jsonDecode(data);
                                        try{
                                          //modify the esp response to send address
                                          print('User ID: ${user["id"]}');
                                           print('Address: $selectedCity');
                                            print('Product: ${plant.getText()}');
                                             print('IP: ${register[0]["IP"]}');
                                             final Uri url = Uri.http("local:8000", "/api/createPlot");
                                         dynamic response=await http.post(
                                           Uri.parse("http://$IP:8000/api/createPlot"),
                                             headers: <String, String>{
                                                'Content-Type': 'application/json; charset=UTF-8',
                                                'Accept':'application/json',
                                              },
                                            body:jsonEncode(<String,dynamic>{
                                              "user_id":user["id"],
                                              "address":selectedCity,
                                              "product":plant.getText(),
                                              "IP":register[0]["IP"]
                                            })
                                          );
                                         final body = await response;
                                       
                                         Navigator.of(context).pushReplacementNamed('/dashboard');
                                        }
                                        catch(e){
                                        print(e);
                                        }
                                       
                                      } , child: MyText(text: "accept"))])],
                             ))),],));
  }
}