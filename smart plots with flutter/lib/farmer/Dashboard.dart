import 'dart:developer';
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

      getCurrentTask();
      
    }
    List<dynamic> data=[];
 List<dynamic> censors=[];
 dynamic current_user;
 dynamic current_plot;
 dynamic current_task;
   
    Future<void> intializeData() async{
      await getUser();
     await fetchPlots();
     await getCurrentTask();
     await setCurrentPlot();
    }
 

  getUser() async { 
   
  try{
  final preferences = await SharedPreferences.getInstance(); 
  final String? userData= preferences.getString('user'); 
  print(userData);
  
  setState((){
   current_user=jsonDecode(userData!);
   });
   print("user done");
   } 
   catch(err){
    print("FETCH USERS ERROR: $err");
   }
  }
  Future<void> setCurrentPlot()async{
    SharedPreferences infos=await SharedPreferences.getInstance();
     await infos.setString("plot", jsonEncode(this.current_plot));
  }
 final plant=InputText(text: "Plant",);
    readCensorsData()async{
      if(this.current_plot==null){
        censors.add('pending...');
        censors.add('pending...');
        censors.add('pending...');
        censors.add('pending...');
        return;
      }
     try{
      final humidity=await http.get(
        Uri.parse('http://${this.current_plot["IP"]}/humidity')
      );
      final temperature=await http.get(
        Uri.parse('http://${this.current_plot["IP"]}/temperature')
      );
       final light=await http.get(
        Uri.parse('http://${this.current_plot["IP"]}/light')
      );
       final solHumidity=await http.get(
        Uri.parse('http://${this.current_plot["IP"]}/solHumidity')
      );
      if(humidity.statusCode==200){
        censors.add(jsonDecode(humidity.body));
      }
      else{
        censors.add('N/A');
      }
       if(temperature.statusCode==200){
        censors.add(jsonDecode(temperature.body));
      }
      else{
        censors.add('N/A');
      }
       if(light.statusCode==200){
        censors.add(jsonDecode(light.body));
      }
      else{
        censors.add('N/A');
      }
      if(solHumidity.statusCode==200){
        censors.add(jsonDecode(solHumidity.body));
      }
      else{
        censors.add('N/A');
      }
      
     }
     catch(e){

     }
    }
     Future currentTask()async{
          if(this.current_plot==null)   {
            return;
          } 
          try{
          
         
          dynamic currentTask=await http.post(
            Uri.parse("http://$IP:8000/api/schedule"),
            headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'},
            
            body: jsonEncode({
              "plot_id":this.current_plot["id"]
            })
          );
          this.current_task=currentTask;
           print("current Task:${currentTask.body}, plot: ${this.current_plot["id"]}");
          return currentTask;}
          catch(err){
            return null;
          }
        }
   fetchPlots() async {
    try {
      
     
   final response = await http.post(Uri.parse('http://$IP:8000/api/getPlots'),
           
             headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      
    },
    body: jsonEncode(<String, int>{
     'user_id':this.current_user["id"]
    }),
      
      );
      
      print("res2=${response.body}");
      if (response.statusCode == 200) {
        data= jsonDecode(response.body)['plots'];
        
        if(this.current_plot==null&&data.length>0){
          setState(() {
            print("in");
            this.current_plot=data[0];
            
         
        });
       
        }
        getCurrentTask();
      
      } else {
        throw Exception('Failed to load plots');
      }
    } catch (err) {
      throw Exception('Operation failed $err');
    }//schedule_error schedule_date
  }
   Future<void> getCurrentTask() async{
      if(this.current_plot!=null){
     return currentTask().then((taskResult)async{
      
        final task=await taskResult;
        final cur_Task=jsonDecode(task.body);

        final info=await SharedPreferences.getInstance();
        DateTime now = DateTime.now(); // Format the date as YYYY-MM-DD 
        String formattedDate = DateFormat('yyyy-MM-dd').format(now);
          DateTime becomeTask=DateTime.parse(cur_Task["schedule_date"]) ;
          final current_time="${now.year}-${now.month}-${now.day}";
          print(current_time==cur_Task["schedule_date"]);
          print("$current_time  <>  ${cur_Task["schedule_date"]}");
          if(current_time==cur_Task["schedule_date"]){
            print("old task:$cur_Task");
             final response=await http.post(
              Uri.parse("http://$IP:8000/api/finishTask"),
                    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
              body: jsonEncode({
                'id':cur_Task["id"]
              })
            );
            final res=await response;
          
            info.setString("schedule", jsonEncode(cur_Task));
          }
          if(info.containsKey("schedule")&&censors[0]is int && censors[1] is int && censors[2] is int && censors[3] is int){
          Map currentTask=jsonDecode( info.getString("schedule")!);
          int EC=int.parse(censors[0]);
          int PH =int.parse(censors[1]);
          int tem=int.parse(censors[2]);
          int light=int.parse(censors[3]);
          print("--->$currentTask");
          if(EC<cur_Task["sol_humidity"] ){
          
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
          print("done");
        }
          }).catchError((error)=>print("schedule_error:$error"));};
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
           credentials.remove('credential');
           credentials.remove('user');
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
                            final infos= await SharedPreferences.getInstance();
                            await infos.setInt('plot_id',plot["id"]);
                            setState((){
                            this.current_plot=plot;
                            
                            });
                          getCurrentTask();
                            
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
     body:Flex(
      direction: Axis.vertical,
      children:[ Expanded(child: SingleChildScrollView(
      child: 
      Container(
      
      height: 800,
      width: 400,
      decoration: BoxDecoration(color: Color(0xFFFFFF),borderRadius: BorderRadius.circular(7)),
      child:Column(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center,
            children: [this.current_plot!=null?MyText(text:this.current_plot["product"],color: Color(0xFF00651F)):MyText(text: ""),SizedBox(width: 260,),Container(width: 45,height: 45,child: IconButton(icon: SvgPicture.asset("./images/settings.svg"),onPressed: (){Navigator.of(context).pushNamed('/create_Scduel');},))],),
          
            
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
                          InfoDisplayer(path: "./images/soil.svg", label: "EC", value: censors[0], unit: ""),
               InfoDisplayer(path: "./images/drop.svg", label: "PH", value: censors[1], unit: "")
              ,
              InfoDisplayer(path: "./images/temperature.svg", label: "Temperature", value:censors[2], unit: "")
              ,
              InfoDisplayer(path: "./images/sun.svg", label: "light", value:censors[3], unit: ""),
                      ],
                    );
                }
                else{
                   
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
            SizedBox(height: 10,),
            Container(
              height: 200,
              child:Flex(
                direction: Axis.horizontal,
                children:[Expanded(child: SingleChildScrollView(child: 
              
               FutureBuilder(
                future: fetchPlots(),
                builder: (context,snapchot){
                  if(snapchot.connectionState==ConnectionState.waiting){
                    return MyText(text: "pending...");
                  }
                  else if(data.isEmpty){
                    return MyText(text: "No products");
                  }
                  else{
                    return Column(children:  data.asMap().entries.map((plot) {
                      int index=plot.key;
                       Map<String,dynamic> _plot=plot.value;

                        return Row(children: [ SizedBox(width: 2,),Container(
                          width: 300,
                          height: 50,
                          padding: EdgeInsets.only(left: 40,bottom: 10),
                          margin: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(border: Border(left: BorderSide(
                            color: Color(0xFF00651F),
                            width: 40
                          ))),
                          child:Row(children: [MyText(text: "Plot ${index}")
                          ,SizedBox(width: 10,),
                          MyText(text: _plot["product"])],) ,
                        ),SizedBox(width: 10,),InkWell(child: Icon(
                          Icons.currency_exchange,
                          color: Color(0xFF00651F),
                        ) ,onTap: ()async{
                           final preferences = await SharedPreferences.getInstance(); 
                           Map data_to_sale={"plot_id":_plot["id"],"supplier_id":this.current_user["id"],"product":_plot["product"],"address":_plot["address"]};
                           preferences.setString("product", jsonEncode(data_to_sale));
                          Navigator.of(context).pushReplacementNamed("/export");
                          return;
                        },)],);
                      }).toList(),);
                  }
                },
              ),)),
            ]))
            ,
             Controle()
        ],
        
      )
     ,),
    ))]));
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