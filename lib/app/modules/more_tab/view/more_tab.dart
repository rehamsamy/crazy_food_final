import 'package:crazy_food/app/core/get_binding.dart';
import 'package:crazy_food/app/modules/auth/login/view/login_screen.dart';
import 'package:crazy_food/app/modules/change_password/view/change_password.dart';
import 'package:crazy_food/app/modules/more_tab/controller/setting_controller.dart';
import 'package:crazy_food/app/modules/profile_data/view/profile_view.dart';
import 'package:crazy_food/app/shared/app_buttons/app_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:get/get.dart';

import '../../../data/storage/local_storage.dart';

class MoreTabScreen extends GetView<SettingController> {
   MoreTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: kContainerDecoraction,
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () => Get.off(() => HomeScreenView()),
                      icon: const Icon(
                        Icons.arrow_back_ios_sharp,
                        color: Colors.white,
                      ),
                    ),
                    AppText(
                      'more_tab'.tr,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    const SizedBox()
                  ],
                ),
                Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
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
                            const SizedBox(
                              height: 40,
                            ),
                            buildSettingWidget('change_lang'.tr, 2, context),
                            const SizedBox(
                              height: 20,
                            ),
                            buildSettingWidget(
                                'change_password'.tr, 1, context),
                            const SizedBox(
                              height: 20,
                            ),
                            buildSettingWidget('account_info'.tr, 3, context),
                            const SizedBox(
                              height: 20,
                            ),
                            buildSettingWidget('sign_out'.tr,4, context),
                          ],
                        ),
                      )),
                )
              ],
            ),
          )),
    );
  }

  buildSettingWidget(String txt, int flag, BuildContext context) {
    return InkWell(
      onTap: () {
        if(flag==1){
          Get.to(() => ChangePasswordView(), binding: GetBinding());
        }else if(flag==2){
          showChangeLangDialog(context);
        }else if(flag==3){
          Get.to(() => ProfileView(), binding: GetBinding());
        }else if(flag==4){
          LocalStorage.signOut();
          Get.offAll(() => LoginScreenView(), binding: GetBinding());
        }
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
              const Icon(
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
      builder: (ctx) => AlertDialog(
        title: Center(
            child: AppText(
          'change_lang'.tr,
          color: kPrimaryColor,
        )),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: LayoutBuilder(
              builder: (_, cons) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: cons.maxWidth * 0.8,
                        height: 40,
                        child: AppProgressButton(
                          backgroundColor: kPrimaryColor,
                          radius: 5,
                          onPressed: (val) {
                            Get.back();
                            onChangeLang('ar');
                          },
                          child: const AppText(
                            '??????????????',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 40,
                        width: cons.maxWidth * 0.8,
                        child: AppProgressButton(
                          backgroundColor: kPrimaryColor,
                          radius: 5,
                          onPressed: (val) {
                            Get.back();
                            onChangeLang('en');
                          },
                          child: const AppText(
                            'English',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )),
        ),
      ),
    );
  }

  onChangeLang(String lang) async {
    await Get.updateLocale(Locale(lang));
    LocalStorage.saveLocale(lang);
  }

  final List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('us')},
    {'name': '??????????????', 'locale': const Locale('ar')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }
}
