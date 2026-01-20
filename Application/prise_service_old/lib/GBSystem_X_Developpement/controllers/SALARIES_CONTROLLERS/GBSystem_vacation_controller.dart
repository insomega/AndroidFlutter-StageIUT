import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_site_planning_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_vacation_model.dart';
import 'package:get/get.dart';

class GBSystemVacationController extends GetxController {
  Rx<List<VacationModel>?>? _allVacations = Rx<List<VacationModel>?>(null);
  // List<VacationModel>? _allVacations;

  // Rx<List<VacationModel>?>? _allFiltredVacations =
  //     Rx<List<VacationModel>?>(null);
  // List<VacationModel>? _allFiltredVacations;

  List<VacationModel> _allSelectedVacations = [];

  List<SitePlanningModel>? _allFiltredLieu;
  List<SitePlanningModel>? _allLieu;
  List<SitePlanningModel>? _allFiltredEvenements;

  DateTime? _entrer, _sortie;
  List<TimeOfDay>? _filterDebutDate, _filterFinDate;
  List<TimeOfDay>? _selectedfilterDebutDate, _selectedfilterFinDate;
  // VacationModel? _currentVacation;
  //  Rx<List<AbsenceModel>?>? _allAbsences = Rx<List<AbsenceModel>?>(null);
  Rx<VacationModel?>? _currentVacation = Rx<VacationModel?>(null);
  bool _useFilterDebut = false,
      _useFilterFin = false,
      _useFilterLieu = false,
      _useFilterEvenements = false;
  String? _textSearch;
  set setVacation(VacationModel vacation) {
    _allVacations?.value?.add(vacation);
    update();
  }

  set setSelectedVacation(VacationModel vacation) {
    _allSelectedVacations.add(vacation);
    update();
  }

  void removeItemFromSelectedVacations(VacationModel vacation) {
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

  set setCurrentVacationVacation(VacationModel? vacation) {
    _currentVacation?.value = vacation;
    update();
  }

  set setVacationToLeft(VacationModel vacation) {
    _allVacations?.value?.insert(0, vacation);
    update();
  }

  set setVacationToRight(VacationModel vacation) {
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

  set setAllVacation(List<VacationModel>? vacations) {
    _allVacations?.value = vacations;
    update();
  }

  set setAllSelectedVacation(List<VacationModel> vacations) {
    _allSelectedVacations = vacations;
    update();
  }

  // set setAllFiltredVacation(List<VacationModel>? vacations) {
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

  List<VacationModel>? get getAllVacations => _allVacations?.value;
  Rx<List<VacationModel>?>? get getAllVacationsRx => _allVacations;

  List<VacationModel>? get getAllSelectedVacations => _allSelectedVacations;

  // List<VacationModel>? get getAllFiltredVacations =>
  //     _allFiltredVacations?.value;
  // Rx<List<VacationModel>?>? get getAllFiltredVacationsRx =>
  //     _allFiltredVacations;
  List<SitePlanningModel>? get getAllFiltredLieu => _allFiltredLieu;
  List<SitePlanningModel>? get getAllLieu => _allLieu;
  List<SitePlanningModel>? get getAllFiltredEvenements => _allFiltredEvenements;
  VacationModel? get getCurrentVacation => _currentVacation?.value;
  Rx<VacationModel?>? get getCurrentVacationRx => _currentVacation;

  String? get getSearchText => _textSearch;

  DateTime? get getEntrer => _entrer;
  DateTime? get getSortie => _sortie;

  List<TimeOfDay>? get getDebutFilter => _filterDebutDate;
  List<TimeOfDay>? get getFinFilter => _filterFinDate;

  List<TimeOfDay>? get getSelectedDebutFilter => _selectedfilterDebutDate;
  List<TimeOfDay>? get getSelectedFinFilter => _selectedfilterFinDate;

  bool get getFilterDebut => _useFilterDebut;
  bool get getFilterFin => _useFilterFin;
  bool get getFilterLieu => _useFilterLieu;
  bool get getFilterEvenements => _useFilterEvenements;
}
