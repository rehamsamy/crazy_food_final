import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/modules/category_items_screen/controller/category_items_controller.dart';
import 'package:get/get.dart';
class CartController extends GetxController{
  CategoryItemsController categoryItemsController=Get.find();
  List<ProductModel>? cartsList;


  @override
  void onInit() {
    cartsList =categoryItemsController.cartItemsList;
    super.onInit();
  }

}