import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/data/remote_data_source/popular_apis.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/discount_item.dart';
import 'package:crazy_food/app/modules/offers_tab/view/widget/offer_item.dart';
import 'package:flutter/material.dart';
import 'package:crazy_food/app/data/models/order_model.dart';
import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/loading_widget/discount_item_loading.dart';
import 'package:crazy_food/app/modules/orders_tab/controller/order_controller.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:get/get.dart';

class OffersTab extends GetView<HomeController> {
  List<OrderModel> ordersList = [];
  OrderController controller1 = Get.put(OrderController());

  OffersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<HomeController>(builder: (context) {
        return Scaffold(
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
                          onPressed: () => Get.off(() => HomeScreenView()),
                          icon: const Icon(
                            Icons.arrow_back_ios_sharp,
                            color: Colors.white,
                          ),
                        ),
                        AppText(
                          'offers_tab'.tr,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        const SizedBox()
                      ],
                    ),
                    Container(
                      height: Get.height,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20)),
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
                          child: getDiscountList()),
                    )
                  ],
                ),
              )),
        );
      }),
    );
  }

  getDiscountList() {
    return FutureBuilder(
        future: PopularApis().getPopular(),
        builder: (_, snap) {
          if (snap.hasData) {
            List<ProductModel> prods = snap.data as List<ProductModel>;
            List<ProductModel> discountList = [];
            if (prods.isNotEmpty) {
              prods.map((e) {
                if ((e.discount ?? 0.0) > 4) {
                  discountList.add(e);
                }
              }).toList();
              List<ProductModel> discountOrderList =
                  selectionAsecSortFilter(discountList);
              return SizedBox(
                height: DiscountItem.height,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: discountOrderList.length,
                    itemBuilder: (_, index) {
                      // return DiscountItemLoading(index);
                      return OfferItem(index, discountOrderList[index]);
                    }),
              );
            } else if (discountList.isEmpty) {
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
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (_, index) {
                  // return DiscountItemLoading(index);
                  return DiscountItemLoading(index);
                });
          } else {
            return const SizedBox();
          }
        });
  }

  List<ProductModel> selectionAsecSortFilter(List<ProductModel> prodss) {
    List<ProductModel> prods = prodss;
    for (var i = 0; i < prods.length - 1; i++) {
      var indexMin = i;
      for (var j = i + 1; j < prods.length; j++) {
        if ((prods[j].discount)! < (prods[indexMin].discount ?? 0)) {
          indexMin = j;
        }
      }
      if (indexMin != i) {
        var temp = prods[i];
        prods[i] = prods[indexMin];
        prods[indexMin] = temp;
      }
    }
    return prods;
  }
}
