import 'dart:convert';
import 'package:crazy_food/app/data/models/cart_model.dart';
import 'package:crazy_food/app/data/models/order_model.dart';
import 'package:crazy_food/app/data/models/payment_response.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:get/get.dart';
import 'package:crazy_food/app/data/services/network_service.dart/dio_network_service.dart';
import 'package:http/http.dart' as http;

class AddOrdersApis {
  Future<bool> addOrder(
      {required List<CartModel> carts,
      required double total,
      required String address,
      required payment,
      required double latitude,
      required double longitude}) async {
    // String dateTime = DateTime.now().toIso8601String();

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


  Future<bool> updateOrder(
      {required List<Products> carts,
        required double total,
        required String address,
        required payment,
        required double latitude,
        required double longitude,required String bath}) async {

    final request = NetworkRequest(
      type: NetworkRequestType.PUT,
      path: '/orders/token/$bath.json',
      data: NetworkRequestBody.json({
        'products': carts
            .map((e) => {
          'productId': e.productId,
          'productName': e.productName,
          'productImage': e.productImage,
          'price': e.price,
          'quantity': e.quantity,
          'caleories': e.caleories
        })
            .toList(),
        'dateTime':DateTime.now().toString(),
        'totalAmount':total,
        'order_status':'processing',
        // 'statusId':2,
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

       //   ---------  change order status ------------------------------
        Future.delayed(Duration(seconds: 10));
          AddOrdersApis().updateOrder(
              carts: model.products ?? [],
              total: model.totalAmount ?? 0.0,
              address: model.address ?? '',
              payment: model.payment ?? '',
              latitude: model.latitude ?? 0.0,
              longitude: model.longitude ?? 0.0,bath: key);
          Get.log('error '+key);
          ordersList?.add(model);
        });

        ordersList=await getFinalOrders();
      } else {
        Get.log('error');
      }
    } catch (err) {
      Get.log('error' + err.toString());
    }
    return ordersList;
  }

  Future<List<OrderModel>?> getFinalOrders() async {
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