import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app/shared/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterWidget extends StatelessWidget {
  var nameController, emailController, passwordController;

  RegisterWidget(
      {required this.nameController,
      required this.passwordController,
      required this.emailController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          hintText: 'name'.tr,
          keyboardType: TextInputType.text,
          prefixIcon: Icons.perm_identity,
          radius: 8,
          horizontalPadding: 12,
          controller: nameController,
        ),
        CustomTextFormField(
          hintText: 'email'.tr,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.email,
          radius: 8,
          horizontalPadding: 12,
          controller: emailController,
        ),
        CustomTextFormField(
          isPassword: true,
          hintText: 'password'.tr,
          prefixIcon: Icons.lock,
          keyboardType: TextInputType.visiblePassword,
          radius: 8,
          horizontalPadding: 12,
          controller: passwordController,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'by_pressing_on'.tr,
                  style: TextStyle(color: Colors.white)),
              TextSpan(
                  text: 'terms'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    decorationThickness: 1,
                    fontSize: 16,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {}),
            ]),
          ),
        ),
      ],
    );
  }
}
