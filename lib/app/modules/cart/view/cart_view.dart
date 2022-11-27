import 'package:crazy_food/app/modules/cart/controller/cart_controller.dart';
import 'package:crazy_food/app/modules/cart/view/widget/cart_item.dart';
import 'package:crazy_food/app/modules/checkout/view/checkout_view.dart';
import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/modules/home/view/widgets/bottom_navigation.dart';
import 'package:crazy_food/app/modules/home/view/widgets/fab_home.dart';
import 'package:crazy_food/app/shared/app_buttons/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartScreen extends GetView<CartController> {
  HomeController homeController=Get.find();
   String ? fabFlag;
   CartScreen({this.fabFlag});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: GetBuilder<CartController>(
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
                      AppText('cart'.tr,color: Colors.white,fontSize: 18,),
                      SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: 10,
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
                            child: GetBuilder<HomeController>(
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            AppText('${'total'.tr}:${homeController.totalCartPrice}',fontSize: 15,),
                                            AppElevatedButton(
                                              text: 'checkout'.tr,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              backgroundColor: kPrimaryColor,
                                              onPressed: (){
                                                if(controller.cartItemMap.values.isEmpty){
                                                  Fluttertoast.showToast(
                                                      msg: "cart_empty".tr,
                                                      toastLength: Toast.LENGTH_LONG,
                                                      backgroundColor: kPrimaryColor,
                                                      textColor: Colors.white,
                                                      gravity: ToastGravity.CENTER,);
                                                }else{
                                                  double total=homeController.totalCartPrice;
                                                  Get.off(()=>CheckoutView(),arguments: {'total':total,'products':(controller.cartItemMap.values).toList() });
                                                }
                                                 },

                                            )
                                          ],
                                        ),
                                      ]
                                  ),
                                );
                              }
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
        bottomNavigationBar:fabFlag=='yes'? BottomNavigationHome():SizedBox(),
        floatingActionButtonLocation:fabFlag=='yes'? FloatingActionButtonLocation.centerDocked:null,
        floatingActionButton: fabFlag=='yes'?FabHome():SizedBox());
  }

  getCartList() {
    Get.log('size is ==>'+controller.cartItemMap.length.toString());
    if(controller.cartItemMap.values.length>0) {
      return Container(
        height: CartItem.height,
        padding: EdgeInsets.all(5),
        child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemBuilder: (_, index) => CartItem((controller.cartItemMap.values.toList())[index]),
            itemCount: (controller.cartItemMap.values.toList()).length),
      );
    }else{
      return  Container(
          height: CartItem.height,
          padding: EdgeInsets.all(5),
    child:Center(child:AppText('no_items')));
    }
  }
}
