import 'package:gbsystem_stock/GBSystem_Application/GBSystem_taille_model.dart';
import 'package:get/get.dart';

class TailleController extends GetxController {
  List<GbsystemTailleModel>? _allTailles;
  Rx<GbsystemTailleModel?> _selectedTaille = Rx<GbsystemTailleModel?>(null);

  set setSelectedTaille(GbsystemTailleModel? taille) {
    _selectedTaille.value = taille;
    update();
  }

  set setAllTailles(List<GbsystemTailleModel>? tailles) {
    _allTailles = tailles;
    update();
  }

  GbsystemTailleModel? get getSelectedTaille => _selectedTaille.value;
  Rx<GbsystemTailleModel?> get getSelectedTailleObx => _selectedTaille;

  List<GbsystemTailleModel>? get getAllTailles => _allTailles;
  Rx<List<GbsystemTailleModel>?> get getAllTaillesRx => Rx(_allTailles);
}
