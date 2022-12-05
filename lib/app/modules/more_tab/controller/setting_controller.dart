import 'package:crazy_food/app/data/storage/local_storage.dart';
import 'package:get/get.dart';
class SettingController extends GetxController{

  onChangeLang(String lang) {
   LocalStorage
        .saveLocale(lang);
    update();
  }
}