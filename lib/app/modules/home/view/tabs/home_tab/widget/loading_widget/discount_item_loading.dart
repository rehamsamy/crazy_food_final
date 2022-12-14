import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/category_item.dart';
import 'package:crazy_food/app/shared/shimmer_ui_effect.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../app_constant.dart';



class DiscountItemLoading extends StatelessWidget {
int index;
DiscountItemLoading(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
        margin: const EdgeInsets.all(5.0),
    padding: const EdgeInsets.all(5.0),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: colorsMenu[index%6]
    ),
      child:Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 5,),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: MyShimmerEffectUI.rectangular(
                  height: CategoryItem.height - 50,
                ),
              ),
          const SizedBox(width: 5,),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(12),
          //   child: MyShimmerEffectUI.rectangular(
          //     height: CategoryItem.height - 70,
          //     // width: Get.width*20,
          //   ),
          // ),
          const SizedBox(width: 5,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              MyShimmerEffectUI.rectangular(height: 10),
              SizedBox(height: 10,),
              MyShimmerEffectUI.rectangular(height: 15 ),
              SizedBox(height: 20,),
              MyShimmerEffectUI.rectangular(height: 10)
            ],
          )
        ],
      ),

      // Column(
      //   children: [
      //     ClipRRect(
      //       borderRadius: BorderRadius.circular(8),
      //       child: MyShimmerEffectUI.rectangular(
      //         height: CategoryItem.height - 50,
      //       ),
      //     ),
      //     SizedBox(height: 5),
      //     MyShimmerEffectUI.rectangular(height: 10)
      //   ],
      // ),
      ) );
  }
}
