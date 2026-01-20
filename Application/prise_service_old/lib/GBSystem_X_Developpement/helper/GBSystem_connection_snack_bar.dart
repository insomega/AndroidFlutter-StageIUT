import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';

import 'package:get/get.dart';

import '../../_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemConnectionSnackBar {
  void afficherSnackBarConnection(
      {required ConnectivityResult connectivityResult,
      final void Function()? whenConnextionReturn}) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.closeCurrentSnackbar();
      Get.rawSnackbar(
        snackPosition: SnackPosition.BOTTOM,
        messageText: GBSystem_TextHelper().smallText(
            text: GbsSystemStrings.str_error_no_connection_title,
            textColor: Colors.white),
        icon: const Icon(
          Icons.wifi_off,
          color: Colors.white,
        ),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: Colors.red,
      );
    } else {
      // when cnx return
      if (whenConnextionReturn != null) {
        Get.closeAllSnackbars();
        whenConnextionReturn();
      } else {
        if (Get.isSnackbarOpen) {
          // Get.closeCurrentSnackbar();
          Get.closeAllSnackbars();
          Get.rawSnackbar(
            snackPosition: SnackPosition.BOTTOM,
            messageText: GBSystem_TextHelper().smallText(
                text: GbsSystemStrings.str_error_connection_returned_title,
                textColor: Colors.white),
            icon: const Icon(
              Icons.wifi,
              color: Colors.white,
            ),
            shouldIconPulse: false,
            isDismissible: false,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
          );

          // Get.closeCurrentSnackbar();
          Get.closeAllSnackbars();
        }
      }
    }
  }
}
