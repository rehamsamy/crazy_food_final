import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/product_details/view/product_details_screen.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class CategoryItemsItem extends GetView<HomeController> {
  static double height = 250;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => GestureDetector(
        onTap: () {Get.log('category details ==>');
          Get.to(()=>ProductDetailsScreen());},
        child: Container(
          // margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 0.1, color: Colors.grey)),
          child: Stack(
            children: [
              Positioned(
                left: 1,
                right: 1,
                top: -2,
                child: Container(
                  margin: EdgeInsets.only(top: 4),
                  child: AppCashedImage(
                    imageUrl: 'https://fustany.com/images/en/content/header_image_fustany-burger-recipe-home-made-backdrop-1-.jpg',
                    height: 130,
                    width: MediaQuery.of(context).size.width*0.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                left: 1,
                bottom: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SizedBox(
                          width: 120,
                          child: AppText(
                             'name',
                            fontSize: 16,
                            color: Colors.black,
                            textOverflow: TextOverflow.ellipsis,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: AppText('150',fontSize: 10,color: Colors.grey.shade400,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: AppText('120', color: kPrimaryColor,fontWeight: FontWeight.bold,
                        fontSize: 12,),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                      width: 30,
                      height: controller.isIncrementVisible ? 80 : 40,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(15))),
                      child: controller.isIncrementVisible
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      controller.changeItemQuantity('decrement');
                                    },
                                    child: Icon(
                                      Icons.minimize_outlined,
                                      size: 16,
                                      color: Colors.white,
                                    )),
                                AppText(
                                  controller.itemQuantity<10?'0${controller.itemQuantity}':'${controller.itemQuantity}',
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                                InkWell(
                                    onTap: () {
                                      controller.changeItemQuantity('increment');
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: 16,
                                      color: Colors.white,
                                    )),
                              ],
                            )
                          : Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  size: 14,
                                ),
                                onPressed: () {
                                  controller.handleIsIncrementVisible(true);
                                },
                                color: Colors.white,
                                padding: EdgeInsets.all(0),
                              ),
                            )))
            ],
          ),
        ),
      ),
    );
  }
}
