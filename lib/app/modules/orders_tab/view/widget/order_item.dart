import 'package:crazy_food/app/data/models/order_model.dart';
import 'package:crazy_food/app/modules/orders_details/view/orders_details_screen.dart';
import 'package:crazy_food/app/modules/orders_tab/controller/order_controller.dart';
import 'package:crazy_food/app/shared/app_buttons/app_elevated_button.dart';
import 'package:crazy_food/app/shared/app_buttons/app_progress_button.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
class OrderItem extends GetView<OrderController> {
  OrderModel model;
  OrderItem(this.model);
  @override
  Widget build(BuildContext context) {
    Get.log('cccc '+(model.address).toString());
    return InkWell(
       onTap: ()=>Get.to(()=>OrdersDetailsScreen()),
      child: Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor,width: 0.8),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
                itemCount: model.products?.length,itemBuilder: (_,index){
              return ProductItem(model.products![index]);
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  '${'total'.tr} ${model.totalAmount}\$',
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                AppProgressButton(
                  width: 70,
                  height: 35,
                  text: model.orderStatus??'Processing',
                  onPressed: (val) {},
                  backgroundColor: Colors.grey.shade100,
                  textColor: Colors.black,
                ),
                Row(
                  children: [
                    IconButton(onPressed: ()async{
                      final availableMaps = await MapLauncher.installedMaps;
                      print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                      await availableMaps.first.showMarker(
                        coords: Coords(model.latitude??0.0, model.longitude??0.0),
                        title: "Shanghai Tower",
                        description: model.address??"Asia's tallest building",
                      );
                    },
                        icon: Icon(Icons.location_on,color: kPrimaryColor,)),
                    SizedBox(
                      width: 70,
                      child: AppText(
                        '${(model.address).toString().substring(15,50)}',
                      ),
                    ),
                  ],
                )

              ],
            )

          ],
        ),
      ),
      // child: Container(
      //   height: 130,
      //   margin: EdgeInsets.all(10),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           AppCashedImage(
      //             imageUrl: productModel.productImage??'https://knoww.cc/wp-content/uploads/2018/06/2718.jpg',
      //             width: Get.width * 0.30,
      //             height: 80,
      //             fit: BoxFit.cover,
      //           ),
      //           SizedBox(
      //             width: Get.width * 0.30,
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.all(2.0),
      //                   child: AppText(
      //                    productModel.productName?? 'Meat new food',
      //                     fontSize: 16,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.all(2.0),
      //                   child: AppText(
      //                     '${productModel.price}\$',
      //                     color: kPrimaryColor,
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 14,
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   height: 10,
      //                 ),
      //                 AppElevatedButton(
      //                   text: 'Processing',
      //                   onPressed: () {},
      //                   backgroundColor: Colors.grey.shade100,
      //                   textColor: Colors.black,
      //                 )
      //               ],
      //             ),
      //           ),
      //           SizedBox(
      //             height: 70,
      //             child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     // AppText('ll'),
      //                     SizedBox(),
      //                     SizedBox(
      //                       width: Get.width*0.20,
      //                       child: AppText(
      //                         '10 Aug,2020',
      //                         color: Colors.grey,
      //                         textOverflow: TextOverflow.ellipsis,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //           )
      //
      //         ],
      //       ),
      //       Divider(color: kPrimaryColor,)
      //     ],
      //   ),
      // ),
    );
  }
}

class ProductItem  extends StatelessWidget{
  Products productModel;

  ProductItem(this.productModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppCashedImage(
                  imageUrl: productModel.productImage??'https://knoww.cc/wp-content/uploads/2018/06/2718.jpg',
                  width: Get.width * 0.20,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: Get.width * 0.30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: AppText(
                         productModel.productName?? 'Meat new food',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: AppText(
                          '${productModel.price}\$',
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // AppElevatedButton(
                      //   text: 'Processing',
                      //   onPressed: () {},
                      //   backgroundColor: Colors.grey.shade100,
                      //   textColor: Colors.black,
                      // )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           SizedBox(
                               width: Get.width*0.20,
                               child: AppText('${'quantity'.tr} ${productModel.quantity.toString()}')),
                          SizedBox(
                            width: Get.width*0.20,
                            child: AppText(
                              '10 Aug,2020',
                              color: Colors.grey,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                )

              ],
            ),
             Divider(color: kPurpleColor,)
          ],
        ),
    );
  }
}
