
import 'package:crazy_food/app/modules/category_items_screen/widget/category_items_item.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/modules/search/controller/search_controller.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app/shared/app_text_field.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SearchScreen extends GetView<SearchController>{
  @override
  SearchController controller=Get.put(SearchController());
  SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: GetBuilder<SearchController>(
            builder:(_)=> Container(
              decoration: kContainerDecoraction,
              width: Get.width,
              height: Get.height,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                     const SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed:()=>Get.offAll(()=>HomeScreenView()),
                          icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                        ),
                        AppText('search'.tr,color: Colors.white,fontSize: 18,),
                        const SizedBox()
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                          onTap: () {
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                              currentFocus.focusedChild?.unfocus();
                            }

                        } ,
                        child: CustomTextFormField(
                          hintText: 'search'.tr,
                          controller: controller.searchController,
                          keyboardType: TextInputType.text,
                          prefixIcon: Icons.search,
                          prefixIconColor: Colors.grey,
                          radius: 15,
                          horizontalPadding: 0,
                          onChanged: (val) {
                            Get.log('text val  ==>$val');
                            controller.onSearchTextChanged(val);
                          },
                        ),
                      ),
                    ),
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
                          child:getSearchListBuilder()
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

      ),
    );
  }

  getSearchListBuilder() {
    if (controller.searchList!.isNotEmpty) {
      return   GetBuilder<SearchController>(
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(5),
            width: Get.width,
            height: CategoryItemsItem.height,
            child:GridView.builder(
              padding:const EdgeInsets.all(10),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                mainAxisExtent: CategoryItemsItem.height),
              itemBuilder: (_,index)
              {
                // return CategoryItemsLoading();
                // List<ProductModel>? list=controller.allCategoryItemsList;
                //  List<ProductModel> similarProds=list!.map((e) => e.idType==list[index].idType).cast<ProductModel>().toList();
                return CategoryItemsItem(controller.searchList![index],controller.allCategoryItemsList,index);
              },
              itemCount:controller.searchList?.length,),
          );
        }
      );
    } else if (controller.searchList!.isEmpty) {
      return Center(
        child: AppText('no_cat_found'.tr),
      );
    } else {
      return const SizedBox();
    }
  }



}