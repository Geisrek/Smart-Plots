import 'dart:ui';

import 'package:Smart_pluts/constants/constants.dart';
import 'package:Smart_pluts/farmer/chatgpt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {
 List<dynamic> data=[];
 List<dynamic> censors=[];
 final openai=OpenAI.instance.build(token: Openai_Key,baseOption: HttpSetup(sendTimeout: Duration(seconds: 5)),enableLog: true);
 String _message="";
  Future<void> getMessage(m)async{
    await Future.delayed(Duration(seconds: 10));
  try{setState((){
_message=m;
  });

   final request = ChatCompleteText(
      messages:[Messages(role: Role.user,name: 'user',content: m).toJson()],
      maxToken: 200,
      model: GptTurbo16k0631Model(),
    );
  final response= await openai.onChatCompletion(request: request);
  print(response);}
  catch(e){
    print('AI Error: $e');
  }
}
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
     'user_id':1
    }),
      
      );
      if (response.statusCode == 200) {
        data= jsonDecode(response.body)['plots'];
      } else {
        throw Exception('Failed to load plots');
      }
    } catch (err) {
      print(err);
      throw Exception('Operation failed ');
    }
  }
  @override
  Widget build(BuildContext context) {
    print('hello');
    //getMessage("Hello chatgpt");
    callChatGPT("Hello");
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
        print('in');
        try{
          final credentials=await SharedPreferences.getInstance();
          credentials.remove('user_information');
          credentials.remove('credential');
           final response=await http.post(
            Uri.parse('http://$IP:8000/api/logout')
           );
           Navigator.of(context).pushReplacementNamed('/');
           print('done');
      }catch(err){
         print('Error:$err');
      }},child: Column(crossAxisAlignment: CrossAxisAlignment.center,children:[Icon(Icons.logout_outlined,size: 23,color: Colors.white,)],),))
           ],
         ),),
         SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [ PlotWidget(
                          path: "./images/add.svg",
                          name: "Add",
                          function: (id) async{
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
           print('----->$_info  , ${_info}');
                            
                          }catch(e){
                            print(e);
                          }
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
                            final plot= await SharedPreferences.getInstance();
                            plot.setInt('plot', id);
                            
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
            child: FutureBuilder(future: callChatGPT("give me the best environment for the potato group"), 
            builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting)
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
                  Expanded(child:  SingleChildScrollView (
                     scrollDirection: Axis.vertical,
                child:MyText(text: snapshot.data!)
                    ));
                   } else {
                     return  Text('No data');
                      }
            }
            
            )
            ,)
            ,)
            ,SizedBox(height: 20,),Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [MyText(text:"Air humidity"),SizedBox(width: 20,),MyText(text: "Sol humidity"),IconButton(onPressed: (){Navigator.of(context).pushNamed("/history");}, icon:  SvgPicture.asset("./images/history.svg") )],),)
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

//PlotWidget(path: "./images/plot.svg", name: "plot1", function:updateIndex, id: 0),PlotWidget(path: "./images/plot.svg", name: "plot2", function:updateIndex, id: 1),PlotWidget(path: "./images/plot.svg", name: "plot3", function:updateIndex, id: 2),PlotWidget(path: "./images/plot.svg", name: "plot4", function:updateIndex, id: 2),PlotWidget(path: "./images/add.svg", name: "", function:updateIndex, id: 2)