import 'package:crazy_food/app/modules/category/controller/category_controller.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/category_item.dart';
import 'package:crazy_food/app/modules/home/view/widgets/bottom_navigation.dart';
import 'package:crazy_food/app/modules/home/view/widgets/fab_home.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
class CategoryScreen extends GetView<CategoryController>{
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
           SizedBox(height: 50,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               IconButton(
                 onPressed:()=>Get.to(()=>HomeScreenView()),
                 icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
               ),
              AppText('categories'.tr,color: Colors.white,fontSize: 17,),
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
               child:GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 3,
                   mainAxisSpacing: 0,
                   crossAxisSpacing: 0,
                   mainAxisExtent: CategoryItem.height),
                   itemBuilder: (_,index)=>CategoryItem(),
               itemCount: 10,)
             ),
           )
         ],
       ),
     ),
   ),
  bottomNavigationBar: BottomNavigationHome(),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       floatingActionButton: FabHome()
   );
  }





}







