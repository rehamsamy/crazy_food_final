import 'package:crazy_food/app/data/models/category_model.dart';
import 'package:crazy_food/app/data/models/popular_model.dart';
import 'package:crazy_food/app/data/remote_data_source/category_apis.dart';
import 'package:crazy_food/app/data/remote_data_source/popular_apis.dart';
import 'package:crazy_food/app/modules/category/view/category_screen.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/category_item.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/loading_widget/category_item_loading.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/discount_item.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/loading_widget/popular_item_loading.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/popular_item.dart';
import 'package:crazy_food/app/modules/search/view/search_view.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app/shared/app_text_field.dart';
import 'package:crazy_food/app/shared/occasions_shimmer.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';

import 'widget/loading_widget/discount_item_loading.dart';

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
                SizedBox(height: kToolbarHeight / 2),
                profileWidget(),
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
                      color: Colors.grey.shade50,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: Column(
                    children: [
                      Card(
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
                              trailing: InkWell(
                                onTap: () => Get.to(() => CategoryScreen()),
                                child: AppText(
                                  'see_all'.tr,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            getCategoryList(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: DiscountItem.height,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (_, index) {
                              return DiscountItemLoading(index);
                            }),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Card(
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
                                'popular'.tr,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              trailing: AppText(
                                'see_all'.tr,
                                color: kPrimaryColor,
                              ),
                            ),
                            getPopularList()

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  profileWidget() {
    return ListTile(
      horizontalTitleGap: 10,
      leading: AppCashedImage(
        imageUrl:
            'https://tse2.mm.bing.net/th?id=OIP.izqqI6zf0-Ot-O1iaVu4KAHaEK&pid=Api&P=0',
        isCircular: true,
        fit: BoxFit.cover,
        width: 40,
        height: 40,
        borderColor: Colors.white,
        borderWidth: 2,
      ),
      title: AppText(
        'user_name',
        color: Colors.white,
      ),
      subtitle: AppText(
        'welcome to your crazy food ?!',
        color: Colors.white,
      ),
      trailing: Badge(
        badgeContent: AppText(
          '6',
          color: Colors.white,
          fontSize: 12,
        ),
        toAnimate: true,
        position: BadgePosition.topEnd(top: -15, end: -5),
        child: Icon(
          Icons.notifications,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  getCategoryList() {
    return FutureBuilder(
        future: CategoryApis().categories(),
        builder: (_, snap) {
          if (snap.hasData) {
            List<CategoryItemModel> categories =
                snap.data as List<CategoryItemModel>;
            if (categories.isNotEmpty) {
              return Container(
                padding: EdgeInsets.all(5),
                height: CategoryItem.height,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return CategoryItem(categories[index]);
                    },
                    separatorBuilder: (_, index) => SizedBox(
                          height: 3,
                        ),
                    itemCount: categories.length),
              );
            } else if (categories.isEmpty) {
              return Center(
                child: AppText('no_cat_found'.tr),
              );
            } else {
              return SizedBox();
            }
          } else if (snap.connectionState == ConnectionState.waiting) {
            return  Container(
              padding: EdgeInsets.all(5),
              height: CategoryItem.height,
              child: ListView.builder(
                  // physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return  CategoryItemLoading();
                  },
                  itemCount: 5),
            );

          } else {
            return SizedBox();
          }
        });
  }

  getPopularList() {
    return FutureBuilder(
        future: PopularApis().getPopular(),
        builder: (_, snap) {
          if (snap.hasData) {
            List<Popular> popularList = snap.data as List<Popular>;
            if (popularList.isNotEmpty) {
           return   Container(
                height: 150,
                padding: EdgeInsets.only(
                    bottom: 15, right: 15, left: 15),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularList.length,
                    itemBuilder: (_, index) {
                      return PopularItem(popularList[index]);
                    }),
              );
            } else if (popularList.isEmpty) {
              return Center(
                child: AppText('no_cat_found'.tr),
              );
            } else {
              return SizedBox();
            }
          } else if (snap.connectionState == ConnectionState.waiting) {
          return  Container(
              height: 150,
              padding: EdgeInsets.only(
                  bottom: 15, right: 15, left: 15),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (_, index) {
                    return PopularItemLoading();
                  }),
            );
          } else {
            return SizedBox();
          }
        });


  }
}
