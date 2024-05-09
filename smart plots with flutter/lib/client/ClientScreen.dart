import 'package:Smart_pluts/comon/MyText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../comon/MyText.dart';
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
                  
                  decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                  width: 250 ,
                  height:150 ,
                  child: Row(
                    crossAxisAlignment:CrossAxisAlignment.center ,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                        children: [
                          MyText(text: "Cabage"),
                          MyText(text: "3\$",)
                        ],
                      )
                    ,Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(borderRadius:BorderRadius.circular(50) ) ,
                      child: SvgPicture.asset("./images/vegetable.svg"),
                    )],
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}