import 'dart:async';

import 'package:Smart_pluts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../comon/Logo.dart';
import '../comon/TextInputs.dart';
import '../comon/MyTitle.dart';
import '../comon/MyText.dart';
import '../comon/Button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SignupScreen extends StatefulWidget {
   SignupScreen({super.key});
   final   userName=InputText(text: "Username",);
  final   email=InputText(text: "Email",);
   final   country=InputText(text: "country",);
  final  password=PasswordInput();
  final countries=["Lebanon","Syria","KSA","UAE","Iraq"];
  final Map<String,List<String>> cities={
   "Lebanon":["Saida","Beirut","Tyre","Tripoli","Byblos","Bekaa","Mount Lebanon","El Chouf"],

   "Syria":["Damascus","Aleppo","Homs","Deir ez-Zor","Suwayda","Al Hasakah","Delicacy","Al-Zabadani","Tartous"
   ,"Albukamal","Al-Shaghour"],

   "KSA":["Riyadh","Al-Medina","Macca","Jeddah","Der'aiyah"],

   "UAE":["Abu Dhabi","Al Ain","Sharja"],

   "Iraq":["Baghdad","Al-Najaf","Karbala","Ramadi","Fallujah","Sulaymaniyah","Kirkuk","Anbar","Mosul"
   ,"Tikrit","Nineveh","Basra","Wasta","Dhi-Qar"]
  };
  final user_types=["Farmer","Vendor","Client",];
  List<DropdownMenuItem> countriesItems(List countriesNames){
    List<DropdownMenuItem> items=[];
    for(var county in countriesNames){
      items.add(DropdownMenuItem(child: Text(county),value: county,));
    }
    return items;
  }
  List<DropdownMenuItem>  CitiesItems(List Cities){
    List<DropdownMenuItem> items=[];
    
    for(var city in Cities){
      items.add(DropdownMenuItem(child: Text( city),value:  city,));
    }
    return items;
  }
  List<DropdownMenuItem> TypesItems(List Types){
    List<DropdownMenuItem> items=[];
    for(var Type in Types){
      items.add(DropdownMenuItem(child: Text( Type),value:  Type,));
    }
    return items;
  }
  
  @override
  void signUp (userName,email,password) async{
try{
   final register_infos=await SharedPreferences.getInstance();
   register_infos.setStringList("registers", <String>[userName,email,password]);
          
            //  Navigator.of(context).pushReplacementNamed("/pickuser");
            }
            catch(err){
              print(err);
            }
  }
  _SignupScreenState createState()=>_SignupScreenState();
  }
 class _SignupScreenState extends State<SignupScreen>{
  dynamic selectedCountry;
  dynamic selectedCity;
  dynamic selectedType;
  
    @override void dispose() { // Cleanup code here
     print('dispose called'); 
     super.dispose(); 
     }
  void callBackCountriesDropDown(dynamic selectedCountry){
    if(selectedCountry is String){
      setState((){
      this.selectedCountry=selectedCountry;
      });
    }
  }
  void callBackCitiesDropDown(dynamic selectedCity){
    if(selectedCity is String){
      setState((){
      this.selectedCity=selectedCity;
      });
    }
  }
  void callBackTypesDropDown(dynamic selectedType){
    if(selectedCity is String){
      setState((){
      this.selectedType=selectedType;
      });
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      appBar: AppBar(toolbarHeight: 200,title: Center(child: Logo(),),),
      body: Expanded(child: 
      SingleChildScrollView(child: 
       Container(padding: EdgeInsets.only(bottom: 10),child: Center(child:
       Column(
      
        children:
        <Widget>[
          MyTitle(text: "Welcome back !"),
          MyText(text: "Glad to See you !"),
          SizedBox(height: 10,),
          widget.userName
          ,
          SizedBox(height: 10,),
          widget.email,
          SizedBox(height: 10,),
          widget.password,
          SizedBox(height: 10,),
          
          Container(
            width: 440,
            height:100,
            child:   Wrap(
              alignment: WrapAlignment.center,
              spacing: 0.8,
              runSpacing: 0.4,
              children: [
             
            DropdownButton(
              
               hint: Text("Select your country"),
              items:widget.countriesItems(widget.countries),
              value: selectedCountry,
               onChanged: callBackCountriesDropDown
               ),
               SizedBox(width: 10,),
              selectedCountry != null ? DropdownButton(
              hint: Text("Select City"),
              items:selectedCountry!=null?widget.CitiesItems(widget.cities[selectedCountry]!):null,
              value: selectedCity,
               onChanged: selectedCountry!=null?callBackCitiesDropDown:null
               ):Container(),
                SizedBox(width: 10,),
               DropdownButton(
                hint: Text("Select your type"),
                 itemHeight: 60,
               
              items:widget.TypesItems(widget.user_types),
              value: selectedType,
               onChanged: callBackTypesDropDown
               )
               
          ]),)
          ,SizedBox(height: 10,),
          Button(onPress: ()async{
           final storage=await SharedPreferences.getInstance();
           Map<String,String> credantials={
            "name":widget.userName.getText(),
            "email":widget.email.getText(),
            "password":widget.password.getText()
            };
        
           storage.setString('credential',jsonEncode(credantials));
           storage.setString('user',jsonEncode(credantials['user']));
           //storage.remove('user_information');
         // Navigator.of(context).pushNamed("/pickuser");
           try{
       final response=await http.post(
        Uri.parse("http://$IP:8000/api/register"),
        headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',
            },
        body: jsonEncode(<String, String>{
          "name":widget.userName.getText(),
          "email":widget.email.getText(),
          "password":widget.password.getText(),
          "user_address":selectedCountry+"-"+selectedCity

        })
       
       );
       if(response.statusCode==200){
          final user=jsonDecode(response.body);
         
          
          final type_res=await http.post(
            Uri.parse("http://$IP:8000/api/insertUser"),
            headers:<String,String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',}
            ,
            body:jsonEncode(<String, dynamic> {
              "user_id":user["user"]["id"],
            "user_type":selectedType,
            })
          );
         
          if(type_res.statusCode==200){
            
            if(selectedType=="Farmer"){
             Navigator.of(context).pushReplacementNamed("/dashboard");
            }
            else if(selectedType=="Vendor"){
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
  }, text: "Next"),
          Container(padding: 
          EdgeInsets.only(left: 10,right: 10), margin: EdgeInsets.only(bottom: 10,left: 10),height: 40,child:
            Row(crossAxisAlignment: CrossAxisAlignment.center,children: 
            [
              Text( "do you want to create an account?",style: TextStyle(fontSize: 16,fontFamily: 'Nunito') ,),
            TextButton(style: TextButton.styleFrom(fixedSize: Size(75, 80)),child: 
            Text("Login",style:TextStyle(fontSize: 16,color: Colors.black,fontFamily: 'Nunito')),onPressed: (){Navigator.of(context).pushReplacementNamed("/signin");},)],)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:
             [Container(width: 120,child: Divider(thickness: 2,),)
             ,MyText(text: "Sign Up with"),
             Container(width: 120,child: Divider(thickness: 2,),)]),
             Container(margin: EdgeInsets.only(left: 80,top: 10),child: 
             Row(children:
              [Container(width: 85,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Color(0xFF000000)),child: 
              ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0,backgroundColor: Color(0x0000)),onPressed: (){},child: 
              SvgPicture.asset('./images/google.svg',),),),
              SizedBox(width: 20,),
              Container(width: 85,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Color(0xFF000000)),child:
               ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0,backgroundColor: Color(0x0000)),
               onPressed: (){
               
              widget.signUp(widget.userName.getText(),widget.email.getText(), widget.password.getText());
               print("yyy");
               void show()async{
                try{
                print('d');
                final data = await SharedPreferences.getInstance();
                print(data.getString("user_information"));}
                catch(err){
                  print(err);
                  print("-----");
                }
              
               }
                 show();
               },
               child: SvgPicture.asset('./images/facebook.svg',),)
               )
               ],
               )),
               ]))
               ,)
      ))
    );
  }
}
/**
 * try{
          dynamic response=await http.post(
            //https://official-joke-api.appspot.com/random_joke
            Uri.parse("http://192.168.1.6/api/register"),
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
/*
  use it to check time
  Timer? _timer;
    int _counter=0;
    @override
    void initState(){
    //when a widget or state crated
      super.initState();
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
         setState(() 
         { 
          _counter++; 
         });
         });
    }
    @override void dispose() { 
    //Cleanup code here
    //when an object die
     print('dispose called'); 
     super.dispose(); }
     $_counter;*/