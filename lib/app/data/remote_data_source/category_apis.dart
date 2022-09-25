
import 'package:crazy_food/app/data/models/category_model.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:get/get.dart';
import 'package:crazy_food/app/data/services/network_service.dart/dio_network_service.dart';


class CategoryApis {
  Future<List<CategoryItemModel>?> categories()async{
    List<CategoryItemModel> categories=[];
    final request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: '/categories.json',
      data: NetworkRequestBody.json(
        {}
      ),
    );
Map<String,dynamic> map=  json.decode(response.body) as Map<String, dynamic>;

    NetworkResponse response = await networkService.execute(
      request,
      CategoryItemModel.fromJson, // <- Function to convert API response to your model
    );
    Get.log('ccc '+response.toString());
    response.maybeWhen(
        ok: (data) {
          categories.add(data);
          Get.log('ccc '+data.toString());
          categories = data;
          return categories;
        },
        noData: (info) {
          return null;
        },
        orElse: () {});
    return categories;
  }



}
