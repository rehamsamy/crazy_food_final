import 'package:crazy_food/app/modules/auth/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
class LoginScreen extends GetView<LoginController>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
       height: 200,
       width: 200,
    child: Image.asset('assets/images/back.png'),
       
     ),
   );
  }

}