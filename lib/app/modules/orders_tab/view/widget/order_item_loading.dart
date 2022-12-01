import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/category_item.dart';
import 'package:crazy_food/app/shared/shimmer_ui_effect.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class OrderItemLoading extends StatelessWidget {
  const OrderItemLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: MyShimmerEffectUI.rectangular(
                  width: Get.width *0.30,
                  height: CategoryItem.height - 80,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyShimmerEffectUI.rectangular(height: 12, width: Get.width *0.15,),
                  SizedBox(height: 5,),
                  MyShimmerEffectUI.rectangular(height: 12, width: Get.width *0.15,),
                  SizedBox(height: 20,),
                  MyShimmerEffectUI.rectangular(height: 32, width: Get.width *0.15,)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 20,),
                  MyShimmerEffectUI.rectangular(height: 12, width: Get.width *0.20,)
                ],
              )
            ],
          ),
          Divider(color: kPrimaryColor,)
        ],
      ),
    );
  }
}
