import 'package:crazy_food/app/modules/category_items_screen/widget/category_items_item.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/category_item.dart';
import 'package:crazy_food/app/shared/shimmer_ui_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CategoryItemsLoading extends StatelessWidget {
  const CategoryItemsLoading({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: MyShimmerEffectUI.rectangular(
              height: CategoryItemsItem.height - 80,
            ),
          ),
          SizedBox(height: 7),
          MyShimmerEffectUI.rectangular(height: 10),
          SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: MyShimmerEffectUI.rectangular(
              height:  30,
            ),
          ),

        ],
      ),
    );
  }
}
