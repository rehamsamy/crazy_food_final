import 'package:crazy_food/app/data/models/cart_model.dart';
import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/shared/app_buttons/app_elevated_button.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CartItem extends GetView<HomeController> {
  static double height = 120;
  CartModel ? model;
  CartItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key:ValueKey<int>(1),
      onDismissed: (_){
        showAlertDialog(context);
      },
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppCashedImage(
                  imageUrl:
                     model?.imagePath?? 'https://cdn.pixabay.com/photo/2020/05/17/04/22/pizza-5179939__340.jpg',
                  fit: BoxFit.cover,
                  width: 135,
                  height: 120,
                  radius: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      model?.title??'',
                      fontSize: 16,
                      color: Colors.black,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: AppText(
                        (model?.caleories).toString(),
                        fontSize: 10,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    SizedBox(
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
                SizedBox(
                  width: 20,
                ),
                getIncrementWIdget(),
              ],
            ),
            Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  getIncrementWIdget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            controller.changeItemQuantity('increment');
          },
          icon: Icon(
            Icons.add,
            color: Colors.black,
            size: 20,
          ),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
        SizedBox(
          height: 7,
        ),
        Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: AppText(
              controller.itemQuantity < 10
                  ? '0${controller.itemQuantity}'
                  : '${controller.itemQuantity}',
              color: Colors.white,
              fontSize: 12,
            ))),
        SizedBox(
          height: 5,
        ),
        IconButton(
          onPressed: () {
            controller.changeItemQuantity('decrement');
          },
          icon: Icon(
            Icons.minimize,
            color: Colors.black,
            size: 20,
          ),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ],
    );
  }

  void showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: AppText("delete_cart_item".tr,color: Colors.black,fontSize: 16,
        maxLines: 2,),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppElevatedButton(text: 'delete'.tr, onPressed: (){},fontSize: 18,),
            AppElevatedButton(text: 'cancel'.tr,fontSize: 18, onPressed: (){
              Navigator.of(context).pop();
            }),
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
