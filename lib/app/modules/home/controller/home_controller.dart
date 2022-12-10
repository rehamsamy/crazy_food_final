import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class HomeController extends GetxController{
  int index=0;

   var homePageViewController =PageController();
  bool isIncrementVisible=false;

  handlePageViewerIndex(int newVal){
    index=newVal;
    homePageViewController.jumpToPage(index);
    update();
  }
  handleIsIncrementVisible (bool newVal){
    isIncrementVisible=newVal;
    update();
  }



}