import 'package:crazy_food/app/core/get_binding.dart';
import 'package:crazy_food/app/modules/cart/controller/cart_controller.dart';
import 'package:crazy_food/app/modules/cart/view/widget/cart_item.dart';
import 'package:crazy_food/app/modules/checkout/view/checkout_view.dart';
import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/modules/home/view/widgets/bottom_navigation.dart';
import 'package:crazy_food/app/modules/home/view/widgets/fab_home.dart';
import 'package:crazy_food/app/shared/app_buttons/app_elevated_button.dart';
import 'package:crazy_food/app/shared/app_buttons/app_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartScreen extends GetView<CartController> {
   String ? fabFlag;
   CartScreen({Key? key, this.fabFlag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.changeTotalCartPrice();
    });
    return Scaffold(
          appBar: null,
          body: GetBuilder<CartController>(
            builder: (_) => Container(
              decoration: kContainerDecoraction,
              width: Get.width,
              height: Get.height,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed:()=>Get.to(()=>HomeScreenView(),binding: GetBinding()),
                          icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                        ),
                        AppText('cart'.tr,color: Colors.white,fontSize: 18,),
                        const SizedBox()
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: Get.height,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.vertical(top: Radius.circular(20)),
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
                        PositionedDirectional(
                          bottom:20,
                          start: 1,
                          end: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.all(5),
                            height: 230,
                            child:
                            Card(
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
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                AppText('${'total'.tr}${controller.totalCartPrice}',fontSize: 15,),
                                                AppProgressButton(
                                                      text:'checkout',
                                                    fontSize: 15,
                                                    textColor: Colors.white,
                                                    width: 120,
                                                    height: 35,
                                                    backgroundColor: kPrimaryColor,
                                                  onPressed: (AnimationController animationController) async{
                                                  Future.delayed(const Duration(seconds: 1));
                                                    animationController.forward();
                                                        if(controller.cartItemMap.values.isEmpty){
                                                          Fluttertoast.showToast(
                                                              msg: "cart_empty".tr,
                                                              toastLength: Toast.LENGTH_LONG,
                                                              backgroundColor: kPrimaryColor,
                                                              textColor: Colors.white,
                                                              gravity: ToastGravity.CENTER,);
                                                        }else{
                                                          double total=controller.totalCartPrice;
                                                          Get.off(()=>CheckoutView(),arguments: {'total':total,'products':(controller.cartItemMap.values).toList() });
                                                        }
                                                        // val.reverse();
                                                  },
                                                    // child: Text('checkout',style: const TextStyle(
                                                    //   color: Colors.white
                                                    // ),),
                                                )
                                              ],
                                            ),
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
          bottomNavigationBar:fabFlag=='yes'? const BottomNavigationHome():const SizedBox(),
          floatingActionButtonLocation:fabFlag=='yes'? FloatingActionButtonLocation.centerDocked:null,
          floatingActionButton: fabFlag=='yes'? FabHome():const SizedBox()
    );
  }

  getCartList() {
    Get.log('size is ==>${controller.cartItemMap.length}');
    if(controller.cartItemMap.values.isNotEmpty) {
      return Container(
        height: CartItem.height,
        padding: const EdgeInsets.all(5),
        child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemBuilder: (_, index) => CartItem((controller.cartItemMap.values.toList())[index],index,controller.cartItemMap),
            itemCount: (controller.cartItemMap.values.toList()).length),
      );
    }else{
      return  Container(
          height: CartItem.height,
          padding: const EdgeInsets.all(5),
    child:const Center(child:AppText('no_items')));
    }
  }
}
