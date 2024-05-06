import 'package:flutter/material.dart';
import '../comon/MyTitle.dart';
class PickUserType extends StatelessWidget {
  const PickUserType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(title: Center(child: MyTitle(text: "Pick your user type",),),),);
  }
}