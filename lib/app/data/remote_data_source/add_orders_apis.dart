import 'dart:convert';
import 'package:crazy_food/app/data/models/address_model.dart';
import 'package:crazy_food/app/data/models/cart_model.dart';
import 'package:crazy_food/app/data/models/order_model.dart';
import 'package:crazy_food/app/data/models/payment_response.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:get/get.dart';
import 'package:crazy_food/app/data/services/network_service.dart/dio_network_service.dart';
import 'package:http/http.dart' as http;

class AddOrdersApis {
  Future<bool> addOrder(
      {required List<CartModel> carts, required double total,required String address,required payment}) async {
    String dateTime = DateTime.now().toIso8601String();

    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: '/orders/token.json',
      data: NetworkRequestBody.json({
        'products': carts
            .map((e) => {
                  'productId': e.id,
                  'productName': e.title,
                  'productImage': e.imagePath,
                  'price': e.price,
                  'quantity': e.quantity,
                  'caleories': e.caleories
                })
            .toList(),
        'dateTime':DateTime.now().toString(),
        'totalAmount':total,
        'order_status':'pending',
        'address':address,
        'payment':payment
      }),
    );

    NetworkResponse response =
        await networkService.execute(request, PaymentResponse.fromJson);
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

  Future<List<OrderModel>?> getOrders() async {
    List<OrderModel>? ordersList = [];
    try {
      var response = await http.get(Uri.parse('$baseUrl/orders/token.json'));
      Get.log(
          'orders data ==>' + response.body.toString() + response.statusCode.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> result =
            json.decode(response.body) as Map<String, dynamic>;
        result.forEach((key, value) {
          Get.log('orders data ==> step 1 '+value.toString() );
          OrderModel model = OrderModel.fromJson(value);
          Get.log('orders data ==> step 1 '+model.toString() );
          ordersList.add(model);
          // value.forEach((key, val) {
          //   Get.log('orders data ==> step 2 '+val.toString() );
          //   OrderModel model = OrderModel.fromJson(val);
          //   Get.log('orders data ==> step 3 '+model.toString() );
          //   ordersList.add(model);
          // });
        });
      } else {
        Get.log('error');
      }
    } catch (err) {
      Get.log('error' + err.toString());
    }
    return ordersList;
  }
}
