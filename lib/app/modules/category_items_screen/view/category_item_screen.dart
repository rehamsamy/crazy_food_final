import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/data/models/category_model.dart';
import 'package:crazy_food/app/data/remote_data_source/category_items_apis.dart';
import 'package:crazy_food/app/modules/category/view/category_screen.dart';
import 'package:crazy_food/app/modules/category_items_screen/widget/category_items_item.dart';
import 'package:crazy_food/app/modules/category_items_screen/widget/category_items_loading.dart';
import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/loading_widget/category_item_loading.dart';
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
   int ?typeId;
   String ? catName;
   Map map=Get.arguments;
  // CategoryItemsScreen(this._categoryItemModel);
  @override
  Widget build(BuildContext context) {
    typeId=map['categoryType'];
    catName=map['categoryName'];
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
                      AppText('قسم ال${ catName??''}',color: Colors.white,fontSize: 20,),
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

    return  FutureBuilder(
        future: CategoryItemsApis().getCategoriesList(),
        builder: (_,snap){
          if(snap.hasData){
            List<ProductModel>?products=snap.data as List<ProductModel>;
           List<ProductModel>? prods=[];
           products.map((e) {
             if (e.idType==typeId){
               prods.add(e);
               return e;
             }
           }).toList()  ;
           for (int i=0;i<prods.length;i++){
             Get.log('items   '+typeId.toString()+'    '+prods[i].nameAr.toString());
           }
            Get.log('prods  ===>  '+typeId.toString()+'    '+prods.length.toString());
            if(prods.isNotEmpty){
              return    Container(
                padding: EdgeInsets.all(5),
                   width: Get.width,
                   height: CategoryItemsItem.height,
                child:GridView.builder(
                  padding:EdgeInsets.all(10),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    mainAxisExtent: CategoryItemsItem.height),
                  itemBuilder: (_,index)
                    {
                      // return CategoryItemsLoading();
                      // List<ProductModel> similarProds=products.map((e) => null).toList();
                       return CategoryItemsItem(products[index],prods,index,products);
                    },
                  itemCount: prods.length,),
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
                  crossAxisCount: 2,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  mainAxisExtent:CategoryItemsItem.height),
                itemBuilder: (_,index)=>CategoryItemsLoading(),
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