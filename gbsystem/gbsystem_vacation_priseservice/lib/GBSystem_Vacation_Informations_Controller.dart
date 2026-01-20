import 'package:flutter/material.dart';
/*import 'GBSystem_site_planning_model.dart';
import 'GBSystem_vacation_model.dart';*/
import 'package:get/get.dart';
import 'package:gbsystem_root/GBSystem_vacation_model.dart';
import 'package:gbsystem_root/GBSystem_site_planning_model.dart';

import 'package:gbsystem_root/GBSystem_Root_Controller.dart';
import 'package:gbsystem_root/GBSystem_response_model.dart';
import 'package:gbsystem_root/GBSystem_convert_date_service.dart';
//import 'package:gbsystem_root/GBSystem_snack_bar.dart';
import 'package:gbsystem_root/GBSystem_pause_model.dart';

class GBSystem_Vacation_Informations_Controller extends GBSystem_Root_Controller {
  // Variables observables
  final Rx<List<GBSystem_Vacation_Model>?> _allVacations = Rx<List<GBSystem_Vacation_Model>?>(null);
  final Rx<GBSystem_Vacation_Model?> _currentVacation = Rx<GBSystem_Vacation_Model?>(null);

  // Collections de données

  List<SitePlanningModel>? _allFiltredLieu;
  List<SitePlanningModel>? _allLieu;
  List<SitePlanningModel>? _allEvenement;
  List<SitePlanningModel>? _allFiltredEvenements;

  // Filtres et paramètres de recherche
  //DateTime? _entrer;
  List<TimeOfDay>? _filterDebutDate, _filterFinDate;
  List<TimeOfDay>? _selectedfilterDebutDate, _selectedfilterFinDate;
  String? _textSearch;

  // États des filtres
  bool _useFilterDebut = false;
  bool _useFilterFin = false;
  bool _useFilterLieu = false;
  bool _useFilterEvenements = false;

  //=== Getters ================================================================

  // Getters de base
  List<GBSystem_Vacation_Model>? get allVacations => _allVacations.value;
  Rx<List<GBSystem_Vacation_Model>?> get allVacationsRx => _allVacations;
  GBSystem_Vacation_Model? get currentVacation => _currentVacation.value;
  Rx<GBSystem_Vacation_Model?> get currentVacationRx => _currentVacation;

  // List<GBSystem_Vacation_Model> _allSelectedVacations = [];
  // List<GBSystem_Vacation_Model> get allSelectedVacations => _allSelectedVacations;

  final RxList<GBSystem_Vacation_Model> _allSelectedVacations = <GBSystem_Vacation_Model>[].obs;
  RxList<GBSystem_Vacation_Model> get allSelectedVacations => _allSelectedVacations;

  /// 👉 Ajouter une vacation sélectionnée
  void addSelectedVacation(GBSystem_Vacation_Model vacation) {
    if (!_allSelectedVacations.contains(vacation)) {
      _allSelectedVacations.add(vacation);
    }
  }

  /// 👉 Supprimer une vacation sélectionnée
  void removeSelectedVacation(GBSystem_Vacation_Model vacation) {
    _allSelectedVacations.remove(vacation);
  }

  /// 👉 Vider toutes les sélections
  void clearSelectedVacations() {
    _allSelectedVacations.clear();
  }

  /// 👉 Remplacer la sélection entière
  set setAllSelectedVacation(List<GBSystem_Vacation_Model> vacations) {
    _allSelectedVacations.assignAll(vacations);
  }

  /// 👉 Toggle (ajoute si absent, supprime si déjà sélectionné)
  void toggleSelectedVacation(GBSystem_Vacation_Model vacation) {
    if (_allSelectedVacations.contains(vacation)) {
      _allSelectedVacations.remove(vacation);
    } else {
      _allSelectedVacations.add(vacation);
    }
  }

  //List<GBSystem_Vacation_Model>? get getAllSelectedVacations => _allSelectedVacations;

  // Getters pour les lieux et événements

  List<SitePlanningModel>? get allLieu => _allLieu;
  List<SitePlanningModel>? get allEvenemnt => _allEvenement;

