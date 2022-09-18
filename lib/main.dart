import 'package:crazy_food/app/views/network_error.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:get/get.dart';

void main() {
  runApp(const CrazyApp());
}

class CrazyApp extends StatefulWidget {
  const CrazyApp({Key? key}) : super(key: key);

  @override
  State<CrazyApp> createState() => _CrazyAppState();
}

class _CrazyAppState extends State<CrazyApp> {

  bool _backViewOn = true;
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    Connectivity().onConnectivityChanged.listen((event) async{
  if(await InternetConnectionChecker().hasConnection){
    if(!_backViewOn){
      setState(() {
        _backViewOn=false;
      });
      Get.to(
            () => const NetworkError(),
      );

    }
  }
    });
  }
}
