import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/category_item.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/discount_item.dart';
import 'package:crazy_food/app/modules/search/view/search_view.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app/shared/app_text_field.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTab extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kContainerDecoraction,
        height: Get.height,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: Card(
                    elevation: 8,
                    color: Colors.white,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: AppText(
                            'categories'.tr,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          trailing: AppText(
                            'see_all'.tr,
                            color: kPrimaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          height: CategoryItem.height,
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                return CategoryItem();
                              },
                              separatorBuilder: (_, index) => SizedBox(
                                    height: 3,
                                  ),
                              itemCount: 7),
                        ),
                          Container(
                            height: DiscountItem.height,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,itemBuilder: (_,index){
                              return DiscountItem(index);}),
                          )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
