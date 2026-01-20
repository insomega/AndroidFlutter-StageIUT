import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_habiliter_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_habiliter_select_item_model.dart';

class GBSystemSelectItemHabiliterController extends GetxController {
  GBSystemSelectItemHabiliterController( {required this.context , });
  BuildContext context;


  RxBool isLoading = RxBool(false);
  RxList<getHabiliterSelectItemModel> habiliter = RxList<getHabiliterSelectItemModel>([]);
  RxList<getHabiliterSelectItemModel> filtredHabiliter = RxList<getHabiliterSelectItemModel>([]);

  RxString? text = RxString("");
  TextEditingController controllerSearch = TextEditingController();
  final GBSystemHabiliterController habiliterController =
      Get.put(GBSystemHabiliterController());


  void updateString(String str) {
    text?.value = str;
    update();
  }

  @override
  void onInit() {
    habiliter.value =habiliterController.getAllHabiliters ?? [];
    super.onInit();
  }

  void filterDataSite(String query) {
    text?.value = query;
    filtredHabiliter.value = habiliter.where((agence) {
      return agence.FOR_LIB
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();
  }
  void selectItemSiteFunction(
      {required getHabiliterSelectItemModel selectedSite}) async {
    habiliterController.setCurrentHabiliter = selectedSite;
   
      Get.back();
  }



}