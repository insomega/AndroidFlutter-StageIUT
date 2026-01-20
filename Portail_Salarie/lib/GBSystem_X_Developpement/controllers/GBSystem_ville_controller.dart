import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_ville_model.dart';

class GBSystemVilleController extends GetxController {
  List<GbsystemVilleModel>? _allVille;
  GbsystemVilleModel? _currentVille;

  set setVille(GbsystemVilleModel Ville) {
    _allVille?.add(Ville);
    update();
  }

  set setCurrentVille(GbsystemVilleModel? Ville) {
    _currentVille = Ville;
    update();
  }

  set setVilleToLeft(GbsystemVilleModel Ville) {
    _allVille?.insert(0, Ville);
    update();
  }

  set setVilleToRight(GbsystemVilleModel Ville) {
    _allVille?.insert(_allVille!.length, Ville);
    update();
  }

  set setAllVille(List<GbsystemVilleModel>? Villes) {
    _allVille = Villes;
    update();
  }

  List<GbsystemVilleModel>? get getAllVilles => _allVille;
  GbsystemVilleModel? get getCurrentVille => _currentVille;
}
