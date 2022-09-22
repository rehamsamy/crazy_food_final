import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
static double height=150;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
        margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kBackColor1
          ),
          padding: EdgeInsets.all(8),
          child:AppCashedImage(
            imageUrl: 'https://tse2.mm.bing.net/th?id=OIP.4vrkRMpeUJQM2gjRGsR57wHaEK&pid=Api&P=0',
            height: 80,
            width: 80,
            fit: BoxFit.contain,
          ) ,
        ),
        SizedBox(height: 5,),
        AppText('cat name', maxLines: 1,fontSize: 15,),
      ],
    );
  }
}
