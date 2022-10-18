import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/home/view/widgets/bottom_navigation.dart';
import 'package:crazy_food/app/modules/home/view/widgets/fab_home.dart';
import 'package:crazy_food/app/modules/orders_tab/view/widget/order_item.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app/shared/custom_stepper.dart' as step;
import 'package:crazy_food/app/shared/custom_stepper.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class OrdersDetailsScreen extends GetView<HomeController> {
  List<step.Step> stepList() => [
    const step.Step(title: Text('Account'),time: Text('ddd'), content: Center(child: Text('Account'),)),
    const step.Step(title: Text('Address'),time: Text('ddd'), content: Center(child: Text('Address'),)),
    const step.Step(title: Text('Confirm'),time: Text('ddd'), content: Center(child: Text('Confirm'),))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          CustomStepper(steps: stepList() ),
                              AppText(''),
                              AppText(''),
                              AppText(''),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
        bottomNavigationBar: BottomNavigationHome(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FabHome());
  }
}
