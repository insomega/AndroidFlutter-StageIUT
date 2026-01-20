import 'package:bmsoft_ps2/GBSystem_Application/GBSystem_sites_planning_controller.dart';
import 'package:bmsoft_ps2/GBSystem_Application/selected_vacation_screen.dart';

//import 'package:bmsoft_ps2/GBSystem_Application/selected_vacation_screen.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_site_planning_model.dart';
import 'package:gbsystem_vacation_priseservice/GBSystem_Root_PriseService_Controller.dart';
import 'package:gbsystem_root/GBSystem_vacation_model.dart';
//import 'package:gbsystem_vacation_priseservice/GBSystem_vacation_informations_Widget.dart';
import 'package:get/get.dart';

class GBSystem_Vacation_List_PS2_Controller extends GBSystem_Root_PriseService_Controller {
  final RxBool isVacationNonPointer = false.obs;
  final RxBool callBool = false.obs;
  String? phoneNumber;
  final RxString text = "".obs;

  var isSwitchOn = false.obs;
  var isSelectAllChecked = false.obs;
  var selectedItems = 0.obs;
  var totalItems = 0.obs;

  final TextEditingController controllerSearch = TextEditingController();
  final GBSystemSitesPlanningController sitePlanningController = Get.put(GBSystemSitesPlanningController());

  // ✅ Nouvelle liste observable filtrée
  final RxList<GBSystem_Vacation_Model> _filteredVacations = <GBSystem_Vacation_Model>[].obs;
  RxList<GBSystem_Vacation_Model> get usedListVacation => _filteredVacations;

  @override
  void onInit() {
    super.onInit();

    _setupSearchListener();
    initializeController();

    // ✅ Réagit automatiquement quand les filtres changent
    ever(isVacationNonPointer, (_) => refreshUsedListVacation());
    ever(text, (_) => refreshUsedListVacation());
  }

