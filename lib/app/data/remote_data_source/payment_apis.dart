
import 'package:crazy_food/app/data/models/payment_model.dart';
import 'package:crazy_food/app/data/models/payment_response.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:get/get.dart';
import 'package:crazy_food/app/data/services/network_service.dart/dio_network_service.dart';


class PaymentApis {
  Future<bool> puplishPaymentMethod(String paymentType,String id)async{

    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: '/payment.json',
      data: NetworkRequestBody.json(
          {
            'id':id,
            'type':paymentType
          }
      ),
    );


    NetworkResponse response = await networkService.execute(
      request,
        PaymentResponse.fromJson);
    Get.log('cccccccccccc       '+response.toString());
    response.maybeWhen(
        ok: (data) {
          return true;
        },
        noData: (info) {
          return null;
        },
        orElse: () {});
    return true;
  }

  Future<bool?> getPayment()async{
List<PaymentModel>? paymentList;
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: '/payment/payment/token1.json',
      data: NetworkRequestBody.json(
          {

          }
      ),
    );


    NetworkResponse response = await networkService.execute(
        request,Payment.fromJson
        );
     Get.log('cccccccccccc       '+response.toString());
    response.maybeWhen(
        ok: (data) {
          Get.log('2222222222       '+response.toString());
          return true;
        },
        noData: (info) {
          return null;
        },
        orElse: () {});
    return false;
  }
}
