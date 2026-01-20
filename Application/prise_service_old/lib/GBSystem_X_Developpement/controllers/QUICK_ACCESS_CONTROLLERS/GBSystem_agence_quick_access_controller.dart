import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_agence_model.dart';

import 'package:get/get.dart';

class GBSystemAgenceQuickAccessController extends GetxController {
  GbsystemAgenceModel? _agence;
  GbsystemAgenceModel? _loginAgence;

  List<GbsystemAgenceModel>? _allAgences;

  set setCurrentAgence(GbsystemAgenceModel Agence) {
    _agence = Agence;
    update();
  }

  set setLoginAgence(GbsystemAgenceModel? Agence) {
    _loginAgence = Agence;
    update();
  }

  set setAgence(GbsystemAgenceModel Agence) {
    _allAgences?.add(Agence);
    update();
  }

  set setAgenceToLeft(GbsystemAgenceModel Agence) {
    _allAgences?.insert(0, Agence);
    update();
  }

  set setAgenceToRight(GbsystemAgenceModel Agence) {
    _allAgences?.insert(_allAgences!.length, Agence);
    update();
  }

  set setAllAgence(List<GbsystemAgenceModel>? Agences) {
    _allAgences = Agences;
    update();
  }

  List<GbsystemAgenceModel>? get getAllAgences => _allAgences;
  GbsystemAgenceModel? get getCurrentAgence => _agence;
  GbsystemAgenceModel? get getLoginAgence => _loginAgence;
}
