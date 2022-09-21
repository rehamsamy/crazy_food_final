import 'package:crazy_food/app/modules/auth/login/controller/login_controller.dart';
import 'package:crazy_food/app/modules/auth/login/view/widget/login_widget.dart';
import 'package:crazy_food/app/modules/auth/login/view/widget/register_widget.dart';
import 'package:crazy_food/app/shared/app_buttons/app_progress_button.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
class LoginScreen extends GetView<LoginController>{
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  bool isLogin=true;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: GetBuilder<LoginController>(
       builder: (_)=>Container(
         height: ScreenUtil().screenHeight,
         width: ScreenUtil().screenWidth,
    color: Colors.white,
    child: SingleChildScrollView(
        child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
             clipBehavior: Clip.none,
          children: [
             Card(
            elevation: 10,
            child: Container(
              decoration: kContainerDecoraction,
              child: Form(
                child: Column(
                  children: [
                    SizedBox(height: 200,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                           InkWell(
                               onTap: (){
                                 controller.setIsLogin(true);
                               },
                               child: AppText('login'.tr,color: Colors.white,fontSize: 20,)),
                           InkWell(
                             onTap: (){
                               controller.setIsLogin(false);
                             },
                               child: AppText('register'.tr,color: Colors.white,fontSize: 20,)),
                      ],
                    ),
                  controller.isLogin??true?LoginWidget(nameController: nameController, passwordController: passwordController,)
                      : RegisterWidget(nameController: nameController, passwordController: passwordController,emailController: emailController),
                  const SizedBox(height: 40),
                  ],

                ),
              ),
            ),
          ),
        PositionedDirectional(
          bottom:-30,
            child: Container(
          decoration:const BoxDecoration(
            shape: BoxShape.circle,
            color: kPrimaryColor
          ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppProgressButton(
                  width: 50,
                  height: 50,
                  radius: 100,
                  onPressed: (AnimationController animationController) {  },
                  child: Icon(
                    Icons.arrow_forward,
                    color: kPrimaryColor,
                    size: 30,
                  ),
                ),
              ),
        ),)
        ]
        ),
    ),

       ),
     ),
   );
  }

}