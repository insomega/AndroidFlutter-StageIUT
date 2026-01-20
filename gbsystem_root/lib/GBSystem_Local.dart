import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'GBSystem_Storage_Service.dart';

class GBSystem_Local {
  // Locales supportées — statiques donc accessibles globalement
  static Locale getLocaleApplication() {
    final String? local = GBSystem_Storage_Service().getLocal();

    if (local != null) {
      return Locale(local);
    } else {
      return Get.deviceLocale!;
    }
  }
}
