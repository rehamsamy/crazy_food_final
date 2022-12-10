import 'package:crazy_food/app/data/models/login_model.dart';
import 'package:crazy_food/app/data/remote_data_source/profile_apis.dart';
import 'package:crazy_food/app/modules/change_password/controller/change_password_controller.dart';
import 'package:crazy_food/app/modules/more_tab/view/more_tab.dart';
import 'package:crazy_food/app/shared/app_buttons/app_progress_button.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app/shared/app_text_field.dart';
import 'package:crazy_food/app/shared/snack_bar.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ChangePasswordController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      builder: (_) {
        return Scaffold(
            appBar: null,
            body: Container(
                decoration: kContainerDecoraction,
                width: Get.width,
                height: Get.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () => Get.off(() => MoreTabScreen()),
                            icon: const Icon(
                              Icons.arrow_back_ios_sharp,
                              color: Colors.white,
                            ),
                          ),
                          AppText(
                            'update_profile'.tr,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          const SizedBox()
                        ],
                      ),
                      const SizedBox(
                        height: 10,
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
                          child: Container(
                            padding: const EdgeInsets.only(top: 50,bottom: 10,left: 20,right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    color: kPrimaryColor,
                                  ),

                                  height: 240,
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 20,),
                                        CustomTextFormField(
                                          hintText: 'name'.tr,
                                          keyboardType: TextInputType.text,
                                          prefixIcon: Icons.lock,
                                          radius: 8,
                                          horizontalPadding: 12,
                                          controller: _nameController,
                                        ),
                                        CustomTextFormField(
                                          hintText: 'email'.tr,
                                          keyboardType: TextInputType.text,
                                          prefixIcon: Icons.lock,
                                          radius: 8,
                                          horizontalPadding: 12,
                                          controller: _emailController,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                PositionedDirectional(
                                   top: 220,
                                  child: AppProgressButton(
                                    width: 200,
                                    height: 50,
                                    radius: 100,
                                    onPressed: (AnimationController
                                    animationController) async {
                                      if (_formKey.currentState!.validate()) {
                                        animationController.forward();
                                        await Future.delayed(
                                            const Duration(seconds: 2));
                                        LoginModel ? model= await ProfileApis().updateProfileData(name: _nameController.text,
                                            email: _emailController.text);
                                        if(model.localId !=null){
                                          Get.offAll(()=>MoreTabScreen());
                                          Future.delayed(Duration.zero, () async {
                                            showSnackBar('change_profile_success'.tr);
                                          });
                                          animationController.reverse();
                                        }else if(model.error?.message!=null){
                                          Future.delayed(Duration.zero, () async {
                                            Get.log('err    ${model.error?.message}');
                                            showSnackBar(model.error?.message??'general_error'.tr);
                                          });
                                          animationController.reverse();
                                          Get.log('rev');
                                        }
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        AppText('update_profile'.tr),
                                        const SizedBox(width: 10,),
                                        const Icon(
                                          Icons.arrow_forward,
                                          color: kPrimaryColor,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )));
      },
    );
  }
}
