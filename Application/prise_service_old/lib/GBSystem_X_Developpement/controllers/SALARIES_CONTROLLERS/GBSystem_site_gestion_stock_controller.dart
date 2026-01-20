import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_site_gestion_stock_model.dart';
import 'package:get/get.dart';

class GBSystemSiteGestionStockController extends GetxController {
  List<SiteGestionStockModel>? _allSites;
  Rx<SiteGestionStockModel?>? _currentSite = Rx<SiteGestionStockModel?>(null);

  set setSite(SiteGestionStockModel Site) {
    _allSites?.add(Site);
    update();
  }

  set setCurrentSiteSite(SiteGestionStockModel? Site) {
    _currentSite?.value = Site;
    update();
  }

  set setSiteToLeft(SiteGestionStockModel Site) {
    _allSites?.insert(0, Site);
    update();
  }

  set setSiteToRight(SiteGestionStockModel Site) {
    _allSites?.insert(_allSites!.length, Site);
    update();
  }

  set setAllSite(List<SiteGestionStockModel>? Sites) {
    _allSites = Sites;
    update();
  }

  List<SiteGestionStockModel>? get getAllSites => _allSites;
  SiteGestionStockModel? get getCurrentSite => _currentSite?.value;
  Rx<SiteGestionStockModel?>? get getCurrentSiteRx => _currentSite;
}
