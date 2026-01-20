import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_ville_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_ville_model.dart';

class GBSystemSelectItemVilleController extends GetxController {
  GBSystemSelectItemVilleController({
    required this.context,
  });
  BuildContext context;

  RxBool isLoading = RxBool(false);
  RxList<GbsystemVilleModel> villes = RxList<GbsystemVilleModel>([]);
  RxList<GbsystemVilleModel> filtredVilles = RxList<GbsystemVilleModel>([]);

  RxString? text = RxString("");
  TextEditingController controllerSearch = TextEditingController();
  final GBSystemVilleController villeController =
      Get.put(GBSystemVilleController());

  void updateString(String str) {
    text?.value = str;
    update();
  }

  @override
  void onInit() {
    villes.value = villeController.getAllVilles ?? [];
    super.onInit();
  }

  void filterDataSite(String query) {
    text?.value = query;
    filtredVilles.value = villes.where((agence) {
      return agence.VIL_LIB
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          agence.VIL_CODE
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();
  }

  void selectItemSiteFunction(
      {required GbsystemVilleModel selectedSite}) async {
    villeController.setCurrentVille = selectedSite;

    Get.back();
  }
}
