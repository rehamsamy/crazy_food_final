import 'package:crazy_food/app/modules/cart/controller/cart_controller.dart';
import 'package:crazy_food/app/modules/cart/view/widget/cart_item.dart';
import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/home/view/widgets/bottom_navigation.dart';
import 'package:crazy_food/app/modules/home/view/widgets/fab_home.dart';
import 'package:crazy_food/app/shared/app_buttons/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:crazy_food/app/data/models/category_model.dart';
import 'package:crazy_food/app/modules/category_items_screen/widget/category_items_item.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:get/get.dart';

class CartScreen extends GetView<HomeController> {
  CategoryItemModel? _categoryItemModel;

  CartScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: GetBuilder<HomeController>(
          builder: (_) => Container(
            decoration: kContainerDecoraction,
            width: Get.width,
            height: Get.height,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppText(
                        'cart'.tr,
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: Get.height,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                          color: Colors.grey.shade50,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 18.0),
                        child: Card(
                            elevation: 8,
                            color: Colors.white,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: getCartList()),
                      ),
                      Positioned(
                        bottom:20,
                        left: 1,
                        right: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(5),
                          height: 230,
                          child: Card(
                            elevation: 5,
                            color: kBlueLightColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        AppText('Total: 14.25',fontSize: 15,),
                                        AppElevatedButton(
                                          text: 'checkout'.tr,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          backgroundColor: kPrimaryColor,
                                          onPressed: (){},

                                        )
                                      ],
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationHome(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FabHome());
  }

  getCartList() {
    return Container(
      height: CartItem.height,
      padding: EdgeInsets.all(5),
      child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemBuilder: (_, index) => CartItem(),
          itemCount: 3),
    );
  }
}
