import 'package:crazy_food/app/core/get_binding.dart';
import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/home/view/tabs/cart_tab.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/home_tab.dart';
import 'package:crazy_food/app/modules/home/view/tabs/more_tab.dart';
import 'package:crazy_food/app/modules/home/view/tabs/offers_tab.dart';
import 'package:crazy_food/app/modules/home/view/tabs/orders_tab.dart';
import 'package:crazy_food/app/modules/home/view/widgets/bottom_navigation.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';

class HomeScreenView extends GetView<HomeController> {
  const HomeScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (_)=>Container(
          width: Get.width,
          height: Get.height,
          //decoration: kContainerDecoraction,
          color: Colors.white,
          child: PageView(
               controller: controller.homePageViewController,
            onPageChanged: (index)=>controller.handlePageViewerIndex(index),
            children: [
              HomeTab(),
              OrdersTab(),
              CartTab(),
              OffersTab(),
              MoreTab()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationHome(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
            shape: BoxShape.circle,
      ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 10,
          color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Badge(
              toAnimate: true,
              badgeContent:AppText('3',color: Colors.white,),
              position:BadgePosition.topEnd(top:-15),
              child: Icon(
                  Icons.shopping_cart_outlined,
                color: kPrimaryColor,
              ),
            ),
          ),
          ),
        ),
      ),
    );
  }
}
