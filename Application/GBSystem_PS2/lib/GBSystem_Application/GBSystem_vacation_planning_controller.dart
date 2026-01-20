// import 'package:get/get.dart';
// import 'package:gbsystem_root/GBSystem_vacation_model.dart';

// class GBSystemVacationPlanningController extends GetxController {
//   List<GBSystem_Vacation_Model>? _allVacations;
//   DateTime? _entrer, _sortie;
//   GBSystem_Vacation_Model? _currentVacation;

//   set setVacation(GBSystem_Vacation_Model vacation) {
//     _allVacations?.add(vacation);
//     update();
//   }

//   set setCurrentVacationVacation(GBSystem_Vacation_Model vacation) {
//     _currentVacation = vacation;
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

//   set setAllVacation(List<GBSystem_Vacation_Model> vacations) {
//     _allVacations = vacations;
//     update();
//   }

//   List<GBSystem_Vacation_Model>? get getAllVacations => _allVacations;
//   GBSystem_Vacation_Model? get getCurrentVacation => _currentVacation;

//   DateTime? get getEntrer => _entrer;
//   DateTime? get getSortie => _sortie;
// }
