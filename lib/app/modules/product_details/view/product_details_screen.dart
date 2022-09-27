import 'package:crazy_food/app/modules/product_details/controller/product_details_controller.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              floating: true,
              pinned: false,
              snap: true,
              backgroundColor: Colors.white,
              actionsIconTheme: IconThemeData(opacity: 0.0),
              flexibleSpace: AppCashedImage(
                imageUrl:
                    'https://cdn.britannica.com/27/218927-050-E99E1D46/Lychee-fruit-tree-plant.jpg',
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            height: 800,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(20),
                  left: Radius.circular(20),
                ),
                color: Colors.grey.shade300),
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: getFirstProductData()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getFirstProductData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          'model.name' ?? '',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        AppText(
          '${'model.itemDiscount'}\$',
          color: Colors.grey,
          fontSize: 13,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppText(
              '${'model.itemPrice'}\$',
              fontSize: 14,
            ),
            AppText(
              '40 Calarios',
              fontSize: 14,
            ),
            RatingBarIndicator(
              itemCount: 1,
              itemSize: 27,
              rating: 1,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, _) => Icon(
                Icons.star_border,
                color: Colors.amber,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.minimize_outlined,
                      color: Colors.white,
                      size: 18,
                    )),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            AppText(
              'quantity kg',
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    )),
              ),
            ),
          ],
        )
      ],
    );
  }
}
