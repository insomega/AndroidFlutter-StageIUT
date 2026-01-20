import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_agrement_select_item_model.dart';

class GBSystemAgrementController extends GetxController {
  List<getAgrementSelectItemModel>? _allAgrement;
  getAgrementSelectItemModel? _currentAgrement;

  set setAgrement(getAgrementSelectItemModel Agrement) {
    _allAgrement?.add(Agrement);
    update();
  }

  set setCurrentAgrement(getAgrementSelectItemModel? Agrement) {
    _currentAgrement = Agrement;
    update();
  }

  set setAgrementToLeft(getAgrementSelectItemModel Agrement) {
    _allAgrement?.insert(0, Agrement);
    update();
  }

  set setAgrementToRight(getAgrementSelectItemModel Agrement) {
    _allAgrement?.insert(_allAgrement!.length, Agrement);
    update();
  }

  set setAllAgrement(List<getAgrementSelectItemModel>? Agrements) {
    _allAgrement = Agrements;
    update();
  }

  



  List<getAgrementSelectItemModel>? get getAllAgrements => _allAgrement;
  getAgrementSelectItemModel? get getCurrentAgrement => _currentAgrement;
}
