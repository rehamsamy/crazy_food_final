import 'package:crazy_food/app/data/models/address_model.dart';
import 'package:crazy_food/app/data/models/cart_model.dart';
import 'package:crazy_food/app/data/models/payment_model.dart';
import 'package:crazy_food/app/data/remote_data_source/add_address_api.dart';
import 'package:crazy_food/app/data/remote_data_source/payment_apis.dart';
import 'package:get/get.dart';
class CheckoutController extends GetxController{
  Map map=Get.arguments ??{};
  List<CartModel>? cartProducts;
List<bool> ? paymentTypeSelected;
List<PaymentModel>? paymentList;
int paymentIndex = 0;
double ?total;

List<bool> ? addressTypeSelected;
List<Address>? addressList;
int addressIndex = 0;

@override
  void onInit() async{
  super.onInit();
  Get.log('controller.cartProducts ${cartProducts?.length.toString()} ');
  total=map['total'];
  cartProducts=map['products'];
  Get.log('total   =>${cartProducts!.length}');
  paymentList =await PaymentApis().getPayment() as List<PaymentModel>;
  paymentTypeSelected=List<bool>.filled(paymentList!.length, false);

  addressList =await AddAddressApis().getAddress() as List<Address>;
  addressTypeSelected=List<bool>.filled(addressList!.length, false);
  }


  changePaymentTypeSelected(index,val){
  Get.log('nnn $index');
    paymentTypeSelected?[index] = val;
    update();
  }

void setPaymentIndex(int newVal) {
  paymentIndex = newVal;
  update();
}


changeAddressTypeSelected(index,val){
  Get.log('nnn $index');
  addressTypeSelected?[index] = val;
  update();
}

void setAddressIndex(int newVal) {
  addressIndex = newVal;
  update();
}

}