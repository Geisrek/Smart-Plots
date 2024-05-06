import 'package:flutter/material.dart';
import 'credebtials/WelcomScreen.dart';
import 'credebtials/SigninScreen.dart';
import 'credebtials/SingnupScreen.dart';
import 'credebtials/PickUserTypeScreen.dart';
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

