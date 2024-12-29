import 'package:Smart_pluts/comon/MyText.dart';
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
  dynamic current_user;
  @override
  Future<void>? _historyFuture;
   @override 
   void initState() {
     super.initState();
      _historyFuture = getHistory();
      } // Store the Future in a variable to cache the result }
 Future<void> getHistory() async { 
  final infos = await SharedPreferences.getInstance(); 
  final int? _id = infos.getInt('plot_id');
   final String? userData = infos.getString('user'); 
   if (_id == null || userData == null) { 
    print("No plot or user data found in SharedPreferences."); 
    return; 
    } 
    print("user :>> $userData");
    print("id>>$_id");
     setState(() {
       current_user = jsonDecode(userData);
        });
       if (current_user == null) { 
        return; 
        } try { 
          final response = await http.post( Uri.parse("http://$IP:8000/api/getHistory"), 
          headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8', }, 
          body: jsonEncode(<String, int>{ 'plot_id': _id, }), ); 
          setState(() { 
            data = jsonDecode(response.body); 
            }); 
            print(data); }
            catch (err) { print("schedule's error: $err"); }
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
        future:_historyFuture, 
        builder: (context, snapshot)  {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: MyText(text: ("Wating...")),
            );
          }
          else if (data.isEmpty) { return Center( child: MyText(text: "No schedule found"), );}
         
          else if(snapshot.hasError){
            return  Center(child: Text('Error: ${snapshot.error}'));
          }
          else{
              if(data.length==0){
            return Center(
              child: MyText(text: ("No scheduel found")),
            );
          }
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
                                  EC: item['air_humidity'].toString(),
                                  Date: item['schedule_date'].toString(),
                                  Lux: item['light'].toString(),
                                  PH: item['sol_humidity'].toString(),
                                 
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
