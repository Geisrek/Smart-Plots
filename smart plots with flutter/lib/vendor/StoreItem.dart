import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../comon/MyText.dart';
class StoreItem extends StatelessWidget {
  final String price;
  final String product_name;
  const StoreItem({super.key, required this.price,required this.product_name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
       child:Row(
        children: [Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("images/usd.svg"),
          MyText(text: this.price)
          ],
        ),Container(width: ,child: Row())],
       ) ,
    );
  }
}