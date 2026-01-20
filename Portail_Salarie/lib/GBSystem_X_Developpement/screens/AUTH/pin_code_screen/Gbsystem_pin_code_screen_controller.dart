import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GbsystemPinCodeScreenController extends GetxController {
  SharedPreferences? prefs;
  RxBool isLoading = RxBool(false);

  Future<void> setCodePIN({required String pinCode}) async {
    isLoading.value = true;

    prefs = await SharedPreferences.getInstance();
    await prefs!.setString(GbsSystemServerStrings.kPINCode, pinCode);
    isLoading.value = false;
  }

  Future<String?> getCodePIN() async {
    isLoading.value = true;

    prefs = await SharedPreferences.getInstance();
    isLoading.value = false;
    return await prefs!.getString(GbsSystemServerStrings.kPINCode);
  }

  Future<bool> compareCodePIN({required String pinCode}) async {
    isLoading.value = true;

    prefs = await SharedPreferences.getInstance();
    String? oldPIN = await prefs!.getString(GbsSystemServerStrings.kPINCode);
    isLoading.value = false;

    if (oldPIN == pinCode) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> onEnregistrerTap({required String codePIN}) async {
    await setCodePIN(pinCode: codePIN);
  }

  Future<void> onValiderTap(BuildContext context,
      {required String codePIN}) async {
    await compareCodePIN(pinCode: codePIN);
  }

  Future<void> viderLoginSharedPerfermences() async {
    isLoading.value = true;
    await SharedPreferences.getInstance().then((value) {
      value.setString(GbsSystemServerStrings.kToken, "");
      value.setString(GbsSystemServerStrings.kCookies, "");
      isLoading.value = false;
    });
  }
}
