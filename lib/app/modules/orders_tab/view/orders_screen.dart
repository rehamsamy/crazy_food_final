import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/home/view/widgets/bottom_navigation.dart';
import 'package:crazy_food/app/modules/home/view/widgets/fab_home.dart';
import 'package:crazy_food/app/modules/orders_tab/view/widget/order_item.dart';
import 'package:crazy_food/app/modules/orders_tab/view/widget/order_item_loading.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class OrdersScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 4,
          child: Scaffold(
              appBar: null,
              body: Container(
                  decoration: kContainerDecoraction,
                  width: Get.width,
                  height: Get.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        AppText(
                          'orders_tab'.tr,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        SizedBox(
                          height: 15,
                        ),
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
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0,left: 15,right: 15),
                                  child: SizedBox(
                                    height: 40,
                                    child: TabBar(
                                      isScrollable: true,
                                      indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                        color: kPrimaryColor,
                                      ),
                                      labelColor: Colors.white,
                                      unselectedLabelColor: Colors.black,
                                      tabs: [
                                        Tab(
                                          text: '  ${'all_orders'.tr}  ',
                                        ),
                                        Tab(text: 'pending.tr'),
                                        Tab(text: 'processing.tr'),
                                        Tab(text: 'delivery.tr'),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Expanded(
                                    child: TabBarView(
                                  children: [
                                    ListView.builder(
                                        padding: EdgeInsets.all(0),itemBuilder: (_, index) {
                                      return OrderItemLoading();
                                    }),
                                   Container(
                                     color: Colors.grey,
                                     height: 50,
                                   ),
                                    AppText(''),
                                    AppText(''),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              // bottomNavigationBar: BottomNavigationHome(),
              // floatingActionButtonLocation:
              //     FloatingActionButtonLocation.centerDocked,
              // floatingActionButton: FabHome()
          )
      ),
    );
  }
}
