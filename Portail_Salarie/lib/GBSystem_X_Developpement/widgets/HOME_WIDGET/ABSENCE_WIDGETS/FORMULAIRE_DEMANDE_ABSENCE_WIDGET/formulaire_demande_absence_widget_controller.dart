import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_compteur_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_type_absence_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_shift_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_absence_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_compteur_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_type_absence_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_date_picker.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/TYPE_ABSENCE_DISPLAY_DATA_WIDGET/type_absence_display_data_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class FormulaireDemandeAbsenceWidgetController extends GetxController {
  FormulaireDemandeAbsenceWidgetController(
    this.context,
  );

  BuildContext context;
  Rx<bool> enabledDateDebutFin = RxBool(false);

  Rx<DateTime?> dateDebut = Rx<DateTime?>(null);
  Rx<DateTime?> dateFin = Rx<DateTime?>(null);

  Rx<PlatformFile?> file = Rx<PlatformFile?>(null);
  Rx<Color?> typeAbsColor = Rx<Color?>(GbsSystemStrings.str_primary_color);

  final typeAbsenceController =
      Get.put<GBSystemTypeAbsenceController>(GBSystemTypeAbsenceController());
  final compteurController =
      Get.put<GBSystemCompteurController>(GBSystemCompteurController());

  final vacaionShiftController = Get.put<GBSystemVacationShiftController>(
      GBSystemVacationShiftController());

  CompteurModel? compteurModel;
  PageController pageController = PageController(initialPage: 0);
  RxInt currentPageIndex = 0.obs;
  Rx<TextEditingController> controllerAbsence = TextEditingController().obs;
  TextEditingController controllerComment = TextEditingController();
  Rx<TextEditingController> controllerDuree = TextEditingController().obs;

  List<TypeAbsenceModel> getListParentsTypsAbsences(
      List<TypeAbsenceModel> listTypsAbsences) {
    List<TypeAbsenceModel> listParents = [];
    for (var i = 0; i < listTypsAbsences.length; i++) {
      if (listTypsAbsences[i].PTPH_IDF == null ||
          listTypsAbsences[i].PTPH_IDF!.isEmpty) {
        listParents.add(listTypsAbsences[i]);
      }
    }

    return listParents;
  }

  bool verifierHasChildren(TypeAbsenceModel selectedTypeAbsence,
      List<TypeAbsenceModel> allTypeAbsences) {
    bool hasChildren = false;
    for (var i = 0; i < allTypeAbsences.length; i++) {
      if (allTypeAbsences[i].PTPH_IDF == selectedTypeAbsence.TPH_IDF) {
        hasChildren = true;
      }
    }

    return hasChildren;
  }

  int getNumberChildren(TypeAbsenceModel selectedTypeAbsence,
      List<TypeAbsenceModel> allTypeAbsences) {
    int nb = 0;
    if (verifierHasChildren(selectedTypeAbsence, allTypeAbsences)) {
      for (var i = 0; i < allTypeAbsences.length; i++) {
        if (allTypeAbsences[i].PTPH_IDF == selectedTypeAbsence.TPH_IDF) {
          nb++;
        }
      }
    }

    return nb;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    if (typeAbsenceController.getAllTypeAbsences != null &&
        typeAbsenceController.getAllTypeAbsences!.isNotEmpty) {
      controllerAbsence.value.text =
          typeAbsenceController.getAllTypeAbsences!.first.TPH_LIB;
      final hexColor = typeAbsenceController.getAllTypeAbsences!.first.CLR_CODE
          .replaceAll(r"#", "")
          .replaceAll(r"$", "");
      final color = Color(int.parse(
        '0xFF$hexColor',
      ));

      typeAbsColor.value = color;
    }
    compteurModel = compteurController.getCompteur;
    super.onInit();
  }

  Future<void> showDialogCompteurInfoSimple2(
      {required BuildContext context,
      required CompteurModel compteurModel}) async {
    // Capture the context before it's disposed
    BuildContext dialogContext = context;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: dialogContext,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              backgroundColor:
                  GbsSystemStrings.str_primary_color.withOpacity(0.85),
              content: Stack(
                clipBehavior: Clip.none,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    // onPageChanged: (index) {
                    //   currentPageIndex.value = index;
                    // },
                    // controller: pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return TypeAbsenceDisplayDataWidget(
                        atr1: (index == 0
                                ? compteurModel.SABSD_CP_ACQUIS
                                : index == 1
                                    ? compteurModel.SABSD_RC_ACQUIS
                                    : compteurModel.SABSD_RTT_ACQUIS) ??
                            "",
                        name: (index == 0
                                ? compteurModel.TPH_CODE_CP
                                : index == 1
                                    ? compteurModel.TPH_CODE_RC
                                    : compteurModel.TPH_CODE_RTT) ??
                            "",
                        atr2: (index == 0
                                ? compteurModel.SABSD_CP_PRIS
                                : index == 1
                                    ? compteurModel.SABSD_RC_PRIS
                                    : compteurModel.SABSD_RTT_PRIS) ??
                            "",
                        atr22: (index == 0
                                ? compteurModel.CET_EN_COURS_CP
                                : index == 1
                                    ? compteurModel.CET_EN_COURS_RC
                                    : compteurModel.CET_EN_COURS_RTT) ??
                            "",
                        atr3: (index == 0
                                ? compteurModel.CPJOUR
                                : index == 1
                                    ? compteurModel.RCJOUR
                                    : compteurModel.RTTJOUR) ??
                            "",
                        atr4: (index == 0
                                ? compteurModel.CP_DEM
                                : index == 1
                                    ? compteurModel.RC_DEM
                                    : "") ??
                            "",
                        atr5: (index == 0
                                ? compteurModel.CP_REST
                                : index == 1
                                    ? compteurModel.RC_REST
                                    : compteurModel.RTT_REST) ??
                            "",
                      );
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //         "${GbsSystemStrings.demander_acquis.tr} :  ${compteurModel.CET_EN_COURS_CP}"),
                      //     Text(
                      //         "CET_EN_COURS_RC :  ${compteurModel.CET_EN_COURS_RC}"),
                      //     Text(
                      //         "CET_EN_COURS_RTT :  ${compteurModel.CET_EN_COURS_RTT}"),
                      //     Text("CET_RACHAT :  ${compteurModel.CET_RACHAT}"),
                      //     Text(
                      //         "CET_RACHAT_EN_COURS :  ${compteurModel.CET_RACHAT_EN_COURS}"),
                      //     Text("CPJOUR :  ${compteurModel.CPJOUR}"),
                      //     Text("CP_REST :  ${compteurModel.CP_REST}"),
                      //     Text(
                      //         "END_DATE_CP_CALC :  ${compteurModel.END_DATE_CP_CALC}"),
                      //   ],
                      // );
                    },
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(CupertinoIcons.multiply, color: Colors.white),
                    ),
                  )
                ],
              ),
              actions: [],
            ),
          );
        },
      );
    });
  }

  Future<void> showDialogCompteurInfoSimple(
      {required BuildContext context,
      required CompteurModel compteurModel}) async {
    // Capture the context before it's disposed
    BuildContext dialogContext = context;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: dialogContext,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              backgroundColor:
                  GbsSystemStrings.str_primary_color.withOpacity(0.85),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${GbsSystemStrings.demander_acquis.tr} :  ${compteurModel.CET_EN_COURS_CP}"),
                  Text("CET_EN_COURS_RC :  ${compteurModel.CET_EN_COURS_RC}"),
                  Text("CET_EN_COURS_RTT :  ${compteurModel.CET_EN_COURS_RTT}"),
                  Text("CET_RACHAT :  ${compteurModel.CET_RACHAT}"),
                  Text(
                      "CET_RACHAT_EN_COURS :  ${compteurModel.CET_RACHAT_EN_COURS}"),
                  Text("CPJOUR :  ${compteurModel.CPJOUR}"),
                  Text("CP_REST :  ${compteurModel.CP_REST}"),
                  Text("END_DATE_CP_CALC :  ${compteurModel.END_DATE_CP_CALC}"),
                ],
              ),
              actions: [],
            ),
          );
        },
      );
    });
  }

  Future<void> showDialogVacationsShift(
      {required TypeAbsenceModel typeAbsenceModel,
      required BuildContext context}) async {
    // Capture the context before it's disposed
    BuildContext dialogContext = context;
    DateTime selectedDate = DateTime.now();
    bool showVacations = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: dialogContext,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),

                // backgroundColor: GbsSystemStrings.str_primary_color.withOpacity(0.85),
                backgroundColor: Colors.white,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomDatePicker(
                            // color: Colors.white,
                            selectedDate: selectedDate,
                            initialDate: selectedDate,
                            onDateSelected: (p0) {
                              setState(() {
                                selectedDate = p0;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomButton(
                            onTap: () async {
                              await GBSystem_AuthService(context)
                                  .getListVacationsShift(
                                      TPH_IDF: typeAbsenceModel.TPH_IDF,
                                      //   RC_REST: compteur.RC_REST,
                                      selectedDate: selectedDate)
                                  .then((value) {
                                // print("list vacs shit : $value");

                                vacaionShiftController.setAllVacationShift =
                                    value;

                                if (value != null && value.isNotEmpty) {
                                  vacaionShiftController
                                      .setCurrentVacationShift = value.first;
                                }

                                setState(
                                  () {
                                    showVacations = true;
                                  },
                                );
                              });
                              // await GBSystem_AuthService(context)
                              //     .verifierGetDateRC(selectedDate: selectedDate)
                              //     .then((value) async {
                              //   // print("test val : $value");

                              //   if (value == true) {
                              //     await GBSystem_AuthService(context)
                              //         .chargerCompteur()
                              //         .then((compteur) async {
                              //       // print("compteur  : $compteur");

                              //       if (compteur != null) {
                              //         compteurController.setCompteur = compteur;
                              //         compteurModel = compteur;

                              //         await GBSystem_AuthService(context)
                              //             .getListVacationsShift(
                              //                 TPH_IDF: typeAbsenceModel.TPH_IDF,
                              //                 //   RC_REST: compteur.RC_REST,
                              //                 selectedDate: selectedDate)
                              //             .then((value) {
                              //           // print("list vacs shit : $value");

                              //           vacaionShiftController
                              //               .setAllVacationShift = value;

                              //           if (value != null && value.isNotEmpty) {
                              //             vacaionShiftController
                              //                     .setCurrentVacationShift =
                              //                 value.first;
                              //           }

                              //           setState(
                              //             () {
                              //               showVacations = true;
                              //             },
                              //           );
                              //         });
                              //       }
                              //     });
                              //   }
                              // });
                            },
                            horPadding: 5,
                            verPadding: 5,
                            text: GbsSystemStrings.str_charger.tr)
                      ],
                    ),
                    Visibility(visible: showVacations, child: MainWidget())
                  ],
                )),
          );
        },
      );
    });
  }

  Future<void> showDialogCompteurInfo(
      {required BuildContext context,
      required CompteurModel compteurModel}) async {
    // Capture the context before it's disposed
    // BuildContext dialogContext = context;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: GlobalKey<NavigatorState>().currentContext!,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              backgroundColor:
                  GbsSystemStrings.str_primary_color.withOpacity(0.85),
              content: Padding(
                padding: EdgeInsets.only(
                  top: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.02),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    PageView.builder(
                      onPageChanged: (index) {
                        currentPageIndex.value = index;
                      },
                      // controller: pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return TypeAbsenceDisplayDataWidget(
                          atr1: (index == 0
                                  ? compteurModel.SABSD_CP_ACQUIS
                                  : index == 1
                                      ? compteurModel.SABSD_RC_ACQUIS
                                      : compteurModel.SABSD_RTT_ACQUIS) ??
                              "",
                          name: (index == 0
                                  ? compteurModel.TPH_CODE_CP
                                  : index == 1
                                      ? compteurModel.TPH_CODE_RC
                                      : compteurModel.TPH_CODE_RTT) ??
                              "",
                          atr2: (index == 0
                                  ? compteurModel.SABSD_CP_PRIS
                                  : index == 1
                                      ? compteurModel.SABSD_RC_PRIS
                                      : compteurModel.SABSD_RTT_PRIS) ??
                              "",
                          atr22: (index == 0
                                  ? compteurModel.CET_EN_COURS_CP
                                  : index == 1
                                      ? compteurModel.CET_EN_COURS_RC
                                      : compteurModel.CET_EN_COURS_RTT) ??
                              "",
                          atr3: (index == 0
                                  ? compteurModel.CPJOUR
                                  : index == 1
                                      ? compteurModel.RCJOUR
                                      : compteurModel.RTTJOUR) ??
                              "",
                          atr4: (index == 0
                                  ? compteurModel.CP_DEM
                                  : index == 1
                                      ? compteurModel.RC_DEM
                                      : "") ??
                              "",
                          atr5: (index == 0
                                  ? compteurModel.CP_REST
                                  : index == 1
                                      ? compteurModel.RC_REST
                                      : compteurModel.RTT_REST) ??
                              "",
                        );
                      },
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child:
                            Icon(CupertinoIcons.multiply, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              actions: <Widget>[],
            ),
          );
        },
      );
    });
  }

  Future<void> dialogCompteur(
      {
      // required BuildContext context,
      required CompteurModel compteurModel}) async {
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: Colors.white,
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: 250,
            height: 410,
            child: PageView.builder(
              onPageChanged: (index) {
                currentPageIndex.value = index;
              },
              // controller: pageController,
              scrollDirection: Axis.horizontal,
              itemCount: 3,

              itemBuilder: (context, index) {
                return TypeAbsenceDisplayDataWidget(
                  atr1: (index == 0
                          ? compteurModel.SABSD_CP_ACQUIS
                          : index == 1
                              ? compteurModel.SABSD_RC_ACQUIS
                              : compteurModel.SABSD_RTT_ACQUIS) ??
                      "",
                  name: (index == 0
                          ? compteurModel.TPH_CODE_CP
                          : index == 1
                              ? compteurModel.TPH_CODE_RC
                              : compteurModel.TPH_CODE_RTT) ??
                      "",
                  atr2: (index == 0
                          ? compteurModel.SABSD_CP_PRIS
                          : index == 1
                              ? compteurModel.SABSD_RC_PRIS
                              : compteurModel.SABSD_RTT_PRIS) ??
                      "",
                  atr22: (index == 0
                          ? compteurModel.CET_EN_COURS_CP
                          : index == 1
                              ? compteurModel.CET_EN_COURS_RC
                              : compteurModel.CET_EN_COURS_RTT) ??
                      "",
                  atr3: (index == 0
                          ? compteurModel.CPJOUR
                          : index == 1
                              ? compteurModel.RCJOUR
                              : compteurModel.RTTJOUR) ??
                      "",
                  atr4: (index == 0
                          ? compteurModel.CP_DEM
                          : index == 1
                              ? compteurModel.RC_DEM
                              : "") ??
                      "",
                  atr5: (index == 0
                          ? compteurModel.CP_REST
                          : index == 1
                              ? compteurModel.RC_REST
                              : compteurModel.RTT_REST) ??
                      "",
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(CupertinoIcons.multiply, color: Colors.white),
            ),
          )
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: GbsSystemStrings.str_primary_color,
              textStyle: TextStyle(color: GbsSystemStrings.str_primary_color)),
          onPressed: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              GbsSystemStrings.str_fermer.tr,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ));
  }

  Future<void> dialogCompteur2(
      {required BuildContext context,
      required CompteurModel compteurModel}) async {
    // Capture the context before it's disposed
    BuildContext dialogContext = context;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: dialogContext,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),

                    // backgroundColor: GbsSystemStrings.str_primary_color.withOpacity(0.85),
                    backgroundColor: Colors.white,
                    content: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 410,
                          child: PageView.builder(
                            onPageChanged: (index) {
                              currentPageIndex.value = index;
                            },
                            // controller: pageController,
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,

                            itemBuilder: (context, index) {
                              return TypeAbsenceDisplayDataWidget(
                                atr1: (index == 0
                                        ? compteurModel.SABSD_CP_ACQUIS
                                        : index == 1
                                            ? compteurModel.SABSD_RC_ACQUIS
                                            : compteurModel.SABSD_RTT_ACQUIS) ??
                                    "",
                                name: (index == 0
                                        ? compteurModel.TPH_CODE_CP
                                        : index == 1
                                            ? compteurModel.TPH_CODE_RC
                                            : compteurModel.TPH_CODE_RTT) ??
                                    "",
                                atr2: (index == 0
                                        ? compteurModel.SABSD_CP_PRIS
                                        : index == 1
                                            ? compteurModel.SABSD_RC_PRIS
                                            : compteurModel.SABSD_RTT_PRIS) ??
                                    "",
                                atr22: (index == 0
                                        ? compteurModel.CET_EN_COURS_CP
                                        : index == 1
                                            ? compteurModel.CET_EN_COURS_RC
                                            : compteurModel.CET_EN_COURS_RTT) ??
                                    "",
                                atr3: (index == 0
                                        ? compteurModel.CPJOUR
                                        : index == 1
                                            ? compteurModel.RCJOUR
                                            : compteurModel.RTTJOUR) ??
                                    "",
                                atr4: (index == 0
                                        ? compteurModel.CP_DEM
                                        : index == 1
                                            ? compteurModel.RC_DEM
                                            : "") ??
                                    "",
                                atr5: (index == 0
                                        ? compteurModel.CP_REST
                                        : index == 1
                                            ? compteurModel.RC_REST
                                            : compteurModel.RTT_REST) ??
                                    "",
                              );
                            },
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(CupertinoIcons.multiply,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: GbsSystemStrings.str_primary_color,
                            textStyle: TextStyle(
                                color: GbsSystemStrings.str_primary_color)),
                        onPressed: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            GbsSystemStrings.str_fermer.tr,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
        },
      );
    });
  }

  // void dialogCompteur({required CompteurModel compteurModel}) async {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Get.dialog(
  //       AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16.0),
  //         ),
  //         backgroundColor: Colors.white,

  //         //  GbsSystemStrings.str_primary_color.withOpacity(0.85),
  //         content: Stack(
  //           clipBehavior: Clip.none,
  //           children: [
  //             SizedBox(
  //               width: 250,
  //               height:
  //                   GBSystem_ScreenHelper.screenHeightPercentage(context, 0.65),
  //               child: PageView.builder(
  //                 onPageChanged: (index) {
  //                   currentPageIndex.value = index;
  //                 },
  //                 // controller: pageController,
  //                 scrollDirection: Axis.horizontal,
  //                 itemCount: 3,

  //                 itemBuilder: (context, index) {
  //                   return TypeAbsenceDisplayDataWidget(
  //                     atr1: (index == 0
  //                             ? compteurModel.SABSD_CP_ACQUIS
  //                             : index == 1
  //                                 ? compteurModel.SABSD_RC_ACQUIS
  //                                 : compteurModel.SABSD_RTT_ACQUIS) ??
  //                         "",
  //                     name: (index == 0
  //                             ? compteurModel.TPH_CODE_CP
  //                             : index == 1
  //                                 ? compteurModel.TPH_CODE_RC
  //                                 : compteurModel.TPH_CODE_RTT) ??
  //                         "",
  //                     atr2: (index == 0
  //                             ? compteurModel.SABSD_CP_PRIS
  //                             : index == 1
  //                                 ? compteurModel.SABSD_RC_PRIS
  //                                 : compteurModel.SABSD_RTT_PRIS) ??
  //                         "",
  //                     atr22: (index == 0
  //                             ? compteurModel.CET_EN_COURS_CP
  //                             : index == 1
  //                                 ? compteurModel.CET_EN_COURS_RC
  //                                 : compteurModel.CET_EN_COURS_RTT) ??
  //                         "",
  //                     atr3: (index == 0
  //                             ? compteurModel.CPJOUR
  //                             : index == 1
  //                                 ? compteurModel.RCJOUR
  //                                 : compteurModel.RTTJOUR) ??
  //                         "",
  //                     atr4: (index == 0
  //                             ? compteurModel.CP_DEM
  //                             : index == 1
  //                                 ? compteurModel.RC_DEM
  //                                 : "") ??
  //                         "",
  //                     atr5: (index == 0
  //                             ? compteurModel.CP_REST
  //                             : index == 1
  //                                 ? compteurModel.RC_REST
  //                                 : compteurModel.RTT_REST) ??
  //                         "",
  //                   );
  //                 },
  //               ),
  //             ),
  //             Positioned(
  //               top: 0,
  //               left: 0,
  //               child: InkWell(
  //                 onTap: () {
  //                   Get.back();
  //                 },
  //                 child: Icon(CupertinoIcons.multiply, color: Colors.white),
  //               ),
  //             )
  //           ],
  //         ),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //                 backgroundColor: GbsSystemStrings.str_primary_color,
  //                 textStyle:
  //                     TextStyle(color: GbsSystemStrings.str_primary_color)),
  //             onPressed: () {
  //               Get.back();
  //             },
  //             child: Padding(
  //               padding: const EdgeInsets.all(4.0),
  //               child: Text(
  //                 GbsSystemStrings.str_fermer.tr,
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }
}

