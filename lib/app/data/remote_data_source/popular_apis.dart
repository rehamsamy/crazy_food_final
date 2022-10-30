
import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/data/models/category_model.dart';
import 'package:crazy_food/app/data/models/popular_model.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:get/get.dart';
import 'package:crazy_food/app/data/services/network_service.dart/dio_network_service.dart';


class PopularApis {
  // Future<List<Popular>?> getPopular()async{
  //   List<Popular> popular=[];
  //   final request = NetworkRequest(
  //     type: NetworkRequestType.GET,
  //     path: '/popular.json',
  //     data: NetworkRequestBody.json(
  //         {}
  //     ),
  //   );
  //
  //
  //   NetworkResponse response = await networkService.execute(
  //     request,
  //     PopularModel.fromJson, // <- Function to convert API response to your model
  //   );
  //   Get.log('ccc '+response.toString());
  //   response.maybeWhen(
  //       ok: (data) {
  //         Get.log('ccc 111 '+data.toString());
  //         popular = data.popular;
  //         return popular;
  //       },
  //       noData: (info) {
  //         return null;
  //       },
  //       orElse: () {});
  //   return popular;
  // }

  Future<List<ProductModel>?> getPopular()async{
    List<ProductModel> popularList=[];
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
          popularList = data.productsList;

          // products.map((e) {
          //   if((e.rate??0.0)>4){
          //     Popular popular=Popular(id:e.id,imagePath:e.imagePath,);
          //     popularList.add(popular);
          //   }
          // } ).toList();
          Get.log('prods size ==>'+popularList.length.toString());
          return popularList;
        },
        noData: (info) {
          return null;
        },
        orElse: () {});
    return popularList;
  }

}
