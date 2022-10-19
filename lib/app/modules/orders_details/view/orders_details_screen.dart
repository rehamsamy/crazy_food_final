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
     step.Step(title: Text('order_placed'.tr),time: '9:30 AM', content:Text('order_placed_dts'.tr),),
     step.Step(title: Text('pending'.tr),time:'9:30 AM', content: Center(child: Text('pending_dts'.tr),)),
     step.Step(title: Text('confirmed'.tr),time: '9:30 AM', content: Center(child: Text('confirmed_dts'.tr),)),
     step.Step(title: Text('processing'.tr),time:'9:30 AM', content: Center(child: Text('processing_dts'.tr),)),
     step.Step(title: Text('delivered'.tr),time:'9:30 AM', content: Center(child: Text('delivered_dts'.tr),))
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
              physics: BouncingScrollPhysics(),
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
                    child: Column(
                      children: [
                        SizedBox(
                          height:Get.height*0.58,
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: Get.height*0.20,
                          child: Card(
                              color: Colors.white,
                              elevation: 10,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      'description.tr',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    ListTile(
                                      // onTap: () => Get.to(() => MapScreen(), binding: GetBinding()),
                                      isThreeLine: true,
                                      leading:Container(
                                        color: Colors.amber,
                                        width: 70,
                                        height: 70,
                                      ),
                                      title: AppText(
                                        'Straberrery(1kg)',
                                        fontSize: 15,
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: kPrimaryColor,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            '1.5 kg ',
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          AppText(
                                            '150.0 (paid)',
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
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
