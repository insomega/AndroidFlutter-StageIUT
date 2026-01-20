import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_diplome_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_diplome_select_item_model.dart';


class GBSystemSelectItemDiplomeController extends GetxController {
  GBSystemSelectItemDiplomeController( {required this.context , });
  BuildContext context;


  RxBool isLoading = RxBool(false);
  RxList<getDiplomeSelectItemModel> diplome= RxList<getDiplomeSelectItemModel>([]);
  RxList<getDiplomeSelectItemModel> filtredDiplome = RxList<getDiplomeSelectItemModel>([]);

  RxString? text = RxString("");
  TextEditingController controllerSearch = TextEditingController();
  final GBSystemDiplomeController diplomeController =
      Get.put(GBSystemDiplomeController());


  void updateString(String str) {
    text?.value = str;
    update();
  }

  @override
  void onInit() {
    diplome.value =diplomeController.getAllDiplomes ?? [];
    super.onInit();
  }

  void filterDataSite(String query) {
    text?.value = query;
    filtredDiplome.value = diplome.where((agence) {
      return agence.DIP_LIB
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();
  }
  void selectItemSiteFunction(
      {required getDiplomeSelectItemModel selectedSite}) async {
    diplomeController.setCurrentDiplome = selectedSite;
   
      Get.back();
  }



}