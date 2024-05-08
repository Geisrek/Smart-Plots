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
      decoration: BoxDecoration(color: Color(0xFFD9D9D9),borderRadius: BorderRadius.circular(7)),
      padding: EdgeInsets.all(5),
       child:Row(
        children: [Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("images/usd.svg"),
          MyText(text: this.price)
          ],
        ),Container(height: 70,width:100 
        ,child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween 
        ,crossAxisAlignment: CrossAxisAlignment.center
        ,children: [MyText(text: this.product_name,),
        IconButton(onPressed: (){Navigator.of(context).pushNamed("/history");}, icon: SvgPicture)],))],
       ) ,
    );
  }
}