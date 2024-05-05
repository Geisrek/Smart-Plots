import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 150,height: 200,child:ClipRRect(
        child:Image.asset("./images/Smartplots.png"),
        
      ));
  }
}