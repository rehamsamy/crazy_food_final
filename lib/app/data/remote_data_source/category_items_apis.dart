
import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/data/models/category_model.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:get/get.dart';
import 'package:crazy_food/app/data/services/network_service.dart/dio_network_service.dart';


class CategoryItemsApis {
  Future<List<ProductModel>?> getCategoriesList()async{
    List<ProductModel> products=[];
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: '/categoriesItems.json',
      data: NetworkRequestBody.json(
          {}
      ),
    );


    NetworkResponse response = await networkService.execute(
      request,
      CategoryItemsModel.fromJson, // <- Function to convert API response to your model
    );
    Get.log('ccc '+response.toString());
    response.maybeWhen(
        ok: (data) {
          Get.log('ccc 111 '+data.toString());
          products = data.productsList;
          return products;
        },
        noData: (info) {
          return null;
        },
        orElse: () {});
    return products;
  }



}
