// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gbsystem_root/GBSystem_vacation_model.dart';
// import 'GBSystem_site_planning_model.dart';

// class GBSystemVacationController extends GetxController {
//   List<TimeOfDay>? _selectedfilterDebutDate, _selectedfilterFinDate;
//   List<TimeOfDay>? _filterDebutDate, _filterFinDate;

//   List<GBSystem_Vacation_Model>? _allVacations;
//   DateTime? _entrer, _sortie;
//   // GBSystem_Vacation_Model? _currentVacation;
//   Rx<GBSystem_Vacation_Model?> _currentVacation = Rx<GBSystem_Vacation_Model?>(null);
//   Rx<List<GBSystem_Vacation_Model>> _listCurrentVacation = Rx<List<GBSystem_Vacation_Model>>([]);

//   Rx<int?> _numberVacationProposer = Rx<int?>(null);

//   set setVacation(GBSystem_Vacation_Model vacation) {
//     _allVacations?.add(vacation);
//     update();
//   }

//   set setNumberVacationsProposer(int? nbr) {
//     _numberVacationProposer.value = nbr;
//     update();
//   }

//   set setCurrentVacationVacation(GBSystem_Vacation_Model? vacation) {
//     _currentVacation.value = vacation;
//     update();
//   }

//   set setCurrentVacationList(GBSystem_Vacation_Model vacation) {
//     _listCurrentVacation.value.add(vacation);
//     update();
//   }

//   set setVacationToLeft(GBSystem_Vacation_Model vacation) {
//     _allVacations?.insert(0, vacation);
//     update();
//   }

//   set setVacationToRight(GBSystem_Vacation_Model vacation) {
//     _allVacations?.insert(_allVacations!.length, vacation);
//     update();
//   }

//   set setVacationEntrer(DateTime entrer) {
//     _entrer = entrer;
//     update();
//   }

//   set setVacationSortie(DateTime sortie) {
//     _sortie = sortie;
//     update();
//   }

//   set setAllVacation(List<GBSystem_Vacation_Model>? vacations) {
//     _allVacations = vacations;
//     update();
//   }

//   List<GBSystem_Vacation_Model>? get getAllVacations => _allVacations;
//   GBSystem_Vacation_Model? get getCurrentVacation => _currentVacation.value;
//   Rx<GBSystem_Vacation_Model?> get getCurrentVacationRx => _currentVacation;

//   DateTime? get getEntrer => _entrer;
//   DateTime? get getSortie => _sortie;
//   Rx<int?> get getNumberVacationProposer => _numberVacationProposer;
//   Rx<List<GBSystem_Vacation_Model>?> get getListCurrentVacation => _listCurrentVacation;

//   List<TimeOfDay>? get getSelectedDebutFilter => _selectedfilterDebutDate;
//   List<TimeOfDay>? get getSelectedFinFilter => _selectedfilterFinDate;
//   set setFilterDateDebut(List<TimeOfDay>? debut) {
//     _filterDebutDate = debut;
//     update();
//   }

//   set setFilterDateFin(List<TimeOfDay>? fin) {
//     _filterFinDate = fin;
//     update();
//   }

//   bool _useFilterDebut = false, _useFilterFin = false, _useFilterLieu = false, _useFilterEvenements = false;
//   List<SitePlanningModel>? _allLieu;
//   List<SitePlanningModel>? _allFiltredLieu;
//   List<SitePlanningModel>? _allFiltredEvenements;

//   bool get getFilterDebut => _useFilterDebut;
//   bool get getFilterFin => _useFilterFin;
//   bool get getFilterLieu => _useFilterLieu;
//   bool get getFilterEvenements => _useFilterEvenements;

//   List<SitePlanningModel>? get getAllLieu => _allLieu;
//   List<SitePlanningModel>? get getAllFiltredLieu => _allFiltredLieu;
//   List<SitePlanningModel>? get getAllFiltredEvenements => _allFiltredEvenements;
//   List<GBSystem_Vacation_Model> _allSelectedVacations = [];
//   List<TimeOfDay>? get getDebutFilter => _filterDebutDate;
//   List<TimeOfDay>? get getFinFilter => _filterFinDate;
//   String? _textSearch;

//   set setFilterDebutBool(bool value) {
//     _useFilterDebut = value;
//     update();
//   }

//   set setFilterFinBool(bool value) {
//     _useFilterFin = value;
//     update();
//   }

//   set setSelectedFilterDateDebut(List<TimeOfDay>? debut) {
//     _selectedfilterDebutDate = debut;
//     update();
//   }

//   set setSelectedFilterDateFin(List<TimeOfDay>? fin) {
//     _selectedfilterFinDate = fin;
//     update();
//   }

//   set setAllFiltredLieu(List<SitePlanningModel>? AllLieu) {
//     _allFiltredLieu = AllLieu;
//     update();
//   }

//   set setFilterLieuBool(bool value) {
//     _useFilterLieu = value;
//     update();
//   }

//   set setAllSelectedVacation(List<GBSystem_Vacation_Model> vacations) {
//     _allSelectedVacations = vacations;
//     update();
//   }

//   set setAllFiltredEvenements(List<SitePlanningModel>? AllEvenements) {
//     _allFiltredEvenements = AllEvenements;
//     update();
//   }

//   set setSearchtext(String value) {
//     _textSearch = value;
//     update();
//   }

//   set setSelectedVacation(GBSystem_Vacation_Model vacation) {
//     _allSelectedVacations.add(vacation);
//     update();
//   }

//   List<GBSystem_Vacation_Model>? get getAllSelectedVacations => _allSelectedVacations;
//   void removeItemFromSelectedVacations(GBSystem_Vacation_Model vacation) {
//     int? index;
//     for (var i = 0; i < _allSelectedVacations.length; i++) {
//       if (_allSelectedVacations[i].VAC_IDF == vacation.VAC_IDF) {
//         index = i;
//       }
//     }
//     if (index != null) {
//       _allSelectedVacations.removeAt(index);
//     }
//     update();
//   }

//   set setFilterEvenementsBool(bool value) {
//     _useFilterEvenements = value;
//     update();
//   }

//   String? get getSearchText => _textSearch;
// }
