import 'dart:html';

import 'package:flutter/material.dart';
import './HistoryItem.dart';
class TascksScreen extends StatelessWidget  {
  const TascksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class Infos extends HistoryItem{
  Infos({required super.C,required super.EC, required super.Date,required super.Lux,required super.PH});
  
  @override
  Widget build(BuildContext context){
   return Container( child:  super.build(context));
  }
  
}