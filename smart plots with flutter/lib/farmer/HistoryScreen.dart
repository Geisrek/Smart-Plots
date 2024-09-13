import 'package:Smart_pluts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../comon/MyTitle.dart';
import './HistoryItem.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<dynamic> data = [];
  
  @override
  void initState() {
    super.initState();
    getHistory();
  }
  getHistory()async{
    final infos= await SharedPreferences.getInstance();
    final int _id=await infos.getInt('plot')!;
    try{
    dynamic response=await http.post(
          
            Uri.parse("http://$IP:8000/api/getHistory"),
             headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
     'plot_id':_id
    }),
           );
           data=jsonDecode(response.body);
           print(data);
          }
           catch(err){
            print(err);
           }
  }
  @override
 void didChangeDependencies(){
    super.didChangeDependencies();
    getHistory();
 }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: MyTitle(text: "History"),
        ),
      ),
      body: FutureBuilder(
        future:getHistory(), 
        builder: (context, snapshot)  {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.hasError){
            return  Center(child: Text('Error: ${snapshot.error}'));
          }
          else{
           return ListView(
            
            children: [
                Container(
                  height: 900,
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 520,
                            child: ListView(
                              children: data.map((item) {
                                return HistoryItem(
                                  C: item['temperature'].toString(),
                                  EC: item['sol_humidity'].toString(),
                                  Date: item['schedule_date'].toString(),
                                  Lux: item['light'].toString(),
                                  PH: item['air_humidity'].toString(),
                                 
                                  id: item['id'],
                            
                                );
                              }).toList(),
                            ),
                          ),
                          
                        ],
                      ),
                    ],
                  ),
                ),
              ],
           );}
        },
        ) 
    );
  }
}
/**Container(height: 600
      ,width: 400,
      decoration: BoxDecoration(color: Color(0xFFD9D9D9),borderRadius: BorderRadius.circular(
        7
      ))
      ,padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(top: 40,right: 5,left: 5)
      ,
      child:  SingleChildScrollView(
          scrollDirection: Axis.vertical,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center
        ,children: [
          Container(margin: EdgeInsets.only(right: 250),child: MyTitle(text: "Plot 1")),
          HistoryItem(Date: "11/3/2015", EC: "10", PH: "12", Lux: "100", C: "24",id: 1,),
           HistoryItem(Date: "11/4/2015", EC: "20", PH: "5", Lux: "100", C: "24",id: 1,),
           HistoryItem(Date: "11/3/2015", EC: "10", PH: "12", Lux: "100", C: "24",id: 1,),
           HistoryItem(Date: "11/4/2015", EC: "20", PH: "5", Lux: "100", C: "24",id: 1,),
        ],),
      ),
      ), */