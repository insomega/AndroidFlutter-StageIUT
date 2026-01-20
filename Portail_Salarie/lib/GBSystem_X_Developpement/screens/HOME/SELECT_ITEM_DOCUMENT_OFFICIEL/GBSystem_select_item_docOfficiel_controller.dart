import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_document_officiel_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_document_officiel_select_item_model.dart';

class GBSystemSelectItemDocumentOfficielController extends GetxController {
  GBSystemSelectItemDocumentOfficielController( {required this.context , });
  BuildContext context;


  RxBool isLoading = RxBool(false);
  RxList<getDocumentOfficielSelectItemModel> docsOfficiel = RxList<getDocumentOfficielSelectItemModel>([]);
  RxList<getDocumentOfficielSelectItemModel> filtredDocsOfficiel = RxList<getDocumentOfficielSelectItemModel>([]);

  RxString? text = RxString("");
  TextEditingController controllerSearch = TextEditingController();
  final GBSystemDocumentOfficielController docsOfficielController =
      Get.put(GBSystemDocumentOfficielController());


  void updateString(String str) {
    text?.value = str;
    update();
  }

  @override
  void onInit() {
    docsOfficiel.value =docsOfficielController.getAllDocumentOfficiels ?? [];
    super.onInit();
  }

  void filterDataSite(String query) {
    text?.value = query;
    filtredDocsOfficiel.value = docsOfficiel.where((agence) {
      return agence.DOCOFF_LIB
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();
  }
  void selectItemSiteFunction(
      {required getDocumentOfficielSelectItemModel selectedSite}) async {
    docsOfficielController.setCurrentDocumentOfficiel = selectedSite;
   
      Get.back();
  }



}