import 'package:flutter/material.dart';
import 'farmer/WelcomScreen.dart';
import './farmer/SigninScreen.dart';
import './farmer/SingnupScreen.dart';
import './farmer/PickUserTypeScreen.dart';
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
      "/pickuser":(context) => PickUserType()
     },
    );
  }
}

