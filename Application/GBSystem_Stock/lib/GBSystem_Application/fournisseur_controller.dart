import 'package:gbsystem_stock/GBSystem_Application/GBSystem_fournisseur_model.dart';
import 'package:get/get.dart';

class FournisseurController extends GetxController {
  List<GbsystemFournisseurModel>? _allFournisseur;
  Rx<GbsystemFournisseurModel?> _selectedFournisseur = Rx<GbsystemFournisseurModel?>(null);

  set setSelectedFournisseur(GbsystemFournisseurModel? fournisseur) {
    _selectedFournisseur.value = fournisseur;
    update();
  }

  set setAllFournisseur(List<GbsystemFournisseurModel>? fournisseurs) {
    _allFournisseur = fournisseurs;
    update();
  }

  GbsystemFournisseurModel? get getSelectedFournisseur => _selectedFournisseur.value;
  Rx<GbsystemFournisseurModel?> get getSelectedFournisseurObx => _selectedFournisseur;

  List<GbsystemFournisseurModel>? get getAllFournisseur => _allFournisseur;
  Rx<List<GbsystemFournisseurModel>?> get getAllFournisseurRx => Rx(_allFournisseur);
}
