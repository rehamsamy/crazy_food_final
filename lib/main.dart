import 'package:crazy_food/app/core/get_binding.dart';
import 'package:crazy_food/app/core/values/localization/translation.dart';
import 'package:crazy_food/app/modules/orders_tab/view/orders_screen.dart';
import 'package:crazy_food/app/views/network_error.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:get/get.dart';

import 'app/modules/home/view/home_screen.dart';
import 'app/modules/product_details/view/product_details_screen.dart';

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
    return  ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,child)=> MaterialApp(
        home: GetMaterialApp(
          // localizationsDelegates: const [
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate, // ONLY if it's a RTL language
          // ],
          supportedLocales: const [
            Locale('en', 'US'), // include country code too
            Locale('ar', 'EG'), // include country code too
          ],
          defaultTransition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
          translations: Translation(),
          initialBinding: GetBinding(),
         //  locale: LocalStorage.isAr
         //      ? const Locale('ar')
         //      : const Locale('en'),
          fallbackLocale: const Locale('en'),
          debugShowCheckedModeBanner: false,
          title: 'Crazy Food',
          theme: ThemeData(primarySwatch: Colors.green),
          home:
          //LocalStorage.userModel!=null?
          //  ProductDetailsScreen()
          OrdersScreen()
          // CartScreen()
          // HomeScreenView()
          //  LoginScreenView(),
          // home: const LoginScreen(),
        ),
      ),
    );
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
