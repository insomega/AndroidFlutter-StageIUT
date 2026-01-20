import 'GBSystem_site_planning_model.dart';
import 'package:get/get.dart';

class GBSystemSitesPlanningController extends GetxController {
  List<SitePlanningModel>? _allSites;
  List<SitePlanningModel>? _allEvenements;
  // Rx<SitePlanningModel?>? _currentSite;
  Rx<SitePlanningModel?> _currentSite = Rx<SitePlanningModel?>(null);
  Rx<SitePlanningModel?> _currentEvenement = Rx<SitePlanningModel?>(null);
  set setCurrentSite(SitePlanningModel site) {
    _currentSite.value = site;
    update();
  }

  set setCurrentEvenement(SitePlanningModel site) {
    _currentEvenement.value = site;
    update();
  }

  set setSite(SitePlanningModel site) {
    _allSites?.add(site);
    update();
  }

  set setEvenement(SitePlanningModel site) {
    _allEvenements?.add(site);
    update();
  }

  set setAllSite(List<SitePlanningModel> sites) {
    _allSites = sites;
    update();
  }

  set setAllEvenements(List<SitePlanningModel> sites) {
    _allEvenements = sites;
    update();
  }

  List<SitePlanningModel>? get getAllSites => _allSites;
  List<SitePlanningModel>? get getAllEvenements => _allEvenements;
  SitePlanningModel? get getCurrentSite => _currentSite.value;
  SitePlanningModel? get getCurrentEvenement => _currentEvenement.value;
}
