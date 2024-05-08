import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../comon/MyText.dart';
class StoreItem extends StatelessWidget {
  const StoreItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
       child:Row(
        children: [Column(
          children: [
            SvgPicture.asset("images/usd.svg"),
    
          ],
        )],
       ) ,
    );
  }
}