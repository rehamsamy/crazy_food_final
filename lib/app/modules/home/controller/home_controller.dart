import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class HomeController extends GetxController{

  int index=0;
  var homePageViewController =PageController();
  bool isIncrementVisible=false;
  int itemQuantity=0;
  handlePageViewerIndex(int newVal){
    index=newVal;
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