// ignore: must_be_immutable
class MainWidget extends StatefulWidget {
  MainWidget();

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final vacaionShiftController = Get.put<GBSystemVacationShiftController>(
      GBSystemVacationShiftController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: vacaionShiftController.getAllVacationsShift?.length ?? 0,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            vacaionShiftController.setCurrentDateDebut = vacaionShiftController
                .getAllVacationsShift![index].VAC_START_HOUR!;
            vacaionShiftController.setCurrentDateFin = vacaionShiftController
                .getAllVacationsShift![index].VAC_END_HOUR!;
            // print(vacaionShiftController
            //     .getAllVacationsShift![index].VAC_START_HOUR!);
            // print(vacaionShiftController
            //     .getAllVacationsShift![index].VAC_END_HOUR!);
            // print("---------------");
            // print(vacaionShiftController.getCurrentDateDebut);
            // print(vacaionShiftController.getCurrentDateFin);

            Get.back();
          },
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                    context, 0.01)),
            padding: EdgeInsets.symmetric(
                horizontal:
                    GBSystem_ScreenHelper.screenWidthPercentage(context, 0.01),
                vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                    context, 0.01)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    GBSystem_TextHelper().superSmallText(
                        text: GbsSystemStrings.str_du.tr + " ",
                        fontWeight: FontWeight.bold),
                    GBSystem_TextHelper().superSmallText(
                        text: vacaionShiftController
                                        .getAllVacationsShift?[index] !=
                                    null &&
                                vacaionShiftController
                                    .getAllVacationsShift!.isNotEmpty
                            ? "${AbsenceModel.convertDateAndTime(vacaionShiftController.getAllVacationsShift![index].VAC_START_HOUR!)}"
                            : "")
                  ],
                ),
                Row(
                  children: [
                    GBSystem_TextHelper().superSmallText(
                        text: GbsSystemStrings.str_au.tr + " ",
                        fontWeight: FontWeight.bold),
                    GBSystem_TextHelper().superSmallText(
                        text:
                            "${AbsenceModel.convertDateAndTime(vacaionShiftController.getAllVacationsShift![index].VAC_END_HOUR!)}")
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
