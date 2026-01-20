import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_agence_quick_access_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_agence_model.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GBSystemSelectItemAgenceController extends GetxController {
  GBSystemSelectItemAgenceController({
    required this.context,
  });
  BuildContext context;

  RxBool isLoading = RxBool(false);
  RxList<GbsystemAgenceModel> agences = RxList<GbsystemAgenceModel>([]);
  RxList<GbsystemAgenceModel> filtredAgences = RxList<GbsystemAgenceModel>([]);

  RxString? text = RxString("");
  TextEditingController controllerSearch = TextEditingController();
  final GBSystemAgenceQuickAccessController agencesController =
      Get.put(GBSystemAgenceQuickAccessController());

  void updateString(String str) {
    text?.value = str;
    update();
  }

  @override
  void onInit() {
    agences.value = agencesController.getAllAgences ?? [];
    super.onInit();
  }

  void filterDataSite(String query) {
    text?.value = query;
    filtredAgences.value = agences.where((agence) {
      return agence.DOS_LIB
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          agence.DOS_CODE
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();
  }

  void selectItemSiteFunction(
      {required GbsystemAgenceModel selectedAgence}) async {
    agencesController.setLoginAgence = selectedAgence;
    print(selectedAgence.DOS_CODE);
    agencesController.setCurrentAgence = selectedAgence;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(GbsSystemServerStrings.kDOS_IDF, selectedAgence.DOS_IDF);
    prefs.setString(GbsSystemServerStrings.kDOS_CODE, selectedAgence.DOS_CODE);

    print("geeeeet ${prefs.getString(GbsSystemServerStrings.kDOS_IDF)}");

    Get.back();
  }
}
