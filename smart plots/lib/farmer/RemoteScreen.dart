import 'package:flutter/material.dart';
import "AppBar.dart";
import './Controle.dart';
import './Plot.dart';
class RemoteScreen extends StatelessWidget {
  const RemoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyBar(Title: "Remote").MyAppBarr(),
      body:Container(width: 400,
      height: 600,
      child: Column(
        children: [
          Container(
            height: 460
            ,width: 390,
            child: Wrap(children: [Row()],
            ),
            )
            ,Controle()],),) ,
    );
  }
}