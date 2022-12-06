import 'package:crazy_food/app/modules/auth/login/controller/login_controller.dart';
import 'package:crazy_food/app/modules/cart/controller/cart_controller.dart';
import 'package:crazy_food/app/modules/category/controller/category_controller.dart';
import 'package:crazy_food/app/modules/category_items_screen/controller/category_items_controller.dart';
import 'package:crazy_food/app/modules/change_password/controller/change_password_controller.dart';
import 'package:crazy_food/app/modules/checkout/controller/checkout_controller.dart';
import 'package:crazy_food/app/modules/home/controller/home_controller.dart';
import 'package:crazy_food/app/modules/more_tab/controller/setting_controller.dart';
import 'package:crazy_food/app/modules/orders_tab/controller/order_controller.dart';
import 'package:crazy_food/app/modules/product_details/controller/product_details_controller.dart';
import 'package:crazy_food/app/modules/search/controller/search_controller.dart';
import 'package:get/get.dart';


class GetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<LoginController>(
          () => LoginController(),
    );
    Get.lazyPut<CategoryController>(
          () => CategoryController(),
    );
    Get.lazyPut<ProductDetailsController>(
          () => ProductDetailsController(),
    );
    Get.lazyPut<SearchController>(
          () => SearchController(),
    );
    Get.lazyPut<CartController>(
          () => CartController(),
    );
    Get.lazyPut<CategoryItemsController>(
          () => CategoryItemsController(),
    );
    Get.lazyPut<CheckoutController>(
          () => CheckoutController(),
    );

    Get.lazyPut<OrderController>(
          () => OrderController(),
    );

    Get.lazyPut<SettingController>(
          () => SettingController(),
    );

    Get.lazyPut<ChangePasswordController>(
          () => ChangePasswordController(),
    );
  }
}