  List<SitePlanningModel>? get allFiltredLieu => _allFiltredLieu;
  List<SitePlanningModel>? get allFiltredEvenements => _allFiltredEvenements;

  // Getters pour la recherche
  String? get searchText => _textSearch;

  // Getters pour les dates
  DateTime? get entrer => _entrer;
  DateTime? get sortie => _entrer;
  List<TimeOfDay>? get debutFilter => _filterDebutDate;
  List<TimeOfDay>? get finFilter => _filterFinDate;
  List<TimeOfDay>? get selectedDebutFilter => _selectedfilterDebutDate;
  List<TimeOfDay>? get selectedFinFilter => _selectedfilterFinDate;

  // Getters pour l'état des filtres
  bool get filterDebutEnabled => _useFilterDebut;
  bool get filterFinEnabled => _useFilterFin;
  bool get filterLieuEnabled => _useFilterLieu;
  bool get filterEvenementsEnabled => _useFilterEvenements;

  // Getters calculés (méthodes d'accès encapsulées)
  bool get hasCurrentVacation => currentVacation != null;
  String get currentVacationTitle => currentVacation?.TITLE.trim() ?? "";
  bool get isCurrentVacationActive => currentVacation?.TPH_PSA == "1";

  int? get entryPointageNumber {
    final nbr = currentVacation?.PNTGS_IN_NBR;
    return nbr != null && nbr.isNotEmpty ? int.tryParse(nbr) : null;
  }

  int? get exitPointageNumber {
    final nbr = currentVacation?.PNTGS_OUT_NBR;
    return nbr != null && nbr.isNotEmpty ? int.tryParse(nbr) : null;
  }

  bool get hasEntryPointage => entryPointageNumber != null;
  bool get hasExitPointage => exitPointageNumber != null;

  // Getter qui retourne toujours une List (vide si null)
  List<GBSystem_Vacation_Model> get safeAllVacations => allVacations ?? [];

  List<GBSystem_Vacation_Model> get safeAllSelectedVacations => allSelectedVacations;

  bool get hasVacations {
    final list = _allVacations.value;
    return list != null && list.isNotEmpty;
  }

  GBSystem_Vacation_Model? get firstVacation {
    final vacations = allVacations;
    return vacations != null && vacations.isNotEmpty ? vacations[0] : null;
  }

  // Ou avec valeur par défaut
  String get currentVacationSafe_SVR_CODE_LIB => currentVacation?.SVR_CODE_LIB ?? '';
  String get currentVacationSafe_VAC_HOUR_CALC => currentVacation?.VAC_HOUR_CALC ?? '';
  String get currentVacationSafe_VAC_DURATION => currentVacation?.VAC_DURATION ?? '';
  String get currentVacationSafe_VAC_BREAK => currentVacation?.VAC_BREAK ?? '';

  //=== Setters ================================================================

  // Setters pour les vacances
  set setVacation(GBSystem_Vacation_Model vacation) {
    _allVacations.value?.add(vacation);
    update();
  }

  set setSelectedVacation(GBSystem_Vacation_Model vacation) {
    _allSelectedVacations.add(vacation);
    update();
  }

  // set setCurrentVacation(GBSystem_Vacation_Model? vacation) {
  //   _currentVacation.value = vacation;
  //   update();
  // }
  set currentVacation(GBSystem_Vacation_Model? vacation) {
    _currentVacation.value = vacation;
    update();
  }

  // set setCurrentVacationVacation(GBSystem_Vacation_Model? vacation) {
  //     _currentVacation.value = vacation;
  //     update();
  //   }

  set setVacationToLeft(GBSystem_Vacation_Model vacation) {
    _allVacations.value?.insert(0, vacation);
    update();
  }

  set setVacationToRight(GBSystem_Vacation_Model vacation) {
    _allVacations.value?.insert(_allVacations.value!.length, vacation);
    update();
  }

  set setAllVacation(List<GBSystem_Vacation_Model>? vacations) {
    _allVacations.value = vacations ?? [];

    if (_allVacations.value!.isNotEmpty) {
      currentVacation = _allVacations.value!.first;
    } else {
      currentVacation = null; // 👈 sécurité si la liste est vide
    }

    // _allVacations.value = vacations;
    // currentVacation = _allVacations.value?.first;
    update();
  }

