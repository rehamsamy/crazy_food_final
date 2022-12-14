import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BottomNavigationHome extends GetView<HomeController> {
  const BottomNavigationHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_)=> SizedBox(
          height: 80,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            child: BottomAppBar(
              color: kPrimaryColor,
              elevation: 10,
              notchMargin: 10,
              shape: const CircularNotchedRectangle(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  bottombarItem(
                    svgName: 'category',
                    text: 'home'.tr,
                    index: 0,
                  ),
                  bottombarItem(
                    svgName: 'orders',
                    text: 'orders_tab'.tr,
                    index: 1,
                  ),

                  bottombarItem(
                    svgName: 'offers',
                    text: 'offers_tab'.tr,
                    index: 2,
                  ),
                  bottombarItem(
                    svgName: 'more',
                    text: 'more_tab'.tr,
                    index: 3,
                  )
                ],
              ),
            ),
          )),
    );
  }

  bottombarItem({
    required String svgName,
    required String text,
    required int index,
  }) {
    return InkWell(
      onTap: (){
        controller.handlePageViewerIndex(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icon/$svgName.svg',
            color: controller.index == index ? Colors.white : Colors.white38,
          ),
          AppText(
            text,
            color: controller.index == index ? Colors.white : Colors.white38,
            fontSize: controller.index == index ? 16 : 12,
          )
        ],
      ),
    );
  }
}
