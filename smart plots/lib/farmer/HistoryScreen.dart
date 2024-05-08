import 'package:flutter/material.dart';
import '../comon/MyTitle.dart';
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: MyTitle(text: "History"),
        ),
      ),
      body: Container(height: 600,width: 400,padding: EdgeInsets.all(5),
      ),
    );
  }
}