import 'dart:ui';

import 'package:Smart_pluts/comon/TextInputs.dart';
import 'package:Smart_pluts/constants/constants.dart';
import 'package:Smart_pluts/farmer/chatgpt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../comon/MyTitle.dart";
import '../comon/MyText.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Plot.dart';
import './Plot.dart';
import 'InfoDisplay.dart';
import 'Controle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
class DashBoard extends StatefulWidget {
   DashBoard({super.key});
 


  @override
  State<DashBoard> createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {
   @override
    void initState() {
      super.initState();
      intializeData();
    }
    Future<void> intializeData() async{
      await getUser();
     await fetchPlots();
    }
 List<dynamic> data=[];
 List<dynamic> censors=[];
 dynamic current_user;
 dynamic current_plot;

  getUser() async { 
   
  try{
  final preferences = await SharedPreferences.getInstance(); 
  final String? userData= preferences.getString('user'); 
  print("user :>>${userData}");
  
  setState((){
   current_user=jsonDecode(userData!);
   });
   
   } 
   catch(err){
    print("FETCH USERS ERROR: $err");
   }
  }
  
 final plant=InputText(text: "Plant",);
    readCensorsData()async{
      
     try{
      final humidity=await http.get(
        Uri.parse('http://$ESP32/humidity')
      );
      final temperature=await http.get(
        Uri.parse('http://$ESP32/temperature')
      );
       final light=await http.get(
        Uri.parse('http://$ESP32/light')
      );
       final solHumidity=await http.get(
        Uri.parse('http://$ESP32/solHumidity')
      );
      if(humidity.statusCode==200){
        censors.add(jsonDecode(humidity.body));
      }
      else{
        censors.add('--');
      }
       if(temperature.statusCode==200){
        censors.add(jsonDecode(temperature.body));
      }
      else{
        censors.add('--');
      }
       if(light.statusCode==200){
        censors.add(jsonDecode(light.body));
      }
      else{
        censors.add('--');
      }
      if(solHumidity.statusCode==200){
        censors.add(jsonDecode(solHumidity.body));
      }
      else{
        censors.add('--');
      }
      
     }
     catch(e){

     }
    }
    
   fetchPlots() async {
    try {
      
      final response = await http.post(Uri.parse('http://$IP:8000/api/getPlots'),
           
             headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
     'user_id':this.current_user["user"]["id"]
    }),
      
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        data= jsonDecode(response.body)['plots'];
        print(data);
      } else {
        throw Exception('Failed to load plots');
      }
    } catch (err) {
      print("------------------------------------------errorr----------------------");
      print(this.current_user["user"]["id"]);
      throw Exception('Operation failed $err');
    }
  }
  
 
  @override
  Widget build(BuildContext context) {
   
    return  Scaffold(
     appBar: AppBar(toolbarHeight: 211,shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),backgroundColor: Color(0xFF00651F)
     
     ,title:
       Column(
       children: [
         Container(height: 30,width: 500,margin: EdgeInsets.only(right: 10,bottom: 70,top: 10),child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             MyTitle(text: "Dashboard",color: Colors.white,),
             SizedBox(width: 70,),
             Container( width: 26,height: 26,child: InkWell(onTap: ()async{
        
        try{
          final credentials=await SharedPreferences.getInstance();
          
           final response=await http.post(
            Uri.parse('http://$IP:8000/api/logout')
           );
           Navigator.of(context).pushReplacementNamed('/');
           
      }catch(err){
         print('Error:$err');
      }},child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Icon(Icons.logout_outlined,size: 23,color: Colors.white,)],),))
           ],
         ),),
         SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [ PlotWidget(
                          path: "./images/add.svg",
                          name: "Add",
                          function: (id){
                            Navigator.of(context).pushNamed('/add');
                             },
                          id:0,
                        ),
            FutureBuilder(future: fetchPlots(), builder:(context,snapshot){
      if(snapshot.connectionState==ConnectionState.waiting) {
        return CircularProgressIndicator(color:Color(0xEEFFAA00),);
      }
      else
          {
             
                  
              
            return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: data.map((plot) {
                        return PlotWidget(
                          path: "./images/plot.svg",
                          name: "Plot ${plot['id']}",
                          function: (id) async{
                          try{
                            setState((){
                            this.current_plot=plot;
                            });
                            
                            
                          }catch(e){
                            print(e);
                          }
                          },
                          id: plot['id'],
                        );
                      }).toList(),
                    ),
                  );
                }
          },)],))
       ],
     )),
     body: Container(
      
      height: 600,
      width: 400,
      decoration: BoxDecoration(color: Color(0xFFFFFF),borderRadius: BorderRadius.circular(7)),
      child:Column(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center,
            children: [MyText(text: "Plot 1",color: Color(0xFF00651F)),SizedBox(width: 260,),Container(width: 45,height: 45,child: IconButton(icon: SvgPicture.asset("./images/settings.svg"),onPressed: (){Navigator.of(context).pushNamed('/create_Scduel');},))],),
          
            
            SizedBox(height: 5,)
            ,
            Container(margin: EdgeInsets.only(left: 10),child: Container(
            height: 75,
            width: 300,
            child:this.current_plot!=null? FutureBuilder(future: callChatGPT("give me the best environment for the ${this.current_plot["product"]} group that developed in ${this.current_plot["address"]}"), 
            builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting  )
               { 
                return MyText(text: "--");
                 }
               else if 
               (snapshot.hasError) 
               { 
                print("gpt errore:${this.current_plot}");
                return Text('Error: ${snapshot.error}'); 
                } 
                else if 
                (snapshot.hasData)
                 { 
                  return
                  Expanded(child:  SingleChildScrollView (
                     scrollDirection: Axis.vertical,
                child:MyText(text: snapshot.data!)
                    ));
                   } else {
                     return  Text('No data');
                      }
            }
            
            ):MyText(text: "Please select a plot")
            ,)
            ,)
            ,SizedBox(height: 20,),
            Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              MyText(text:"Air humidity"),
              SizedBox(width: 20,),
              MyText(text: "Sol humidity"),
              IconButton(onPressed: (){Navigator.of(context).pushNamed("/history");}, icon:  SvgPicture.asset("./images/history.svg") )],),)
            ,
            SizedBox(height: 10,)
            ,
            Container(
              child: FutureBuilder(future: readCensorsData(), builder:(context, snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting|| censors.length==0){
                  return Column(
                      children: [
                          InfoDisplayer(path: "./images/soil.svg", label: "EC", value: "--", unit: ""),
               InfoDisplayer(path: "./images/drop.svg", label: "PH", value: "--", unit: "")
              ,
              InfoDisplayer(path: "./images/temperature.svg", label: "Temperature", value:"--", unit: "")
              ,
              InfoDisplayer(path: "./images/sun.svg", label: "light", value: "--", unit: ""),
                      ],
                    );
                }
                else{
                   void initState(){
                        super.initState();
                        Future currentTask()async{
                          try{
                          final plot= await SharedPreferences.getInstance();
                          final plot_id=await plot.getInt("plot");
                          dynamic currentTask=await http.post(
                            Uri.parse("http://localhost:8000/api/schedule"),
                            body: jsonEncode({
                              "plot_id":plot_id
                            })
                          );
                          return currentTask;}
                          catch(err){
                            return null;
                          }
                        }
                       currentTask().then((taskResult)async{
                        final info=await SharedPreferences.getInstance();
                        DateTime now = DateTime.now(); // Format the date as YYYY-MM-DD 
                        String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                        DateTime becomeTask=DateTime.parse(taskResult["schedule_date"]) ;
                        if(now.isAtSameMomentAs(becomeTask)){
                          
                          if(info.getString("schedule")!=null){
                          Map old_task=jsonDecode(info.getString("schedule")!);
                           http.post(
                            Uri.parse("http://$IP:8000/api/finishTask"),
                            body: jsonEncode({
                              'id':old_task["id"]
                            })
                          );
                          }
                          info.setString("schedule", jsonEncode(taskResult));
                        }
                        if(info.containsKey("schedule")&&censors[0]is int && censors[1] is int && censors[2] is int && censors[3] is int){
                        Map currentTask=jsonDecode( info.getString("schedule")!);
                        int EC=int.parse(censors[0]);
                        int PH =int.parse(censors[1]);
                        int tem=int.parse(censors[2]);
                        int light=int.parse(censors[3]);
                        if(EC<currentTask["sol_humidity"] ){
                       
                         http.get(Uri.parse(
                          "http://$ESP32/water"
                         )
                         );

                        }
                        if(PH<currentTask["air_humidity"]){
                          http.get(
                              Uri.parse(
                                'http://$ESP32/fan'
                                ));
                        }
                        if(tem<currentTask["temperature"]|| tem>currentTask["temperature"]){
                            http.get( 
                               Uri.parse(
                                'http://$ESP32/condition'
                                ));
                        }
                        if(light<currentTask["light"]){
                          http.get(
                              Uri.parse(
                                'http://$ESP32/light'
                              ));
                          
                        }
                      }
                        });
                      }
                    return Column(
                     
                      children: [
                          InfoDisplayer(path: "./images/soil.svg", label: "EC", value: censors[0] , unit: ""),
               InfoDisplayer(path: "./images/drop.svg", label: "PH", value: censors[1], unit: "")
              ,
              InfoDisplayer(path: "./images/temperature.svg", label: "Temperature", value:censors[2], unit: "")
              ,
              InfoDisplayer(path: "./images/sun.svg", label: "light", value: censors[3], unit: ""),
                      ],
                    );}
              },),
            ),
             Controle()
        ],
        
      )
     ,),
    );
  }
 
}
/**
 * (id) async{
                          try{
                           final plot=await http.get(
                            Uri.parse("http://plot.local/register"));
                            final info=await SharedPreferences.getInstance();
                           final token= info.getString('credential');
           
            dynamic response=await http.post(
          
            Uri.parse("http://${IP}:8000/api/login"),
             headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',
            'Authorization': 'Bearer $token'  });
           final _info=jsonDecode(response.body);
                            
                          }catch(e){
                            print(e);
                          }
                          }

                          Uri.parse("http://plot.local/register"),
     headers: { 'Content-Type': 'application/json' ,
     'Origin': 'http://your-flutter-web-app.com',
     "Access-Control-Allow-Origin": "*",
     }
 */