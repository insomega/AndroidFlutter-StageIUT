import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_type_de_jour_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_type_de_jour_model.dart';

class GBSystemSelectItemTypeJourController extends GetxController {
  GBSystemSelectItemTypeJourController( {required this.context , });
  BuildContext context;


  RxBool isLoading = RxBool(false);
  RxList<TypeDeJourModel> docsOfficiel = RxList<TypeDeJourModel>([]);
  RxList<TypeDeJourModel> filtredDocsOfficiel = RxList<TypeDeJourModel>([]);

  RxString? text = RxString("");
  TextEditingController controllerSearch = TextEditingController();
  final GBSystemTypeDeJourController typeDeJourController =
      Get.put(GBSystemTypeDeJourController());


  void updateString(String str) {
    text?.value = str;
    update();
  }

  @override
  void onInit() {
    docsOfficiel.value =typeDeJourController.getAllTypeDeJours ?? [];
    super.onInit();
  }

  void filterDataSite(String query) {
    text?.value = query;
    filtredDocsOfficiel.value = docsOfficiel.where((agence) {
      return agence.SYSDAY_SHORTDESC
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();
  }
  void selectItemSiteFunction(
      {required TypeDeJourModel selectedSite}) async {
    typeDeJourController.setCurrentTypeDeJour = selectedSite;
   
      Get.back();
  }



}