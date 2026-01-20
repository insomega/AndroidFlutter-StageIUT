import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/GBSystem_internet_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/PLANNING_CONTROLLERS/GBSystem_sites_planning_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_vacation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_site_planning_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_vacation_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/selected_vacation_screen/selected_vacation_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_convert_date_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class GBSystemSelectItemVacationController extends GetxController {
  GBSystemSelectItemVacationController({
    required this.context,
    required this.destination,
    required this.updateUI,
  });
  BuildContext context;
  final Function updateUI;
  final Widget destination;

  RxBool isLoading = RxBool(false);
  RxBool isVacationNonPointer = RxBool(false);

  bool isSwitchOn = false;

  bool isSelectAllChecked = false;
  int selectedItems = 0;
  late int totalItems;

  RxString? text = RxString("");

  TextEditingController controllerSearch = TextEditingController();

  final GBSystemVacationController vacationController =
      Get.put(GBSystemVacationController());
  final GBSystemSitesPlanningController sitePlanningController =
      Get.put(GBSystemSitesPlanningController());
  final GBSystemInternatController internatController =
      Get.put(GBSystemInternatController());
  void updateString(String str) {
    text?.value = str;
    update();
  }

  @override
  void onInit() {
    totalItems = usedListVacation().length;

    super.onInit();
  }

  List<VacationModel> usedListVacation() {
    List<VacationModel> tempList = vacationController.getAllVacations ?? [];

    tempList = filterVacationsWithDatesList(allVacs: tempList);
    // filtre vacation non pointer
    if (isVacationNonPointer.value) {
      tempList = tempList
          .where(
            (element) =>
                (element.PNTGS_IN_NBR == null ||
                    element.PNTGS_IN_NBR!.isEmpty) &&
                (element.PNTGS_OUT_NBR == null ||
                    element.PNTGS_OUT_NBR!.isEmpty),
          )
          .toList();
    }
//  filtre search
    if (text?.value != null && text!.value.isNotEmpty) {
      return tempList
          .where(
            (element) => element.SVR_CODE_LIB
                .toLowerCase()
                .contains(text!.value.toLowerCase()),
          )
          .toList();
    } else {
      return tempList;
    }
  }

  List<SitePlanningModel> usedListEvenements() {
    return vacationController.getFilterEvenements
        ? vacationController.getAllFiltredEvenements ?? []
        : sitePlanningController.getAllEvenements ?? [];
  }

  List<SitePlanningModel> usedListLieu() {
    return vacationController.getFilterLieu
        ? vacationController.getAllFiltredLieu ?? []
        : sitePlanningController.getAllSites ?? [];
  }

  Future getItemsWithAllConditions() async {
    updateUI();
  }

  bool checkHourAndMinute(TimeOfDay dateVac, List<TimeOfDay> dateTest) {
    bool hoursTest = dateTest.map((e) => e.hour).contains(dateVac.hour);
    bool minutsTest = dateTest.map((e) => e.minute).contains(dateVac.minute);

    if (hoursTest && minutsTest) {
      return true;
    } else {
      return false;
    }
  }

  List<VacationModel> filterVacationsWithDatesList(
      {required List<VacationModel> allVacs}) {
    // interval ==> selected date debut <debut+fin< selected date fin
    List<VacationModel> tempList = [];

    if (vacationController.getFilterDebut && vacationController.getFilterFin) {
      for (var i = 0; i < allVacs.length; i++) {
        if (checkHourAndMinute(allVacs[i].HEURE_DEBUT,
                vacationController.getDebutFilter ?? []) &&
            checkHourAndMinute(
                allVacs[i].HEURE_FIN, vacationController.getFinFilter ?? [])) {
          tempList.add(allVacs[i]);
        }
      }
    } else if (vacationController.getFilterDebut) {
      for (var i = 0; i < allVacs.length; i++) {
        if (checkHourAndMinute(
            allVacs[i].HEURE_DEBUT, vacationController.getDebutFilter ?? [])) {
          tempList.add(allVacs[i]);
        }
      }
    } else if (vacationController.getFilterFin) {
      for (var i = 0; i < allVacs.length; i++) {
        if (checkHourAndMinute(
            allVacs[i].HEURE_FIN, vacationController.getFinFilter ?? [])) {
          tempList.add(allVacs[i]);
        }
      }
    } else {
      tempList = allVacs;
    }

    return tempList;
  }

  void viderSelectedItems() {
    vacationController.setAllSelectedVacation = [];
    selectedItems = 0;
  }

  void filterDataSalarie(String query) async {
    text?.value = query;
    vacationController.setSearchtext = query;
    updateUI();
  }

  Future selectItemVacationFunction(
      {required VacationModel selectedVacation}) async {
    vacationController.setCurrentVacationVacation = selectedVacation;
    Get.back();
  }

  Future selectItemAllVacationFunction(
      {required VacationModel selectedVacation}) async {
    vacationController.setCurrentVacationVacation = selectedVacation;
    Get.to(SelectedVacationScreen(
      destination: destination,
    ));
  }

  Future selectItemAllSelectedVacationFunction(
      {required VacationModel selectedVacation}) async {
    if (!(vacationController.getAllSelectedVacations ?? [])
        .contains(selectedVacation)) {
      vacationController.setSelectedVacation = selectedVacation;
      selectedItems = vacationController.getAllSelectedVacations?.length ?? 0;
    } else {
      vacationController.removeItemFromSelectedVacations(selectedVacation);
      selectedItems = vacationController.getAllSelectedVacations?.length ?? 0;
    }
    print("all selected ${vacationController.getAllSelectedVacations?.length}");

    print("all controller ${vacationController.getAllVacations?.length}");

    // Get.to(SelectedVacationScreen(
    //   destination: destination,
    // ));
  }

  Future<void> getDataNowWithChanges() async {
    if (!(vacationController.getFilterLieu) &&
        !(vacationController.getFilterEvenements)) {
      await GBSystem_AuthService(context)
          .getAllVacationPlanning(
              isGetAll: true,
              evenementList: sitePlanningController.getAllEvenements ?? [],
              searchText: vacationController.getSearchText,
              sitePlanningList: sitePlanningController.getAllSites ?? [])
          .then((vacations) async {
        vacationController.setAllVacation = vacations;
        // filterVacationsWithDates();
      });
    } else {
      await GBSystem_AuthService(context)
          .getAllVacationPlanning(
              isGetAll: false,
              evenementList: vacationController.getFilterEvenements
                  ? vacationController.getAllFiltredEvenements ?? []
                  : [],
              searchText: vacationController.getSearchText,
              sitePlanningList: vacationController.getFilterLieu
                  ? vacationController.getAllFiltredLieu ?? []
                  : [])
          .then((vacations) async {
        vacationController.setAllVacation = vacations;
        // filterVacationsWithDates();
      });
    }
  }

  Future entrerFunction(BuildContext context) async {
    if (vacationController.getAllSelectedVacations != null &&
        vacationController.getAllSelectedVacations!.isNotEmpty) {
      // isLoading.value = true;
      print("ammmmmm ${vacationController.getAllSelectedVacations?.length}");
      await GBSystem_AuthService(context)
          .pointageEntrerSorieMultiple(
              Sens: GbsSystemServerStrings.str_pointage_entrer_sens,
              vacations: vacationController.getAllSelectedVacations ?? [])
          .then((infoEntrer) async {
        if (infoEntrer != null) {
          VacationModel myVacation = infoEntrer;
          vacationController.setVacationEntrer =
              myVacation.PNTGS_START_HOUR_IN!;
          vacationController.setCurrentVacationVacation = myVacation;
          // charger new data

          // await getDataNowWithChanges().then((vacations) async {
          //   vacationController.setAllVacation = vacations;
          // });

          // vider selected vacation
          viderSelectedItems();

          // isLoading.value = false;
          showSuccesDialog(
              context, GbsSystemStrings.str_pointage_entrer_succes);
        } else {
          // isLoading.value = false;
          showErrorDialog(context, GbsSystemStrings.str_mal_tourner);
        }
      }).catchError((e) async {
        isLoading.value = false;
        GBSystem_ManageCatchErrors().catchErrors(
          context,
          message: e.toString(),
          method: "entrerFunction",
          page: "GBSystem_user_entrer_sortie_controller",
        );
      });
    } else {
      showWarningDialog(context, GbsSystemStrings.str_aucune_vacation_selected);
    }
  }

  Future sortieFunction(BuildContext context) async {
    if (vacationController.getAllSelectedVacations != null &&
        vacationController.getAllSelectedVacations!.isNotEmpty) {
      // isLoading.value = true;

      await GBSystem_AuthService(context)
          .pointageEntrerSorieMultiple(
              Sens: GbsSystemServerStrings.str_pointage_sortie_sens,
              vacations: vacationController.getAllSelectedVacations ?? [])
          .then((infoSortie) async {
        if (infoSortie != null) {
          VacationModel myVacation = infoSortie;
          vacationController.setVacationSortie =
              myVacation.PNTGS_START_HOUR_OUT!;
          vacationController.setCurrentVacationVacation = myVacation;
          // charger new data
          // await getDataNowWithChanges().then((vacations) async {
          //   vacationController.setAllVacation = vacations;

          // });
          // vider selected vacation
          viderSelectedItems();

          // isLoading.value = false;
          showSuccesDialog(
              context, GbsSystemStrings.str_pointage_sortie_succes);
        } else {
          // isLoading.value = false;
          showErrorDialog(context, GbsSystemStrings.str_mal_tourner);
        }
      }).catchError((e) async {
        print(e);
        isLoading.value = false;
        GBSystem_ManageCatchErrors().catchErrors(
          context,
          message: e.toString(),
          method: "sortieFunction",
          page: "GBSystem_user_entrer_sortie_controller",
        );
      });
    } else {
      showWarningDialog(context, GbsSystemStrings.str_aucune_vacation_selected);
    }
  }

  Future<void> entrerFunctionSingle(BuildContext context,
      {required VacationModel currentVacation}) async {
//  test connexion
    isLoading.value = true;
    await GBSystem_AuthService(context)
        .pointageEntrerSorie(
            Sens: GbsSystemServerStrings.str_pointage_entrer_sens,
            vacation: currentVacation)
        .then((infoEntrer) async {
      if (infoEntrer != null) {
        VacationModel myVacation = infoEntrer;
        vacationController.setVacationEntrer = myVacation.PNTGS_START_HOUR_IN!;
        vacationController.setCurrentVacationVacation = myVacation;
        isLoading.value = false;

        currentVacation.PNTGS_IN_NBR = infoEntrer.PNTGS_IN_NBR;
        currentVacation.PNTGS_OUT_NBR = infoEntrer.PNTGS_OUT_NBR;
        currentVacation.PNTGS_START_HOUR_OUT = infoEntrer.PNTGS_START_HOUR_OUT;
        currentVacation.PNTGS_START_HOUR_IN = infoEntrer.PNTGS_START_HOUR_IN;
        currentVacation.PNTG_START_HOUR = infoEntrer.PNTG_START_HOUR;
        currentVacation.PNTG_END_HOUR = infoEntrer.PNTG_END_HOUR;

        showSuccesDialog(context, GbsSystemStrings.str_pointage_entrer_succes);
      } else {
        await internatController.initConnectivity();
        isLoading.value = false;

        if (internatController.isConnected) {
          showErrorDialog(context, GbsSystemStrings.str_mal_tourner);
        } else {
          // stocked locally
          // showWarningDialog(context,
          //     GbsSystemStrings.str_no_connexion_action_stocked_locally);
        }
      }
    }).catchError((e) async {
      isLoading.value = false;
      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "entrerFunction",
        page: "GBSystem_user_entrer_sortie_controller",
      );
    });
  }

  Future sortieFunctionSingle(BuildContext context,
      {required VacationModel currentVacation}) async {
    isLoading.value = true;

    await GBSystem_AuthService(context)
        .pointageEntrerSorie(
            Sens: GbsSystemServerStrings.str_pointage_sortie_sens,
            vacation: currentVacation)
        .then((infoSortie) async {
      // print('info $infoSortie');
      if (infoSortie != null) {
        VacationModel myVacation = infoSortie;
        vacationController.setVacationSortie = myVacation.PNTGS_START_HOUR_OUT!;
        vacationController.setCurrentVacationVacation = myVacation;
        isLoading.value = false;
        currentVacation.PNTGS_IN_NBR = infoSortie.PNTGS_IN_NBR;
        currentVacation.PNTGS_OUT_NBR = infoSortie.PNTGS_OUT_NBR;
        currentVacation.PNTGS_START_HOUR_OUT = infoSortie.PNTGS_START_HOUR_OUT;
        currentVacation.PNTGS_START_HOUR_IN = infoSortie.PNTGS_START_HOUR_IN;
        currentVacation.PNTG_START_HOUR = infoSortie.PNTG_START_HOUR;
        currentVacation.PNTG_END_HOUR = infoSortie.PNTG_END_HOUR;

        showSuccesDialog(context, GbsSystemStrings.str_pointage_sortie_succes);
      } else {
        await internatController.initConnectivity();
        isLoading.value = false;
        // showErrorDialog(context, GbsSystemStrings.str_mal_tourner);
        if (internatController.isConnected) {
          showErrorDialog(context, GbsSystemStrings.str_mal_tourner);
        } else {
          // stocked locally
          // showWarningDialog(context,
          //     GbsSystemStrings.str_no_connexion_action_stocked_locally);
        }
      }
    }).catchError((e) async {
      // print('err');
      isLoading.value = false;
      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "sortieFunction",
        page: "GBSystem_user_entrer_sortie_controller",
      );
    });
  }
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key, required this.updateUI}) : super(key: key);
  final Function updateUI;
  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  List<SitePlanningModel> allLieu = [];

  final List<bool> selectedLieu = [];

  List<SitePlanningModel> allEvenements = [];

  final List<bool> selectedEvenements = [];

  List<TimeOfDay> timeDebut = [];
  List<TimeOfDay> timeFin = [];
  bool isTimeDebut = false,
      isTimeFin = false,
      isLieu = false,
      isEvenement = false;
