import 'package:crazy_food/app/data/models/login_model.dart';
import 'package:crazy_food/app/data/models/register_model.dart';
import 'package:crazy_food/app/data/remote_data_source/auth_apis.dart';
import 'package:crazy_food/app/modules/auth/login/controller/login_controller.dart';
import 'package:crazy_food/app/modules/auth/login/view/widget/login_widget.dart';
import 'package:crazy_food/app/modules/auth/login/view/widget/register_widget.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/shared/app_buttons/app_progress_button.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
class LoginScreenView extends GetView<LoginController> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isLogin = true;
  final GlobalKey<FormState>  _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GetBuilder<LoginController>(
          builder: (_) => SingleChildScrollView(
            child: Container(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.all(15),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: kToolbarHeight),
                  Center(
                    child: ListTile(
                      title:  AppText(controller.isLogin ? 'welcome_back'.tr : 'welcome'.tr, fontSize: 18),
                      subtitle: AppText(controller.isLogin ? 'Sign_in_to_continue'.tr : 'Sign_up_to_continue'.tr),
                    ),
                  ),
                  Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Card(
                          elevation: 10,
                          color: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 18),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.setIsLogin(true);
                                        },
                                        child: IntrinsicWidth(
                                          stepWidth: 120,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Center(
                                                  child: AppText(
                                                'login'.tr,
                                                color: Colors.white,
                                                fontSize: 25,
                                              )),
                                              Container(
                                                margin: const EdgeInsets.symmetric(
                                                    vertical: 4.0),
                                                color: controller.isLogin
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .primaryColor,
                                                height: 3.5,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.setIsLogin(false);
                                        },
                                        child: IntrinsicWidth(
                                          stepWidth: 120,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Center(
                                                  child: AppText(
                                                'register'.tr,
                                                color: Colors.white,
                                                fontSize: 25,
                                              )),
                                              Container(
                                                margin: const EdgeInsets.symmetric(
                                                    vertical: 4.0),
                                                color: !controller.isLogin
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .primaryColor,
                                                height: 3.5,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                controller.isLogin
                                    ? LoginWidget(
                                        emailController: emailController,
                                        passwordController: passwordController,
                                      )
                                    : RegisterWidget(
                                        nameController: nameController,
                                        passwordController: passwordController,
                                        emailController: emailController),
                                const SizedBox(height: 50),
                              ],
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          bottom: -30,
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: kPrimaryColor),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: AppProgressButton(
                                width: 50,
                                height: 50,
                                radius: 100,
                                onPressed: (AnimationController animationController) async{
                                  if(_formKey.currentState!.validate()){
                                    animationController.forward();
                                    await Future.delayed(Duration(seconds: 2));
                                    if(controller.isLogin){
                                   LoginModel ? model=   await AuthApis().loginUser(
                                          email: emailController.text, password: passwordController.text);
                                   Get.log('expire is '+(model.expiresIn).toString());
                                   if(model.expiresIn !=null){
                                     Get.offAll(()=>HomeScreenView());
                                   }
                                    }else{
                                    RegisterModel model=  await AuthApis().registerUser(name: nameController.text,
                                          email: emailController.text, password: passwordController.text);
                                      if(model.expiresIn !=null){
                                        Get.offAll(()=>HomeScreenView());
                                      }
                                    }

                                   // Get.offAll(()=>HomeScreenView());
                                  }
                                },
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: kPrimaryColor,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
