import 'package:flutter/material.dart';
import 'AppBar.dart';
import '../comon/MyText.dart';
class CreateScduelScreen extends StatelessWidget {
  const CreateScduelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBar(Title: "Create a new sceduel",).MyAppBarr(),
    );
  }
}