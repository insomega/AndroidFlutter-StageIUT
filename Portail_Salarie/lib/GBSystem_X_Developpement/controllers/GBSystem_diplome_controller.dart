import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_diplome_select_item_model.dart';

class GBSystemDiplomeController extends GetxController {
  List<getDiplomeSelectItemModel>? _allDiplome;
  getDiplomeSelectItemModel? _currentDiplome;

  set setDiplome(getDiplomeSelectItemModel Diplome) {
    _allDiplome?.add(Diplome);
    update();
  }

  set setCurrentDiplome(getDiplomeSelectItemModel? Diplome) {
    _currentDiplome = Diplome;
    update();
  }

  set setDiplomeToLeft(getDiplomeSelectItemModel Diplome) {
    _allDiplome?.insert(0, Diplome);
    update();
  }

  set setDiplomeToRight(getDiplomeSelectItemModel Diplome) {
    _allDiplome?.insert(_allDiplome!.length, Diplome);
    update();
  }

  set setAllDiplome(List<getDiplomeSelectItemModel>? Diplomes) {
    _allDiplome = Diplomes;
    update();
  }

  



  List<getDiplomeSelectItemModel>? get getAllDiplomes => _allDiplome;
  getDiplomeSelectItemModel? get getCurrentDiplome => _currentDiplome;
}
