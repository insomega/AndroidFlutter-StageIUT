import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_agrement_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_agrement_select_item_model.dart';


class GBSystemSelectItemAgrementController extends GetxController {
  GBSystemSelectItemAgrementController( {required this.context , });
  BuildContext context;


  RxBool isLoading = RxBool(false);
  RxList<getAgrementSelectItemModel> agrements = RxList<getAgrementSelectItemModel>([]);
  RxList<getAgrementSelectItemModel> filtredAgrements = RxList<getAgrementSelectItemModel>([]);

  RxString? text = RxString("");
  TextEditingController controllerSearch = TextEditingController();
  final GBSystemAgrementController agrementController =
      Get.put(GBSystemAgrementController());


  void updateString(String str) {
    text?.value = str;
    update();
  }

  @override
  void onInit() {
    agrements.value =agrementController.getAllAgrements ?? [];
    super.onInit();
  }

  void filterDataSite(String query) {
    text?.value = query;
    filtredAgrements.value = agrements.where((agence) {
      return agence.DGRP_LIB
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();
  }
  void selectItemSiteFunction(
      {required getAgrementSelectItemModel selectedSite}) async {
    agrementController.setCurrentAgrement = selectedSite;
   
      Get.back();
  }



}