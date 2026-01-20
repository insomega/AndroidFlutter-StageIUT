import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_historique_model.dart';

class GBSystemHistoriqueController extends GetxController {
  List<HistoriqueModel>? _allHistorique;
  HistoriqueModel? _currentHistorique;
  
  set setHistorique(HistoriqueModel Historique) {
    _allHistorique?.add(Historique);
    update();
  }

  set setCurrentHistorique(HistoriqueModel? Historique) {
    _currentHistorique = Historique;
    update();
  }

  
  set setHistoriqueToLeft(HistoriqueModel Historique) {
    _allHistorique?.insert(0, Historique);
    update();
  }

  set setHistoriqueToRight(HistoriqueModel Historique) {
    _allHistorique?.insert(_allHistorique!.length, Historique);
    update();
  }


  set setAllHistorique(List<HistoriqueModel>? Historiques) {
    _allHistorique = Historiques;
    update();
  }

  List<HistoriqueModel>? get getAllHistoriques => _allHistorique;
  HistoriqueModel? get getCurrentHistorique => _currentHistorique;
   
}
