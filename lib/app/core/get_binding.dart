import 'package:crazy_food/app/modules/auth/login/controller/login_controller.dart';
import 'package:get/get.dart';


class GetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
