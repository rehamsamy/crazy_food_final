import 'package:crazy_food/app/modules/orders_details/view/orders_details_screen.dart';
import 'package:crazy_food/app/modules/orders_tab/controller/order_controller.dart';
import 'package:crazy_food/app/shared/app_buttons/app_elevated_button.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class OrderItem extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Get.to(()=>OrdersDetailsScreen()),
      child: Container(
        height: 120,
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppCashedImage(
                  imageUrl: 'https://knoww.cc/wp-content/uploads/2018/06/2718.jpg',
                  width: Get.width * 0.30,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: Get.width * 0.30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: AppText(
                          'Meat new food',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: AppText(
                          '25\$',
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AppElevatedButton(
                        text: 'Processing',
                        onPressed: () {},
                        backgroundColor: Colors.grey.shade100,
                        textColor: Colors.black,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // AppText('ll'),
                          SizedBox(),
                          SizedBox(
                            width: Get.width*0.20,
                            child: AppText(
                              '10 Aug,2020',
                              color: Colors.grey,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                )

              ],
            ),
            Divider(color: kPrimaryColor,)
          ],
        ),
      ),
    );
  }
}
