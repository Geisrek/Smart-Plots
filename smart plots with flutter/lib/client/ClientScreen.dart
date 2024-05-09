import 'package:flutter/material.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: [
              Container(
                width: 100 ,
                height: 100,
                child: ClipRRect(child: Image.asset("images/client-avatar.png"),),
              )
            ],
          ),
        ),),
        body: Container(
          width: 400,
          height:600 ,
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 380 ,
                  height:200 ,
                  child: Row(),
                )
              ],
            ),
          ),
        ),
    );
  }
}