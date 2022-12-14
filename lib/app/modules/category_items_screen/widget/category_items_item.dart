import 'package:crazy_food/app/core/get_binding.dart';
import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/modules/category_items_screen/controller/category_items_controller.dart';
import 'package:crazy_food/app/modules/product_details/view/product_details_screen.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItemsItem extends GetView<CategoryItemsController> {
  static double height = 230;
  ProductModel model;
  int ? index;
  List<ProductModel> ?allProducts;
  List<ProductModel> ?similarProducts=[];
  int ?selectedIndex;
  CategoryItemsItem(this.model,this.allProducts,this.index, {Key? key}) : super(key: key);
  @override
    Widget build(BuildContext context) {
    allProducts!.map((e) {
      if (e.idType==model.idType){
        similarProducts!.add(e);
        return e;
      }
    }).toList()  ;
    return GetBuilder<CategoryItemsController>(
      init: CategoryItemsController(),
      builder: (_) => InkWell(
        onTap: () {
          Get.to(()=>ProductDetailsScreen(),binding: GetBinding(),
              arguments: {'product_details':model,
                          'similarProducts':similarProducts
                          ,'index':index ,});},
        child: Container(
          // margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 0.1, color: Colors.grey)),
          child: Stack(
            children: [
              PositionedDirectional(
                start: 1,
                end: 1,
                top: -2,
                child: Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: AppCashedImage(
                    imageUrl: model.imagePath??'https://fustany.com/images/en/content/header_image_fustany-burger-recipe-home-made-backdrop-1-.jpg',
                    height: 150,
                    width: MediaQuery.of(context).size.width*0.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              PositionedDirectional(
                start: 1,
                bottom: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SizedBox(
                          width: 120,
                          child: AppText(
                            model.nameAr??'name',
                            fontSize: 16,
                            color: Colors.black,
                            textOverflow: TextOverflow.ellipsis,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: AppText((model.caleories).toString(),fontSize: 10,color: Colors.grey.shade400,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: AppText((model.discount).toString(), color: kPrimaryColor,fontWeight: FontWeight.bold,
                        fontSize: 12,),
                    ),
                  ],
                ),
              ),
              PositionedDirectional(
                  bottom: 0,
                  end: 0,
                  child: Container(
                      width: 30,
                      height: controller.itemIndex==index? 80 : 40,
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius:
                              BorderRadius.
                              only(topLeft: Radius.circular(15))),
                      child: controller.itemIndex==index
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      controller.changeItemQuantity('decrement',index,model);
                                    },
                                    child: const Icon(
                                      Icons.minimize_outlined,
                                      size: 16,
                                      color: Colors.white,
                                    )),
                                AppText(
                                  controller.itemQuantity<10?'0${controller.itemQuantity}':'${controller.itemQuantity}',
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                                InkWell(
                                    onTap: () {
                                      controller.changeItemQuantity('increment',index,model);
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      size: 16,
                                      color: Colors.white,
                                    )),
                              ],
                            )
                          : Center(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  size: 14,
                                ),
                                onPressed: () {
                                  controller.setItemIndex(index??-1);
                                    controller.handleIsIncrementVisible(true,index??-1);
                                        },
                                color: Colors.white,
                                padding: const EdgeInsets.all(0),
                              ),
                            )))
            ],
          ),
        ),
      ),
    );
  }

}
