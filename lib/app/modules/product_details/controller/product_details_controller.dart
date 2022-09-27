import 'package:get/get.dart';
class ProductDetailsController extends GetxController{

bool  isDetailsSelected=true;

handleISDetailsReviews(bool newVal){
  isDetailsSelected=newVal;
  update();
}

}