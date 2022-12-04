import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/data/remote_data_source/category_items_apis.dart';
import 'package:crazy_food/app/data/remote_data_source/popular_apis.dart';
import 'package:crazy_food/app/modules/category/view/category_screen.dart';
import 'package:crazy_food/app/modules/category_items_screen/controller/category_items_controller.dart';
import 'package:crazy_food/app/modules/category_items_screen/widget/category_items_item.dart';
import 'package:crazy_food/app/modules/category_items_screen/widget/category_items_loading.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/modules/home/view/widgets/bottom_navigation.dart';
import 'package:crazy_food/app/modules/home/view/widgets/fab_home.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
class PopularScreen extends GetView<CategoryItemsController>{
 PopularScreen();
   @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: GetBuilder<CategoryItemsController>(
          builder:(_)=> Container(
            decoration: kContainerDecoraction,
            width: Get.width,
            height: Get.height,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed:()=>Get.offAll(()=>HomeScreenView()),
                        icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                      ),
                      AppText('popular'.tr,color: Colors.white,fontSize: 20,),
                      SizedBox(),

                    ],
                  ),
                  SizedBox(height: 15,),
                  Container(
                    height: Get.height,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                        child:getCategoryItemsList()
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationHome(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FabHome()
    );
  }

  getCategoryItemsList() {
    return  FutureBuilder(
        future: PopularApis().getPopular(),
        builder: (_,snap){
          if (snap.hasData) {
            List<ProductModel> popularList = [];
            List<ProductModel> popular = snap.data as List<ProductModel>;
            if (popular.isNotEmpty) {
              popular.map((e) {
                if ((e.rate ?? 0.0) > 4) {
                  popularList.add(e);
                }
              }).toList();
            }
            if (popularList.isNotEmpty) {
              return Container(
                padding: EdgeInsets.all(5),
                width: Get.width,
                height: CategoryItemsItem.height,
                child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      mainAxisExtent: CategoryItemsItem.height),
                  itemBuilder: (_, index) {
                    return CategoryItemsItem(popularList[index], popularList, index);
                  },
                  itemCount: popularList.length,
                ),
              );
            } else if (popularList.isEmpty) {
              return Center(
                child: AppText('no_cat_found'.tr),
              );
            } else {
              return SizedBox();
            }
          } else if (snap.connectionState == ConnectionState.waiting) {
            return Container(
              padding: EdgeInsets.all(5),
              height: CategoryItemsItem.height,
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    mainAxisExtent: CategoryItemsItem.height),
                itemBuilder: (_, index) => CategoryItemsLoading(),
                itemCount: 10,
              ),
            );
          } else {
            return SizedBox();
          }
        });
  }

}