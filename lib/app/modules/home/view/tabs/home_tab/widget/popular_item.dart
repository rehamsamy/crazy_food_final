import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularItem extends StatelessWidget {

  int index;
  PopularItem(this.index);
  @override
  Widget build(BuildContext context) {
     return   Padding(
       padding: const EdgeInsets.all(5.0),
       child: AppCashedImage(
         radius: 15,
         height: 130,
         width: 140,
         fit: BoxFit.cover,
         imageUrl: 'https://cdn.britannica.com/27/218927-050-E99E1D46/Lychee-fruit-tree-plant.jpg',
       ),
     );
  }


}
