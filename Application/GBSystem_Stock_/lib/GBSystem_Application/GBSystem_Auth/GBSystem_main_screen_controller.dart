import 'dart:io';

import 'package:get/get.dart';
import 'GBSystem_salarie_controller.dart';
import 'GBSystem_text_helper.dart';
import 'GBSystem_toast.dart';
import 'GBSystem_app_info_details_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/ABSENCE_SCREENS/ABSENCE_MAIN_SCREEN/GBSystem_absence_main_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/DOCUMENTS_SCREENS/DOCUMENT_MAIN_SCREEN/GBSystem_document_main_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/INFO_SALARIE_SCREENS/INFO_SALARIE_MAIN/GBSystem_info_salarie_main_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PLANNING_SCREEN/PLANNING_MAIN/GBSystem_planning_main_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/home_screen/GBSystem_home_screen.dart';
import 'package:flutter/material.dart';
import 'GBSystem_Ajouturl_launcher_service.dart';
import 'GBSystem_Application_Strings.dart';
import 'GBSystem_Server_Strings.dart';

class GBSystemMainScreenController extends GetxController {
  RxInt currentIndex = 0.obs, pageIndex = 0.obs;
  //selected index
  int? selectedIndex;

  final GBSystemSalarieController salarieController = Get.put(GBSystemSalarieController());

  @override
  void onInit() {
    currentIndex = 0.obs;
    pageIndex = 0.obs;

    super.onInit();
  }

  void onClose() {
    currentIndex = 0.obs;
    pageIndex = 0.obs;

    super.onClose();
  }

  // Define your screens in a list
  final screens = [GBSystem_Home_Screen(), GBSystemPlanningMainScreen(selectedIndexFromOut: 2), GBSystemAbsenceMainScreen(selectedIndexFromOut: 2), GBSystemInfoSalarieMainScreen(selectedIndexFromOut: 1), GBSystemDocumentMainScreen(selectedIndexFromOut: 1)];
  bool checkChatPage() {
    return selectedIndex == 3 && currentIndex.value == 3;
  }

  void showUpdateDialog(BuildContext context, {required bool isDissmisible, required GbsystemAppInfoDetailsModel? appInfoDetails}) {
    showDialog(
      context: context,
      barrierDismissible: isDissmisible, // User cannot dismiss dialog by tapping outside
      builder: (BuildContext context) {
        return PopScope(
          canPop: isDissmisible,
          onPopInvoked: (didPop) {
            if (!isDissmisible) {
              showToast(text: GBSystem_Application_Strings.str_action_non_autoriser.tr);
            }
          },
          child: AlertDialog(
            title: Row(
              children: [
                Icon(Icons.system_update, color: GbsSystemServerStrings.str_primary_color),
                SizedBox(width: 8),
                Flexible(
                  child: GBSystem_TextHelper().normalText(text: GBSystem_Application_Strings.str_new_version_available.tr, textColor: Colors.black, maxLines: 3, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: GBSystem_TextHelper().normalText(textColor: Colors.black, text: GBSystem_Application_Strings.str_new_version_desc.tr, maxLines: 10),
            actions: <Widget>[
              // "Try Later" button
              Visibility(
                visible: isDissmisible,
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: GBSystem_TextHelper().normalText(text: GBSystem_Application_Strings.str_annuler.tr, textColor: Colors.black54),
                ),
              ),
              // "Update Now" button
              TextButton(
                onPressed: () {
                  if (isDissmisible) {
                    Get.back();
                  }

                  if (Platform.isAndroid) {
                    if (appInfoDetails?.play_store_link != null && appInfoDetails!.play_store_link!.isNotEmpty) {
                      UrlLauncherService().openWebsite(context, webSite: appInfoDetails.play_store_link!);
                      // UrlLauncherService().openWebsite(context,
                      //     webSite:
                      //         "https://play.google.com/store/apps/details?id=com.whatsapp");
                    }
                  } else if (Platform.isIOS) {
                    if (appInfoDetails?.app_store_link != null && appInfoDetails!.app_store_link!.isNotEmpty) {
                      UrlLauncherService().openWebsite(context, webSite: appInfoDetails.app_store_link!);
                    }
                  } else {
                    if (appInfoDetails?.play_store_link != null && appInfoDetails!.play_store_link!.isNotEmpty) {
                      UrlLauncherService().openWebsite(context, webSite: appInfoDetails.play_store_link!);
                    }
                  }
                },
                child: GBSystem_TextHelper().normalText(text: GBSystem_Application_Strings.str_update_now.tr, textColor: GbsSystemServerStrings.str_primary_color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
