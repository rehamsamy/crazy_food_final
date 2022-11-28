import 'package:crazy_food/app/data/remote_data_source/add_orders_apis.dart';
import 'package:get/get.dart';
class OrderController extends GetxController{

  Future onRefresh() async {
    await AddOrdersApis().getOrders();
  }

}