import 'package:crazy_food/app/core/get_binding.dart';
import 'package:crazy_food/app/data/models/category_model.dart';
import 'package:crazy_food/app/modules/category_items_screen/view/category_item_screen.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
static double height=150;
CategoryItemModel ? model;

CategoryItem(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>
          Get.to(()=>CategoryItemsScreen(),arguments: {'categoryType':model?.id,'categoryName':model?.nameAr},
        binding: GetBinding()),
      child: Column(
        children: [
          Container(
          margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kBackColor1
            ),
            padding: const EdgeInsets.all(8),
            child:AppCashedImage(
              imageUrl:model?.imagePath?? 'https://tse2.mm.bing.net/th?id=OIP.4vrkRMpeUJQM2gjRGsR57wHaEK&pid=Api&P=0',
              height: 80,
              width: 80,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 5,),
          AppText(model?.nameAr??'', maxLines: 1,fontSize: 15,),
        ],
      ),
    );
  }
}
