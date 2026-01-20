import 'package:flutter/material.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_fournisseur_model.dart';
import 'package:gbsystem_stock/GBSystem_Application/fournisseur_controller.dart';

import 'package:get/get.dart';

class GBSystemSelectItemFournisseurScreenController extends GetxController {
  GBSystemSelectItemFournisseurScreenController({required this.context});
  BuildContext context;

  RxBool isLoading = RxBool(false);
  RxList<GbsystemFournisseurModel> fournisseur = RxList<GbsystemFournisseurModel>([]);
  RxList<GbsystemFournisseurModel> filtredFournisseur = RxList<GbsystemFournisseurModel>([]);

  RxString? text = RxString("");
  TextEditingController controllerSearch = TextEditingController();
  final FournisseurController fournisseurController = Get.put(FournisseurController());

  void updateString(String str) {
    text?.value = str;
    update();
  }

  @override
  void onInit() {
    fournisseur.value = fournisseurController.getAllFournisseur ?? [];
    super.onInit();
  }

  void filterDataSite(String query) {
    text?.value = query;
    filtredFournisseur.value = fournisseur.where((fourni) {
      return fourni.FOU_LIB.toString().toLowerCase().contains(query.toLowerCase()) || fourni.FOU_CODE.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void selectItemSiteFunction({required GbsystemFournisseurModel selectedFourni}) async {
    fournisseurController.setSelectedFournisseur = selectedFourni;

    Get.back();
  }
}
