import 'package:crazy_food/app/modules/cart/view/cart_view.dart';
import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/home_tab.dart';
import 'package:crazy_food/app/modules/home/view/tabs/more_tab.dart';
import 'package:crazy_food/app/modules/home/view/tabs/offers_tab.dart';
import 'package:crazy_food/app/modules/home/view/widgets/bottom_navigation.dart';
import 'package:crazy_food/app/modules/home/view/widgets/fab_home.dart';
import 'package:crazy_food/app/modules/orders_tab/view/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenView extends GetView<HomeController> {
   HomeScreenView({Key? key}) : super(key: key);
  HomeController controller=Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GetBuilder<HomeController>(
          builder: (_)=>Container(
            width: Get.width,
            height: Get.height,
            color: Colors.white,
            child: PageView(
                 controller: controller.homePageViewController,
              onPageChanged: (index)=>controller.handlePageViewerIndex(index),
              children: [
                HomeTab(),
                OrdersScreen(),
                CartScreen(),
                OffersTab(),
                MoreTab()
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationHome(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FabHome()
      ),
    );
  }
}