  // set setAllSelectedVacation(List<GBSystem_Vacation_Model> vacations) {
  //   _allSelectedVacations.value = vacations;
  //   update();
  // }

  // Setters pour les lieux et événements
  set setAllFiltredLieu(List<SitePlanningModel>? avalue) {
    _allFiltredLieu = avalue;
    update();
  }

  set setAllLieu(List<SitePlanningModel>? allLieu) {
    _allLieu = allLieu;
    update();
  }

  set setAllEvenemt(List<SitePlanningModel>? allEvenement) {
    _allEvenement = allEvenement;
    update();
  }

  set setAllFiltredEvenements(List<SitePlanningModel>? allEvenements) {
    _allFiltredEvenements = allEvenements;
    update();
  }

  //List<SitePlanningModel> _allFiltredEvenements = [];
  //List<SitePlanningModel> get getAllFiltredEvenements => _allFiltredEvenements;
  // set setAllFiltredEvenements(List<SitePlanningModel> value) => _allFiltredEvenements = value;

  // Setters pour les dates
  set setVacationEntrer(DateTime entrer) {
    _entrer = entrer;
    update();
  }

  set setVacationSortie(DateTime sortie) {
    update();
  }

  set setFilterDateDebut(List<TimeOfDay>? debut) {
    _filterDebutDate = debut;
    update();
  }

  set setSelectedFilterDateDebut(List<TimeOfDay>? debut) {
    _selectedfilterDebutDate = debut;
    update();
  }

  set setSelectedFilterDateFin(List<TimeOfDay>? fin) {
    _selectedfilterFinDate = fin;
    update();
  }

  set setFilterDateFin(List<TimeOfDay>? fin) {
    _filterFinDate = fin;
    update();
  }

  // Setters pour la recherche
  set setSearchtext(String value) {
    _textSearch = value;
    update();
  }

  // Setters pour l'état des filtres
  set setFilterDebutBool(bool value) {
    _useFilterDebut = value;
    update();
  }

  set setFilterFinBool(bool value) {
    _useFilterFin = value;
    update();
  }

  set setFilterLieuBool(bool value) {
    _useFilterLieu = value;
    update();
  }

  set setFilterEvenementsBool(bool value) {
    _useFilterEvenements = value;
    update();
  }

  //=== Méthodes publiques =====================================================

  void removeItemFromSelectedVacations(GBSystem_Vacation_Model vacation) {
    final index = _allSelectedVacations.indexWhere((v) => v.VAC_IDF == vacation.VAC_IDF);

    if (index != -1) {
      _allSelectedVacations.removeAt(index);
      update();
    }
  }

  void removeItemFromVacations(GBSystem_Vacation_Model vacation) {
    final index = _allVacations.value?.indexWhere((v) => v.VAC_IDF == vacation.VAC_IDF);

    if (index != -1) {
      _allVacations.value?.removeAt(index!);
      update();
    }
  }

