import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_salarie_photo_model.dart';

class EmailWidgetController extends GetxController {
  EmailWidgetController({required this.salarie});
  final GBSystemSalarieWithPhotoModel? salarie;

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  Rx<TextEditingController> controllerEmail = Rx(TextEditingController());
  Rx<TextEditingController> controllerCodeEMail = Rx(TextEditingController());
  final GBSystemSalarieController salarieController =
      Get.put(GBSystemSalarieController());
  RxBool enabledBtn = RxBool(false);
  RxBool showSecondPart = RxBool(false);
  @override
  void onInit() {
    controllerEmail.value.text = salarie!.salarieModel.SVR_EMAIL;
    // controllerSMS.value.text = salarie!.salarieModel.SVR_PRNOM;

    super.onInit();
  }
}
