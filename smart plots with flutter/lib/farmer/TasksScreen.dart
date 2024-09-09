



import 'package:flutter/material.dart';
import './HistoryItem.dart';
import './AppBar.dart';
import './Controle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//192.168.1.3
class TasksScreen extends StatefulWidget {
  TasksScreen({super.key});

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
 List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    getTasks();
  }
  getTasks()async{
    try{
    dynamic response=await http.post(
          
            Uri.parse("http://192.168.1.4:8000/api/getTasks"),
             headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
     
    }),
           );
            data=jsonDecode(response.body)['tasks'];
           print(data);
          }
           catch(err){
            print(err);
           }
  }
  @override
 void didChangeDependencies(){
    super.didChangeDependencies();
    getTasks();
 }
  @override
  Widget build(BuildContext context) {
getTasks();
    const color=Color(0xFFD9D9D9);
  
    return Scaffold(
      appBar: MyBar(Title: "Tasks",).MyAppBarr(),
      body: FutureBuilder(
        future: getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Container(
              height: 600,
              margin: EdgeInsets.all(5),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 520,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              ListView(
                                shrinkWrap: true,
                                children: data.map((item) {
                                  print('----->${item}');
                                  return Infos(
                                    C: item['temperature'].toString(),
                                    EC: item['sol_humidity'].toString(),
                                    Date: item['schedule_date'].toString(),
                                    Lux: item['light'].toString(),
                                    PH: item['air_humidity'].toString(),
                                    color: color,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 450,
                        left: 0,
                        right: 0,
                        child: Controle(),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
 

class Infos extends HistoryItem{
 
  Infos({required super.C,required super.EC, required super.Date,required super.Lux,required super.PH,super.color});
  
  @override
  Widget build(BuildContext context){
   return Container( 
    margin: EdgeInsets.only(top: 5,bottom: 5),
    decoration: BoxDecoration(color:this.color,borderRadius: BorderRadius.circular(7)),
   child:  Column(
    children: [
      super.build(context),
      Row(children:[SizedBox(width: 260,),
      ElevatedButton(onPressed: (){}, child: Text("Cansel",style: TextStyle(fontFamily: 'Nunito',fontSize: 12),))])
    ],
      ));
  }
  
}
/**Container(height: 600,margin: EdgeInsets.all(5),child:Column(children: [ Stack(children:[Container(
        height: 520,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,child:  Column(children: [
              ListView(
              shrinkWrap: true,
              children:  data.entries.map((item){
                return Infos(C: "12", EC: "12", Date: "12", Lux: "12", PH: "12",color:color ,);
              }).toList(),
            ),])),
      ),
     Positioned(
     
      top:450
      ,
      left: 0,
      right: 0,
      child: Controle(),
    )])
            ])),

    );
  }
} */