  Future<PauseModel?> updatePauseVacation({required GBSystem_Vacation_Model vacation, required TimeOfDay debutPause, required TimeOfDay finPause}) async {
    //await initApiData();
    DateTime debutPauseDate = DateTime(
      DateTime.now().year, //
      DateTime.now().month,
      DateTime.now().day,
      debutPause.hour,
      debutPause.minute,
    );

    DateTime finPauseDate = DateTime(
      DateTime.now().year, //
      DateTime.now().month,
      DateTime.now().day,
      finPause.hour,
      finPause.minute,
    );

    int durationSeconds = finPauseDate.difference(debutPauseDate).inSeconds;
    bool isDefferentJour = debutPauseDate.compareTo(finPauseDate) == 1;
    // /////////////////////////////////////
    bool isDefferentJourVacation = false;

    if (vacation.VAC_START_HOUR != null && vacation.VAC_END_HOUR != null) {
      isDefferentJourVacation =
          DateTime(
            DateTime.now().year, //
            DateTime.now().month,
            DateTime.now().day,
            vacation.VAC_START_HOUR!.hour,
            vacation.VAC_START_HOUR!.minute,
          ).compareTo(
            DateTime(
              DateTime.now().year, //
              DateTime.now().month,
              DateTime.now().day,
              vacation.VAC_END_HOUR!.hour,
              vacation.VAC_END_HOUR!.minute,
            ),
          ) ==
          1;
    }

    ResponseModel ServerDataREponse = await Execute_Server_post(
      data: {
        "OKey": "Shift_CalendarPlanning_NG,,Update_Vacs_Evenement",
        "actionTH": "0",
        "action": "5",
        "VAC_IDF": vacation.VAC_IDF,
        "EVT_IDF": vacation.EVT_IDF,
        "JOB_IDF": vacation.JOB_IDF,
        'J_PLUS': isDefferentJourVacation ? "1" : "0",
        "JB_PLUS": isDefferentJour ? "1" : "0",
        "VAC_DURATION": vacation.VAC_DURATION_SECONDS ?? "",
        "JOB_FILTER_CKBX": "0",
        "VACS_TO_UPDATE": "",
        "VAC_START_HOUR": vacation.VAC_START_HOUR != null ? GBSystem_convert_date_service().parseDateAndTimeWithoutSec(date: vacation.VAC_START_HOUR!) : "",
        "VAC_END_HOUR": vacation.VAC_END_HOUR != null ? GBSystem_convert_date_service().parseDateAndTimeWithoutSec(date: vacation.VAC_END_HOUR!) : "",
        "VAC_BREAK": durationSeconds.toString(),
        "VAC_BREAKSTART_HOUR": GBSystem_convert_date_service().parseDateAndTimeWithoutSec(date: debutPauseDate),
        "VAC_BREAKEND_HOUR": GBSystem_convert_date_service().parseDateAndTimeWithoutSec(date: isDefferentJour ? finPauseDate.add(Duration(days: 1)) : finPauseDate),
      },
    );

    // for (var i = 0; i < (ServerDataREponse.data["Data"] as List).length; i++) {
    //   if (ServerDataREponse.data["Data"][i] != null && ServerDataREponse.data["Data"][i] is Map && (ServerDataREponse.data["Data"][i] as Map).containsKey("SHIFT_CAL_MSG") && ServerDataREponse.data["Data"][i]["SHIFT_CAL_MSG"] is List && (ServerDataREponse.data["Data"][i]["SHIFT_CAL_MSG"] as List).isNotEmpty) {
    //     showWarningDialog("${ServerDataREponse.data["Data"][i]["SHIFT_CAL_MSG"][0]["MESSAGES"]}");
    //   }
    // }
    // showErrorDialog(
    //     context, "${ServerDataREponse.data["Data"][1]["SHIFT_CAL_MSG"][0]["MESSAGES"]}");

    if ((ServerDataREponse.data["Data"] as List).isNotEmpty && (ServerDataREponse.data["Errors"] as List).isEmpty) {
      //      await saveCookies(ServerDataREponse.cookies!);
      // currentVacation = GBSystem_Vacation_Model.fromResponse_List(ServerDataREponse)!.first;

      // currentVacation = GBSystem_Vacation_Model.fromResponse(ServerDataREponse);

      removeItemFromVacations(currentVacation!);
      //vacation = currentVacation!;

      currentVacation = GBSystem_Vacation_Model.fromResponse_Data(ServerDataREponse);
      setVacation = currentVacation!;

      String vacBreakstartHour = vacation.VAC_BREAKSTART_HOUR.toString(); //      ServerDataREponse.getFirstElementFromDataList()["VAC_BREAKSTART_HOUR"];
      String vacBreakendHour = vacation.VAC_BREAKEND_HOUR.toString(); //ServerDataREponse.getFirstElementFromDataList()["VAC_BREAKEND_HOUR"];
      String vacDuration = vacation.VAC_DURATION.toString(); //ServerDataREponse.getFirstElementFromDataList()["VAC_DURATION_STR"];
      String vacBreak = vacation.VAC_BREAK.toString(); //ServerDataREponse.getFirstElementFromDataList()["VAC_BREAK_STR"];
      // print(ServerDataREponse.data["Data"][0]["ClientData"][0]["VAC_BREAKSTART_HOUR"]);
      // print(ServerDataREponse.data["Data"][0]["ClientData"][0]["VAC_BREAKEND_HOUR"]);
      // print(ServerDataREponse.data["Data"][0]["ClientData"][0]["VAC_DURATION"]);

      // currentVacation!.VAC_BREAK = vacation.VAC_BREAK;
      // currentVacation!.VAC_DURATION = vacation.VAC_DURATION;

      return PauseModel(VAC_BREAK: vacBreak, VAC_DURATION: vacDuration, VAC_BREAKSTART_HOUR: vacBreakstartHour, VAC_BREAKEND_HOUR: vacBreakendHour);
    } else {
      return null;
    }
  }
  /**------------------------------------------------------------------------------------------------------------------ */
  /**------------------------------------------------------------------------------------------------------------------ */
  /**------------------------------------------------------------------------------------------------------------------ */
  /**------------------------------------------------------------------------------------------------------------------ */
  /// ------------------------------------------------------------------------------------------------------------------

