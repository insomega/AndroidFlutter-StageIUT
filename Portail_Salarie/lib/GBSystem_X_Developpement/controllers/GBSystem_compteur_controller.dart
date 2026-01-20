import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_compteur_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_nombre_jour_max_model.dart';

class GBSystemCompteurController extends GetxController {
  // CompteurModel? _compteur;
  // List<NombreJourMaxModel>? _listNombreDesJours;
  // Rx<CompteurModel?>? _compteur = Rx<CompteurModel?>(null);
  // Rx<List<NombreJourMaxModel>?>? _listNombreDesJours =
  //     Rx<List<NombreJourMaxModel>?>(null);
// Rx<SitePlanningModel?>? _currentSite;
  // List<CompteurModel>? _compteur;
  Rx<CompteurModel?> _compteur = Rx<CompteurModel?>(null);

  Rx<List<NombreJourMaxModel>?> _listNombreDesJours =
      Rx<List<NombreJourMaxModel>?>(null);

  set setCompteur(CompteurModel? Compteur) {
    _compteur.value = Compteur;
    update();
  }

  set setListNombreDesJours(List<NombreJourMaxModel>? list) {
    _listNombreDesJours.value = list;
    update();
  }

  CompteurModel? get getCompteur => _compteur.value;

  List<NombreJourMaxModel>? get getListNbrJours => _listNombreDesJours.value;

  Rx<CompteurModel?> get getCompteurRx => _compteur;

  Rx<List<NombreJourMaxModel>?> get getListNbrJoursRx => _listNombreDesJours;
}
