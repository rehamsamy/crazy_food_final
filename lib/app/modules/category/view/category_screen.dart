import 'package:crazy_food/app/core/get_binding.dart';
import 'package:crazy_food/app/data/models/category_model.dart';
import 'package:crazy_food/app/data/remote_data_source/category_apis.dart';
import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/category_item.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/loading_widget/category_item_loading.dart';
import 'package:crazy_food/app/modules/home/view/widgets/bottom_navigation.dart';
import 'package:crazy_food/app/modules/home/view/widgets/fab_home.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CategoryScreen extends GetView<HomeController>{
  const CategoryScreen({Key? key}) : super(key: key);

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
         physics: const BouncingScrollPhysics(),
         child: Column(
           children: [
             const SizedBox(height: 50,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 IconButton(
                   onPressed:()=>Get.off(()=>HomeScreenView(),binding: GetBinding()),
                   icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                 ),
                AppText('categories'.tr,color: Colors.white,fontSize: 18,),
                 const SizedBox()
               ],
             ),
             const SizedBox(height: 15,),
             Container(
               height: Get.height,
               width: Get.width,
               decoration: BoxDecoration(
                 borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
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
                 child:getCategoryList()
               ),
             )
           ],
         ),
       ),
     ),
   ),
  bottomNavigationBar: BottomNavigationHome(),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       floatingActionButton:  FabHome()
   );
  }


  getCategoryList(){
    return  FutureBuilder(
        future: CategoryApis().categories(),
        builder: (_,snap){
          if(snap.hasData){
            List<CategoryItemModel>categories=snap.data as List<CategoryItemModel>;
            if(categories.isNotEmpty){
              return    Container(
                padding: const EdgeInsets.all(5),
                height: CategoryItem.height,
                child:GridView.builder(
                  padding:const EdgeInsets.all(10),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    mainAxisExtent: CategoryItem.height),
                  itemBuilder: (_,index)=>CategoryItem(categories[index]),
                  itemCount: categories.length,),
              );
            }else if(categories.isEmpty) {
              return Center(child: AppText('no_cat_found'.tr),);
            }else{
              return const SizedBox();
            }
          }
          else if(snap.connectionState==ConnectionState.waiting){
            return    Container(
              padding: const EdgeInsets.all(5),
              height: CategoryItem.height,
              child:GridView.builder(
                padding:const EdgeInsets.all(10),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  mainAxisExtent: CategoryItem.height),
                itemBuilder: (_,index)=>const CategoryItemLoading(),
                itemCount: 15,),
            );
          }else{
            return const SizedBox();
          }
        }
    );
  }
}







