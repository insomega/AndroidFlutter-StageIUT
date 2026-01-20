import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_absence_model.dart';

class GBSystemListIndisponibiliterWidgetController extends GetxController {
  BuildContext context;
  GBSystemListIndisponibiliterWidgetController({required this.context});
  RxBool isLoading = false.obs;
  List<AbsenceModel>? listAbsences = [];
  
}
