import 'package:crazy_food/app/data/models/order_model.dart';
import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/map/view/map_screen.dart';
import 'package:crazy_food/app/modules/orders_tab/view/orders_screen.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app/shared/custom_stepper.dart' as step;
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:another_stepper/another_stepper.dart';

class OrdersDetailsScreen extends GetView<HomeController> {
  OrderModel ? model;
  OrdersDetailsScreen(this.model, {Key? key}) : super(key: key);
  int orderStatus=0;
  // List<step.Step> stepList() => [
  //    step.Step(title: Text('order_placed'.tr),time: '9:30 AM', content:Text('order_placed_dts'.tr),),
  //    step.Step(title: Text('pending'.tr),time:'9:30 AM', content: Center(child: Text('pending_dts'.tr),)),
  //    step.Step(title: Text('confirmed'.tr),time: '9:30 AM', content: Center(child: Text('confirmed_dts'.tr),)),
  //    step.Step(title: Text('processing'.tr),time:'9:30 AM', content: Center(child: Text('processing_dts'.tr),)),
  //    step.Step(title: Text('delivered'.tr),time:'9:30 AM', content: Center(child: Text('delivered_dts'.tr),))
  // ];
  @override
  Widget build(BuildContext context) {
    orderStatus =model?.orderStatus=='pending'?2:
                 model?.orderStatus=='processing'?4:
                 model?.orderStatus=='delivered'?5:0;
    Get.log('status  =>$orderStatus');
    return MaterialApp(
      home: Scaffold(
          appBar: null,
          body: Container(
              decoration: kContainerDecoraction,
              width: Get.width,
              height: Get.height,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                  const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed:()=>Get.offAll(()=>OrdersScreen()),
                      icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                    ),
                    AppText('orders_details'.tr,color: Colors.white,fontSize: 20,),
                    const SizedBox()
                    ]),
                    const SizedBox(height: 15,),
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
                                  Container(
                                    margin:const EdgeInsetsDirectional.only(start: 20),
                                    child: step.AnotherStepper(
                                        stepperList: stepperData,
                                        stepperDirection: Axis.vertical,
                                        iconWidth: 40, // Height that will be applied to all the stepper icons
                                        iconHeight: 40,
                                      activeIndex: orderStatus,
                                    ),
                                  )
                                   // CustomStepper(steps: stepList(),orderStatus: orderStatus),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: Get.height*0.23,
                            child: Card(
                                color: Colors.white,
                                elevation: 10,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                         AppText(
                                          'description'.tr,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                        ),
                                        ListTile(
                                           onTap: () => Get.to(() => const MapScreen(),arguments: {'order_details':model}),
                                          isThreeLine: true,
                                          leading:  AppCashedImage(
                                            imageUrl:model?.products?[0].productImage??
                                            'https://knoww.cc/wp-content/uploads/2018/06/2718.jpg',
                                            radius: 10,
                                            width: 80,
                                            height: 60,
                                          ),
                                          title: AppText(
                                            model?.products?[0].productName??'',
                                            fontSize: 15,
                                          ),
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            color: kPrimaryColor,
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                               AppText(
                                                '${((model?.dateTime)??''.substring(0,10))}',
                                                fontSize: 13,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              AppText(
                                                '${model?.totalAmount} ${'paid'.tr}',
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))
          // bottomNavigationBar: BottomNavigationHome(),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: FabHome()),
    ));
  }

  List<StepperData> stepperData = [
    StepperData(
        title: StepperText(
          'order_placed'.tr,
          textStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
        subtitle: StepperText('order_placed_dts'.tr),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_one, color: Colors.white),
        )),
    StepperData(
        title: StepperText('pending'.tr),
        subtitle: StepperText('pending_dts'.tr.tr),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_two, color: Colors.white),
        )),
    StepperData(
        title: StepperText('confirmed'.tr),
        subtitle: StepperText(
            'confirmed_dts'.tr),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_3, color: Colors.white),
        )),
    StepperData(
        title: StepperText('processing'.tr),
        subtitle: StepperText(
            'processing_dts'.tr),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_3, color: Colors.white),
        )),
    StepperData(
      title: StepperText("delivered".tr,
          textStyle: const TextStyle(
            color: Colors.grey,
          )),
      subtitle: StepperText('delivered_dts'.tr)
    ),
  ];


}