  //List<TimeOfDay>? _selectedfilterDebutDate, _selectedfilterFinDate;
  //List<TimeOfDay>? _filterDebutDate, _filterFinDate;

  //List<GBSystem_Vacation_Model>? _allVacations;
  DateTime? _entrer, _sortie;
  // GBSystem_Vacation_Model? _currentVacation;
  //Rx<GBSystem_Vacation_Model?> _currentVacation = Rx<GBSystem_Vacation_Model?>(null);
  final Rx<List<GBSystem_Vacation_Model>> _listCurrentVacation = Rx<List<GBSystem_Vacation_Model>>([]);

  final Rx<int?> _numberVacationProposer = Rx<int?>(null);

  set setNumberVacationsProposer(int? nbr) {
    _numberVacationProposer.value = nbr;
    update();
  }

  set setCurrentVacationList(GBSystem_Vacation_Model vacation) {
    _listCurrentVacation.value.add(vacation);
    update();
  }

  List<GBSystem_Vacation_Model>? get getAllVacations => allVacations;
  GBSystem_Vacation_Model? get getCurrentVacation => _currentVacation.value;
  Rx<GBSystem_Vacation_Model?> get getCurrentVacationRx => _currentVacation;

  DateTime? get getEntrer => _entrer;
  DateTime? get getSortie => _sortie;
  Rx<int?> get getNumberVacationProposer => _numberVacationProposer;
  Rx<List<GBSystem_Vacation_Model>?> get getListCurrentVacation => _listCurrentVacation;

  List<TimeOfDay>? get getSelectedDebutFilter => _selectedfilterDebutDate;
  List<TimeOfDay>? get getSelectedFinFilter => _selectedfilterFinDate;

  bool get getFilterDebut => _useFilterDebut;
  bool get getFilterFin => _useFilterFin;
  bool get getFilterLieu => _useFilterLieu;
  bool get getFilterEvenements => _useFilterEvenements;

  List<SitePlanningModel>? get getAllLieu => _allLieu;
  List<SitePlanningModel>? get getAllEvenement => _allEvenement;
  List<SitePlanningModel>? get getAllFiltredLieu => _allFiltredLieu;
  List<SitePlanningModel>? get getAllFiltredEvenements => _allFiltredEvenements;

  List<TimeOfDay>? get getDebutFilter => _filterDebutDate;
  List<TimeOfDay>? get getFinFilter => _filterFinDate;

  String? get getSearchText => _textSearch;

  void extractDistinctSites() {
    if (allVacations == null) return;

    _allLieu = allVacations!
        .fold<Map<String, SitePlanningModel>>({}, (map, vacation) {
          if (!map.containsKey(vacation.LIE_IDF)) {
            map[vacation.LIE_IDF] = SitePlanningModel.fromVacation(vacation);
          }
          return map;
        })
        .values
        .toList();
  }

  void extractDistinctEvenements() {
    if (allVacations == null) return;

    _allEvenement = allVacations!
        .fold<Map<String, SitePlanningModel>>({}, (map, vacation) {
          if (!map.containsKey(vacation.EVT_IDF)) {
            map[vacation.EVT_IDF] = SitePlanningModel.fromVacation(vacation);
          }
          return map;
        })
        .values
        .toList();
  }

