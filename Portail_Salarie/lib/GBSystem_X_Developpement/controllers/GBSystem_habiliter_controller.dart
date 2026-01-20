import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_habiliter_select_item_model.dart';

class GBSystemHabiliterController extends GetxController {
  List<getHabiliterSelectItemModel>? _allHabiliter;
  getHabiliterSelectItemModel? _currentHabiliter;

  set setHabiliter(getHabiliterSelectItemModel Habiliter) {
    _allHabiliter?.add(Habiliter);
    update();
  }

  set setCurrentHabiliter(getHabiliterSelectItemModel? Habiliter) {
    _currentHabiliter = Habiliter;
    update();
  }

  set setHabiliterToLeft(getHabiliterSelectItemModel Habiliter) {
    _allHabiliter?.insert(0, Habiliter);
    update();
  }

  set setHabiliterToRight(getHabiliterSelectItemModel Habiliter) {
    _allHabiliter?.insert(_allHabiliter!.length, Habiliter);
    update();
  }

  set setAllHabiliter(List<getHabiliterSelectItemModel>? Habiliters) {
    _allHabiliter = Habiliters;
    update();
  }

  List<getHabiliterSelectItemModel>? get getAllHabiliters => _allHabiliter;
  getHabiliterSelectItemModel? get getCurrentHabiliter => _currentHabiliter;
}
