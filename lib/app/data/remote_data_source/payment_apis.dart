
import 'dart:convert';

import 'package:crazy_food/app/data/models/payment_model.dart';
import 'package:crazy_food/app/data/models/payment_response.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:get/get.dart';
import 'package:crazy_food/app/data/services/network_service.dart/dio_network_service.dart';
import 'package:http/http.dart' as http;


class PaymentApis {
  Future<bool> puplishPaymentMethod(String paymentType,String id)async{

    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: '/payment/payment/token/data',
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

  Future<List<PaymentModel>?> getPayment() async {
    List<PaymentModel>? paymentList = [];
    // try {
    //
    //   var response =
    //       await http.get(Uri.parse('$baseUrl/payment/payment/token1.json'));
    //   Get.log('error'+ response.body.toString()+response.statusCode.toString());
    //   if (response.statusCode == 200) {
    //     List< dynamic> result =
    //         json.decode(response.body) as List< dynamic>;
    //
    //     result.forEach((element) {
    //       Get.log('error  '+element);
    //       paymentList.add(element);
    //     });
    //
    //   } else {
    //     Get.log('error');
    //   }
    // } catch (err) {
    //   Get.log('error'+err.toString());
    // }
    // return paymentList;
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: '/payment/payment/token.json',
      data: NetworkRequestBody.json(
          {}
      ),
    );


    NetworkResponse response = await networkService.execute(
        request,
        Payment.fromJson);
    response.maybeWhen(
        ok: (data) {
          paymentList=data.data as List<PaymentModel>;
          Get.log('cccccccccccc       '+paymentList!.length.toString());
          return paymentList;
        },
        noData: (info) {
          return null;
        },
        orElse: () {});
    return paymentList;
  }
}
