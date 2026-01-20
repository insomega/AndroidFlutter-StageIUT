import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_convert_date_service.dart';
import 'package:gbsystem_root/GBSystem_site_planning_model.dart';
import 'package:gbsystem_root/GBSystem_waiting.dart';
import 'package:gbsystem_vacation_priseservice/GBSystem_Vacation_Informations_Controller.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'GBSystem_sites_planning_controller.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'GBSystem_Vacation_List_PS2_Controller.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

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
  bool isTimeDebut = false, isTimeFin = false, isLieu = false, isEvenement = false;
  //
  List<TimeOfDay> timeDebutInitiale = [];
  List<TimeOfDay> timeFinInitiale = [];
  //

  final GBSystem_Vacation_Informations_Controller vacationController = Get.put(GBSystem_Vacation_Informations_Controller());
  final GBSystemSitesPlanningController sitePlanningController = Get.put(GBSystemSitesPlanningController());

  void initTimeDebutFin() {
    // on init debut and fin
    timeDebutInitiale = vacationController.getSelectedDebutFilter ?? [];
    timeFinInitiale = vacationController.getSelectedFinFilter ?? [];
    timeDebut = timeDebutInitiale;
    timeFin = timeFinInitiale;
    //

    List<TimeOfDay> tempDebut = [];

    List<TimeOfDay> tempFin = [];
    for (var i = 0; i < (vacationController.getAllVacations?.length ?? 0); i++) {
      tempDebut.add(vacationController.getAllVacations![i].HEURE_DEBUT);
    }
    vacationController.setFilterDateDebut = tempDebut;
    ///////////////////////
    for (var i = 0; i < (vacationController.getAllVacations?.length ?? 0); i++) {
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
    vacationController.extractDistinctEvenements();
    vacationController.extractDistinctSites();

    //
    isTimeDebut = vacationController.getFilterDebut;
    isTimeFin = vacationController.getFilterFin;
    isLieu = vacationController.getFilterLieu;
    isEvenement = vacationController.getFilterEvenements;

    allLieu = (vacationController.getAllLieu ?? []).toSet().toList();
    allLieu.forEach((element) {
      print("filter lieuuuuu ${element.LIE_IDF}");
      selectedLieu.add(false);
    });
    // init selected lieu if alrady exist

    (vacationController.getAllFiltredLieu ?? []).forEach((element) {
      int indexElement = allLieu.indexOf(element);
      // element exists
      if (indexElement != -1) {
        selectedLieu[indexElement] = true;
      }
    });

    for (var i = 0; i < selectedLieu.length; i++) {
      print("selected lieu debut ${selectedLieu[i]}");
    }
    ///////////////////////
    // evenements
    // allEvenements = (vacationController.getAllEvenement ?? []).toList();
    // allEvenements.forEach((element) {
    //   selectedEvenements.add(false);
    // });

    allEvenements = (vacationController.getAllEvenement ?? []).toSet().toList();
    allEvenements.forEach((element) {
      print("filter EVT ${element.EVT_IDF}");
      selectedEvenements.add(false);
    });

    // init selected lieu if alrady exist
    print("filteredd ${vacationController.getAllFiltredEvenements}");

    (vacationController.getAllFiltredEvenements ?? []).forEach((element) {
      int indexElement = allEvenements.indexOf(element);
      // element exists
      if (indexElement != -1) {
        selectedEvenements[indexElement] = true;
      }
    });

    // for (var i = 0; i < selectedEvenements.length; i++) {
    //   print("selected Evenement debut ${selectedEvenements[i]}");
    // }

    super.initState();
  }

  bool timeEquals(TimeOfDay a, TimeOfDay b) {
    return a.hour == b.hour && a.minute == b.minute;
  }

  List<TimeOfDay> removeDuplicate(List<TimeOfDay> times) {
    List<TimeOfDay> result = <TimeOfDay>[];
    for (var time in times) {
      if (!result.any((t) => timeEquals(t, time))) {
        result.add(time);
      }
    }
    return orderListTimes(result);
  }

  List<TimeOfDay> orderListTimes(List<TimeOfDay> times) {
    final sortedTimes = List<TimeOfDay>.from(times);
    sortedTimes.sort((a, b) {
      final aMinutes = a.hour * 60 + a.minute;
      final bMinutes = b.hour * 60 + b.minute;
      return aMinutes.compareTo(bMinutes);
    });
    return sortedTimes;
  }

  @override
  Widget build(BuildContext context) {
    final GBSystem_Vacation_List_PS2_Controller m = Get.put(GBSystem_Vacation_List_PS2_Controller());
    return Obx(
      () => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(icon: const Icon(Icons.close), onPressed: () => Get.back()), // Navigator.pop(context)),
                        const Text(GBSystem_Application_Strings.str_filtre, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 48), // Placeholder for alignment
                        IconButton(
                          icon: Row(
                            children: [
                              const Icon(CupertinoIcons.delete_solid, size: 18, color: Colors.red),
                              const SizedBox(width: 5),
                              const Text(
                                GBSystem_Application_Strings.str_clear_filters,
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            m.isLoading.value = true;

                            vacationController.setFilterDebutBool = false;
                            vacationController.setFilterFinBool = false;
                            vacationController.setFilterDateDebut = null;
                            vacationController.setFilterDateFin = null;

                            vacationController.setSelectedFilterDateDebut = null;
                            vacationController.setSelectedFilterDateFin = null;

                            vacationController.setAllFiltredLieu = null;
                            vacationController.setFilterLieuBool = false;

                            vacationController.setAllSelectedVacation = [];

                            m.selectedItems.value = 0;
                            m.isSelectAllChecked.value = false;

                            // await GBSystem_AuthService(context)
                            //     .getAllVacationPlanning(
                            //         isGetAll: true,
                            //         evenementList: sitePlanningController
                            //                 .getAllEvenements ??
                            //             [],
                            //         // vacationController
                            //         //         .getAllFiltredEvenements ??
                            //         //     [],
                            //         searchText:
                            //             vacationController.getSearchText,
                            //         sitePlanningList:
                            //             sitePlanningController.getAllSites ??
                            //                 [])
                            //     .then((vacations) async {
                            //   vacationController.setAllVacation = vacations;
                            // });
                            m.refreshUsedListVacation();
                            m.isLoading.value = false;

                            //widget.updateUI();
                            //Navigator.pop(context);
                            Get.back();
                          },
                        ),
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
                            title: Text(GBSystem_Application_Strings.str_evenement, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            leading: SizedBox(
                              height: 15,
                              width: 15,
                              child: CupertinoCheckbox(
                                value: isEvenement,
                                activeColor: GBSystem_Application_Strings.str_primary_color,
                                onChanged: (value) {
                                  setState(() {
                                    isEvenement = value ?? false;

                                    if (!(value ?? false)) {
                                      vacationController.setAllFiltredEvenements = null;

                                      makeAllSelectedEvenemetsAs(false);
                                    } else {
                                      makeAllSelectedEvenemetsAs(true);
                                    }
                                  });
                                },
                              ),
                            ),
                            children: allEvenements.asMap().entries.map((entry) {
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
                                title: Text("${brand.LIE_CODE} | ${brand.LIE_LIB}"),
                                activeColor: GBSystem_Application_Strings.str_primary_color,
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          ExpansionTile(
                            title: Text(GBSystem_Application_Strings.str_lieu, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            leading: SizedBox(
                              height: 15,
                              width: 15,
                              child: CupertinoCheckbox(
                                value: isLieu,
                                activeColor: GBSystem_Application_Strings.str_primary_color,
                                onChanged: (value) {
                                  setState(() {
                                    isLieu = value ?? false;
                                    // if (!(value ?? false)) {
                                    //   vacationController.setAllFiltredLieu =
                                    //       null;
                                    // }
                                    if (!(value ?? false)) {
                                      vacationController.setAllFiltredLieu = null;

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
                                title: Text('${brand.LIE_CODE} | ${brand.LIE_LIB}'),
                                activeColor: GBSystem_Application_Strings.str_primary_color,
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          ExpansionTile(
                            title: Text(GBSystem_Application_Strings.str_hour_debut, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            leading: SizedBox(
                              height: 15,
                              width: 15,
                              child: CupertinoCheckbox(
                                value: isTimeDebut,
                                activeColor: GBSystem_Application_Strings.str_primary_color,
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
                                        timeDebut = vacationController.getDebutFilter ?? [];
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
                                  items: removeDuplicate((vacationController.getDebutFilter != null ? vacationController.getDebutFilter : [])!).map((date) => MultiSelectItem<TimeOfDay?>(date, "${GBSystem_convert_date_service.Add_zero(date.hour)} : ${GBSystem_convert_date_service.Add_zero(date.minute)}")).toList(),
                                  initialValue: timeDebutInitiale,
                                  title: Text(GBSystem_Application_Strings.str_hour_debut),
                                  headerColor: GBSystem_Application_Strings.str_primary_color.withOpacity(0.5),
                                  decoration: BoxDecoration(border: Border.all(color: GBSystem_Application_Strings.str_primary_color, width: 1.8)),
                                  selectedChipColor: GBSystem_Application_Strings.str_primary_color.withOpacity(0.5),
                                  selectedTextStyle: TextStyle(color: GBSystem_Application_Strings.str_primary_color),
                                  onTap: (List<TimeOfDay?>? values) {
                                    if (values != null) {
                                      timeDebut = [];
                                      values.forEach((element) => timeDebut.add(element!));
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
                            title: Text(GBSystem_Application_Strings.str_hour_fin, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            leading: SizedBox(
                              height: 15,
                              width: 15,
                              child: CupertinoCheckbox(
                                value: isTimeFin,
                                activeColor: GBSystem_Application_Strings.str_primary_color,
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
                                        timeFin = vacationController.getFinFilter ?? [];
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
                                  items: removeDuplicate((vacationController.getFinFilter != null ? vacationController.getFinFilter : [])!).map((date) => MultiSelectItem<TimeOfDay?>(date, "${GBSystem_convert_date_service.Add_zero(date.hour)} : ${GBSystem_convert_date_service.Add_zero(date.minute)}")).toList(),
                                  initialValue: timeFinInitiale,
                                  title: Text(GBSystem_Application_Strings.str_hour_fin),
                                  headerColor: GBSystem_Application_Strings.str_primary_color.withOpacity(0.5),
                                  decoration: BoxDecoration(border: Border.all(color: GBSystem_Application_Strings.str_primary_color, width: 1.8)),
                                  selectedChipColor: GBSystem_Application_Strings.str_primary_color.withOpacity(0.5),
                                  selectedTextStyle: TextStyle(color: GBSystem_Application_Strings.str_primary_color),
                                  onTap: (List<TimeOfDay?>? values) {
                                    if (values != null) {
                                      timeFin = [];
                                      values.forEach((element) => timeFin.add(element!));
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
                        m.isLoading.value = true;

                        vacationController.setFilterDebutBool = isTimeDebut;

                        vacationController.setFilterDateDebut = timeDebut;
                        vacationController.setFilterDateFin = timeFin;

                        vacationController.setSelectedFilterDateDebut = timeDebut;
                        vacationController.setSelectedFilterDateFin = timeFin;

                        vacationController.setFilterFinBool = isTimeFin;
                        vacationController.setFilterLieuBool = isLieu;
                        vacationController.setFilterEvenementsBool = isEvenement;

                        List<SitePlanningModel> filtredEvenements = [];
                        List<SitePlanningModel> filtredLieu = [];
                        if (isEvenement) {
                          for (var i = 0; i < selectedEvenements.length; i++) {
                            if (selectedEvenements[i]) {
                              filtredEvenements.add(allEvenements[i]);
                            }
                          }

                          vacationController.setAllFiltredEvenements = filtredEvenements;
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
                          // await GBSystem_AuthService(context)
                          //     .getAllVacationPlanning(
                          //         isGetAll: true,
                          //         evenementList:
                          //             sitePlanningController.getAllEvenements ??
                          //                 [],
                          //         searchText: vacationController.getSearchText,
                          //         sitePlanningList:
                          //             sitePlanningController.getAllSites ?? [])
                          //     .then((vacations) async {
                          //   vacationController.setAllVacation = vacations;
                          //   // filterVacationsWithDates();
                          // });
                        } else {
                          // await GBSystem_AuthService(context)
                          //     .getAllVacationPlanning(
                          //         isGetAll: false,
                          //         evenementList:
                          //             vacationController.getFilterEvenements
                          //                 ? vacationController
                          //                         .getAllFiltredEvenements ??
                          //                     []
                          //                 : [],
                          //         searchText: vacationController.getSearchText,
                          //         sitePlanningList: vacationController
                          //                 .getFilterLieu
                          //             ? vacationController.getAllFiltredLieu ??
                          //                 []
                          //             : [])
                          //     .then((vacations) async {
                          //   vacationController.setAllVacation = vacations;
                          //   // filterVacationsWithDates();
                          // });
                        }

                        // vider selected vacation
                        vacationController.setAllSelectedVacation = [];
                        m.selectedItems.value = 0;
                        m.isSelectAllChecked.value = false;
                        m.refreshUsedListVacation();
                        //
                        m.isLoading.value = false;

                        //widget.updateUI();

                        //Navigator.pop(context);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: GBSystem_Application_Strings.str_primary_color,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text(GBSystem_Application_Strings.str_apply_filter, style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          m.isLoading.value ? Waiting() : Container(),
        ],
      ),
    );
  }
}
