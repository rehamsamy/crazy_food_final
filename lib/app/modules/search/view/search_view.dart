import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/data/models/category_model.dart';
import 'package:crazy_food/app/data/remote_data_source/category_items_apis.dart';
import 'package:crazy_food/app/modules/category/view/category_screen.dart';
import 'package:crazy_food/app/modules/category_items_screen/widget/category_items_item.dart';
import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/loading_widget/category_item_loading.dart';
import 'package:crazy_food/app/modules/home/view/widgets/bottom_navigation.dart';
import 'package:crazy_food/app/modules/home/view/widgets/fab_home.dart';
import 'package:crazy_food/app/modules/search/controller/search_controller.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app/shared/app_text_field.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
class SearchScreen extends StatelessWidget{
  CategoryItemModel ? _categoryItemModel;
  SearchScreen();
  TextEditingController searchController=TextEditingController();
  // CategoryItemsScreen(this._categoryItemModel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<SearchController>(
          builder:(_)=> Container(
            decoration: kContainerDecoraction,
            width: Get.width,
            height: Get.height,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                   SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed:()=>Get.to(()=>HomeScreenView()),
                        icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                      ),
                      AppText('search'.tr,color: Colors.white,fontSize: 18,),
                      SizedBox()
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () => Get.to(() => SearchScreen()),
                      child: CustomTextFormField(
                        hintText: 'search'.tr,
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        prefixIcon: Icons.search,
                        prefixIconColor: Colors.grey,
                        radius: 15,
                        horizontalPadding: 0,
                        // onChanged: ()=>,
                      ),
                    ),
                  ),
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

    );
  }

  getCategoryItemsList() {

    return  FutureBuilder(
        future: CategoryItemsApis().getCategoriesList(),
        builder: (_,snap){
          if(snap.hasData){
            List<ProductModel>products=snap.data as List<ProductModel>;
            if(products.isNotEmpty){
              return    Container(
                padding: EdgeInsets.all(5),
                height: CategoryItemsItem.height,
                child:GridView.builder(
                  padding:EdgeInsets.all(10),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    mainAxisExtent: CategoryItemsItem.height),
                  itemBuilder: (_,index)=>CategoryItemsItem(products[index],products,index),
                  itemCount: products.length,),
              );
            }else if(products.isEmpty) {
              return Center(child: AppText('no_cat_found'.tr),);
            }else{
              return SizedBox();
            }
          }
          else if(snap.connectionState==ConnectionState.waiting){
            return    Container(
              padding: EdgeInsets.all(5),
              height: CategoryItemsItem.height,
              child:GridView.builder(
                padding:EdgeInsets.all(10),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  mainAxisExtent: CategoryItemsItem.height),
                itemBuilder: (_,index)=>CategoryItemLoading(),
                itemCount: 10,),
            );
          }else{
            return SizedBox();
          }
        }
    );


    // return   Container(
    //   padding: EdgeInsets.all(5),
    //   height: CategoryItemsItem.height,
    //   child:GridView.builder(
    //     padding:EdgeInsets.all(10),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       mainAxisSpacing: 0,
    //       crossAxisSpacing: 0,
    //       mainAxisExtent: CategoryItemsItem.height),
    //     itemBuilder: (_,index)=>CategoryItemsItem(),
    //     itemCount: 6),
    // );

  }

}