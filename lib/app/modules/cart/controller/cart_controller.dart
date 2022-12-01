import 'package:crazy_food/app/data/models/cart_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  Map<String, CartModel> _cartsList = {};

  Map<String, CartModel> get cartItemMap => _cartsList;
  int? cartSelectedIndex = 0;
  int itemQuantity = 0;
  double totalCartPrice = 0;

  @override
  void onInit() {
    Get.log('initated   ');
    super.onInit();
    changeTotalCartPrice();
  }

  void addItemToCartScreen(
      String id, num? price, String title, String imagePath, int caleories) {
    Get.log('found');
    if (_cartsList.containsKey(id)) {
      Get.log('yes found');
      _cartsList.update(
          id,
          (oldModel) => CartModel(
              id: id,
              title: oldModel.title,
              price: oldModel.price,
              imagePath: oldModel.imagePath,
              caleories: oldModel.caleories,
              quantity: oldModel.quantity + 1));
    } else {
      Get.log('not found');
      _cartsList.putIfAbsent(
          id,
          () => CartModel(
              id: id,
              title: title,
              price: price,
              imagePath: imagePath,
              caleories: caleories,
              quantity: 1));
    }
    print('exit ${_cartsList.toString()}');
    update();
  }

  changeCartSelectedIndex(int index) {
    cartSelectedIndex = index;
    update();
  }

  changeItemQuantity(String type, String id) {
    if (type == 'increment') {
      cartItemMap.update(
          id,
          (oldModel) => CartModel(
              id: id,
              title: oldModel.title,
              price: oldModel.price,
              imagePath: oldModel.imagePath,
              caleories: oldModel.caleories,
              quantity: oldModel.quantity + 1));
    } else if (type == 'decrement') {
      if (itemQuantity < 0) {
        cartItemMap.update(
            id,
                (oldModel) => CartModel(
                id: id,
                title: oldModel.title,
                price: oldModel.price,
                imagePath: oldModel.imagePath,
                caleories: oldModel.caleories,
                quantity: 0));
      }
      cartItemMap.update(
          id,
          (oldModel) => CartModel(
              id: id,
              title: oldModel.title,
              price: oldModel.price,
              imagePath: oldModel.imagePath,
              caleories: oldModel.caleories,
              quantity: oldModel.quantity - 1));
    }
    changeTotalCartPrice();
    update();
  }

  changeTotalCartPrice() {
    double sum=0.0;
    cartItemMap.forEach((key, value) {
      double price=double.parse((value.price).toString());
      sum +=  value.quantity *price;
      Get.log('price =>'+sum.toString());
    });
   totalCartPrice=sum;
    update();
  }
}
