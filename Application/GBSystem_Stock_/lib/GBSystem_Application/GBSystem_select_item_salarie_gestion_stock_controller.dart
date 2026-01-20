import 'package:flutter/material.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_salarie_gestion_stock_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_salarie_gestion_stock_model.dart';

import 'package:get/get.dart';

class GBSystemSelectItemSalarieGestionStockController extends GetxController {
  GBSystemSelectItemSalarieGestionStockController({required this.context});
  BuildContext context;

  RxBool isLoading = RxBool(false);

  RxList<SalarieGestionStockModel> salaries = RxList<SalarieGestionStockModel>([]);
  RxList<SalarieGestionStockModel> filtredsalaries = RxList<SalarieGestionStockModel>([]);
  RxString? text = RxString("");

  TextEditingController controllerSearch = TextEditingController();
  final GBSystemSalarieGestionStockController salarieGestionStockController = Get.put(GBSystemSalarieGestionStockController());

  void updateString(String str) {
    text?.value = str;
    update();
  }

  @override
  void onInit() {
    salaries.value = salarieGestionStockController.getAllSalaries ?? [];
    super.onInit();
  }

  void filterDataSalarie(String query) {
    text?.value = query;
    filtredsalaries.value = salaries.where((agence) {
      return agence.SVR_LIB.toString().toLowerCase().contains(query.toLowerCase()) || agence.SVR_CODE.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  Future selectItemVacationFunction({required SalarieGestionStockModel selectedSalarie}) async {
    salarieGestionStockController.setCurrentSalarieSalarie = selectedSalarie;
    Get.back();
  }
}
