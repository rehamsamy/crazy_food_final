import 'dart:convert';

import 'package:crazy_food/app/data/models/login_error_model.dart';
import 'package:crazy_food/app/data/models/login_model.dart';
import 'package:crazy_food/app/data/storage/local_storage.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crazy_food/app/data/services/network_service.dart/dio_network_service.dart';


class AuthApis {
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




 Future<String ?> forgetPassword(String email) async {
    String ?mess;
    String url1 =
        'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$kApiKey';
    Map<String, dynamic> map_new = {
      'email': email,
      'requestType': 'PASSWORD_RESET'
    };

    try {
      var response2 =
      await http.post(Uri.parse(url1), body: json.encode(map_new));
      if (response2.statusCode == 200) {
        print(response2.body.toString());
        mess=  response2.body.toString();
        return mess;
      } else if (response2.statusCode == 400){
        mess=  response2.body.toString();
        return mess;
      }else{
        Fluttertoast.showToast(
            msg: 'Token is expired Please login again',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } catch (err) {
      Fluttertoast.showToast(
          msg: 'Token is expired Please login again',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);

    }
    return mess;
  }
}
