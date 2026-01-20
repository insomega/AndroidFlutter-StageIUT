import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_indisponibiliter_absence_controller.dart';

class IndisponibiliterAbsenceWidgetController extends GetxController {
  IndisponibiliterAbsenceWidgetController(this.context);

BuildContext context;
final indisponibiliterController = Get.put<GBSystemIndisponibiliterAbsenceController>(
        GBSystemIndisponibiliterAbsenceController());
}