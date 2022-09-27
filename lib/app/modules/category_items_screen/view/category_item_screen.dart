import 'package:crazy_food/app/data/models/category_model.dart';
import 'package:crazy_food/app/modules/category/view/category_screen.dart';
import 'package:crazy_food/app/modules/category_items_screen/widget/category_items_item.dart';
import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/home/view/widgets/bottom_navigation.dart';
import 'package:crazy_food/app/modules/home/view/widgets/fab_home.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
class CategoryItemsScreen extends GetView<HomeController>{
   CategoryItemModel ? _categoryItemModel;
   CategoryItemsScreen();
  // CategoryItemsScreen(this._categoryItemModel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: GetBuilder<HomeController>(
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
                        onPressed:()=>Get.to(()=>CategoryScreen()),
                        icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                      ),
                      AppText(_categoryItemModel?.nameAr??'',color: Colors.white,fontSize: 18,),
                      SizedBox()
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
    return   Container(
      padding: EdgeInsets.all(5),
      height: CategoryItemsItem.height,
      child:GridView.builder(
        padding:EdgeInsets.all(10),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          mainAxisExtent: CategoryItemsItem.height),
        itemBuilder: (_,index)=>CategoryItemsItem(),
        itemCount: 6),
    );

  }

}