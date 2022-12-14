import 'package:crazy_food/app/data/models/address_model.dart';
import 'package:crazy_food/app/data/models/payment_model.dart';
import 'package:crazy_food/app/data/remote_data_source/add_address_api.dart';
import 'package:crazy_food/app/data/remote_data_source/add_orders_apis.dart';
import 'package:crazy_food/app/data/remote_data_source/payment_apis.dart';
import 'package:crazy_food/app/modules/address/view/address_screen.dart';
import 'package:crazy_food/app/modules/cart/controller/cart_controller.dart';
import 'package:crazy_food/app/modules/checkout/controller/checkout_controller.dart';
import 'package:crazy_food/app/modules/checkout/view/my_fatora.dart';
import 'package:crazy_food/app/modules/checkout/view/widget/address_widget.dart';
import 'package:crazy_food/app/modules/checkout/view/widget/payment_widget.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/loading_widget/discount_item_loading.dart';
import 'package:crazy_food/app/modules/orders_tab/view/orders_screen.dart';
import 'package:crazy_food/app/shared/app_buttons/app_progress_button.dart';
import 'package:crazy_food/app/shared/app_dialog.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fluttertoast/fluttertoast.dart';

class CheckoutView extends GetView<CheckoutController> {
  var controller = Get.put(CheckoutController());
  List<PaymentModel> paymentList = [];
  List<Address> addressList = [];

  CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'EG'),
      home: Scaffold(
          appBar: null,
          body: GetBuilder<CheckoutController>(
            builder: (_) => Container(
              decoration: kContainerDecoraction,
              width: Get.width,
              height: Get.height,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () => Get.to(() => HomeScreenView()),
                          icon: const Icon(
                            Icons.arrow_back_ios_sharp,
                            color: Colors.white,
                          ),
                        ),
                        AppText(
                          'checkout_bar'.tr,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        const SizedBox()
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: Get.height - 90,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                            bottom: Radius.circular(20)),
                        color: Colors.grey.shade50,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 18.0),
                      child: Column(
                        children: [
                          Card(
                              elevation: 8,
                              color: Colors.white,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: SizedBox(
                                height: Get.height * 0.35,
                                child: Column(
                                  children: [
                                    ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          top: 0,
                                          left: 10,
                                          right: 10,
                                          bottom: 0),
                                      minVerticalPadding: 0,
                                      title: AppText(
                                        'address'.tr,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      trailing: InkWell(
                                        onTap: () =>
                                            Get.to(() => const AddressScreen()),
                                        child: AppText(
                                          'add_new'.tr,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      color: kPrimaryColor,
                                    ),
                                    getAddressList(),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: Get.height * 0.35,
                            child: Card(
                                elevation: 8,
                                color: Colors.white,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          top: 0,
                                          left: 10,
                                          right: 10,
                                          bottom: 0),
                                      minVerticalPadding: 0,
                                      title: AppText(
                                        'payment'.tr,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      trailing: InkWell(
                                        onTap: () => Get.to(
                                            () => MyFatora(double.parse('50'))),
                                        child: AppText(
                                          'add_new'.tr,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      color: kPrimaryColor,
                                    ),
                                    getPaymentList(),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Material(
                            child: AppProgressButton(
                              onPressed: (animationController) async {
                                animationController.forward();
                                await Future.delayed(const Duration(seconds: 2));
                                animationController.reverse();
                                if (addressList.isNotEmpty &&
                                    paymentList.isNotEmpty) {
                                  _showDialog(context);

                                  ///??????????????????????
                                  // addOrder(context);
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "cart_empty".tr,
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: kPrimaryColor,
                                    textColor: Colors.white,
                                    gravity: ToastGravity.CENTER,
                                  );
                                }
                              },
                              text: "checkout",
                              textColor: Colors.white,
                              backgroundColor: kPrimaryColor,
                              height: 40,
                            ),
                          ),
                          // checkOrderButton(context)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
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
                    reverse: true,
                    itemCount: addressList.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: InkWell(
                            onTap: () {},
                            child: AddressWidget(addressList[index], index,
                                index == controller.addressIndex)),
                      );
                    }),
              );
            } else if (addressList.isEmpty) {
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
            return SizedBox(
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
            return const SizedBox();
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
                    reverse: true,
                    scrollDirection: Axis.vertical,
                    itemCount: paymentList.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: InkWell(
                            onTap: () {},
                            child: PaymentWidget(paymentList[index], index,
                                index == controller.paymentIndex)),
                      );
                    }),
              );
            } else if (paymentList.isEmpty) {
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
            return SizedBox(
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
            return const SizedBox();
          }
        });
  }

  checkOrderButton(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppProgressButton(
        onPressed: (animationController) async {
          animationController.forward();
          await Future.delayed(const Duration(seconds: 2));
          animationController.reverse();
          if (addressList.isNotEmpty && paymentList.isNotEmpty) {
            _showDialog(context);
          } else {
            Fluttertoast.showToast(
              msg: "cart_empty".tr,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: kPrimaryColor,
              textColor: Colors.white,
              gravity: ToastGravity.CENTER,
            );
          }
        },
        text: ("checkout".tr),
        textColor: Colors.white,
        backgroundColor: kPrimaryColor,
        height: 40,
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showAppDialog(
      context,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCircle(),
              const SizedBox(width: 2),
              buildCircle(),
              const SizedBox(
                width: 2,
              ),
              buildCircle()
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/images/shopping-cart.png',
            width: 150,
            height: 150,
          ),
          AppText(
            'order_success'.tr,
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 8),
          AppText(
            'order_success_data'.tr,
            fontSize: 15,
            color: Colors.grey,
          ),
          const SizedBox(height: 20),
          AppProgressButton(
            text: 'track_my_order'.tr,
            onPressed: (animationController) async {
              animationController.forward();
              await Future.delayed(const Duration(seconds: 4));
              bool result = await AddOrdersApis().addOrder(
                  carts: controller.cartProducts ?? [],
                  total: controller.total ?? 0.0,
                  address:
                      addressList[controller.addressIndex].addressTitle ?? '',
                  payment: paymentList[controller.paymentIndex].type,
                  latitude:
                      addressList[controller.addressIndex].latitude ?? 0.0,
                  longitude:
                      addressList[controller.addressIndex].longitude ?? 0.0);
              if (result) {
                Navigator.of(context).pop();
                Get.offAll(() => OrdersScreen());
                Get.put(CartController()).cartItemMap.clear();
                Get.put(CartController()).cartCount = 0;
                Fluttertoast.showToast(
                  msg: "create_order_sucess".tr,
                  toastLength: Toast.LENGTH_LONG,
                  backgroundColor: kPrimaryColor,
                  textColor: Colors.white,
                  gravity: ToastGravity.CENTER,
                );
              } else {
                Fluttertoast.showToast(
                  msg: "general_error".tr,
                  toastLength: Toast.LENGTH_LONG,
                  backgroundColor: kPrimaryColor,
                  textColor: Colors.white,
                  gravity: ToastGravity.CENTER,
                );
              }
            },
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
          ),
          const SizedBox(height: 20),
          InkWell(
            child: AppText(
              'go_back'.tr,
              color: kPrimaryColor,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Get.offAll(() => HomeScreenView());
            },
          )
        ],
      ),
    );
  }

  buildCircle() {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: kAccentColor.withOpacity(0.4)),
    );
  }

  addOrder(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4));
    bool result = await AddOrdersApis().addOrder(
        carts: controller.cartProducts ?? [],
        total: controller.total ?? 0.0,
        address: addressList[controller.addressIndex].addressTitle ?? '',
        payment: paymentList[controller.paymentIndex].type,
        latitude: addressList[controller.addressIndex].latitude ?? 0.0,
        longitude: addressList[controller.addressIndex].longitude ?? 0.0);
    if (result) {
      Navigator.of(context).pop();
      Get.offAll(() => OrdersScreen());
      Fluttertoast.showToast(
        msg: "create_order_sucess".tr,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: kPrimaryColor,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    } else {
      Fluttertoast.showToast(
        msg: "general_error".tr,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: kPrimaryColor,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}
