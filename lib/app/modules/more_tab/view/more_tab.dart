import 'package:crazy_food/app/core/get_binding.dart';
import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/data/remote_data_source/popular_apis.dart';
import 'package:crazy_food/app/modules/change_password/view/change_password.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/discount_item.dart';
import 'package:crazy_food/app/modules/more_tab/controller/setting_controller.dart';
import 'package:crazy_food/app/modules/offers_tab/view/widget/offer_item.dart';
import 'package:crazy_food/app/modules/profile_data/view/profile_view.dart';
import 'package:crazy_food/app/shared/app_buttons/app_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:crazy_food/app/data/models/order_model.dart';
import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/modules/home/view/tabs/home_tab/widget/loading_widget/discount_item_loading.dart';
import 'package:crazy_food/app/modules/orders_tab/controller/order_controller.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class MoreTabScreen extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<SettingController>(builder: (_) {
        return Scaffold(
          appBar: null,
          body: Container(
              decoration: kContainerDecoraction,
              width: Get.width,
              height: Get.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () => Get.off(() => HomeScreenView()),
                          icon: Icon(
                            Icons.arrow_back_ios_sharp,
                            color: Colors.white,
                          ),
                        ),
                        AppText(
                          'more_tab'.tr,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        SizedBox()
                      ],
                    ),
                    Container(
                      height: Get.height,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                        color: Colors.grey.shade50,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Card(
                          elevation: 8,
                          color: Colors.white,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                buildSettingWidget(
                                    'change_password'.tr, 1, context),
                                SizedBox(
                                  height: 20,
                                ),
                                buildSettingWidget(
                                    'change_lang'.tr, 2, context),
                                SizedBox(
                                  height: 20,
                                ),
                                buildSettingWidget(
                                    'account_info'.tr, 3, context),
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              )),
        );
      }),
    );
  }

  buildSettingWidget(String txt, int flag, BuildContext context) {
    return InkWell(
      onTap: () {
        flag == 1
            ? showChangeLangDialog(context)
            : flag == 2
                ? Get.to(() => ChangePasswordView(), binding: GetBinding())
                : flag == 3
                    ? Get.to(() => ProfileView(), binding: GetBinding())
                    : null;
      },
      child: SizedBox(
        height: 80,
        child: Card(
          elevation: 8,
          color: Colors.greenAccent.withOpacity(0.5),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: AppText(
                  txt,
                  fontSize: 13,
                ),
              ),
              Icon(
                Icons.forward,
                color: kPurpleColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  void showChangeLangDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => GetBuilder<SettingController>(
              builder: (_) => AlertDialog(
                title: Center(
                    child: AppText(
                  'change_lang'.tr,
                  color: kPrimaryColor,
                )),
                content: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  child: LayoutBuilder(
                    builder: (_, cons) => GetBuilder<SettingController>(
                      builder: (_) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: cons.maxWidth * 0.8,
                            height: 40,
                            child: AppProgressButton(
                              backgroundColor: kPrimaryColor,
                                  radius:5,
                              onPressed: (val) {
                                controller.onChangeLang('ar');
                              },
                              child: Container(
                                  child: AppText(
                                'العربيه',
                                color: Colors.white,
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 40,
                            width: cons.maxWidth * 0.8,
                            child: AppProgressButton(
                              backgroundColor: kPrimaryColor,
                                  radius: 5,
                              onPressed: (val) {
                                updateLanguage(locale[0]['locale']);
                                controller.onChangeLang('en');
                              },
                              child: AppText(
                                'English',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('us')},
    {'name': 'العربية', 'locale': Locale('ar')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }
}
