import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_salarie_photo_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/FIND_PLACES_API_MODELS/GBSystem_place_model.dart';

class AdresseWidgetController extends GetxController {
  AdresseWidgetController({required this.salarie});
  final GBSystemSalarieWithPhotoModel? salarie;
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  Rx<TextEditingController> controllerAd1 = Rx(TextEditingController());
  Rx<TextEditingController> controllerSearchAd1 = Rx(TextEditingController());

  Rx<TextEditingController> controllerAd2 = Rx(TextEditingController());
  Rx<TextEditingController> controllerLat = Rx(TextEditingController());
  Rx<TextEditingController> controllerLong = Rx(TextEditingController());
  Rx<TextEditingController> controllerVille = Rx(TextEditingController());
  final GBSystemSalarieController salarieController =
      Get.put(GBSystemSalarieController());
////////
  Rx<List<GbsystemPlaceModel>> filteredSuggestions = Rx([]);
  RxBool isLoading = RxBool(false);
  RxString textInput = RxString("");
  RxBool isSearchVisible = RxBool(false);

  @override
  void onInit() {
    controllerAd1.value.text = salarie!.salarieModel.SVR_ADR1;
    controllerAd2.value.text = salarie!.salarieModel.SVR_ADR2;
    controllerLat.value.text = salarie!.salarieModel.SVR_LATITUDE;
    controllerLong.value.text = salarie!.salarieModel.SVR_LONGITUDE;
    controllerVille.value.text =
        "${salarie!.salarieModel.VIL_CODE} | ${salarie!.salarieModel.VIL_LIB}";

    super.onInit();
  }
}
