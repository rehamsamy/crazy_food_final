import 'package:crazy_food/app/data/models/cart_model.dart';
import 'package:crazy_food/app/modules/cart/controller/cart_controller.dart';
import 'package:crazy_food/app/shared/app_buttons/app_progress_button.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItem extends GetView<CartController> {
  static double height = 120;
  int index;
  CartModel? model;
  Map<String, CartModel> _cartsList = {};

  CartItem(this.model, this.index, this._cartsList);

  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (_) => Dismissible(
        key: model?.id != null ? Key(model!.id) : UniqueKey(),
        direction: DismissDirection.startToEnd,
        background: Container(
          margin: const EdgeInsets.all(15),
          height: 20,
          color: kPurpleColor,
          child: Text('delete'.tr),
        ),
        onDismissed: (_) {
          showAlertDialog(context);
        },
        child: InkWell(
          onTap: () {
            // Get.off(()=>ProductDetailsScreen(),
            //     binding: GetBinding(),
            //     arguments: {'product_details':model,
            //       'similarProducts':similarProducts});
          },
          child: GetBuilder<CartController>(builder: (context) {
            return Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppCashedImage(
                        imageUrl: model?.imagePath ??
                            'https://cdn.pixabay.com/photo/2020/05/17/04/22/pizza-5179939__340.jpg',
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                        radius: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 120,
                            child: AppText(
                              model?.title ?? '',
                              fontSize: 16,
                              color: Colors.black,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: AppText(
                              (model?.caleories).toString(),
                              fontSize: 10,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: AppText(
                              (model?.price).toString(),
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      getIncrementWidget(
                          double.parse((model?.price).toString()), index),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  getIncrementWidget(double price, int index) {
    int selectedIndex = 0;
    return GetBuilder<CartController>(builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              Get.log('cart  =>' + controller.cartItemMap.values.toString());
              // selectedIndex = index;
              // Get.log('selectedIndex  =>' + selectedIndex.toString());
              // controller.changeCartSelectedIndex(index);
              controller.changeItemQuantity('increment', model?.id ?? '');
              controller.changeTotalCartPrice();
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
              size: 25,
            ),
            padding: const EdgeInsets.all(5),
            constraints: const BoxConstraints(),
          ),
          const SizedBox(
            height: 7,
          ),
          Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: AppText(
                (model?.quantity ?? 0) < 10
                    ? '0${(model?.quantity ?? 0)}'
                    : '${(model?.quantity ?? 0)}',
                color: Colors.white,
                fontSize: 15,
              ))),
          const SizedBox(
            height: 5,
          ),
          IconButton(
            onPressed: () {
              selectedIndex = index;
              controller.changeCartSelectedIndex(index);
              controller.changeItemQuantity('decrement', model?.id ?? '');
              controller.changeTotalCartPrice();
            },
            icon: const Icon(
              Icons.minimize,
              color: Colors.black,
              size: 25,
            ),
            padding: const EdgeInsets.all(5),
            constraints: const BoxConstraints(),
          ),
        ],
      );
    });
  }

  void showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: AppText(
        "delete_cart_item".tr,
        color: Colors.black,
        fontSize: 16,
        maxLines: 2,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: AppProgressButton(
                  height: 40,
                  // width: Get.width,
                  textColor: Colors.white,
                  backgroundColor: kPrimaryColor,
                  text: 'delete'.tr,
                  onPressed: (val) {
                    val.forward();
                    Future.delayed(const Duration(seconds: 5))
                        .then((value) => val.reverse());
                    if (_cartsList.values.toList().contains(model?.id ?? '')) {
                      controller.removeCartItem(index);
                      controller.update();
                      val.reverse();
                      Get.log('remove item  ===>');
                    }
                    //
                    // Get.offAll(()=>CartScreen(),binding: GetBinding());
                  },
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: AppProgressButton(
                    height: 40,
                    width: 50,
                    text: 'cancel'.tr,
                    textColor: Colors.white,
                    backgroundColor: kPrimaryColor,
                    fontSize: 18,
                    onPressed: (val) {
                      val.forward();
                      Future.delayed(const Duration(seconds: 5));
                      val.reverse();
                      Navigator.of(context).pop();
                    }),
              ),
            ),
          ],
        )
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
