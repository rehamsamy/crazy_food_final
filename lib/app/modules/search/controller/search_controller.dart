import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/data/remote_data_source/category_items_apis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<ProductModel>? searchList = [];
  List<ProductModel>? allCategoryItemsList = [];


  @override
  void onInit() {
    Get.log('init ==>');
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
    val=searchController.text;
    if (val.isEmpty) {
      update();
      return;
    }
    Get.log('mmm  =>'+(allCategoryItemsList?.length).toString()+'  '+val);
 searchList=allCategoryItemsList?.
 where((element) {
   if  ((((element.nameEn).toString()).toLowerCase()).contains(val.toLowerCase())){
     Get.log('lllll '+val+' '+element.nameEn.toString());
     return true;
   }
   return false;
 }
 ).toList();
 update();
  }
  }


