import 'package:crazy_food/app/data/models/payment_model.dart';
import 'package:crazy_food/app/data/remote_data_source/payment_apis.dart';
import 'package:get/get.dart';
class CheckoutController extends GetxController{
List<bool> ? paymentTypeSelected;
List<PaymentModel>? paymentList;
int paymentIndex = 0;

@override
  void onInit() async{
  paymentList =await PaymentApis().getPayment() as List<PaymentModel>;
  paymentTypeSelected=List<bool>.filled(paymentList!.length, false);
    super.onInit();
  }


  changePaymentTypeSelected(index,val){
  Get.log('nnn '+index.toString());
    paymentTypeSelected?[index] = val;
    update();
  }

void setPaymentIndex(int newVal) {
  paymentIndex = newVal;
  update();
}

}