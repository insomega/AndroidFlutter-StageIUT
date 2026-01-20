import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_type_filtre_model.dart';

class GBSystemTypeFiltreController extends GetxController {
  Rx<TypeFiltreModel?> _currentTypeFiltre = Rx<TypeFiltreModel?>(null);
  Rx<List<TypeFiltreModel>?> _allTypeFiltre = Rx<List<TypeFiltreModel>?>(null);

  TypeFiltreModel tousTypeFiltre =
      TypeFiltreModel(TYPDOC_CODE: "Tous", TYPDOC_IDF: "", TYPDOC_LIB: "Tous");

  set setTypeFiltre(TypeFiltreModel TypeFiltre) {
    _allTypeFiltre.value?.add(TypeFiltre);
    update();
  }

  set setCurrentTypeFiltre(TypeFiltreModel? TypeFiltre) {
    _currentTypeFiltre.value = TypeFiltre;
    update();
  }

  set setTypeFiltreToLeft(TypeFiltreModel TypeFiltre) {
    _allTypeFiltre.value?.insert(0, TypeFiltre);
    update();
  }

  set setTypeFiltreToRight(TypeFiltreModel TypeFiltre) {
    _allTypeFiltre.value?.insert(_allTypeFiltre.value!.length, TypeFiltre);
    update();
  }

  set setAllTypeFiltre(List<TypeFiltreModel>? TypeFiltres) {
    _allTypeFiltre.value = TypeFiltres;
    // _allTypeFiltre.value?.add(tousTypeFiltre);
    update();
  }

  void addTousTypeFiltre() {
    _allTypeFiltre.value?.add(tousTypeFiltre);
    update();
  }

  List<TypeFiltreModel>? get getAllTypeFiltres => _allTypeFiltre.value;
  Rx<List<TypeFiltreModel>?> get getAllTypeFiltresRx => _allTypeFiltre;

  TypeFiltreModel? get getCurrentTypeFiltre => _currentTypeFiltre.value;
  TypeFiltreModel? get getTousTypeFiltre => tousTypeFiltre;
}
