import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_salarie_photo_model.dart';

class TelephoneWidgetController extends GetxController {
  TelephoneWidgetController({required this.salarie});
  final GBSystemSalarieWithPhotoModel? salarie;

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  Rx<TextEditingController> controllerTel1 = Rx(TextEditingController());
  Rx<TextEditingController> controllerPortabl = Rx(TextEditingController());
  Rx<TextEditingController> controllerSMS = Rx(TextEditingController());
  final GBSystemSalarieController salarieController =
      Get.put(GBSystemSalarieController());
  RxBool enabledBtn = RxBool(false);
  RxBool showSecondPart = RxBool(false);

  @override
  void onInit() {
    controllerTel1.value.text = salarie!.salarieModel.SVR_TELPH ?? "";
    controllerPortabl.value.text = salarie!.salarieModel.SVR_TELPOR;
    // controllerSMS.value.text = salarie!.salarieModel.SVR_PRNOM;

    super.onInit();
  }
}
