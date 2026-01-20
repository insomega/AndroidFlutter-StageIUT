import 'package:gbsystem_stock/GBSystem_Application/GBSystem_enterpot_model.dart';
import 'package:get/get.dart';

class EnterpotController extends GetxController {
  List<GbsystemEnterpotModel>? _allEnterpot;
  Rx<GbsystemEnterpotModel?> _selectedEnterpot = Rx<GbsystemEnterpotModel?>(null);

  set setSelectedEnterpot(GbsystemEnterpotModel? enterpot) {
    _selectedEnterpot.value = enterpot;
    update();
  }

  set setAllEnterpot(List<GbsystemEnterpotModel>? enterpots) {
    _allEnterpot = enterpots;
    update();
  }

  GbsystemEnterpotModel? get getSelectedEnterpot => _selectedEnterpot.value;
  Rx<GbsystemEnterpotModel?> get getSelectedEnterpotObx => _selectedEnterpot;

  List<GbsystemEnterpotModel>? get getAllEnterpot => _allEnterpot;
  Rx<List<GbsystemEnterpotModel>?> get getAllEnterpotRx => Rx(_allEnterpot);
}
