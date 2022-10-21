import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:get/get.dart';
class ProductDetailsController extends GetxController{
ProductModel ? productModel;
bool  isDetailsSelected=true;
Map map=Get.arguments;
List<ProductModel> ?similarProducts;

@override
  void onInit() {
  super.onInit();
  Get.log('category details 1 ==>'+(productModel?.nameAr).toString());
productModel = map['product_details'] as ProductModel;
  similarProducts=map['similarProducts'] as List<ProductModel>;
Get.log('category details 1 ==>'+(productModel?.nameAr).toString());
  }





handleISDetailsReviews(bool newVal){
  isDetailsSelected=newVal;
  update();
}

}