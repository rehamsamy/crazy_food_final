import 'package:crazy_food/app/data/models/address_model.dart';
import 'package:crazy_food/app/data/models/payment_model.dart';
import 'package:crazy_food/app/data/remote_data_source/add_address_api.dart';
import 'package:crazy_food/app/data/remote_data_source/add_orders_apis.dart';
import 'package:crazy_food/app/data/remote_data_source/payment_apis.dart';
import 'package:crazy_food/app/modules/address/view/address_screen.dart';
import 'package:crazy_food/app/modules/checkout/controller/checkout_controller.dart';
import 'package:crazy_food/app/modules/checkout/view/my_fatora.dart';
import 'package:crazy_food/app/modules/checkout/view/widget/address_widget.dart';
import 'package:crazy_food/app/modules/checkout/view/widget/payment_widget.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/loading_widget/discount_item_loading.dart';
import 'package:crazy_food/app/modules/orders_tab/view/orders_screen.dart';
import 'package:crazy_food/app/shared/app_buttons/app_elevated_button.dart';
import 'package:crazy_food/app/shared/app_buttons/app_progress_button.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'package:fluttertoast/fluttertoast.dart';

class CheckoutView extends GetView<CheckoutController>{
var controller =Get.find();
List<PaymentModel> paymentList=[];
List<Address> addressList=[];
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
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed:()=>Get.to(()=>HomeScreenView()),
                        icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                      ),
                      AppText('checkout'.tr,color: Colors.white,fontSize: 18,),
                      SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: Get.height-90,
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
                                    contentPadding: EdgeInsets.only(top: 0,left: 10,right: 10,bottom: 0),
                                    minVerticalPadding: 0,
                                    title: AppText(
                                      'address'.tr,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                    trailing: InkWell(
                                      onTap: () => Get.to(() => AddressScreen()),
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
                          height:Get.height *0.35,
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
                                    contentPadding: EdgeInsets.only(top: 0,left: 10,right: 10,bottom: 0),
                                    minVerticalPadding: 0,
                                    title: AppText(
                                      'payment'.tr,
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
                        SizedBox(height: 10,),
                        checkOrderButton(context)
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
    return FutureBuilder(
        future: AddAddressApis().getAddress(),
        builder: (_, snap) {
          if (snap.hasData) {
            addressList = snap.data as List<Address>;
            if (addressList.isNotEmpty) {
              return Expanded(
                // height: 150,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: addressList.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                          onTap: (){
                          },
                          child: AddressWidget(addressList[index],index,index==controller.addressIndex));
                    }),
              );
            } else if (addressList.isEmpty) {
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
  getPaymentList() {
    return FutureBuilder(
        future: PaymentApis().getPayment(),
        builder: (_, snap) {
          if (snap.hasData) {
             paymentList = snap.data as List<PaymentModel>;
            if (paymentList.isNotEmpty) {
              return Expanded(
                // height: 150,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: paymentList.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: (){

                        },
                          child: PaymentWidget(paymentList[index],index,index==controller.paymentIndex));
                    }),
              );
            } else if (paymentList.isEmpty) {
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

  checkOrderButton(BuildContext context) {
    return    AppProgressButton(
      onPressed: (animationController) async {
        animationController.forward();
        await Future.delayed(Duration(seconds: 2));
        if(addressList.isNotEmpty&& paymentList.isNotEmpty) {
          _showDialog(context);
        }else{
          Fluttertoast.showToast(
            msg: "cart_empty".tr,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            gravity: ToastGravity.CENTER,);
        }

      },
      text: ("checkout".tr),
      textColor: Colors.white,
      backgroundColor: kPrimaryColor,
      height: 40,
    );
  }
  void _showDialog(BuildContext context) {
    Get.log('alerttt');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildCircle(),
                  SizedBox(width: 2,),
                  buildCircle(),
                  SizedBox(width: 2,),
                  buildCircle()
                ],),
              SizedBox(height: 20,),
              Image.asset('assets/images/shopping-cart.png'),
              AppText('order_success'.tr,fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold,),
              SizedBox(height: 8,),
              AppText('order_success_data'.tr,fontSize: 15,color: Colors.grey,),
              SizedBox(height: 20,),
              AppElevatedButton(text: 'track_my_order'.tr, onPressed: () async {
                  bool result = await AddOrdersApis().addOrder(
                      carts: controller.cartProducts ?? [],
                      total: controller.total ?? 0.0,
                      address:
                          addressList[controller.addressIndex].addressTitle ??
                              '',
                      payment: paymentList[controller.paymentIndex].type,
                      latitude:
                          addressList[controller.addressIndex].latitude ?? 0.0,
                      longitude:
                          addressList[controller.addressIndex].longitude ??
                              0.0);
                  if (result) {
                    Navigator.of(context).pop();
                    Get.offAll(() => OrdersScreen());
                  }
             
                   // ????????????????
                ////   add order to firebase ///////

              },backgroundColor: kPrimaryColor,
                textColor: Colors.white,),
              SizedBox(height: 20,),
              InkWell(child: AppText('go_back'.tr,color: kPrimaryColor,),
                onTap: (){
                  Navigator.of(context).pop();
                  Get.offAll(()=>HomeScreenView());
                },)
            ],
          ),
        );
      },
    );
  }


  buildCircle(){
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kAccentColor.withOpacity(0.4)
      ),
    );
  }

}