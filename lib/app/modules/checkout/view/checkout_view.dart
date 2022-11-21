import 'package:crazy_food/app/data/models/payment_model.dart';
import 'package:crazy_food/app/data/remote_data_source/payment_apis.dart';
import 'package:crazy_food/app/modules/checkout/controller/checkout_controller.dart';
import 'package:crazy_food/app/modules/checkout/view/my_fatora.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/loading_widget/discount_item_loading.dart';
import 'package:crazy_food/app/modules/map/view/map_screen.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
class CheckoutView extends GetView<CheckoutController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: GetBuilder<CheckoutController>(
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
                      IconButton(
                        onPressed:()=>Get.to(()=>HomeScreenView()),
                        icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                      ),
                      AppText('add_new_payment'.tr,color: Colors.white,fontSize: 18,),
                      SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: Get.height-100,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20),bottom:  Radius.circular(20)),
                      color: Colors.grey.shade50,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 18.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height *0.40,
                          child: Card(
                              elevation: 8,
                              color: Colors.white,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child:Column(
                                children: [
                                  ListTile(
                                    title: AppText(
                                      'address'.tr,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                    trailing: InkWell(
                                      onTap: () => Get.to(() => MapScreen()),
                                      child: AppText(
                                        'add_new'.tr,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  Divider(color: kPrimaryColor,),
                                  getAddressList(),
                                ],
                              )
                          ),
                        ),
                        SizedBox(
                          height:Get.height *0.40,
                          child: Card(
                              elevation: 8,
                              color: Colors.white,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child:Column(
                                children: [
                                  ListTile(
                                    title: AppText(
                                      'address'.tr,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                    trailing: InkWell(
                                      onTap: () => Get.to(() => MyFatora(double.parse('50'))),
                                      child: AppText(
                                        'add_new'.tr,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  Divider(color: kPrimaryColor,),
                                  getPaymentList(),
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));

  }

  getAddressList() {
    return Container(
      height: 150,
      color: Colors.orangeAccent,
    );
  }

  getPaymentList() {
    // return Container(
    //   height: 150,
    //   color: Colors.orangeAccent,
    // );

    return FutureBuilder(
        future: PaymentApis().getPayment(),
        builder: (_, snap) {
          if (snap.hasData) {
            return Container(color: Colors.red,);
            // List<PaymentModel> paymentList = snap.data as List<PaymentModel>;
            // if (paymentList.isNotEmpty) {
            //   return Container(
            //     height: 200,
            //     child: ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         itemCount: paymentList.length,
            //         itemBuilder: (_, index) {
            //           // return DiscountItemLoading(index);
            //           return Container(color: Colors.blue,);
            //         }),
            //   );
            // } else if (paymentList.isEmpty) {
            //   return Container(
            //     height: 150,
            //     child: Center(
            //       child: AppText('no_cat_found'.tr),
            //     ),
            //   );
            // } else {
            //   return SizedBox();
            // }
          } else if (snap.connectionState == ConnectionState.waiting) {
            return Container(
              height: 200,
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