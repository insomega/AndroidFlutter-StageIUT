import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';

class GBSystem_ManageCatchErrors {
  RxBool _isConnected = RxBool(false);

  GBSystem_ManageCatchErrors() {
    initConnectivity();
  }

  RxBool get isConnected => _isConnected;

  Future<void> initConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      _isConnected = RxBool(true);
    } else {
      _isConnected = RxBool(false);
    }
  }

  Future<void> catchErrors(BuildContext context,
      {required String page,
      required String method,
      required String message}) async {
    await GBSystem_AuthService(context)
        .ManageCatchErrorsServer(page: page, functionName: method, msg: message)
        .then((value) {
      // showErrorDialog(context,
      //     "Planter : page : $page | method : $method | message : $message ");
    });
    // initConnectivity().then((value) {
    //   if (_isConnected.value == false) {
    //     Get.off(
    //       NoConnectionPage(destination: destination),
    //     );
    //   } else {
    //     Get.off(
    //       ErrorServerPage(destination: destination),
    //     );
    //   }
    // });
  }
}
