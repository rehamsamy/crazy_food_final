
import 'package:crazy_food/app/data/models/login_error_model.dart';
import 'package:crazy_food/app/data/models/login_model.dart';
import 'package:crazy_food/app/data/models/register_model.dart';
import 'package:crazy_food/app/data/storage/local_storage.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';
import 'package:crazy_food/app/data/services/network_service.dart/dio_network_service.dart';


class AuthApis {
  Future<LoginModel> loginUser({required email,required password})async{
    LoginModel loginModel=LoginModel();
    Get.log('passw  '+password.toString());
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: 'accounts:signInWithPassword?key=$kApiKey',
      data: NetworkRequestBody.json(
        {'email': email,
          'password':password,
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
        ok: (data) async {
          loginModel = data;
          await LocalStorage.saveUser(loginModel);
          Get.log('data ==>'+loginModel.toString());
          return loginModel;
        },
        noData: (info) {
          return null;
        },
        orElse: () {
        });
    return loginModel;
  }


  Future<LoginModel> registerUser({required name,required email,required password})async{
    LoginModel registerModel=LoginModel();
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: 'accounts:signUp?key=$kApiKey',
      data: NetworkRequestBody.json(
        {'displayName':name,
          'name':name,
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
      LoginModel.fromJson, // <- Function to convert API response to your model
    );
    response.maybeWhen(
        ok: (data) async{
          registerModel = data;
          await LocalStorage.saveUser(registerModel);
          Get.log('data ==>'+registerModel.toString());
          return registerModel;
        },
        noData: (info) {
          return null;
        },
        orElse: () {});
    return registerModel;
  }
}
