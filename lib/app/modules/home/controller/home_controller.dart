import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class HomeController extends GetxController{

  int index=0;

  var homePageViewController =PageController();

  handlePageViewerIndex(int newVal){
    index=newVal;
    homePageViewController.jumpToPage(index);
    update();
  }

}