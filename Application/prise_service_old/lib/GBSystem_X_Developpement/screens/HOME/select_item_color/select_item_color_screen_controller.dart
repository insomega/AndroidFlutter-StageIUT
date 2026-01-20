import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/GESTION_STOCK_CONTROLLERS/color_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_color_model.dart';
import 'package:get/get.dart';

class GBSystemSelectItemColorScreenController extends GetxController {
  GBSystemSelectItemColorScreenController({
    required this.context,
  });
  BuildContext context;

  RxBool isLoading = RxBool(false);
  RxList<GbsystemColorModel> colors = RxList<GbsystemColorModel>([]);
  RxList<GbsystemColorModel> filtredColors = RxList<GbsystemColorModel>([]);

  RxString? text = RxString("");
  TextEditingController controllerSearch = TextEditingController();
  final ColorController colorsController = Get.put(ColorController());

  void updateString(String str) {
    text?.value = str;
    update();
  }

  @override
  void onInit() {
    colors.value = colorsController.getAllColors ?? [];
    super.onInit();
  }

  void filterDataSite(String query) {
    text?.value = query;
    filtredColors.value = colors.where((color) {
      return color.CLR_LIB
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          color.CLRCAT_LIB
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();
  }

  void selectItemSiteFunction(
      {required GbsystemColorModel selectedColor}) async {
    colorsController.setSelectedColor = selectedColor;

    Get.back();
  }
}
