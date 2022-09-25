
import 'package:crazy_food/app/data/models/login_model.dart';
import 'package:crazy_food/app/data/models/register_model.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';
import 'package:crazy_food/app/data/services/network_service.dart/dio_network_service.dart';


class AuthApis {
  Future<LoginModel> loginUser({required email,required password})async{
    LoginModel loginModel=LoginModel();
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: 'accounts:signInWithPassword?key=$kApiKey',
      data: NetworkRequestBody.json(
        {'email': email,
          'password': 'password',
          'returnSecureToken': true},
      ),
    );

    NetworkService networkService = NetworkService(
      baseUrl: 'https://identitytoolkit.googleapis.com/v1/',
      httpHeaders: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        //'Authorization': 'Bearer ${SharedPrefService.getToken() ?? ''}',
        'Language': Get.locale?.languageCode ?? 'en',
      },//
    );
    NetworkResponse response = await networkService.execute(
      request,
      LoginModel.fromJson, // <- Function to convert API response to your model
    );
    response.maybeWhen(
        ok: (data) {
          loginModel = data;
          Get.log('vvvvvvv '+loginModel.displayName.toString());
          return loginModel;
        },
        noData: (info) {
          return null;
        },
        orElse: () {});
    return loginModel;
  }


  Future<RegisterModel> registerUser({required name,required email,required password})async{
   RegisterModel registerModel=RegisterModel();
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: 'accounts:signUp?key=$kApiKey',
      data: NetworkRequestBody.json(
        {'displayName':'name',
          'email': email,
          'password': 'password',
          'returnSecureToken': true},
      ),
    );

    NetworkService networkService = NetworkService(
      baseUrl: 'https://identitytoolkit.googleapis.com/v1/',
      httpHeaders: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        //'Authorization': 'Bearer ${SharedPrefService.getToken() ?? ''}',
        'Language': Get.locale?.languageCode ?? 'en',
      },
    );
    NetworkResponse response = await networkService.execute(
      request,
      RegisterModel.fromJson, // <- Function to convert API response to your model
    );
    Get.log('vvvvvvv '+response.toString());
    response.maybeWhen(
        ok: (data) {
          registerModel = data;
          return registerModel;
        },
        noData: (info) {
          return null;
        },
        orElse: () {});
    return registerModel;
  }
}
