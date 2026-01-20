import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_type_absence_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_type_absence_model.dart';

class GBSystemDemandeAbsenceScreenController extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  RxInt currentPageIndex = 0.obs;

  final typeAbsenceController = Get.put<GBSystemTypeAbsenceController>(
      GBSystemTypeAbsenceController());
List<TypeAbsenceModel>? listTypeAbcences;
RxBool isLoading = RxBool(false);

@override
  void onInit() {
    listTypeAbcences = typeAbsenceController.getAllTypeAbsences;
    super.onInit();
  }

}