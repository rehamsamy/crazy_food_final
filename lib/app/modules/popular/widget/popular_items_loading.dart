import 'package:crazy_food/app/modules/category_items_screen/widget/category_items_item.dart';
import 'package:crazy_food/app/shared/shimmer_ui_effect.dart';
import 'package:flutter/material.dart';


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
          const SizedBox(height: 7),
          const MyShimmerEffectUI.rectangular(height: 10),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: const MyShimmerEffectUI.rectangular(
              height:  30,
            ),
          ),

        ],
      ),
    );
  }
}
