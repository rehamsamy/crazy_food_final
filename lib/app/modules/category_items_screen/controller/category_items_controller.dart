import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/modules/cart/controller/cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class CategoryItemsController extends GetxController{
  CartController cartController=Get.put(CartController());
  int index=0;
  List<bool>? isIncrementVisible;
  int itemIndex =-1;
  int itemQuantity=0;
  var homePageViewController =PageController();

  handlePageViewerIndex(int newVal){
    index=newVal;
    homePageViewController.jumpToPage(index);
    update();
  }

  void handleIsIncrementVisible(bool newVal, int index) {
    isIncrementVisible?[index] = newVal;
    itemQuantity=0;
    update();
  }

  void setItemIndex(int newVal) {
    itemIndex = newVal;
    // cartCount=itemQuantity;
    itemQuantity=0;
    update();
  }
  changeItemQuantity(String type,index,ProductModel model){
    if(type=='increment'){
      itemQuantity++;
      Get.log('quant  =>1 '+itemQuantity.toString());
    }else if(type=='decrement'){
      itemQuantity--;
      Get.log('quant  =>2 '+itemQuantity.toString());
      if(itemQuantity<0){
        itemQuantity=0;
      }else{
        itemQuantity;
      }
    }
    Get.log('quant  =>'+itemQuantity.toString());
 cartController.addItemToCartScreen(model.id.toString(),model.price,
        model.nameAr??'',model.imagePath??'',model.caleories as int);

    // cartCount=((cartCount!) + 1);
    update();
  }








}