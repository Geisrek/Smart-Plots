import 'package:Smart_pluts/constants/constants.dart';
import 'package:Smart_pluts/farmer/AddScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'credebtials/WelcomScreen.dart';
import 'credebtials/SigninScreen.dart';
import 'credebtials/SingnupScreen.dart';

import './farmer/Dashboard.dart';
import './farmer/CreateScduelScreen.dart';
import './farmer/HistoryScreen.dart';
import './farmer/RemoteScreen.dart';
import './farmer/TasksScreen.dart';
import './vendor/VendorsScreen.dart';
import './vendor/VendorStoreScreen.dart';
import './client/ClientScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
 
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     routes: {
      '/auth':(context)=>Auth2(),
      "/welcomw":(context)=> WelcomeScreen(),
      "/":(context)=> SigninScreen(),
      "/signup":(context)=>SignupScreen(),
      "/add":(context)=>AddScreen(),
      "/dashboard":(context) => DashBoard(),
      "/create_Scduel":(context) => CreateScduelScreen(),
      "/history":(context) => HistoryScreen(),
      "/remote":(context) => RemoteScreen(),
      "/tasks":(context) => TasksScreen(),
      "/vendor":(context)=>VendorScreen(),
      "/vendor_storage":(context) => VendorStoreScreen(),
      "/client":(context) => ClientScreen()
     },
    );
  }
}
class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
   Future <Widget>  authorisation()async{
      
 final data=await SharedPreferences.getInstance();
    
           final token= data.getString('credential');
           
            dynamic response=await http.post(
          
            Uri.parse("http://${IP}:8000/api/login"),
             headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept':'application/json',
            'Authorization': 'Bearer $token'  });
           final info=jsonDecode(response.body);
           print('----->$info  , ${info}');
            if(info['status']=='success'){
             return DashBoard();
            };
           return WelcomeScreen();
           }
          
   return Container() ;
}
}
class Auth2 extends StatelessWidget {
  const Auth2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Widget> authorisation() async {
      final data = await SharedPreferences.getInstance();
      final token = data.getString('credential');

      dynamic response = await http.post(
        Uri.parse("http://192.168.0.100:8000/api/login"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final info = jsonDecode(response.body);
      print('----->$info');

      if (info['status'] == 'success') {
        return DashBoard();
      } else {
        return WelcomeScreen();
      }
    }

    // Call the authorisation function and return the corresponding widget
    return FutureBuilder<Widget>(
      future: authorisation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the response
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle error (e.g., network error)
          return Text('Error: ${snapshot.error}');
        } else {
          // Return the widget based on the response
          return snapshot.data ?? WelcomeScreen(); // Fallback to WelcomeScreen
        }
      },
    );
  }
}
