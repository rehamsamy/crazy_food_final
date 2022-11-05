import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/modules/cart/controller/cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class CategoryItemsController extends GetxController{
  CartController cartController=Get.find();
  int index=0;
  List<bool>? isIncrementVisible;
  int itemIndex =-1;
  int ? cartCount=0;
  int itemQuantity=0;
  @override
  void onInit() {
    // TODO: implement onInit
    Get.log('index  .. => 222 '+index.toString());
    super.onInit();
  }
  var homePageViewController =PageController();

  handlePageViewerIndex(int newVal){
    index=newVal;
    Get.log('index  .. =>'+index.toString());
    homePageViewController.jumpToPage(index);
    update();
  }

  void handleIsIncrementVisible(bool newVal, int index) {
    isIncrementVisible?[index] = newVal;
    // cartCount=itemQuantity;
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
    if(type=='increment'&&index==itemIndex){
      itemQuantity++;
    }else if(type=='decrement'&&index==itemIndex){
      itemQuantity--;
      if(itemQuantity<0){
        itemQuantity=0;
      }else{
        itemQuantity;
      }
    }
 cartController.ddItemToCartScreen(model.id.toString(),model.price,
        model.nameAr??'',model.imagePath??'',model.caleories as int);

    cartCount=((cartCount!) + (itemQuantity));
    update();
  }








}