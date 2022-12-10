import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/modules/cart/controller/cart_controller.dart';
import 'package:crazy_food/app/modules/cart/view/cart_view.dart';
import 'package:crazy_food/app/modules/category_items_screen/controller/category_items_controller.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscountItem extends StatelessWidget {
  static double height = 150;
  ProductModel model;
  int index;
  CartController cartController = Get.put(CartController());
  CategoryItemsController categoryItemsController =
      Get.put(CategoryItemsController());

  DiscountItem(this.index, this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: colorsMenu[index % 6]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 15,
          ),
          AppCashedImage(
            radius: 12,
            imageUrl: model.imagePath ??
                'https://img.freepik.com/free-photo/top-view-condiments-aromatic-herbs_1220-435.jpg?t=st=1649609286~exp=1649609886~hmac=29ddbc5648f242fd0af6ec09e2ac4c6ebade2615cbad24c4a32b1ab607c8da59&w=1060',
            width: MediaQuery.of(context).size.width * 0.35,
            height: 120,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 15,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  '${model.discount} % DISCOUNT',
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 150,
                    child: AppText(
                      'order_message'.tr,
                      fontSize: 15,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                    )),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: AppText('order_now'.tr,
                      color: kPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  onTap: () {
                    double dis = ((model.price)! * (model.discount ?? 0)) / 100;
                    Get.log('price  =>${model.price}   disc  ${model.discount ?? 0}  equal $dis');
                    cartController.addItemToCartScreen(
                        model.id.toString(),
                        dis,
                        model.nameAr ?? '',
                        model.imagePath ?? '',
                        model.caleories as int);
                    categoryItemsController.cartCount =
                        categoryItemsController.cartCount! + 1;
                    Get.offAll(() => CartScreen(fabFlag: 'yes'));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
