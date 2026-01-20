import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_salarie_photo_model.dart';

class PhotoNomPrenomController extends GetxController {
  PhotoNomPrenomController({required this.salarie});
  final GBSystemSalarieWithPhotoModel? salarie;

  Rx<TextEditingController> controllerNom = Rx(TextEditingController());
  Rx<TextEditingController> controllerPrenom = Rx(TextEditingController());
  @override
  void onInit() {
    controllerNom.value.text = salarie!.salarieModel.SVR_NOM;
    controllerPrenom.value.text = salarie!.salarieModel.SVR_PRNOM;
    super.onInit();
  }
}
