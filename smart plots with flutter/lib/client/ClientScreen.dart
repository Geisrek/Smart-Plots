import 'package:flutter/material.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
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
    );
  }
}