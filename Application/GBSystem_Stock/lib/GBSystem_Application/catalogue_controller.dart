import 'package:gbsystem_stock/GBSystem_Application/GBSystem_catalogue_model.dart';
import 'package:get/get.dart';

class CatalogueController extends GetxController {
  List<GbsystemCatalogueModel>? _allCatalogues;
  Rx<GbsystemCatalogueModel?> _selectedCatalogue = Rx<GbsystemCatalogueModel?>(null);

  set setSelectedCatalogue(GbsystemCatalogueModel? catalogue) {
    _selectedCatalogue.value = catalogue;
    update();
  }

  set setAllCatalogues(List<GbsystemCatalogueModel>? catalogues) {
    _allCatalogues = catalogues;
    update();
  }

  void addNewCatalogue(GbsystemCatalogueModel catalogue) {
    _allCatalogues?.add(catalogue);
    update();
  }

  void updateCatalogue(GbsystemCatalogueModel catalogue, GbsystemCatalogueModel newCatalogue) {
    _allCatalogues?.remove(catalogue);

    _allCatalogues?.add(newCatalogue);
    update();
  }

  bool deleteCatalogue(GbsystemCatalogueModel catalogue) {
    try {
      _allCatalogues?.remove(catalogue);
      update();
      return true;
    } catch (e) {
      update();

      return false;
    }
  }

  GbsystemCatalogueModel? get getSelectedCatalogue => _selectedCatalogue.value;
  Rx<GbsystemCatalogueModel?> get getSelectedCatalogueObx => _selectedCatalogue;

  List<GbsystemCatalogueModel>? get getAllCatalogues => _allCatalogues;
  Rx<List<GbsystemCatalogueModel>?> get getAllCataloguesRx => Rx(_allCatalogues);
}
