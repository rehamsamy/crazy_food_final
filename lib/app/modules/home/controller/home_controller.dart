import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class HomeController extends GetxController{

  int index=0;
  @override
  void onInit() {
    // TODO: implement onInit
    Get.log('index  .. => 222 '+index.toString());
    super.onInit();
  }
  var homePageViewController =PageController();
  bool isIncrementVisible=false;
  int itemQuantity=0;
  handlePageViewerIndex(int newVal){
    index=newVal;
    Get.log('index  .. =>'+index.toString());
    homePageViewController.jumpToPage(index);
    update();
  }
  handleIsIncrementVisible (bool newVal){
    isIncrementVisible=newVal;
    update();
  }

  changeItemQuantity(String type){
    if(type=='increment'){
      itemQuantity++;
    }else if(type=='decrement'){
      if(itemQuantity<0){
        itemQuantity=0;
      }else{
        itemQuantity--;
      }
    }
    update();
  }

}