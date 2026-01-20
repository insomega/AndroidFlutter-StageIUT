import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_salarie_quick_acces_with_image_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_agence_salarie_quick_acces_model.dart';
import 'package:get/get.dart';

class GBSystemSalarieQuickAccessWithImageController extends GetxController {
  List<GBSystemSalarieQuickAccessWithPhotoModel>? _listSalaries;
  List<AgenceSalarieQuickAccesModel>? _listAgencesSalaries;
  AgenceSalarieQuickAccesModel? _selectedAgencesSalaries;

  set setSalarie(GBSystemSalarieQuickAccessWithPhotoModel salarie) {
    _listSalaries?.add(salarie);
    update();
  }

  set setAgence(AgenceSalarieQuickAccesModel agnc) {
    _listAgencesSalaries?.add(agnc);
    update();
  }

  set setSelectedAgence(AgenceSalarieQuickAccesModel agnc) {
    _selectedAgencesSalaries = agnc;
    update();
  }

  set setAllSalaries(List<GBSystemSalarieQuickAccessWithPhotoModel>? salaries) {
    _listSalaries = salaries;
    update();
  }

  set setAllAgences(List<AgenceSalarieQuickAccesModel>? agnces) {
    _listAgencesSalaries = agnces;
    update();
  }

  List<GBSystemSalarieQuickAccessWithPhotoModel>? get getAllSalaries =>
      _listSalaries;

  List<AgenceSalarieQuickAccesModel>? get getAllAgences => _listAgencesSalaries;
  AgenceSalarieQuickAccesModel? get getSelectedAgences =>
      _selectedAgencesSalaries;
}
