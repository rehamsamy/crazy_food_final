import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/category_item.dart';
import 'package:crazy_food/app/shared/shimmer_ui_effect.dart';
import 'package:flutter/material.dart';


class PopularItemLoading extends StatelessWidget {
  const PopularItemLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: MyShimmerEffectUI.rectangular(
              height: CategoryItem.height - 50,
            ),
          ),
          // SizedBox(height: 5),
          // MyShimmerEffectUI.rectangular(height: 10)
        ],
      ),
    );
  }
}
