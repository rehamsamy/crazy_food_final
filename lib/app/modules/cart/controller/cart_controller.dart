import 'package:crazy_food/app/data/models/cart_model.dart';import 'package:get/get.dart';
class CartController extends GetxController{
  Map<String,CartModel> _cartsList={};
  Map<String, CartModel> get cartItemMap => _cartsList;
  @override
  void onInit() {
    super.onInit();
  }
  void ddItemToCartScreen(String id,num ? price,String title,String imagePath,int caleories) {
    Get.log('found');
    if(_cartsList.containsKey(id)){
      Get.log('yes found');
      _cartsList.update(id, (oldModel) =>
          CartModel(id: id, title: oldModel.title,
              price: oldModel.price, imagePath: oldModel.imagePath,
              caleories: oldModel.caleories, quantity: oldModel.quantity+1)
      );
    }else{
      Get.log('not found');
      _cartsList.putIfAbsent(id, () =>
          CartModel(id: id, title: title,
              price: price, imagePath:imagePath,
              caleories: caleories, quantity: 1)
      );
    }
    print('exit ${_cartsList.toString()}');
    update();
  }

}