import 'package:flutter/material.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_salarie_gestion_stock_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_site_gestion_stock_controller.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_site_gestion_stock_model.dart';
import 'package:get/get.dart';

class GBSystemSelectItemSiteGestionStockController extends GetxController {
  GBSystemSelectItemSiteGestionStockController({required this.context});
  BuildContext context;

  RxBool isLoading = RxBool(false);

  RxList<SiteGestionStockModel> sites = RxList<SiteGestionStockModel>([]);
  RxList<SiteGestionStockModel> filtredsites = RxList<SiteGestionStockModel>([]);
  RxString? text = RxString("");

  TextEditingController controllerSearch = TextEditingController();

  final GBSystemSiteGestionStockController siteGestionStockController = Get.put(GBSystemSiteGestionStockController());
  final GBSystemSalarieGestionStockController salarieGestionStockController = Get.put(GBSystemSalarieGestionStockController());

  void updateString(String str) {
    text?.value = str;
    update();
  }

  @override
  void onInit() {
    sites.value = siteGestionStockController.getAllSites ?? [];
    super.onInit();
  }

  void filterDataSalarie(String query) {
    text?.value = query;
    filtredsites.value = sites.where((agence) {
      return agence.DOS_LIB.toString().toLowerCase().contains(query.toLowerCase()) || agence.DOS_CODE.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  Future selectItemVacationFunction({required SiteGestionStockModel selectedVacation}) async {
    siteGestionStockController.setCurrentSiteSite = selectedVacation;
    Get.back();
  }

  Future getListSalarieDependSite({required SiteGestionStockModel selectedSite}) async {
    isLoading.value = true;

    // await GBSystem_AuthService(context).getAllSalarieGestionStock(site: selectedSite).then((Salarie) async {
    //   salarieGestionStockController.setAllSalarie = Salarie;
    //   // if (Salarie != null && Salarie.isNotEmpty) {
    //   //   salarieGestionStockController.setCurrentSalarieSalarie = Salarie.first;
    //   // }
    //   isLoading.value = false;
    // });
  }
}
