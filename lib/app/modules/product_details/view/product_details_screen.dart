
import 'package:crazy_food/app/core/get_binding.dart';
import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/modules/product_details/controller/product_details_controller.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
   Map map=Get.arguments;
   ProductModel ? productModel;
   List<ProductModel> ?similarProducts;


  @override
  Widget build(BuildContext context) {
      productModel=map['product_details'] as ProductModel;
    similarProducts=map['similarProducts'] as List<ProductModel>;
    return MaterialApp(
      home: GetBuilder<ProductDetailsController>(
        builder: (_)=> Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 280,
                  floating: true,
                  pinned: false,
                  snap: true,
                  leading: IconButton(icon:Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: ()=>Get.off(()=>HomeScreenView())),
                  backgroundColor: Colors.white,
                  actionsIconTheme: IconThemeData(opacity: 0.0),
                  flexibleSpace: AppCashedImage(
                    imageUrl:
                      productModel?.imagePath?? 'https://cdn.britannica.com/27/218927-050-E99E1D46/Lychee-fruit-tree-plant.jpg',
                    height: 280,
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
                    color:kAuthGreyColor ),
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
                    ),
                    SizedBox(height: 10,),
                    Card(
                      color: Colors.white,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: getProductDetailsData(context),
                    ),
                    SizedBox(height: 10,),
                    Card(
                      color: Colors.white,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(15),
                          child: getSimilarProducts()),
                    ),
                  ],
                ),
              ),
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
          productModel?.nameAr??'model.name',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        AppText(
          ' ${productModel?.discount}.${' Discount'}\$',
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
              '${ productModel?.price}\$',
              fontSize: 14,
            ),
            AppText(
              '${ productModel?.caleories} Calarios',
              fontSize: 14,
            ),
            RatingBarIndicator(
              itemCount: 5,
              itemSize: 20,
              rating:  double.parse((productModel?.rate).toString()),
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

  getProductDetailsData(BuildContext context) {
    return Container(
      height: 220,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  controller.handleISDetailsReviews(true);
                },
                child: AppText(
                  'details'.tr,
                  color:controller.isDetailsSelected? Colors.black:Colors.grey,
                  fontSize:controller.isDetailsSelected? 18:15,
                  fontWeight:controller.isDetailsSelected?FontWeight.bold:FontWeight.normal ,
                ),
              ),
              InkWell(
                onTap: (){
                  controller.handleISDetailsReviews(false);
                },
                child: AppText(
                  'reviews'.tr,
                  color:!controller.isDetailsSelected? Colors.black:Colors.grey,
                  fontSize:!controller.isDetailsSelected? 18:15,
                  fontWeight:!controller.isDetailsSelected?FontWeight.bold:FontWeight.normal ,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: Stack(
              children: [
                getBodyCintent(),
                Positioned(
                    left: controller.isDetailsSelected?70:200,
                    top: -30,
                    child: ClipOval(
                      child: Container(
                        color: Colors.white,
                        height: 60.0,
                        width: 90.0,
                        padding: EdgeInsets.only(bottom: 10),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.orangeAccent),
                            )),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }


  getSimilarProducts(){
    return Container(
      height: 250,
      child: Column(
        children: [
          AppText(
            'similar_products'.tr ,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          SizedBox(height: 5,),
          Divider(color: Colors.grey,thickness: 1,),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
                itemCount: controller.similarProducts?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: (){
                      Get.log('details tapped');
                      Get.offAll(()=>ProductDetailsScreen(),binding: GetBinding(),
                          arguments: {'product_details':controller.similarProducts?[index],
                            'similarProducts':controller.similarProducts});
                    },
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: AppCashedImage(
                          imageUrl:
                         controller.similarProducts?[index].imagePath?? 'https://knoww.cc/wp-content/uploads/2018/06/2718.jpg',
                          radius: 20,
                          width: 250,
                          height: 60,
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }

  getBodyCintent() {
    if (controller.isDetailsSelected){
      return  Container(
        height: 170,
        width: Get.width,
        padding: EdgeInsets.only(top: 40,left: 15,right: 15,bottom: 15),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: AppText(
              productModel?.description??'',color:Colors.white,
              fontSize: 14,
              maxLines: 6,textOverflow: TextOverflow.ellipsis,),
          ),
        ),
      );
    }else{
      return  Container(
        height: 170,
        width: Get.width,
        padding: EdgeInsets.only(top: 40,left: 10,right: 10,bottom: 15),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: ListView.builder(
          itemCount: productModel?.reviews?.length,
          itemBuilder: (context,index) {
            return Row(
              children: [
                 Card(
                   color: Colors.orangeAccent,
                   shape:BeveledRectangleBorder(
                     borderRadius: BorderRadius.circular(20)
                   ),
                   child: SizedBox(height: 14,width: 14,),
                 ),
                Expanded(
                  child: AppText(
                    productModel?.reviews?[index].body??'',color:Colors.white,
                    fontSize: 14,
                    maxLines:1,textOverflow: TextOverflow.ellipsis,),
                ),
              ],
            );
          }
        ),
      );
    }
  }
}
