import 'package:crazy_food/app/data/models/order_model.dart';
import 'package:crazy_food/app/data/remote_data_source/add_orders_apis.dart';
import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/loading_widget/discount_item_loading.dart';
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
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed:()=>Get.offAll(()=>HomeScreenView()),
                              icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                            ),
                            AppText('orders_tab'.tr,color: Colors.white,fontSize: 18,),
                            SizedBox()
                          ],
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
                               getOrdersList()
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
  getOrdersList() {
    return FutureBuilder(
        future: AddOrdersApis().getOrders(),
        builder: (_, snap) {
          if (snap.hasData) {
            List<OrderModel> ordersList = snap.data as List<OrderModel>;
            if (ordersList.isNotEmpty) {
            return  Expanded(
                  child: TabBarView(
                    children: [
                      ListView.builder(
                        itemCount: ordersList[0].products?.length,
                          padding: EdgeInsets.all(0),itemBuilder: (_, index) {
                        //   return OrderItemLoading();
                        return OrderItem(ordersList[0].products![index]);
                      }),
                      Container(
                        color: Colors.grey,
                        height: 50,
                      ),
                      AppText(''),
                      AppText(''),
                    ],
                  ));
            } else if (ordersList.isEmpty) {
              return Container(
                height: 150,
                child: Center(
                  child: AppText('no_cat_found'.tr),
                ),
              );
            } else {
              return SizedBox();
            }
          } else if (snap.connectionState == ConnectionState.waiting) {
            return Container(
              height: 150,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (_, index) {
                    // return DiscountItemLoading(index);
                    return DiscountItemLoading(index);
                  }),
            );
          } else {
            return SizedBox();
          }
        });
  }
}
