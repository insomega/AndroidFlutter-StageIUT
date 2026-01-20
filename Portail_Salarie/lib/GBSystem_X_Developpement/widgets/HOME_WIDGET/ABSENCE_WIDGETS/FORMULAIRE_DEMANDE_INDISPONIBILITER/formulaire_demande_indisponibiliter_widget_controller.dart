import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_compteur_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_type_absence_indisponibiliter_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_type_absence_model.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class FormulaireDemandeIndisponibiliterWidgetController extends GetxController {
  FormulaireDemandeIndisponibiliterWidgetController(this.context);

  BuildContext context;
  DateTime? dateDebut, dateFin;
  Rx<PlatformFile?> file = Rx<PlatformFile?>(null);
  Rx<Color?> typeAbsColor = Rx<Color?>(GbsSystemStrings.str_primary_color);

  final typeAbsenceIndisponibiliterController =
      Get.put<GBSystemTypeAbsenceIndisponibiliterController>(
          GBSystemTypeAbsenceIndisponibiliterController());
  final compteurController =
      Get.put<GBSystemCompteurController>(GBSystemCompteurController());

  PageController pageController = PageController(initialPage: 0);
  RxInt currentPageIndex = 0.obs;
  Rx<TextEditingController> controllerAbsence = TextEditingController().obs;
  TextEditingController controllerComment = TextEditingController();

  List<TypeAbsenceModel> getListParentsTypsAbsences(
      List<TypeAbsenceModel> listTypsAbsences) {
    List<TypeAbsenceModel> listParents = [];
    for (var i = 0; i < listTypsAbsences.length; i++) {
      if (listTypsAbsences[i].PTPH_IDF == null ||
          listTypsAbsences[i].PTPH_IDF!.isEmpty) {
        listParents.add(listTypsAbsences[i]);
      }
    }

    return listParents;
  }

  bool verifierHasChildren(TypeAbsenceModel selectedTypeAbsence,
      List<TypeAbsenceModel> allTypeAbsences) {
    bool hasChildren = false;
    for (var i = 0; i < allTypeAbsences.length; i++) {
      if (allTypeAbsences[i].PTPH_IDF == selectedTypeAbsence.TPH_IDF) {
        hasChildren = true;
      }
    }

    return hasChildren;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    if (typeAbsenceIndisponibiliterController
                .getAllTypeAbsencesIndisponibiliter !=
            null &&
        typeAbsenceIndisponibiliterController
            .getAllTypeAbsencesIndisponibiliter!.isNotEmpty) {
      controllerAbsence.value.text = typeAbsenceIndisponibiliterController
          .getAllTypeAbsencesIndisponibiliter!.first.TPH_LIB;
      final hexColor = typeAbsenceIndisponibiliterController
          .getAllTypeAbsencesIndisponibiliter!.first.CLR_CODE_colorweb
          .replaceAll(r"#", "")
          .replaceAll(r"$", "");
      final color = Color(int.parse(
        '0xFF$hexColor',
      ));

      typeAbsColor.value = color;
    }
    super.onInit();
  }
}
