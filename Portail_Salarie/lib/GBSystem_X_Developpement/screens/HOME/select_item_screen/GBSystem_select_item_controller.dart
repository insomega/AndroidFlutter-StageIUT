import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_type_absence_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_type_absence_model.dart';

class GBSystemSelectItemController extends GetxController {
  GBSystemSelectItemController( {required this.context , required this.selectedTypeAbsence,});
  BuildContext context;
  final TypeAbsenceModel selectedTypeAbsence;

  RxBool isLoading = RxBool(false);
  RxList<TypeAbsenceModel> sites = RxList<TypeAbsenceModel>([]);
  RxList<TypeAbsenceModel> filtredSites = RxList<TypeAbsenceModel>([]);

  RxString? text = RxString("");
  TextEditingController controllerSearch = TextEditingController();
  final GBSystemTypeAbsenceController sitePlanningController =
      Get.put(GBSystemTypeAbsenceController());


  void updateString(String str) {
    text?.value = str;
    update();
  }

  @override
  void onInit() {
      sites.value = getChildrenTypeAbsence(selectedTypeAbsence, sitePlanningController.getAllTypeAbsences!);
     
    super.onInit();
  }

  void filterDataSite(String query) {
    text?.value = query;
    filtredSites.value = sites.where((agence) {
      return agence.TPH_LIB
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();
  }
  void selectItemSiteFunction(
      {required TypeAbsenceModel selectedSite}) async {
    sitePlanningController.setCurrentTypeAbsenceTypeAbsence = selectedSite;
   
      Get.back();
  }


  List<TypeAbsenceModel> getChildrenTypeAbsence(TypeAbsenceModel selectedTypeAbsence , List<TypeAbsenceModel> allTypeAbsences){
 List<TypeAbsenceModel> listChildren = [];
  for (var i = 0; i < allTypeAbsences.length; i++) {
    if (allTypeAbsences[i].PTPH_IDF == selectedTypeAbsence.TPH_IDF) {
      listChildren.add(allTypeAbsences[i]);
    }
  }
  
  return listChildren;
}

}