import 'package:crazy_food/app/modules/map/controller/map_controller.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
class MapScreen extends GetView<MapController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            color: Colors.amber.withOpacity(0.4),
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                  margin: EdgeInsets.all(6),
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  height: 240,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8), borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppCashedImage(
                        imageUrl: userAvatar,
                        height: 50,
                        width: 50,
                        borderColor: Colors.white,
                        borderWidth: 2,
                        isCircular: true,
                        fit: BoxFit.cover,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            'Mohamed Ahmed',
                            color: Colors.white,
                          ),
                          AppText(
                            'hello',
                            color: Colors.grey,
                          ),
                          RatingBar.builder(
                            itemSize: 15,
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
              Container(
                margin: EdgeInsets.all(6),
                alignment: Alignment.topCenter,
                height: 150,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: AppText(
                              'shipping_details.tr',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            )),
                        Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/dumy7.jpg',
                              width: 80,
                              height: 80,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                AppText(
                                  'straberrey',
                                  fontSize: 18,
                                ),
                                AppText(
                                  '1.5 kg ',
                                  fontSize: 13,
                                ),
                                AppText(
                                  '150.0 (paid)',
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );

  }
  
}