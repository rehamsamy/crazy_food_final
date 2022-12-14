import 'package:crazy_food/app/core/get_binding.dart';
import 'package:crazy_food/app/data/models/order_model.dart';
import 'package:crazy_food/app/data/remote_data_source/add_orders_apis.dart';
import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/modules/orders_tab/controller/order_controller.dart';
import 'package:crazy_food/app/modules/orders_tab/view/widget/order_item.dart';
import 'package:crazy_food/app/modules/orders_tab/view/widget/order_item_loading.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersScreen extends GetView<HomeController> {
  List<OrderModel> ordersList=[];
  OrderController controller1=Get.put(OrderController());

  OrdersScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetBuilder<HomeController>(
        builder: (context) {
          return DefaultTabController(
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
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed:()=>Get.offAll(()=>HomeScreenView(),
                                  binding: GetBinding()),
                                  icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                                ),
                                AppText('orders_tab'.tr,color: Colors.white,fontSize: 18,),
                                const SizedBox()
                              ],
                            ),
                            const SizedBox(
                            ),
                            Container(
                              height: Get.height,
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.vertical(top: Radius.circular(20)),
                                color: Colors.grey.shade50,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
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
                                             Tab(text: 'pending'.tr),
                                             Tab(text: 'processing'.tr),
                                             Tab(text: 'delivery'.tr),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
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
          );
        }
      ),
    );
  }
  getOrdersList() {
    return FutureBuilder(
        future: AddOrdersApis().getOrders(),
        builder: (_, snap) {
          if (snap.hasData) {
             ordersList = snap.data as List<OrderModel>;
             handleOrdersType(ordersList);
            if (ordersList.isNotEmpty) {
            return  Expanded(
                  child: TabBarView(
                    children: [
                      ListView.builder(
                        itemCount: ordersList.length,
                          padding: const EdgeInsets.all(0),itemBuilder: (_, index) {
                           return OrderItem(ordersList[index]);
                      }),
                      getPendingList('pending'),
                      getPendingList('processing'),
                      getPendingList('delivered'),
                    ],
                  ));
            } else if (ordersList.isEmpty) {
              return SizedBox(
                height: 150,
                child: Center(
                  child: AppText('no_cat_found'.tr),
                ),
              );
            } else {
              return const SizedBox();
            }
          } else if (snap.connectionState == ConnectionState.waiting) {
            return Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (_, index) {
                    // return DiscountItemLoading(index);
                    return const OrderItemLoading();
                  }),
            );
          } else {
            return const SizedBox();
          }
        });
  }

  getPendingList(var type){
      List<OrderModel>newList=
          ordersList.where((element) => element.orderStatus==type).toList();
      Get.log('');
      if(newList.isNotEmpty){
      return
          ListView.builder(
              itemCount: newList.length,
              padding: const EdgeInsets.all(0),itemBuilder: (_, index) {
            return OrderItem(newList[index]);
          });
    }else{
        return SizedBox(
          height: 150,
          child: Center(
            child: AppText('no_cat_found'.tr),
          ),
        );
      }
  }

  Future<void> handleOrdersType(List<OrderModel> ordersList) async {
    ordersList.where((element)  {
      Get.log('date =>${element.dateTime}');
      if(true){
        // Future.delayed(Duration(seconds: 10)).then((value) {
        //   AddOrdersApis().updateOrder(
        //       carts: element.products ?? [],
        //       total: element.totalAmount ??0.0,
        //       address:
        //       element.address ?? '',
        //       payment: element.payment??'',
        //       latitude:element.latitude?? 0.0,
        //       longitude:element.longitude ??
        //           0.0);
        // });

        return true;
      }
    }).toList();

  }
}
