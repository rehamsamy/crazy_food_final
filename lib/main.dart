import 'package:crazy_food/app/core/get_binding.dart';
import 'package:crazy_food/app/core/values/localization/translation.dart';
import 'package:crazy_food/app/data/storage/local_storage.dart';
import 'package:crazy_food/app/modules/auth/login/view/login_screen.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/modules/notification/view/notification_screen.dart';
import 'package:crazy_food/app/views/network_error.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
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
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    final navigatorKey=GlobalKey<NavigatorState>();
    return  MaterialApp(
       navigatorKey: navigatorKey,
      home: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_,child)=> MaterialApp(
          home: GetMaterialApp(
              debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              // GlobalMaterialLocalizations.delegate,
              // GlobalWidgetsLocalizations.delegate, // ONLY if it's a RTL language
            ],
            supportedLocales: const [
              Locale('en', 'US'), // include country code too
              Locale('ar', 'EG'), // include country code too
            ],
              // locale:  Locale('ar', 'EG'),
            defaultTransition: Transition.cupertino,
            transitionDuration: const Duration(milliseconds: 500),
            translations: Translation(),
            initialBinding: GetBinding(),
           //  locale: LocalStorage.isAr
           //      ? const Locale('ar')
           //      : const Locale('en'),
            fallbackLocale: const Locale('en'),
            title: 'Crazy Food',
            theme: ThemeData(primarySwatch: Colors.green),
            home:MaterialApp(
              home:
              // LocalStorage.userModel!=null?HomeScreenView()
              //     :
              LoginScreenView(),
            ),

            //LocalStorage.userModel!=null?
            //  ProductDetailsScreen()

            // CartScreen()
            // HomeScreenView()
            //  LoginScreenView(),
            // home: const LoginScreen(),
          ),
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



//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