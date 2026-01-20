import 'package:flutter/material.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_enterpot_model.dart';
import 'package:gbsystem_stock/GBSystem_Application/enterpot_controller.dart';
import 'package:get/get.dart';

class GBSystemSelectItemEnterpotScreenController extends GetxController {
  GBSystemSelectItemEnterpotScreenController({required this.context});
  BuildContext context;

  RxBool isLoading = RxBool(false);
  RxList<GbsystemEnterpotModel> enterpot = RxList<GbsystemEnterpotModel>([]);
  RxList<GbsystemEnterpotModel> filtredEnterpot = RxList<GbsystemEnterpotModel>([]);

  RxString? text = RxString("");
  TextEditingController controllerSearch = TextEditingController();
  final EnterpotController enterpotController = Get.put(EnterpotController());

  void updateString(String str) {
    text?.value = str;
    update();
  }

  @override
  void onInit() {
    enterpot.value = enterpotController.getAllEnterpot ?? [];
    super.onInit();
  }

  void filterDataSite(String query) {
    text?.value = query;
    filtredEnterpot.value = enterpot.where((enter) {
      return enter.ENTR_LIB.toString().toLowerCase().contains(query.toLowerCase()) || enter.ENTR_CODE.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void selectItemSiteFunction({required GbsystemEnterpotModel selectedEntr}) async {
    enterpotController.setSelectedEnterpot = selectedEntr;

    Get.back();
  }
}
