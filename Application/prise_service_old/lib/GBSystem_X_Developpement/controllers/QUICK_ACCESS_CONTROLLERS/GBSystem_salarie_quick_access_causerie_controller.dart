import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBsystem_salarie_causerie_model.dart';
import 'package:get/get.dart';

class GBSystemSalarieQuickAccessCauserieController extends GetxController {
  SalarieCuaserieModel? _salarie;
  String? _imageSalarie;

  set setSalarie(SalarieCuaserieModel salarie) {
    _salarie = salarie;
    update();
  }

  SalarieCuaserieModel? get getSalarie => _salarie;

  set setImage(String imageUrl) {
    _imageSalarie = imageUrl;
    update();
  }

  String? get getImage => _imageSalarie;
}
