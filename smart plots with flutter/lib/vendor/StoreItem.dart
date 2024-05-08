import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../comon/MyText.dart';
class StoreItem extends StatelessWidget {
  final String price;
  const StoreItem({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
       child:Row(
        children: [Column(
          children: [
            SvgPicture.asset("images/usd.svg"),
          MyText(text: this.price)
          ],
        )],
       ) ,
    );
  }
}