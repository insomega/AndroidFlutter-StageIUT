import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
//import 'package:fluttertoast/fluttertoast.dart';

void _emptyFunction() {}

bool _isErrorDisplayed = false;

void showWarningSnackBar(
  String text, {
  required void Function()? btnOkOnPress,
  void Function()? btnCancelOnPress = _emptyFunction,
}) {
  if (_isErrorDisplayed) return; // ignore si déjà affiché

  _isErrorDisplayed = true;

  btnCancelOnPress ??= () {};
  btnOkOnPress ??= () {};

  if (Get.context != null) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: GBSystem_Application_Strings.str_dialog_avertissement.tr,
      desc: text,
      btnCancelOnPress: btnCancelOnPress,
      btnOkOnPress: btnOkOnPress,
      showCloseIcon: true,
      btnCancelText: GBSystem_Application_Strings.str_annuler.tr,
      btnOkText: GBSystem_Application_Strings.str_ok.tr,
      onDismissCallback: (DismissType type) {
        _isErrorDisplayed = false;
      },
    ).show();
  } else {
    print("Erreur : Get.context est null !");
    _isErrorDisplayed = false; // Au cas où
  }
}

void showErrorDialog(String text) {
  if (_isErrorDisplayed) return; // ignore si déjà affiché
  _isErrorDisplayed = true;

  if (Get.isSnackbarOpen) {
    Get.closeCurrentSnackbar();
  }

  // try {
  //   if (Get.isSnackbarOpen) {
  //     Get.closeAllSnackbars();
  //   }
  // } catch (e) {
  //   if (Get.isSnackbarOpen) {
  //     Get.closeCurrentSnackbar();
  //   }
  // }

  Get.snackbar(
    GBSystem_Application_Strings.str_dialog_erreur.tr,
    text,
    backgroundColor: Colors.white,
    colorText: Colors.black,
    isDismissible: false,
    leftBarIndicatorColor: Colors.red,
    borderWidth: 1,
    borderColor: Colors.grey.shade300,
    borderRadius: 0,
    duration: Duration(seconds: 5),
    animationDuration: Duration(milliseconds: 300),
    snackbarStatus: (status) {
      if (status == SnackbarStatus.CLOSED || status == SnackbarStatus.CLOSING) {
        _isErrorDisplayed = false;
        print("------------------------****---_isErrorDisplayed = false;");
      }
    },
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
    mainButton: TextButton(
      onPressed: () {
        Get.closeCurrentSnackbar();
      },
      child: Text(
        GBSystem_Application_Strings.str_fermer.tr,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    ),
    icon: Icon(Icons.error_outlined, size: 30, color: Colors.red),
  );
}

void showSuccesDialog(String text) {
  if (_isErrorDisplayed) return; // ignore si déjà affiché
  _isErrorDisplayed = true;

  if (Get.isSnackbarOpen) {
    Get.closeCurrentSnackbar();
  }
  Get.snackbar(
    GBSystem_Application_Strings.str_dialog_succes.tr,
    text,
    // showProgressIndicator: true,
    backgroundColor: Colors.white,

    colorText: Colors.black,
    isDismissible: false,
    leftBarIndicatorColor: Colors.green,
    animationDuration: Duration(milliseconds: 800),

    mainButton: TextButton(
      onPressed: () {
        Get.closeCurrentSnackbar();
      },
      child: Text(
        GBSystem_Application_Strings.str_fermer.tr,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    ),

    borderWidth: 1,
    borderColor: Colors.grey.shade300,
    borderRadius: 0,
    // duration: Duration(minutes: 1),
    snackbarStatus: (status) {
      if (status == SnackbarStatus.CLOSED || status == SnackbarStatus.CLOSING) {
        _isErrorDisplayed = false;
      }
    },

    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),

    icon: Icon(Icons.check_circle, size: 30, color: Colors.green),
  );

  // ElegantNotification.success(
  //     // notificationPosition: NotificationPosition.bottomRight,
  //     width: GBSystem_ScreenHelper.screenWidth(context),
  //     iconSize: 35,
  //     height: 120,
  //     title: Text(
  //       GBSystem_Application_Strings.str_dialog_succes.tr,
  //     ),
  //     description: Flexible(
  //       child: Text(
  //         text,
  //         maxLines: 3,
  //         style: const TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
  //       ),
  //     )).show(context);
}

void showWarningDialog(String text) {
  if (_isErrorDisplayed) return; // ignore si déjà affiché
  _isErrorDisplayed = true;

  // AwesomeDialog(
  //   context: context,
  //   dialogType: DialogType.info,
  //   animType: AnimType.rightSlide,
  //   title: GBSystem_Application_Strings.str_dialog_info,
  //   desc: text,
  //   btnCancelOnPress: () {},
  //   btnOkOnPress: () {},
  //   showCloseIcon: true,
  //   btnCancelText: GBSystem_Application_Strings.str_annuler,
  //   btnOkText: GBSystem_Application_Strings.str_ok,
  // ).show();
  if (Get.isSnackbarOpen) {
    Get.closeCurrentSnackbar();
  }
  Get.snackbar(
    GBSystem_Application_Strings.str_dialog_info.tr,
    text,
    // showProgressIndicator: true,
    backgroundColor: Colors.white,

    colorText: Colors.black,
    isDismissible: false,
    leftBarIndicatorColor: Colors.yellow,
    borderWidth: 1,
    borderColor: Colors.grey.shade300,
    borderRadius: 0,
    duration: Duration(minutes: 1),
    animationDuration: Duration(milliseconds: 800),

    snackbarStatus: (status) {
      if (status == SnackbarStatus.CLOSED || status == SnackbarStatus.CLOSING) {
        _isErrorDisplayed = false;
      }
    },

    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
    mainButton: TextButton(
      onPressed: () {
        Get.closeCurrentSnackbar();
      },
      child: Text(
        GBSystem_Application_Strings.str_fermer.tr,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    ),

    icon: Icon(Icons.info, size: 30, color: Colors.yellow),
  );

  // ElegantNotification.info(
  //     toastDuration: Duration(minutes: 1),
  //     // notificationPosition: NotificationPosition.bottomRight,
  //     width: GBSystem_ScreenHelper.screenWidth(context),
  //     iconSize: 35,
  //     height: 120,
  //     title: Text(
  //       GBSystem_Application_Strings.str_dialog_info.tr,
  //     ),
  //     description: Flexible(
  //       child: Text(
  //         text,
  //         maxLines: 3,
  //         style: const TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
  //       ),
  //     )).show(context);
}

// void showToast({required String text, Color? textColor, Color? toastColor}) {
//   Fluttertoast.showToast(msg: text, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: toastColor ?? Colors.black45, textColor: textColor ?? Colors.white, fontSize: 12.0);
// }