  Future<void> initializeController() async {
    try {
      isLoading.value = true;
      await _Do_Load_Data();
      //currentVacation = Vacation_Informations_Controller.currentVacation;

      // recalcul initial
      refreshUsedListVacation();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _Do_Load_Data() async {
    await getAllVacationPlanning(
      sitePlanningList: Vacation_Informations_Controller.getFilterLieu ? Vacation_Informations_Controller.getAllFiltredLieu ?? [] : [],
      evenementList: Vacation_Informations_Controller.getFilterEvenements ? Vacation_Informations_Controller.getAllFiltredEvenements ?? [] : [],
      searchText: Vacation_Informations_Controller.getSearchText,
      isGetAll: true,
    );
  }

  void _setupSearchListener() {
    controllerSearch.addListener(() {
      text.value = controllerSearch.text;
      Vacation_Informations_Controller.setSearchtext = controllerSearch.text;
    });
  }

  // ✅ Méthode qui recalcule et met à jour la liste filtrée
  void refreshUsedListVacation() {
    List<GBSystem_Vacation_Model> tempList = Vacation_Informations_Controller.getAllVacations ?? [];
    List<SitePlanningModel> filtredLieu = Vacation_Informations_Controller.allFiltredLieu ?? [];

    tempList = filterVacationsWithDatesList(allVacs: tempList, filtredLieu: filtredLieu);

    if (isVacationNonPointer.value) {
      tempList = tempList.where((element) => (element.PNTGS_IN_NBR == null || element.PNTGS_IN_NBR!.isEmpty) && (element.PNTGS_OUT_NBR == null || element.PNTGS_OUT_NBR!.isEmpty)).toList();
    }

    final lowerSearch = text.value.toLowerCase();
    if (text.value.isNotEmpty) {
      tempList = tempList
          .where(
            (element) =>
                element.SVR_CODE_LIB.toLowerCase().contains(lowerSearch) || //
                element.LIE_CODE.toLowerCase().contains(lowerSearch) ||
                element.LIE_LIB.toLowerCase().contains(lowerSearch) ||
                _timeMatchesSearch(element.HEURE_DEBUT, lowerSearch) ||
                _timeMatchesSearch(element.HEURE_FIN, lowerSearch),
          )
          .toList();
    }

    // ✅ Mise à jour observable
    _filteredVacations.assignAll(tempList);
    totalItems.value = tempList.length;
  }

  // Méthode helper pour TimeOfDay
  bool _timeMatchesSearch(TimeOfDay time, String searchText) {
    final formats = ['${time.hour}:${time.minute}', '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}', '${time.hour}h${time.minute}', '${time.hour}h${time.minute.toString().padLeft(2, '0')}', time.hour.toString(), time.minute.toString()];
    return formats.any((format) => format.contains(searchText));
  }

  List<SitePlanningModel> get usedListEvenements {
    return Vacation_Informations_Controller.getFilterEvenements ? (Vacation_Informations_Controller.getAllFiltredEvenements ?? []).cast<SitePlanningModel>() : (sitePlanningController.getAllEvenements ?? []).cast<SitePlanningModel>();
  }

  List<SitePlanningModel> get usedListLieu {
    return Vacation_Informations_Controller.getFilterLieu ? (Vacation_Informations_Controller.getAllFiltredLieu ?? []).cast<SitePlanningModel>() : (sitePlanningController.getAllSites ?? []).cast<SitePlanningModel>();
  }

  bool checkHourAndMinute(TimeOfDay dateVac, List<TimeOfDay> dateTest) {
    bool hoursTest = dateTest.map((e) => e.hour).contains(dateVac.hour);
    bool minutsTest = dateTest.map((e) => e.minute).contains(dateVac.minute);
    return hoursTest && minutsTest;
  }

  List<GBSystem_Vacation_Model> filterVacationsWithDatesList({
    required List<GBSystem_Vacation_Model> allVacs,
    List<SitePlanningModel>? filtredLieu, // 👈 liste optionnelle
  }) {
    // Récupérer les filtres une seule fois
    final filterDebut = Vacation_Informations_Controller.getFilterDebut;
    final filterFin = Vacation_Informations_Controller.getFilterFin;
    final debutFilter = Vacation_Informations_Controller.getDebutFilter ?? [];
    final finFilter = Vacation_Informations_Controller.getFinFilter ?? [];

    // Si une liste de lieux filtrés est fournie → réduire la source
    Iterable<GBSystem_Vacation_Model> sourceList = allVacs;
    if (filtredLieu != null && filtredLieu.isNotEmpty) {
      final idsToKeep = filtredLieu.map((lieu) => lieu.LIE_IDF).toSet();
      sourceList = sourceList.where((vac) => idsToKeep.contains(vac.LIE_IDF));
    }

    // Si aucun filtre d'heures → on retourne direct
    if (!filterDebut && !filterFin) {
      return sourceList.toList();
    }

    // ✅ Une seule boucle
    final tempList = <GBSystem_Vacation_Model>[];
    for (var vac in sourceList) {
      final matchDebut = !filterDebut || checkHourAndMinute(vac.HEURE_DEBUT, debutFilter);
      final matchFin = !filterFin || checkHourAndMinute(vac.HEURE_FIN, finFilter);

      if (matchDebut && matchFin) {
        tempList.add(vac);
      }
    }

    return tempList;
  }

  void viderSelectedItems() {
    Vacation_Informations_Controller.setAllSelectedVacation = [];
    selectedItems.value = 0;
  }

  void filterDataSalarie(String query) {
    text.value = query;
    Vacation_Informations_Controller.setSearchtext = query;
  }

  Future selectItemVacationFunction({required GBSystem_Vacation_Model selectedVacation}) async {
    Vacation_Informations_Controller.currentVacation = selectedVacation;
    Get.back();
  }

  Future selectItemAllVacationFunction({required GBSystem_Vacation_Model selectedVacation}) async {
    Vacation_Informations_Controller.currentVacation = selectedVacation;
    Get.to(SelectedVacationScreen());
  }

  // Future selectItemAllSelectedVacation({required GBSystem_Vacation_Model selectedVacation}) async {
  //   if (!(Vacation_Informations_Controller.allSelectedVacations).contains(selectedVacation)) {
  //     Vacation_Informations_Controller.setSelectedVacation = selectedVacation;
  //   } else {
  //     Vacation_Informations_Controller.removeItemFromSelectedVacations(selectedVacation);
  //   }
  //   selectedItems.value = Vacation_Informations_Controller.allSelectedVacations.length;
  // }

  /// 👉 Sélection / désélection d’une seule vacation
  void selectItemAllSelectedVacation({required GBSystem_Vacation_Model selectedVacation}) {
    Vacation_Informations_Controller.toggleSelectedVacation(selectedVacation);

    // 🔹 Mets à jour le compteur sélectionnés
    selectedItems.value = Vacation_Informations_Controller.allSelectedVacations.length;

    // 🔹 Mets à jour l'état de "Tout sélectionner"
    isSelectAllChecked.value = (selectedItems.value == totalItems.value);
    // if (selectedItems.value == totalItems.value) {
    //   isSelectAllChecked.value = true;
    // } else {
    //   isSelectAllChecked.value = false;
    // }
  }

  /// 👉 Sélectionner toutes les vacations visibles
  void selectAllVacations(List<GBSystem_Vacation_Model> vacations) {
    Vacation_Informations_Controller.setAllSelectedVacation = vacations;
    selectedItems.value = vacations.length;
    isSelectAllChecked.value = true;
  }

  /// 👉 Désélectionner toutes les vacations
  void clearAllVacations() {
    Vacation_Informations_Controller.clearSelectedVacations();
    selectedItems.value = 0;
    isSelectAllChecked.value = false;
  }

  Future<void> getDataNowWithChanges() async {
    await getAllVacationPlanning(
      sitePlanningList: Vacation_Informations_Controller.getFilterLieu ? Vacation_Informations_Controller.getAllFiltredLieu ?? [] : [],
      evenementList: Vacation_Informations_Controller.getFilterEvenements ? Vacation_Informations_Controller.getAllFiltredEvenements ?? [] : [],
      searchText: Vacation_Informations_Controller.getSearchText,
      isGetAll: (!(Vacation_Informations_Controller.getFilterLieu) && !(Vacation_Informations_Controller.getFilterEvenements)),
    );
    refreshUsedListVacation(); // ✅ Recalcule après fetch
  }

  Future<void> entrerFunctionSingle({required GBSystem_Vacation_Model PointageVacation}) async {
    isLoading.value = true;
    Vacation_Informations_Controller.currentVacation = PointageVacation;
    await entrerFunction(false);
    isLoading.value = false;
  }

  Future<void> sortieFunctionSingle({required GBSystem_Vacation_Model PointageVacation}) async {
    isLoading.value = true;
    Vacation_Informations_Controller.currentVacation = PointageVacation;
    await sortieFunction(false);
    isLoading.value = false;
  }
}

//2025/08/25 8:11
// class GBSystem_Vacation_List_PS2_Controller extends GBSystem_Root_PriseService_Controller {
//   final RxBool isVacationNonPointer = false.obs;
//   final RxBool callBool = false.obs;
//   String? phoneNumber;
//   final RxString text = "".obs;

//   var isSwitchOn = false.obs;
//   var isSelectAllChecked = false.obs;
//   var selectedItems = 0.obs;
//   var totalItems = 0.obs;

//   final TextEditingController controllerSearch = TextEditingController();
//   final GBSystemSitesPlanningController sitePlanningController = Get.put(GBSystemSitesPlanningController());

//   @override
//   void onInit() {
//     super.onInit();

//     _setupSearchListener();
//     _initializeController();
//   }

//   Future<void> _initializeController() async {
//     try {
//       isLoading.value = true;
//       await _Do_Load_Data();
//       currentVacation = Vacation_Informations_Controller.currentVacation;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> _Do_Load_Data() async {
//     await getAllVacationPlanning(sitePlanningList: Vacation_Informations_Controller.getFilterLieu ? Vacation_Informations_Controller.getAllFiltredLieu ?? [] : [], evenementList: Vacation_Informations_Controller.getFilterEvenements ? Vacation_Informations_Controller.getAllFiltredEvenements ?? [] : [], searchText: Vacation_Informations_Controller.getSearchText, isGetAll: true);
//   }

//   void _setupSearchListener() {
//     controllerSearch.addListener(() {
//       text.value = controllerSearch.text;
//       Vacation_Informations_Controller.setSearchtext = controllerSearch.text;
//       // plus besoin de updateUI()
//     });
//   }

//   // Méthode helper pour TimeOfDay
//   bool _timeMatchesSearch(TimeOfDay time, String searchText) {
//     final formats = [
//       '${time.hour}:${time.minute}', //
//       '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
//       '${time.hour}h${time.minute}',
//       '${time.hour}h${time.minute.toString().padLeft(2, '0')}',
//       time.hour.toString(),
//       time.minute.toString(),
//     ];

//     return formats.any((format) => format.contains(searchText));
//   }

//   List<GBSystem_Vacation_Model> _usedListVacation() {
//     List<GBSystem_Vacation_Model> tempList = Vacation_Informations_Controller.getAllVacations ?? [];
//     tempList = filterVacationsWithDatesList(allVacs: tempList);

//     if (isVacationNonPointer.value) {
//       tempList = tempList.where((element) => (element.PNTGS_IN_NBR == null || element.PNTGS_IN_NBR!.isEmpty) && (element.PNTGS_OUT_NBR == null || element.PNTGS_OUT_NBR!.isEmpty)).toList();
//     }
//     final lowerSearch = text.value.toLowerCase();
//     if (text.value.isNotEmpty) {
//       return tempList
//           .where(
//             (element) =>
//                 element.SVR_CODE_LIB.toLowerCase().contains(lowerSearch) || //
//                 element.LIE_CODE.toLowerCase().contains(lowerSearch) ||
//                 element.LIE_LIB.toLowerCase().contains(lowerSearch) ||
//                 _timeMatchesSearch(element.HEURE_DEBUT, lowerSearch) || // ← HEURE_DEBUT
//                 _timeMatchesSearch(element.HEURE_FIN, lowerSearch), // ← HEURE_FIN aussi
//           )
//           .toList();
//     }

//     return tempList;
//     // List<GBSystem_Vacation_Model> tempList = _usedListVacation();
//     // totalItems.value = tempList.length; // ✅ devient observable
//     // return tempList;
//   }

//   List<GBSystem_Vacation_Model> usedListVacation() {
//     List<GBSystem_Vacation_Model> tempList = _usedListVacation();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       totalItems.value = tempList.length;
//     });
//     return tempList;
//   }

//   List<SitePlanningModel> get usedListEvenements {
//     return Vacation_Informations_Controller.getFilterEvenements ? (Vacation_Informations_Controller.getAllFiltredEvenements ?? []).cast<SitePlanningModel>() : (sitePlanningController.getAllEvenements ?? []).cast<SitePlanningModel>();
//   }

//   List<SitePlanningModel> get usedListLieu {
//     return Vacation_Informations_Controller.getFilterLieu ? (Vacation_Informations_Controller.getAllFiltredLieu ?? []).cast<SitePlanningModel>() : (sitePlanningController.getAllSites ?? []).cast<SitePlanningModel>();
//   }

//   bool checkHourAndMinute(TimeOfDay dateVac, List<TimeOfDay> dateTest) {
//     bool hoursTest = dateTest.map((e) => e.hour).contains(dateVac.hour);
//     bool minutsTest = dateTest.map((e) => e.minute).contains(dateVac.minute);
//     return hoursTest && minutsTest;
//   }

//   List<GBSystem_Vacation_Model> filterVacationsWithDatesList({required List<GBSystem_Vacation_Model> allVacs}) {
//     List<GBSystem_Vacation_Model> tempList = [];

//     if (Vacation_Informations_Controller.getFilterDebut && Vacation_Informations_Controller.getFilterFin) {
//       for (var vac in allVacs) {
//         if (checkHourAndMinute(vac.HEURE_DEBUT, Vacation_Informations_Controller.getDebutFilter ?? []) && checkHourAndMinute(vac.HEURE_FIN, Vacation_Informations_Controller.getFinFilter ?? [])) {
//           tempList.add(vac);
//         }
//       }
//     } else if (Vacation_Informations_Controller.getFilterDebut) {
//       for (var vac in allVacs) {
//         if (checkHourAndMinute(vac.HEURE_DEBUT, Vacation_Informations_Controller.getDebutFilter ?? [])) {
//           tempList.add(vac);
//         }
//       }
//     } else if (Vacation_Informations_Controller.getFilterFin) {
//       for (var vac in allVacs) {
//         if (checkHourAndMinute(vac.HEURE_FIN, Vacation_Informations_Controller.getFinFilter ?? [])) {
//           tempList.add(vac);
//         }
//       }
//     } else {
//       tempList = allVacs;
//     }

//     return tempList;
//   }

//   void viderSelectedItems() {
//     Vacation_Informations_Controller.setAllSelectedVacation = [];
//     selectedItems.value = 0; // ✅ observable
//   }

//   void filterDataSalarie(String query) {
//     text.value = query;
//     Vacation_Informations_Controller.setSearchtext = query;
//   }

//   Future selectItemVacationFunction({required GBSystem_Vacation_Model selectedVacation}) async {
//     Vacation_Informations_Controller.setCurrentVacationVacation = selectedVacation;
//     Get.back();
//   }

//   Future selectItemAllVacationFunction({required GBSystem_Vacation_Model selectedVacation}) async {
//     Vacation_Informations_Controller.setCurrentVacationVacation = selectedVacation;
//   }

//   Future selectItemAllSelectedVacation({required GBSystem_Vacation_Model selectedVacation}) async {
//     if (!(Vacation_Informations_Controller.getAllSelectedVacations ?? []).contains(selectedVacation)) {
//       Vacation_Informations_Controller.setSelectedVacation = selectedVacation;
//     } else {
//       Vacation_Informations_Controller.removeItemFromSelectedVacations(selectedVacation);
//     }
//     selectedItems.value = Vacation_Informations_Controller.getAllSelectedVacations?.length ?? 0; // ✅
//   }

//   Future<void> getDataNowWithChanges() async {
//     await getAllVacationPlanning(
//       sitePlanningList: Vacation_Informations_Controller.getFilterLieu ? Vacation_Informations_Controller.getAllFiltredLieu ?? [] : [],
//       evenementList: Vacation_Informations_Controller.getFilterEvenements ? Vacation_Informations_Controller.getAllFiltredEvenements ?? [] : [],
//       searchText: Vacation_Informations_Controller.getSearchText,
//       isGetAll: (!(Vacation_Informations_Controller.getFilterLieu) && !(Vacation_Informations_Controller.getFilterEvenements)),
//     );
//   }

//   Future<void> entrerFunctionSingle({required GBSystem_Vacation_Model PointageVacation}) async {
//     isLoading.value = true;
//     currentVacation = PointageVacation;
//     await entrerFunction(false);
//     isLoading.value = false;
//   }

//   Future<void> sortieFunctionSingle({required GBSystem_Vacation_Model PointageVacation}) async {
//     isLoading.value = true;
//     currentVacation = PointageVacation;
//     await entrerFunction(false);
//     isLoading.value = false;
//   }
// }

// // gbsystem_select_item_vacation_controller.dart
// class GBSystem_Vacation_List_PS2_Controller extends GBSystem_Root_PriseService_Controller {
//   //final BuildContext context;
//   //  final Function updateUI;
//   //final Widget destination;

//   void updateUI() {
//     update();
//   }

//   final RxBool isVacationNonPointer = false.obs;
//   final RxBool callBool = false.obs;
//   String? phoneNumber;
//   final RxString? text = RxString("");

//   var isSwitchOn = false.obs;
//   var isSelectAllChecked = false.obs;
//   var selectedItems = 0.obs;
//   var totalItems = 0.obs;

//   final TextEditingController controllerSearch = TextEditingController();
//   //final GBSystemVacationController Vacation_Informations_Controller = Get.find();
//   final GBSystemSitesPlanningController sitePlanningController = Get.put(GBSystemSitesPlanningController());

//   //GBSystem_Vacation_List_PS2_Controller({required this.context, required this.destination);

//   @override
//   void onInit() {
//     super.onInit();
//     totalItems = usedListVacation().length;
//     _setupSearchListener();
//     _initializeController();
//   }

//   Future<void> _initializeController() async {
//     try {
//       isLoading.value = true;

//       await _Do_Load_Data();

//       currentVacation = Vacation_Informations_Controller.currentVacation;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> _Do_Load_Data() async {
//     try {
//       await getAllVacationPlanning(
//         //
//         sitePlanningList: Vacation_Informations_Controller.getFilterLieu ? Vacation_Informations_Controller.getAllFiltredLieu ?? [] : [],
//         evenementList: Vacation_Informations_Controller.getFilterEvenements ? Vacation_Informations_Controller.getAllFiltredEvenements ?? [] : [],
//         searchText: Vacation_Informations_Controller.getSearchText,
//         isGetAll: true,
//       );
//     } finally {
//       //   isLoading.value = false;
//     }
//   }

//   void _setupSearchListener() {
//     controllerSearch.addListener(() {
//       text?.value = controllerSearch.text;
//       Vacation_Informations_Controller.setSearchtext = controllerSearch.text;
//       updateUI();
//     });
//   }

//   List<GBSystem_Vacation_Model> usedListVacation() {
//     List<GBSystem_Vacation_Model> tempList = Vacation_Informations_Controller.getAllVacations ?? [];
//     tempList = filterVacationsWithDatesList(allVacs: tempList);

//     if (isVacationNonPointer.value) {
//       tempList = tempList.where((element) => (element.PNTGS_IN_NBR == null || element.PNTGS_IN_NBR!.isEmpty) && (element.PNTGS_OUT_NBR == null || element.PNTGS_OUT_NBR!.isEmpty)).toList();
//     }

//     if (text?.value != null && text!.value.isNotEmpty) {
//       return tempList.where((element) => element.SVR_CODE_LIB.toLowerCase().contains(text!.value.toLowerCase())).toList();
//     }

//     return tempList;
//   }

//   // List<SitePlanningModel>? get getAllFiltredEvenements => _allFiltredEvenements;
//   // List<SitePlanningModel>? _allFiltredEvenements;

//   //   List<SitePlanningModel>? get getAllEvenements => _allEvenements;
//   //   List<SitePlanningModel>? _allEvenements;

//   //  List<SitePlanningModel> usedListEvenements() {
//   //   if (Vacation_Informations_Controller.getFilterEvenements) {
//   //     return (Vacation_Informations_Controller.getAllFiltredEvenements ?? <SitePlanningModel>[]).cast<SitePlanningModel>() ;
//   //   } else {
//   //     return sitePlanningController.getAllEvenements ?? <SitePlanningModel>[];
//   //   }
//   // }
//   List<SitePlanningModel> get usedListEvenements {
//     return Vacation_Informations_Controller.getFilterEvenements ? (Vacation_Informations_Controller.getAllFiltredEvenements ?? []).cast<SitePlanningModel>() : (sitePlanningController.getAllEvenements ?? []).cast<SitePlanningModel>();
//   }

//   List<SitePlanningModel> get usedListLieu {
//     return Vacation_Informations_Controller.getFilterLieu ? (Vacation_Informations_Controller.getAllFiltredLieu ?? []).cast<SitePlanningModel>() : (sitePlanningController.getAllSites ?? []).cast<SitePlanningModel>();
//   }

//   // ... (autres méthodes conservées avec les mêmes noms)
//   Future getItemsWithAllConditions() async {
//     updateUI();
//   }

//   bool checkHourAndMinute(TimeOfDay dateVac, List<TimeOfDay> dateTest) {
//     bool hoursTest = dateTest.map((e) => e.hour).contains(dateVac.hour);
//     bool minutsTest = dateTest.map((e) => e.minute).contains(dateVac.minute);
//     return hoursTest && minutsTest;
//   }

//   List<GBSystem_Vacation_Model> filterVacationsWithDatesList({required List<GBSystem_Vacation_Model> allVacs}) {
//     List<GBSystem_Vacation_Model> tempList = [];

//     if (Vacation_Informations_Controller.getFilterDebut && Vacation_Informations_Controller.getFilterFin) {
//       for (var i = 0; i < allVacs.length; i++) {
//         if (checkHourAndMinute(allVacs[i].HEURE_DEBUT, Vacation_Informations_Controller.getDebutFilter ?? []) && checkHourAndMinute(allVacs[i].HEURE_FIN, Vacation_Informations_Controller.getFinFilter ?? [])) {
//           tempList.add(allVacs[i]);
//         }
//       }
//     } else if (Vacation_Informations_Controller.getFilterDebut) {
//       for (var i = 0; i < allVacs.length; i++) {
//         if (checkHourAndMinute(allVacs[i].HEURE_DEBUT, Vacation_Informations_Controller.getDebutFilter ?? [])) {
//           tempList.add(allVacs[i]);
//         }
//       }
//     } else if (Vacation_Informations_Controller.getFilterFin) {
//       for (var i = 0; i < allVacs.length; i++) {
//         if (checkHourAndMinute(allVacs[i].HEURE_FIN, Vacation_Informations_Controller.getFinFilter ?? [])) {
//           tempList.add(allVacs[i]);
//         }
//       }
//     } else {
//       tempList = allVacs;
//     }

//     return tempList;
//   }

//   void viderSelectedItems() {
//     Vacation_Informations_Controller.setAllSelectedVacation = [];
//     selectedItems = 0;
//   }

//   void filterDataSalarie(String query) async {
//     text?.value = query;
//     Vacation_Informations_Controller.setSearchtext = query;
//     updateUI();
//   }

//   Future selectItemVacationFunction({required GBSystem_Vacation_Model selectedVacation}) async {
//     Vacation_Informations_Controller.setCurrentVacationVacation = selectedVacation;
//     Get.back();
//   }

//   Future selectItemAllVacationFunction({required GBSystem_Vacation_Model selectedVacation}) async {
//     Vacation_Informations_Controller.setCurrentVacationVacation = selectedVacation;
//     //Get.to(SelectedVacationScreen(destination: destination));
//   }

//   Future selectItemAllSelectedVacation({required GBSystem_Vacation_Model selectedVacation}) async {
//     if (!(Vacation_Informations_Controller.getAllSelectedVacations ?? []).contains(selectedVacation)) {
//       Vacation_Informations_Controller.setSelectedVacation = selectedVacation;
//       selectedItems = Vacation_Informations_Controller.getAllSelectedVacations?.length ?? 0;
//     } else {
//       Vacation_Informations_Controller.removeItemFromSelectedVacations(selectedVacation);
//       selectedItems = Vacation_Informations_Controller.getAllSelectedVacations?.length ?? 0;
//     }
//   }

//   Future<void> getDataNowWithChanges() async {
//     await getAllVacationPlanning(
//       sitePlanningList: Vacation_Informations_Controller.getFilterLieu ? Vacation_Informations_Controller.getAllFiltredLieu ?? [] : [],
//       evenementList: Vacation_Informations_Controller.getFilterEvenements ? Vacation_Informations_Controller.getAllFiltredEvenements ?? [] : [],
//       searchText: Vacation_Informations_Controller.getSearchText,
//       isGetAll: (!(Vacation_Informations_Controller.getFilterLieu) && !(Vacation_Informations_Controller.getFilterEvenements)),
//     );
//     // if (!(Vacation_Informations_Controller.getFilterLieu) && !(Vacation_Informations_Controller.getFilterEvenements)) {
//     //   await GBSystem_AuthService(context)
//     //       .getAllVacationPlanning(
//     //         isGetAll: true, //
//     //         evenementList: sitePlanningController.getAllEvenements ?? [],
//     //         searchText: Vacation_Informations_Controller.getSearchText,
//     //         sitePlanningList: sitePlanningController.getAllSites ?? [],
//     //       )
//     //       .then((vacations) async {
//     //         Vacation_Informations_Controller.setAllVacation = vacations;
//     //         // filterVacationsWithDates();
//     //       });
//     // } else {
//     //   await GBSystem_AuthService(context)
//     //       .getAllVacationPlanning(
//     //         isGetAll: false, //
//     //         evenementList: Vacation_Informations_Controller.getFilterEvenements ? Vacation_Informations_Controller.getAllFiltredEvenements ?? [] : [],
//     //         searchText: Vacation_Informations_Controller.getSearchText,
//     //         sitePlanningList: Vacation_Informations_Controller.getFilterLieu ? Vacation_Informations_Controller.getAllFiltredLieu ?? [] : [],
//     //       )
//     //       .then((vacations) async {
//     //         Vacation_Informations_Controller.setAllVacation = vacations;
//     //         // filterVacationsWithDates();
//     //       });
//     // }
//   }

//   // Future entrerFunction(BuildContext context) async {
//   //   if (Vacation_Informations_Controller.getAllSelectedVacations != null && Vacation_Informations_Controller.getAllSelectedVacations!.isNotEmpty) {
//   //     // isLoading.value = true;
//   //     print("ammmmmm ${Vacation_Informations_Controller.getAllSelectedVacations?.length}");
//   //     await GBSystem_AuthService(context)
//   //         .pointageEntrerSorieMultiple(Sens: GBSystem_System_Strings.str_pointage_entrer_sens, vacations: Vacation_Informations_Controller.getAllSelectedVacations ?? [])
//   //         .then((infoEntrer) async {
//   //           if (infoEntrer != null) {
//   //             GBSystem_Vacation_Model myVacation = infoEntrer;
//   //             Vacation_Informations_Controller.setVacationEntrer = myVacation.PNTGS_START_HOUR_IN!;
//   //             Vacation_Informations_Controller.setCurrentVacationVacation = myVacation;
//   //             // charger new data

//   //             // await getDataNowWithChanges().then((vacations) async {
//   //             //   Vacation_Informations_Controller.setAllVacation = vacations;
//   //             // });

//   //             // vider selected vacation
//   //             viderSelectedItems();

//   //             // isLoading.value = false;
//   //             showSuccesDialog(GBSystem_Application_Strings.str_pointage_entrer_succes);
//   //           } else {
//   //             // isLoading.value = false;
//   //             showErrorDialog(GBSystem_Application_Strings.str_mal_tourner);
//   //           }
//   //         })
//   //         .catchError((e) async {
//   //           isLoading.value = false;
//   //           GBSystem_Add_LogEvent(message: e.toString(), method: "entrerFunction", page: "GBSystem_user_entrer_sortie_controller")
//   //           //GBSystem_Add_LogEvent( message: e.toString(), method: "entrerFunction", page: "GBSystem_user_entrer_sortie_controller");
//   //         });
//   //   } else {
//   //     showWarningDialog( GBSystem_Application_Strings.str_aucune_vacation_selected);
//   //   }
//   // }

//   // Future sortieFunction(BuildContext context) async {
//   //   if (Vacation_Informations_Controller.getAllSelectedVacations != null && Vacation_Informations_Controller.getAllSelectedVacations!.isNotEmpty) {
//   //     // isLoading.value = true;

//   //     await GBSystem_AuthService(context)
//   //         .pointageEntrerSorieMultiple(Sens: GBSystem_System_Strings.str_pointage_sortie_sens, vacations: Vacation_Informations_Controller.getAllSelectedVacations ?? [])
//   //         .then((infoSortie) async {
//   //           if (infoSortie != null) {
//   //             GBSystem_Vacation_Model myVacation = infoSortie;
//   //             Vacation_Informations_Controller.setVacationSortie = myVacation.PNTGS_START_HOUR_OUT!;
//   //             Vacation_Informations_Controller.setCurrentVacationVacation = myVacation;
//   //             // charger new data
//   //             // await getDataNowWithChanges().then((vacations) async {
//   //             //   Vacation_Informations_Controller.setAllVacation = vacations;

//   //             // });
//   //             // vider selected vacation
//   //             viderSelectedItems();

//   //             // isLoading.value = false;
//   //             showSuccesDialog( GBSystem_Application_Strings.str_pointage_sortie_succes);
//   //           } else {
//   //             // isLoading.value = false;
//   //             showErrorDialog( GBSystem_Application_Strings.str_mal_tourner);
//   //           }
//   //         })
//   //         .catchError((e) async {
//   //           print(e);
//   //           isLoading.value = false;
//   //           GBSystem_Add_LogEvent( message: e.toString(), method: "sortieFunction", page: "GBSystem_user_entrer_sortie_controller");
//   //         });
//   //   } else {
//   //     showWarningDialog( GBSystem_Application_Strings.str_aucune_vacation_selected);
//   //   }
//   // }

//   Future<void> entrerFunctionSingle({required GBSystem_Vacation_Model PointageVacation}) async {
//     //  test connexion
//     isLoading.value = true;
//     currentVacation = PointageVacation;
//     await entrerFunction(false);
//     isLoading.value = false;

//     // await GBSystem_AuthService(context)
//     //     .pointageEntrerSorie(Sens: GBSystem_System_Strings.str_pointage_entrer_sens, vacation: currentVacation)
//     //     .then((infoEntrer) async {
//     //       if (infoEntrer != null) {
//     //         GBSystem_Vacation_Model myVacation = infoEntrer;
//     //         Vacation_Informations_Controller.setVacationEntrer = myVacation.PNTGS_START_HOUR_IN!;
//     //         Vacation_Informations_Controller.setCurrentVacationVacation = myVacation;
//     //         isLoading.value = false;

//     //         currentVacation.PNTGS_IN_NBR = infoEntrer.PNTGS_IN_NBR;
//     //         currentVacation.PNTGS_OUT_NBR = infoEntrer.PNTGS_OUT_NBR;
//     //         currentVacation.PNTGS_START_HOUR_OUT = infoEntrer.PNTGS_START_HOUR_OUT;
//     //         currentVacation.PNTGS_START_HOUR_IN = infoEntrer.PNTGS_START_HOUR_IN;
//     //         currentVacation.PNTG_START_HOUR = infoEntrer.PNTG_START_HOUR;
//     //         currentVacation.PNTG_END_HOUR = infoEntrer.PNTG_END_HOUR;

//     //         showSuccesDialog(GBSystem_Application_Strings.str_pointage_entrer_succes);
//     //       } else {
//     //         isLoading.value = false;
//     //         showErrorDialog(GBSystem_Application_Strings.str_mal_tourner);
//     //       }
//     //     })
//     //     .catchError((e) async {
//     //       isLoading.value = false;
//     //       GBSystem_Add_LogEvent(message: e.toString(), method: "entrerFunction", page: "GBSystem_user_entrer_sortie_controller");
//     //     });
//   }

//   Future sortieFunctionSingle({required GBSystem_Vacation_Model PointageVacation}) async {
//     isLoading.value = true;
//     currentVacation = PointageVacation;
//     await entrerFunction(false);
//     isLoading.value = false;
//     // await GBSystem_AuthService(context)
//     //     .pointageEntrerSorie(Sens: GBSystem_System_Strings.str_pointage_sortie_sens, vacation: currentVacation)
//     //     .then((infoSortie) async {
//     //       // print('info $infoSortie');
//     //       if (infoSortie != null) {
//     //         GBSystem_Vacation_Model myVacation = infoSortie;
//     //         Vacation_Informations_Controller.setVacationSortie = myVacation.PNTGS_START_HOUR_OUT!;
//     //         Vacation_Informations_Controller.setCurrentVacationVacation = myVacation;
//     //         isLoading.value = false;
//     //         currentVacation.PNTGS_IN_NBR = infoSortie.PNTGS_IN_NBR;
//     //         currentVacation.PNTGS_OUT_NBR = infoSortie.PNTGS_OUT_NBR;
//     //         currentVacation.PNTGS_START_HOUR_OUT = infoSortie.PNTGS_START_HOUR_OUT;
//     //         currentVacation.PNTGS_START_HOUR_IN = infoSortie.PNTGS_START_HOUR_IN;
//     //         currentVacation.PNTG_START_HOUR = infoSortie.PNTG_START_HOUR;
//     //         currentVacation.PNTG_END_HOUR = infoSortie.PNTG_END_HOUR;

//     //         showSuccesDialog(GBSystem_Application_Strings.str_pointage_sortie_succes);
//     //       } else {
//     //         showErrorDialog(GBSystem_Application_Strings.str_mal_tourner);
//     //       }
//     //     })
//     //     .catchError((e) async {
//     //       // print('err');
//     //       isLoading.value = false;
//     //       GBSystem_Add_LogEvent(message: e.toString(), method: "sortieFunction", page: "GBSystem_user_entrer_sortie_controller");
//     //     });
//   }
// }
