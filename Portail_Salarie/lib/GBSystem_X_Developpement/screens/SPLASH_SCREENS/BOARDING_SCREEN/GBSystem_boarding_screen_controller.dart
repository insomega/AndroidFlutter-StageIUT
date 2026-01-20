import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_screen.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GBSystem_BoardingScreen_Controller extends GetxController {
  SharedPreferences? prefs;
  Future updateFirstTime() async {
    prefs = await SharedPreferences.getInstance();
    await prefs!
        .setBool(GbsSystemServerStrings.kIsFirstTime, false)
        .then((value) {
      Get.off(GBSystemLoginScreen());
    });
  }
}