//
  List<TimeOfDay> timeDebutInitiale = [];
  List<TimeOfDay> timeFinInitiale = [];
  //
  RxBool isLoading = RxBool(false);
  final GBSystemVacationController vacationController =
      Get.put(GBSystemVacationController());
  final GBSystemSitesPlanningController sitePlanningController =
      Get.put(GBSystemSitesPlanningController());

  void initTimeDebutFin() {
    // on init debut and fin
    timeDebutInitiale = vacationController.getSelectedDebutFilter ?? [];
    timeFinInitiale = vacationController.getSelectedFinFilter ?? [];
    timeDebut = timeDebutInitiale;
    timeFin = timeFinInitiale;
    //

    List<TimeOfDay> tempDebut = [];

    List<TimeOfDay> tempFin = [];
    for (var i = 0;
        i < (vacationController.getAllVacations?.length ?? 0);
        i++) {
      tempDebut.add(vacationController.getAllVacations![i].HEURE_DEBUT);
    }
    vacationController.setFilterDateDebut = tempDebut;
    ///////////////////////
    for (var i = 0;
        i < (vacationController.getAllVacations?.length ?? 0);
        i++) {
      tempFin.add(vacationController.getAllVacations![i].HEURE_FIN);
    }
    vacationController.setFilterDateFin = tempFin;
  }

  void makeAllSelectedEvenemetsAs(bool value) {
    for (var i = 0; i < selectedEvenements.length; i++) {
      selectedEvenements[i] = value;
    }
  }

  void makeAllSelectedLieusAs(bool value) {
    for (var i = 0; i < selectedLieu.length; i++) {
      selectedLieu[i] = value;
    }
  }

  @override
  void initState() {
    //
    initTimeDebutFin();
    //

    isTimeDebut = vacationController.getFilterDebut;
    isTimeFin = vacationController.getFilterFin;
    isLieu = vacationController.getFilterLieu;
    isEvenement = vacationController.getFilterEvenements;

    allLieu = (vacationController.getAllLieu ?? []).toSet().toList();
    allLieu.forEach(
      (element) {
        print("filter lieuuuuu ${element.LIE_IDF}");
        selectedLieu.add(false);
      },
    );
    // init selected lieu if alrady exist

    (vacationController.getAllFiltredLieu ?? []).forEach(
      (element) {
        int indexElement = allLieu.indexOf(element);
        // element exists
        if (indexElement != -1) {
          selectedLieu[indexElement] = true;
        }
      },
    );

    for (var i = 0; i < selectedLieu.length; i++) {
      print("selected lieu debut ${selectedLieu[i]}");
    }
///////////////////////
// evenements
    allEvenements = (sitePlanningController.getAllEvenements ?? []).toList();
    allEvenements.forEach(
      (element) {
        selectedEvenements.add(false);
      },
    );
    // init selected lieu if alrady exist
    print("filteredd ${vacationController.getAllFiltredEvenements}");
    (vacationController.getAllFiltredEvenements ?? []).forEach(
      (element) {
        int indexElement = allEvenements.indexOf(element);
        // element exists
        if (indexElement != -1) {
          selectedEvenements[indexElement] = true;
        }
      },
    );

    for (var i = 0; i < selectedEvenements.length; i++) {
      print("selected Evenement debut ${selectedEvenements[i]}");
    }

    super.initState();
  }

  bool timeEquals(TimeOfDay a, TimeOfDay b) {
    return a.hour == b.hour && a.minute == b.minute;
  }

  List<TimeOfDay> removeDuplicate(List<TimeOfDay> times) {
    List<TimeOfDay> result = <TimeOfDay>[];
    for (var time in times) {
      if (!result.any(
        (t) => timeEquals(t, time),
      )) {
        result.add(time);
      }
    }
    return orderListTimes(result);
  }

  List<TimeOfDay> orderListTimes(List<TimeOfDay> times) {
    final sortedTimes = List<TimeOfDay>.from(times);
    sortedTimes.sort(
      (a, b) {
        final aMinutes = a.hour * 60 + a.minute;
        final bMinutes = b.hour * 60 + b.minute;
        return aMinutes.compareTo(bMinutes);
      },
    );
    return sortedTimes;
  }

  @override
  Widget build(BuildContext context) {
    final GBSystemSelectItemVacationController m = Get.put(
        GBSystemSelectItemVacationController(
            context: context, destination: Container(), updateUI: () {}));
    return Obx(
      () => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Text(
                          GbsSystemStrings.str_filtre,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 48), // Placeholder for alignment
                        IconButton(
                            icon: Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.delete_solid,
                                  size: 18,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  GbsSystemStrings.str_clear_filters,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              isLoading.value = true;

                              vacationController.setFilterDebutBool = false;
                              vacationController.setFilterFinBool = false;
                              vacationController.setFilterDateDebut = null;
                              vacationController.setFilterDateFin = null;

                              vacationController.setSelectedFilterDateDebut =
                                  null;
                              vacationController.setSelectedFilterDateFin =
                                  null;

                              vacationController.setAllFiltredLieu = null;
                              vacationController.setFilterLieuBool = false;
                              //  specific case
                              // vacationController.setAllFiltredEvenements =
                              //     sitePlanningController.getAllEvenements ?? [];
                              // vacationController.setFilterEvenementsBool = true;
                              // vider selected vacation
                              vacationController.setAllSelectedVacation = [];

                              m.selectedItems = 0;
                              m.isSelectAllChecked = false;
                              // widget.updateUI();
                              //

                              await GBSystem_AuthService(context)
                                  .getAllVacationPlanning(
                                      isGetAll: true,
                                      evenementList: sitePlanningController
                                              .getAllEvenements ??
                                          [],
                                      // vacationController
                                      //         .getAllFiltredEvenements ??
                                      //     [],
                                      searchText:
                                          vacationController.getSearchText,
                                      sitePlanningList:
                                          sitePlanningController.getAllSites ??
                                              [])
                                  .then((vacations) async {
                                vacationController.setAllVacation = vacations;
                              });
                              isLoading.value = false;

                              widget.updateUI();
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                  const Divider(thickness: 1, height: 1),
                  const SizedBox(height: 8),
                  // Categories Section
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExpansionTile(
                            title: Text(
                              GbsSystemStrings.str_evenement,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: SizedBox(
                              height: 15,
                              width: 15,
                              child: CupertinoCheckbox(
                                value: isEvenement,
                                activeColor:
                                    GbsSystemServerStrings.str_primary_color,
                                onChanged: (value) {
                                  setState(() {
                                    isEvenement = value ?? false;

                                    if (!(value ?? false)) {
                                      vacationController
                                          .setAllFiltredEvenements = null;

                                      makeAllSelectedEvenemetsAs(false);
                                    } else {
                                      makeAllSelectedEvenemetsAs(true);
                                    }
                                  });
                                },
                              ),
                            ),
                            children:
                                allEvenements.asMap().entries.map((entry) {
                              final index = entry.key;
                              final brand = entry.value;
                              return CheckboxListTile(
                                value: selectedEvenements[index],
                                onChanged: (value) {
                                  setState(() {
                                    selectedEvenements[index] = value ?? false;
                                  });
                                  if (selectedEvenements.contains(true)) {
                                    setState(() {
                                      isEvenement = true;
                                    });
                                  } else {
                                    setState(() {
                                      isEvenement = false;
                                    });
                                  }
                                },
                                title: Text(
                                    "${brand.LIE_CODE} | ${brand.LIE_LIB}"),
                                activeColor:
                                    GbsSystemServerStrings.str_primary_color,
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          ExpansionTile(
                            title: Text(
                              GbsSystemStrings.str_lieu,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: SizedBox(
                              height: 15,
                              width: 15,
                              child: CupertinoCheckbox(
                                value: isLieu,
                                activeColor:
                                    GbsSystemServerStrings.str_primary_color,
                                onChanged: (value) {
                                  setState(() {
                                    isLieu = value ?? false;
                                    // if (!(value ?? false)) {
                                    //   vacationController.setAllFiltredLieu =
                                    //       null;
                                    // }
                                    if (!(value ?? false)) {
                                      vacationController.setAllFiltredLieu =
                                          null;

                                      makeAllSelectedLieusAs(false);
                                    } else {
                                      makeAllSelectedLieusAs(true);
                                    }
                                  });
                                },
                              ),
                            ),
                            children: allLieu.asMap().entries.map((entry) {
                              final index = entry.key;
                              final brand = entry.value;
                              return CheckboxListTile(
                                value: selectedLieu[index],
                                onChanged: (value) {
                                  setState(() {
                                    selectedLieu[index] = value ?? false;
                                  });
                                  if (selectedLieu.contains(true)) {
                                    setState(() {
                                      isLieu = true;
                                    });
                                  } else {
                                    setState(() {
                                      isLieu = false;
                                    });
                                  }
                                },
                                title: Text(
                                    '${brand.LIE_CODE} | ${brand.LIE_LIB}'),
                                activeColor:
                                    GbsSystemServerStrings.str_primary_color,
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          ExpansionTile(
                            title: Text(
                              GbsSystemStrings.str_hour_debut,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: SizedBox(
                              height: 15,
                              width: 15,
                              child: CupertinoCheckbox(
                                value: isTimeDebut,
                                activeColor:
                                    GbsSystemServerStrings.str_primary_color,
                                onChanged: (value) {
                                  setState(() {
                                    isTimeDebut = value ?? false;

                                    if (!(value ?? false)) {
                                      setState(() {
                                        timeDebut = [];
                                        timeDebutInitiale = timeDebut;
                                      });
                                    } else {
                                      setState(() {
                                        timeDebut =
                                            vacationController.getDebutFilter ??
                                                [];
                                        timeDebutInitiale = timeDebut;
                                      });
                                    }
                                  });
                                },
                              ),
                            ),
                            children: [
                              Material(
                                child: MultiSelectChipField<TimeOfDay?>(
                                  items: removeDuplicate((vacationController
                                                  .getDebutFilter !=
                                              null
                                          ? vacationController.getDebutFilter
                                          : [])!)
                                      .map((date) => MultiSelectItem<
                                              TimeOfDay?>(date,
                                          "${ConvertDateService.Add_zero(date.hour)} : ${ConvertDateService.Add_zero(date.minute)}"))
                                      .toList(),
                                  initialValue: timeDebutInitiale,
                                  title: Text(GbsSystemStrings.str_hour_debut),
                                  headerColor: GbsSystemServerStrings
                                      .str_primary_color
                                      .withOpacity(0.5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: GbsSystemServerStrings
                                            .str_primary_color,
                                        width: 1.8),
                                  ),
                                  selectedChipColor: GbsSystemServerStrings
                                      .str_primary_color
                                      .withOpacity(0.5),
                                  selectedTextStyle: TextStyle(
                                      color: GbsSystemServerStrings
                                          .str_primary_color),
                                  onTap: (List<TimeOfDay?>? values) {
                                    if (values != null) {
                                      timeDebut = [];
                                      values.forEach(
                                        (element) => timeDebut.add(element!),
                                      );
                                    } else {
                                      timeDebut = [];
                                    }
                                    setState(() {
                                      timeDebutInitiale = timeDebut;
                                    });
                                    // controll check box debut
                                    if (timeDebut.isNotEmpty) {
                                      setState(() {
                                        isTimeDebut = true;
                                      });
                                    } else {
                                      setState(() {
                                        isTimeDebut = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ExpansionTile(
                            title: Text(
                              GbsSystemStrings.str_hour_fin,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: SizedBox(
                              height: 15,
                              width: 15,
                              child: CupertinoCheckbox(
                                value: isTimeFin,
                                activeColor:
                                    GbsSystemServerStrings.str_primary_color,
                                onChanged: (value) {
                                  setState(() {
                                    isTimeFin = value ?? false;
                                    if (!(value ?? false)) {
                                      setState(() {
                                        timeFin = [];
                                        timeFinInitiale = timeFin;
                                      });
                                    } else {
                                      setState(() {
                                        timeFin =
                                            vacationController.getFinFilter ??
                                                [];
                                        timeFinInitiale = timeFin;
                                      });
                                    }
                                  });
                                },
                              ),
                            ),
                            children: [
                              Material(
                                child: MultiSelectChipField<TimeOfDay?>(
                                  items: removeDuplicate(
                                          (vacationController.getFinFilter !=
                                                  null
                                              ? vacationController.getFinFilter
                                              : [])!)
                                      .map((date) => MultiSelectItem<
                                              TimeOfDay?>(date,
                                          "${ConvertDateService.Add_zero(date.hour)} : ${ConvertDateService.Add_zero(date.minute)}"))
                                      .toList(),
                                  initialValue: timeFinInitiale,
                                  title: Text(GbsSystemStrings.str_hour_fin),
                                  headerColor: GbsSystemServerStrings
                                      .str_primary_color
                                      .withOpacity(0.5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: GbsSystemServerStrings
                                            .str_primary_color,
                                        width: 1.8),
                                  ),
                                  selectedChipColor: GbsSystemServerStrings
                                      .str_primary_color
                                      .withOpacity(0.5),
                                  selectedTextStyle: TextStyle(
                                      color: GbsSystemServerStrings
                                          .str_primary_color),
                                  onTap: (List<TimeOfDay?>? values) {
                                    if (values != null) {
                                      timeFin = [];
                                      values.forEach(
                                        (element) => timeFin.add(element!),
                                      );
                                    } else {
                                      timeFin = [];
                                    }
                                    setState(() {
                                      timeFinInitiale = timeFin;
                                    });
                                    // controll check box debut
                                    if (timeFin.isNotEmpty) {
                                      setState(() {
                                        isTimeFin = true;
                                      });
                                    } else {
                                      setState(() {
                                        isTimeFin = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  // Apply Button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        isLoading.value = true;

                        vacationController.setFilterDebutBool = isTimeDebut;

                        vacationController.setFilterDateDebut = timeDebut;
                        vacationController.setFilterDateFin = timeFin;

                        vacationController.setSelectedFilterDateDebut =
                            timeDebut;
                        vacationController.setSelectedFilterDateFin = timeFin;

                        vacationController.setFilterFinBool = isTimeFin;
                        vacationController.setFilterLieuBool = isLieu;
                        vacationController.setFilterEvenementsBool =
                            isEvenement;

                        List<SitePlanningModel> filtredEvenements = [];
                        List<SitePlanningModel> filtredLieu = [];
                        if (isEvenement) {
                          for (var i = 0; i < selectedEvenements.length; i++) {
                            if (selectedEvenements[i]) {
                              filtredEvenements.add(allEvenements[i]);
                            }
                          }

                          vacationController.setAllFiltredEvenements =
                              filtredEvenements;
                        }
                        if (isLieu) {
                          for (var i = 0; i < selectedLieu.length; i++) {
                            if (selectedLieu[i]) {
                              filtredLieu.add(allLieu[i]);
                            }
                          }

                          vacationController.setAllFiltredLieu = filtredLieu;
                        }
                        if ((!isLieu) && (!isEvenement)) {
                          await GBSystem_AuthService(context)
                              .getAllVacationPlanning(
                                  isGetAll: true,
                                  evenementList:
                                      sitePlanningController.getAllEvenements ??
                                          [],
                                  searchText: vacationController.getSearchText,
                                  sitePlanningList:
                                      sitePlanningController.getAllSites ?? [])
                              .then((vacations) async {
                            vacationController.setAllVacation = vacations;
                            // filterVacationsWithDates();
                          });
                        } else {
                          await GBSystem_AuthService(context)
                              .getAllVacationPlanning(
                                  isGetAll: false,
                                  evenementList:
                                      vacationController.getFilterEvenements
                                          ? vacationController
                                                  .getAllFiltredEvenements ??
                                              []
                                          : [],
                                  searchText: vacationController.getSearchText,
                                  sitePlanningList: vacationController
                                          .getFilterLieu
                                      ? vacationController.getAllFiltredLieu ??
                                          []
                                      : [])
                              .then((vacations) async {
                            vacationController.setAllVacation = vacations;
                            // filterVacationsWithDates();
                          });
                        }

                        // vider selected vacation
                        vacationController.setAllSelectedVacation = [];
                        m.selectedItems = 0;
                        m.isSelectAllChecked = false;
                        //
                        isLoading.value = false;

                        widget.updateUI();

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor:
                            GbsSystemServerStrings.str_primary_color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        GbsSystemStrings.str_apply_filter,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          isLoading.value ? Waiting() : Container()
        ],
      ),
    );
  }

  bool compareTwoTime(TimeOfDay time, DateTime date, bool isGreat) {
    if (isGreat) {
      if (time.hour > date.hour) {
        return true;
      } else if (time.hour == date.hour && time.minute >= date.minute) {
        return true;
      } else {
        return false;
      }
    } else {
      if (time.hour < date.hour) {
        return true;
      } else if (time.hour == date.hour && time.minute <= date.minute) {
        return true;
      } else {
        return false;
      }
    }
  }

  bool isTimeEqual(TimeOfDay time, DateTime date, bool isGreat) {
    return time.hour == date.hour && time.minute == date.minute;
  }

  // void filterVacationsWithDates() {
  //   List<VacationModel> tempList = vacationController.getAllVacations ?? [];

  //   // interval ==> selected date debut <debut+fin< selected date fin
  //   if (vacationController.getFilterDebut && vacationController.getFilterFin) {
  //     vacationController.setAllVacation = tempList.where(
  //       (element) {
  //         print(
  //             "intervale ${checkDateInIntervale(element.HEURE_DEBUT, vacationController.getDebutFilter ?? DateTime.now(), vacationController.getFinFilter ?? DateTime.now()) && checkDateInIntervale(element.HEURE_FIN, vacationController.getDebutFilter ?? DateTime.now(), vacationController.getFinFilter ?? DateTime.now())}");
  //         return checkDateInIntervale(
  //                 element.HEURE_DEBUT,
  //                 vacationController.getDebutFilter ?? DateTime.now(),
  //                 vacationController.getFinFilter ?? DateTime.now()) &&
  //             checkDateInIntervale(
  //                 element.HEURE_FIN,
  //                 vacationController.getDebutFilter ?? DateTime.now(),
  //                 vacationController.getFinFilter ?? DateTime.now());
  //       },
  //     ).toList();
  //   }

  //   // filter debut ==
  //   else if (vacationController.getFilterDebut) {
  //     print("debuuuuuuuut");
  //     vacationController.setAllVacation = tempList.where(
  //       (element) {
  //         return element.HEURE_DEBUT.hour ==
  //                 vacationController.getDebutFilter?.hour &&
  //             element.HEURE_DEBUT.minute ==
  //                 vacationController.getDebutFilter?.minute;
  //       },
  //     ).toList();
  //   }
  //   // filter fin ==
  //   else if (vacationController.getFilterFin) {
  //     vacationController.setAllVacation = tempList.where(
  //       (element) {
  //         return element.HEURE_FIN.hour ==
  //                 vacationController.getFinFilter?.hour &&
  //             element.HEURE_FIN.minute ==
  //                 vacationController.getFinFilter?.minute;
  //       },
  //     ).toList();
  //   }
  //   print("old vacs : ${tempList.length}");
  //   print("new vacs : ${vacationController.getAllVacations?.length}");
  // }

  bool checkDateInIntervale(
    TimeOfDay myDate,
    DateTime debut,
    DateTime fin,
  ) {
    print(
        "myDate ${myDate.hour}:${myDate.minute} , debut : ${debut.hour}:${debut.minute} , fin : ${fin.hour}:${fin.minute}");
    bool firstCond = false, secondCond = false;
// first cond : myTime supperrieur a debut time
    if (myDate.hour > debut.hour) {
      firstCond = true;
    } else if (myDate.hour == debut.hour) {
      if (myDate.minute >= debut.minute) {
        firstCond = true;
      }
    }

// second cond : myTime inferieur a fin time
    if (myDate.hour < fin.hour) {
      secondCond = true;
    } else if (myDate.hour == fin.hour) {
      if (myDate.minute <= fin.minute) {
        secondCond = true;
      }
    }
    print("first $firstCond");
    print("second $secondCond");
    print(firstCond && secondCond);
    print("----------------------");
    return firstCond && secondCond;
  }
}
