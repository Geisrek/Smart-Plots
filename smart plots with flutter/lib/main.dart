import 'package:flutter/material.dart';
import 'credebtials/WelcomScreen.dart';
import 'credebtials/SigninScreen.dart';
import 'credebtials/SingnupScreen.dart';
import 'credebtials/PickUserTypeScreen.dart';
import './farmer/Dashboard.dart';
import './farmer/CreateScduelScreen.dart';
import './farmer/HistoryScreen.dart';
import './farmer/RemoteScreen.dart';
import './farmer/TasksScreen.dart';
import './vendor/VendorsScreen.dart';
import './vendor/VendorStoreScreen.dart';
import './client/ClientScreen.dart';
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
      "/":(context)=> WelcomeScreen(),
      "/signin":(context)=> SigninScreen(),
      "/signup":(context)=>SignupScreen(),
      "/pickuser":(context) => PickUserType(),
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

