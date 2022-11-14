
import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/data/models/category_model.dart';
import 'package:crazy_food/app/data/models/popular_model.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:get/get.dart';
import 'package:crazy_food/app/data/services/network_service.dart/dio_network_service.dart';


class PaymentApis {
  Future<bool> getPopular()async{
    List<ProductModel> popularList=[];
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: '/payment.json',
      data: NetworkRequestBody.json(
          {}
      ),
    );


    NetworkResponse response = await networkService.execute(
      request,
        {});

    response.maybeWhen(
        ok: (data) {
          popularList = data.productsList;

          // products.map((e) {
          //   if((e.rate??0.0)>4){
          //     Popular popular=Popular(id:e.id,imagePath:e.imagePath,);
          //     popularList.add(popular);
          //   }
          // } ).toList();
          return popularList;
        },
        noData: (info) {
          return null;
        },
        orElse: () {});
    return popularList;



  }

}