  String get selectedVacationsIdf {
    if (allSelectedVacations.isEmpty) {
      // 👇 si rien n’est sélectionné → currentVacation
      return currentVacation?.VAC_IDF ?? "";
    } else {
      // 👇 sinon → toutes les sélectionnées
      return allSelectedVacations.map((e) => e.VAC_IDF).toList().join(",");
    }
  }

  void applyServerResponse(ResponseModel responseServer) {
    if (allSelectedVacations.isNotEmpty) {
      final List<GBSystem_Vacation_Model> serverVacations = GBSystem_Vacation_Model.fromResponse_List(responseServer) ?? [];

      for (final serverVac in serverVacations) {
        final localVac = allSelectedVacations.firstWhereOrNull((v) => v.VAC_IDF == serverVac.VAC_IDF);
        if (localVac != null) {
          localVac.updateFrom(serverVac);
        }
      }
    } else {
      GBSystem_Vacation_Model? serverVac = GBSystem_Vacation_Model.fromResponse(responseServer);

      if (currentVacation != null && serverVac != null && currentVacation!.VAC_IDF == serverVac.VAC_IDF) {
        currentVacation!.updateFrom(serverVac);
      }
    }

    update(); // 👉 notifier la vue
  }
}

/*

class GBSystem_Vacation_Informations_Controller extends GetxController {
  Rx<List<GBSystem_Vacation_Model>?>? _allVacations = Rx<List<GBSystem_Vacation_Model>?>(null);
  // List<GBSystem_Vacation_Model>? _allVacations;

  // Rx<List<GBSystem_Vacation_Model>?>? _allFiltredVacations =
  //     Rx<List<GBSystem_Vacation_Model>?>(null);
  // List<GBSystem_Vacation_Model>? _allFiltredVacations;

  List<GBSystem_Vacation_Model> _allSelectedVacations = [];

  List<SitePlanningModel>? _allFiltredLieu;
  List<SitePlanningModel>? _allLieu;
  List<SitePlanningModel>? _allFiltredEvenements;

  DateTime? _entrer, _sortie;
  List<TimeOfDay>? _filterDebutDate, _filterFinDate;
  List<TimeOfDay>? _selectedfilterDebutDate, _selectedfilterFinDate;
  // GBSystem_Vacation_Model? _currentVacation;
  //  Rx<List<AbsenceModel>?>? _allAbsences = Rx<List<AbsenceModel>?>(null);
  Rx<GBSystem_Vacation_Model?>? _currentVacation = Rx<GBSystem_Vacation_Model?>(null);
  bool _useFilterDebut = false, _useFilterFin = false, _useFilterLieu = false, _useFilterEvenements = false;
  String? _textSearch;
  set setVacation(GBSystem_Vacation_Model vacation) {
    _allVacations?.value?.add(vacation);
    update();
  }

  set setSelectedVacation(GBSystem_Vacation_Model vacation) {
    _allSelectedVacations.add(vacation);
    update();
  }

  void removeItemFromSelectedVacations(GBSystem_Vacation_Model vacation) {
    int? index;
    for (var i = 0; i < _allSelectedVacations.length; i++) {
      if (_allSelectedVacations[i].VAC_IDF == vacation.VAC_IDF) {
        index = i;
      }
    }
    if (index != null) {
      _allSelectedVacations.removeAt(index);
    }
    update();
  }

  set setSearchtext(String value) {
    _textSearch = value;
    update();
  }

  set setFilterDebutBool(bool value) {
    _useFilterDebut = value;
    update();
  }

  set setFilterFinBool(bool value) {
    _useFilterFin = value;
    update();
  }

  set setFilterLieuBool(bool value) {
    _useFilterLieu = value;
    update();
  }

  set setFilterEvenementsBool(bool value) {
    _useFilterEvenements = value;
    update();
  }

  set currentVacation(GBSystem_Vacation_Model? vacation) {
    _currentVacation?.value = vacation;
    update();
  }

  set setVacationToLeft(GBSystem_Vacation_Model vacation) {
    _allVacations?.value?.insert(0, vacation);
    update();
  }

  set setVacationToRight(GBSystem_Vacation_Model vacation) {
    _allVacations?.value?.insert(_allVacations!.value!.length, vacation);
    update();
  }

  set setVacationEntrer(DateTime entrer) {
    _entrer = entrer;
    update();
  }

  set setFilterDateDebut(List<TimeOfDay>? debut) {
    _filterDebutDate = debut;
    update();
  }

  set setSelectedFilterDateDebut(List<TimeOfDay>? debut) {
    _selectedfilterDebutDate = debut;
    update();
  }

  set setSelectedFilterDateFin(List<TimeOfDay>? fin) {
    _selectedfilterFinDate = fin;
    update();
  }

  set setFilterDateFin(List<TimeOfDay>? fin) {
    _filterFinDate = fin;
    update();
  }

  set setVacationSortie(DateTime sortie) {
    _sortie = sortie;
    update();
  }

  set setAllVacation(List<GBSystem_Vacation_Model>? vacations) {
    _allVacations?.value = vacations;
    update();
  }

  set setAllSelectedVacation(List<GBSystem_Vacation_Model> vacations) {
    _allSelectedVacations = vacations;
    update();
  }

  // set setAllFiltredVacation(List<GBSystem_Vacation_Model>? vacations) {
  //   _allFiltredVacations?.value = vacations;
  //   update();
  // }

  set setAllFiltredLieu(List<SitePlanningModel>? AllLieu) {
    _allFiltredLieu = AllLieu;
    update();
  }

  set setAllLieu(List<SitePlanningModel>? AllLieu) {
    _allLieu = AllLieu;
    update();
  }

  set setAllFiltredEvenements(List<SitePlanningModel>? AllEvenements) {
    _allFiltredEvenements = AllEvenements;
    update();
  }

  List<GBSystem_Vacation_Model>? get getAllVacations => _allVacations?.value;
  Rx<List<GBSystem_Vacation_Model>?>? get getAllVacationsRx => _allVacations;

  List<GBSystem_Vacation_Model>? get safeAllSelectedVacations => _allSelectedVacations;

  // List<GBSystem_Vacation_Model>? get getAllFiltredVacations =>
  //     _allFiltredVacations?.value;
  // Rx<List<GBSystem_Vacation_Model>?>? get getAllFiltredVacationsRx =>
  //     _allFiltredVacations;
  List<SitePlanningModel>? get allFiltredLieu => _allFiltredLieu;
  List<SitePlanningModel>? get allLieu => _allLieu;
  List<SitePlanningModel>? get allFiltredEvenements => _allFiltredEvenements;
  GBSystem_Vacation_Model? get getCurrentVacation => _currentVacation?.value;
  Rx<GBSystem_Vacation_Model?>? get getCurrentVacationRx => _currentVacation;

  String? get getSearchText => _textSearch;

  DateTime? get getEntrer => _entrer;
  DateTime? get getSortie => _sortie;

  List<TimeOfDay>? get debutFilter => _filterDebutDate;
  List<TimeOfDay>? get finFilter => _filterFinDate;

  List<TimeOfDay>? get selectedDebutFilter => _selectedfilterDebutDate;
  List<TimeOfDay>? get selectedFinFilter => _selectedfilterFinDate;

  bool get filterDebutEnabled => _useFilterDebut;
  bool get filterFinEnabled => _useFilterFin;
  bool get filterLieuEnabled => _useFilterLieu;
  bool get filterEvenementsEnabled => _useFilterEvenements;

  // Méthodes d'accès encapsulées
  bool get hasCurrentVacation => getCurrentVacation != null;
  String get currentVacationTitle => getCurrentVacation?.TITLE.trim() ?? "";
  bool get isCurrentVacationActive => getCurrentVacation?.TPH_PSA == "1";
  int? get entryPointageNumber {
    final nbr = getCurrentVacation?.PNTGS_IN_NBR;
    return nbr != null && nbr.isNotEmpty ? int.tryParse(nbr) : null;
  }

  int? get exitPointageNumber {
    final nbr = getCurrentVacation?.PNTGS_OUT_NBR;
    return nbr != null && nbr.isNotEmpty ? int.tryParse(nbr) : null;
  }

  bool get hasEntryPointage => entryPointageNumber != null;
  bool get hasExitPointage => exitPointageNumber != null;
}
*/
