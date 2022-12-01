import 'dart:convert';

import 'package:crazy_food/app/data/models/login_error_model.dart';
import 'package:crazy_food/app/data/models/login_model.dart';
import 'package:crazy_food/app/data/storage/local_storage.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:crazy_food/app/data/services/network_service.dart/dio_network_service.dart';


class AuthApis {
  // Future<LoginModel> loginUser({required email,required password})async{
  //   LoginModel loginModel=LoginModel();
  //   LoginErrorModel errorModel=LoginErrorModel();
  //   Get.log('passw  '+password.toString());
  //   final request = NetworkRequest(
  //     type: NetworkRequestType.POST,
  //     path: 'accounts:signInWithPassword?key=$kApiKey',
  //     data: NetworkRequestBody.json(
  //       {'email': email,
  //         'password':password,
  //         'returnSecureToken': true},
  //     ),
  //   );
  //
  //   NetworkService networkService = NetworkService(
  //     baseUrl: 'https://identitytoolkit.googleapis.com/v1/',
  //     httpHeaders: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       //'Authorization': 'Bearer ${SharedPrefService.getToken() ?? ''}',
  //       'Language': Get.locale?.languageCode ?? 'en',
  //     },//
  //   );
  //   NetworkResponse response = await networkService.execute(
  //     request,
  //     LoginModel.fromJson, // <- Function to convert API response to your model
  //   );
  //
  //   Get.log('err     1 =>'+response.toString());
  //
  //   response.maybeWhen(
  //       ok: (data) async {
  //         loginModel = data;
  //         await LocalStorage.saveUser(loginModel);
  //         Get.log('data ==>'+loginModel.toString());
  //         return loginModel;
  //       },
  //       noData: (info) {
  //         return null;
  //       },
  //       badRequest: (info){
  //
  //         Get.log('err     1 =>'+(loginModel.error?.message).toString());
  //       },
  //       orElse: () {
  //       });
  //   return loginModel;
  // }



  Future<LoginModel> loginUser({required email,required password})async{
    LoginModel loginModel=LoginModel();
  String   baseUrl= 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$kApiKey';
    try{
      var x = await http.post(Uri.parse(baseUrl), body: json.encode(
      {'email': email,
                    'password':password,
                    'returnSecureToken': true},
      ));

      if (x.statusCode == 200) {
        print('step1');
        var y = json.decode(x.body);
        loginModel=LoginModel.fromJson(y);
        await LocalStorage.saveUser(loginModel);
        Get.log('save data to storage'+loginModel.toString());

      }else if(x.statusCode==400){
        print('step2');
         var y = json.decode(x.body);
        loginModel=LoginModel.fromJson(y);
        // loginModel=y;
        Get.log('ff '+x.body.toString());
      }
      return loginModel;
    }catch(err){

    }
    return loginModel;
  }



  // Future<LoginModel> registerUser({required name,required email,required password})async{
  //   LoginModel registerModel=LoginModel();
  //   final request = NetworkRequest(
  //     type: NetworkRequestType.POST,
  //     path: 'accounts:signUp?key=$kApiKey',
  //     data: NetworkRequestBody.json(
  //       {'displayName':name,
  //         'name':name,
  //         'email': email,
  //         'password': password,
  //         'returnSecureToken': true},
  //     ),
  //   );
  //
  //   NetworkService networkService = NetworkService(
  //     baseUrl: 'https://identitytoolkit.googleapis.com/v1/',
  //     httpHeaders: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       //'Authorization': 'Bearer ${SharedPrefService.getToken() ?? ''}',
  //       'Language': Get.locale?.languageCode ?? 'en',
  //     },
  //   );
  //   NetworkResponse response = await networkService.execute(
  //     request,
  //     LoginModel.fromJson, // <- Function to convert API response to your model
  //   );
  //   response.maybeWhen(
  //       ok: (data) async{
  //         registerModel = data;
  //         await LocalStorage.saveUser(registerModel);
  //         Get.log('data ==>'+registerModel.toString());
  //         return registerModel;
  //       },
  //       noData: (info) {
  //         return null;
  //       },
  //       orElse: () {});
  //   return registerModel;
  // }



  Future<LoginModel> registerUser({required name,required email,required password})async{
    LoginModel loginModel=LoginModel();
    String   baseUrl= 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$kApiKey';
    try{
      var x = await http.post(Uri.parse(baseUrl), body: json.encode(
        {'displayName':name,
          'name':name,
          'email': email,
          'password': password,
          'returnSecureToken': true},
      ));

      if (x.statusCode == 200) {
        print('step1');
        var y = json.decode(x.body);
        loginModel=LoginModel.fromJson(y);
        await LocalStorage.saveUser(loginModel);
        Get.log('save data to storage'+loginModel.toString());

      }else if(x.statusCode==400){
        print('step2');
        var y = json.decode(x.body);
        loginModel=LoginModel.fromJson(y);
      }
      return loginModel;
    }catch(err){

    }
    return loginModel;
  }
}
