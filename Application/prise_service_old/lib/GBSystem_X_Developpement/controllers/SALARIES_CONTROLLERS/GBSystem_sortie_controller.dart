import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_sortie_model.dart';
import 'package:get/get.dart';

class GBSystemSortieController extends GetxController {
  List<SortieModel>? _allSortie;

  set setSortie(SortieModel sortie) {
    _allSortie?.add(sortie);
    update();
  }

  setAllSortie(List<SortieModel> sorties) {
    _allSortie = sorties;
    update();
  }

  List<SortieModel>? get getAllSorties => _allSortie;
}
