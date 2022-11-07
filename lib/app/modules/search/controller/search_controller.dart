import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/data/models/category_model.dart';
import 'package:crazy_food/app/data/remote_data_source/category_items_apis.dart';
import 'package:crazy_food/app/modules/category_items_screen/widget/category_items_item.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/category_item.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/loading_widget/category_item_loading.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<ProductModel>? searchList = [];
  List<ProductModel>? allCategoryItemsList = [];


  @override
  void onInit() {
    getCategoryItemsList();
  }

  getCategoryItemsList() {
    allCategoryItemsList!.clear();
    CategoryItemsApis().getCategoriesList().then((value) {
      allCategoryItemsList = value as List<ProductModel>;
    });
  }


  void onSearchTextChanged(String val) {
    searchList?.clear();
    if (val.isEmpty) {
      update();
      return;
    }
    Get.log('mmm  =>'+(allCategoryItemsList?.length).toString());
 searchList=allCategoryItemsList?.
 where((element) => ((element.nameAr).toString()).contains(val)).toList();
 update();
  }
  }


