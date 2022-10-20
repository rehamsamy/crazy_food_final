import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:get/get.dart';
class ProductDetailsController extends GetxController{
ProductModel ? productModel;
bool  isDetailsSelected=true;


@override
  void onInit() {
productModel = Get.arguments['product_details'] as ProductModel;
Get.log('category details 1 ==>'+(productModel?.nameAr).toString());
  }

  handleISDetailsReviews(bool newVal){
  isDetailsSelected=newVal;
  update();
}

}