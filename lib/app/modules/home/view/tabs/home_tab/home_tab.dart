import 'dart:convert';
import 'package:crazy_food/app/core/get_binding.dart';
import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/data/models/category_model.dart';
import 'package:crazy_food/app/data/models/login_model.dart';
import 'package:crazy_food/app/data/remote_data_source/category_apis.dart';
import 'package:crazy_food/app/data/remote_data_source/popular_apis.dart';
import 'package:crazy_food/app/data/storage/local_storage.dart';
import 'package:crazy_food/app/modules/category/view/category_screen.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/category_item.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/loading_widget/category_item_loading.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/discount_item.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/loading_widget/popular_item_loading.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/popular_item.dart';
import 'package:crazy_food/app/modules/popular/view/popular_screen.dart';
import 'package:crazy_food/app/modules/search/view/search_view.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app/shared/app_text_field.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:badges/badges.dart';
import 'widget/loading_widget/discount_item_loading.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}
class _HomeTabState extends State<HomeTab> {
  var searchController = TextEditingController();
  List<ProductModel>? allProducts;
  LoginModel? model;
  @override
  void initState() {
    super.initState();
    model = LoginModel.fromJson(jsonDecode(
      LocalStorage.getString(LocalStorage.userModel) ?? '{}',
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kContainerDecoraction,
        height: Get.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                const SizedBox(height: kToolbarHeight / 2),
                profileWidget(),
                InkWell(
                  onTap: () => Get.off(() => SearchScreen()),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () => Get.off(() => SearchScreen()),
                      child: CustomTextFormField(
                        onTapped: (){
                          Get.off(() => SearchScreen());
                        },
                        hintText: 'search'.tr,
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        prefixIcon: Icons.search,
                        prefixIconColor: Colors.grey,
                        radius: 15,
                        horizontalPadding: 0,
                        onChanged: (val) {
                          Get.off(() => SearchScreen());
                        },
                        // onChanged: ()=>,
                      ),
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
                          const BorderRadius.vertical(top: Radius.circular(30))),
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
                      const SizedBox(
                        height: 15,
                      ),
                      getDiscountList(),
                      const SizedBox(
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
                              trailing: InkWell(
                                onTap: () => Get.to(() => PopularScreen(),
                                    binding: GetBinding()),
                                child: AppText(
                                  'see_all'.tr,
                                  color: kPrimaryColor,
                                ),
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
      leading: const AppCashedImage(
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
        model?.name ?? 'user_name',
        color: Colors.white,
      ),
      subtitle: const AppText(
        'welcome to your crazy food ?!',
        color: Colors.white,
      ),
      trailing: Badge(
        badgeContent: const AppText(
          '6',
          color: Colors.white,
          fontSize: 12,
        ),
        toAnimate: true,
        position: BadgePosition.topEnd(top: -15, end: -5),
        child: const Icon(
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
                padding: const EdgeInsets.all(5),
                height: CategoryItem.height,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return CategoryItem(categories[index]);
                    },
                    separatorBuilder: (_, index) => const SizedBox(
                          height: 3,
                        ),
                    itemCount: categories.length),
              );
            } else if (categories.isEmpty) {
              return Container(
                  padding: const EdgeInsets.all(5),
                  height: CategoryItem.height,
                  child: Center(
                    child: AppText('no_cat_found'.tr),
                  ));
            } else {
              return const SizedBox();
            }
          } else if (snap.connectionState == ConnectionState.waiting) {
            return Container(
              padding: const EdgeInsets.all(5),
              height: CategoryItem.height,
              child: ListView.builder(
                  // physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return const CategoryItemLoading();
                  },
                  itemCount: 5),
            );
          } else {
            return const SizedBox();
          }
        });
  }
  getPopularList() {
    return FutureBuilder(
        future: PopularApis().getPopular(),
        builder: (_, snap) {
          if (snap.hasData) {
            List<ProductModel> prods = snap.data as List<ProductModel>;
            List<ProductModel> popularList = [];
            if (prods.isNotEmpty) {
              prods.map((e) {
                if ((e.rate ?? 0.0) > 4) {
                  popularList.add(e);
                }
              }).toList();

              return Container(
                height: 150,
                padding: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularList.length,
                    itemBuilder: (_, index) {
                      return PopularItem(popularList[index], prods,index);
                    }),
              );
            } else if (popularList.isEmpty) {
              return SizedBox(
                height: 150,
                child: Center(
                  child: AppText('no_cat_found'.tr),
                ),
              );
            } else {
              return const SizedBox();
            }
          } else if (snap.connectionState == ConnectionState.waiting) {
            return Container(
              height: 150,
              padding: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (_, index) {
                    return const PopularItemLoading();
                  }),
            );
          } else {
            return const SizedBox();
          }
        });
  }
  getDiscountList() {
    return FutureBuilder(
        future: PopularApis().getPopular(),
        builder: (_, snap) {
          if (snap.hasData) {
            List<ProductModel> prods = snap.data as List<ProductModel>;
            List<ProductModel> discountList = [];
            if (prods.isNotEmpty) {
              prods.map((e) {
                if ((e.discount ?? 0.0) > 4) {
                  discountList.add(e);
                }
              }).toList();
              List<ProductModel> discountOrderList =
                  selectionAsecSortFilter(discountList);
              return SizedBox(
                  height: DiscountItem.height,
                  child: CarouselSlider.builder(
                      itemBuilder: (_, index, index1) {
                        return DiscountItem(index, discountOrderList[index]);
                      },
                      itemCount: discountOrderList.length,
                      options: CarouselOptions(
                        height: 400,
                        aspectRatio: 16 / 12,
                        viewportFraction: 0.9,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        onPageChanged: (_, x) {},
                        scrollDirection: Axis.horizontal,
                      ))
                  // child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: discountOrderList.length,
                  //     itemBuilder: (_, index) {
                  //       // return DiscountItemLoading(index);
                  //       return DiscountItem(index,discountOrderList[index]);
                  //     }),
                  );
            } else if (discountList.isEmpty) {
              return SizedBox(
                height: 150,
                child: Center(
                  child: AppText('no_cat_found'.tr),
                ),
              );
            } else {
              return const SizedBox();
            }
          } else if (snap.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: DiscountItem.height,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (_, index) {
                    // return DiscountItemLoading(index);
                    return DiscountItemLoading(index);
                  }),
            );
          } else {
            return const SizedBox();
          }
        });
  }
  List<ProductModel> selectionAsecSortFilter(List<ProductModel> prodss) {
    List<ProductModel> prods = prodss;
    for (var i = 0; i < prods.length - 1; i++) {
      var index_min = i;
      for (var j = i + 1; j < prods.length; j++) {
        if ((prods[j].discount)! < (prods[index_min].discount ?? 0)) {
          index_min = j;
        }
      }
      if (index_min != i) {
        var temp = prods[i];
        prods[i] = prods[index_min];
        prods[index_min] = temp;
      }
    }
    return prods;
  }
}
