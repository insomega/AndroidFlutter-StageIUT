import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_absences_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_type_absence_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/select_item_screen/GBSystem_select_item_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/pick_file_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_date_picker.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_text_field.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/text_field_animated.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/FORMULAIRE_DEMANDE_ABSENCE_WIDGET/formulaire_demande_absence_widget_controller.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class FormulaireDemandeAbsenceWidget extends StatelessWidget {
  FormulaireDemandeAbsenceWidget({
    super.key,
    required this.updateLoading,
  });
  final Function updateLoading;

  @override
  Widget build(BuildContext context) {
    final m = Get.put<FormulaireDemandeAbsenceWidgetController>(
        FormulaireDemandeAbsenceWidgetController(
      context,
    ));
    return m.typeAbsenceController.getAllTypeAbsences != null
        ? MainWidget(updateLoading: updateLoading)
        : FutureBuilder(
            future: GBSystem_AuthService(context).getListTypsAbsences(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  m.typeAbsenceController.setAllTypeAbsence = snapshot.data;
                  m.typeAbsenceController.setCurrentTypeAbsenceTypeAbsence =
                      snapshot.data?.first;
                  m.controllerAbsence.value.text =
                      m.typeAbsenceController.getCurrentTypeAbsence!.TPH_LIB;
                  final hexColor = m.typeAbsenceController.getAllTypeAbsences!
                      .first.CLR_CODE_colorweb
                      .replaceAll(r"#", "")
                      .replaceAll(r"$", "");
                  final color = Color(int.parse(
                    '0xFF$hexColor',
                  ));

                  m.typeAbsColor.value = color;
                  return MainWidget(
                    updateLoading: updateLoading,
                  );
                } else {
                  return EmptyDataWidget();
                }
              } else {
                return Container(
                  height: 250,
                  child: WaitingWidgets(),
                );
              }
            },
          );
  }
}

class MainWidget extends StatelessWidget {
  MainWidget({
    super.key,
    required this.updateLoading,
  });
  final Function updateLoading;

  @override
  Widget build(BuildContext context) {
    final m = Get.put<FormulaireDemandeAbsenceWidgetController>(
        FormulaireDemandeAbsenceWidgetController(
      context,
    ));

    return Stack(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal:
                  GBSystem_ScreenHelper.screenWidthPercentage(context, 0.04),
              vertical:
                  GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                width: 0.4, color: Colors.grey, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                m.typeAbsenceController.getAllTypeAbsences != null &&
                        m.typeAbsenceController.getAllTypeAbsences!.length >= 2
                    ? SizedBox(
                        height: 30,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: m
                              .getListParentsTypsAbsences(
                                  m.typeAbsenceController.getAllTypeAbsences!)
                              .map((e) => e.TPH_CODE)
                              .toList()
                              .length,
                          itemBuilder: (context, index) {
                            return Obx(() => InkWell(
                                  onTap: () async {
                                    try {
                                      List<TypeAbsenceModel> myList =
                                          m.getListParentsTypsAbsences(m
                                              .typeAbsenceController
                                              .getAllTypeAbsences!);
                                      if (m.verifierHasChildren(
                                          myList[index],
                                          m.typeAbsenceController
                                              .getAllTypeAbsences!)) {
                                        Get.to(GBSystem_SelectItemScreen(
                                          enabledDates: m.enabledDateDebutFin,
                                          selectedTypeAbsence: m
                                              .typeAbsenceController
                                              .getAllTypeAbsences![index],
                                          controllerTxtField:
                                              m.controllerAbsence.value,
                                        ));
                                      } else {
                                        m.typeAbsenceController
                                                .setCurrentTypeAbsenceTypeAbsence =
                                            myList[index];
                                        m.controllerAbsence.value.text =
                                            myList[index].TPH_LIB;
                                        final hexColor = myList[index]
                                            .CLR_CODE_colorweb
                                            .replaceAll(r"#", "")
                                            .replaceAll(r"$", "");
                                        final color = Color(int.parse(
                                          '0xFF$hexColor',
                                        ));
                                        m.typeAbsColor.value = color;

                                        if (m
                                                .typeAbsenceController
                                                .getCurrentTypeAbsence!
                                                .TPH_CTRL_SHIFT ==
                                            "1") {
                                          await m.showDialogVacationsShift(
                                              typeAbsenceModel: m
                                                  .typeAbsenceController
                                                  .getAllTypeAbsences![index],
                                              context: context);
                                          m.enabledDateDebutFin.value = true;
                                        } else {
                                          m.enabledDateDebutFin.value = false;
                                        }
                                      }
                                    } catch (e) {
                                      GBSystem_ManageCatchErrors().catchErrors(
                                          context,
                                          message: e.toString(),
                                          method: "showDialogVacationsShift",
                                          page:
                                              "formulaire_demande_absence_widget");
                                    }
                                    print(
                                        "current type abs  : ${m.typeAbsenceController.getCurrentTypeAbsence?.TPH_WEB_HOUR}");
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.01)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.02)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: (m.typeAbsenceController
                                                      .getCurrentTypeAbsence ==
                                                  m.typeAbsenceController
                                                          .getAllTypeAbsences![
                                                      index] ||
                                              m
                                                      .typeAbsenceController
                                                      .getCurrentTypeAbsence!
                                                      .PTPH_IDF ==
                                                  m
                                                      .typeAbsenceController
                                                      .getAllTypeAbsences![
                                                          index]
                                                      .TPH_IDF)
                                          ? m.typeAbsColor.value
                                          : Colors.grey.shade400
                                              .withOpacity(0.7),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GBSystem_TextHelper().smallText(
                                              textColor: Colors.white,
                                              text: m
                                                  .typeAbsenceController
                                                  .getAllTypeAbsences![index]
                                                  .TPH_CODE),
                                          Visibility(
                                            visible: m.verifierHasChildren(
                                                m.typeAbsenceController
                                                    .getAllTypeAbsences![index],
                                                m.typeAbsenceController
                                                    .getAllTypeAbsences!),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  width: 15,
                                                  // height: 18,
                                                  // clipBehavior: Clip.hardEdge,
                                                  decoration: BoxDecoration(
                                                    color: GbsSystemStrings
                                                        .str_primary_color,
                                                    // borderRadius:
                                                    //     BorderRadius.circular(100),
                                                  ),
                                                  child: Center(
                                                    child: GBSystem_TextHelper().superSmallText(
                                                        text: m
                                                            .getNumberChildren(
                                                                m.typeAbsenceController
                                                                        .getAllTypeAbsences![
                                                                    index],
                                                                m.typeAbsenceController
                                                                    .getAllTypeAbsences!)
                                                            .toString(),
                                                        textColor:
                                                            Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.02),
                ),
                Obx(
                  () => CustomTextField(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      textStyle: TextStyle(fontSize: 12),
                      height: 40,
                      enabled: false,
                      controller: m.controllerAbsence.value,
                      text: GbsSystemStrings.str_absence.tr),
                ),
                SizedBox(
                  height: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.02),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Obx(
                      () => CustomDatePicker(
                        addTime: m.typeAbsenceController.getCurrentTypeAbsence
                                    ?.TPH_WEB_HOUR ==
                                "1"
                            ? true
                            : false,
                        enabled: m.enabledDateDebutFin.value,
                        selectedDate:
                            m.vacaionShiftController.getCurrentDateDebut.value,
                        labelText: GbsSystemStrings.str_date_debut.tr,
                        initialDate:
                            m.vacaionShiftController.getCurrentDateDebut.value,
                        onDateSelected: (DateTime selectedDate) {
                          m.dateDebut.value = selectedDate;
                          m.vacaionShiftController.setCurrentDateDebut =
                              selectedDate;
                        },
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Obx(
                      () => CustomDatePicker(
                        addTime: m.typeAbsenceController.getCurrentTypeAbsence
                                    ?.TPH_WEB_HOUR ==
                                "1"
                            ? true
                            : false,
                        selectedDate:
                            m.vacaionShiftController.getCurrentDateFin.value,
                        enabled: m.enabledDateDebutFin.value,
                        labelText: GbsSystemStrings.str_date_fin.tr,
                        initialDate:
                            m.vacaionShiftController.getCurrentDateFin.value,
                        onDateSelected: (DateTime selectedDate) {
                          m.vacaionShiftController.setCurrentDateFin =
                              selectedDate;
                        },
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.02),
                ),
                TextFieldAnimated(
                    controller: m.controllerComment,
                    hint: GbsSystemStrings.str_comment.tr),
                SizedBox(
                  height: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.02),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Flexible(
                        child: CustomTextField(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            textStyle: TextStyle(fontSize: 12),
                            enabled: false,
                            controller: m.controllerDuree.value,
                            text: GbsSystemStrings.str_duree.tr),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                        onTap: () async {
                          try {
                            if (m.vacaionShiftController.getCurrentDateDebut
                                        .value !=
                                    null &&
                                m.vacaionShiftController.getCurrentDateFin
                                        .value !=
                                    null) {
                              updateLoading(true);
                              await GBSystem_AuthService(context)
                                  .calculateDuree(
                                      dateDebut: m.vacaionShiftController
                                          .getCurrentDateDebut.value!,
                                      typeAbsenceModel: m.typeAbsenceController
                                          .getCurrentTypeAbsence!,
                                      dateFin: m.vacaionShiftController
                                          .getCurrentDateFin.value!)
                                  .then((value) {
                                updateLoading(false);
                                if (value != null) {
                                  m.controllerDuree.value.text = value;
                                }
                              });
                            } else {
                              showErrorDialog(
                                  context,
                                  GbsSystemStrings
                                      .str_svp_add_date_debut_fin.tr);
                            }
                          } catch (e) {
                            updateLoading(false);
                            GBSystem_ManageCatchErrors().catchErrors(context,
                                message: e.toString(),
                                method: "calculateDuree",
                                page: "formulaire_demande_absence_widget");
                          }
                        },
                        horPadding: 5,
                        verPadding: 10,
                        textSize: 12,
                        text: GbsSystemStrings.str_calculer.tr +
                            ' ' +
                            GbsSystemStrings.str_duree.tr)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02)),
                  child: InkWell(
                    onTap: () async {
                      try {
                        PlatformFile? filePath =
                            await PickFileService().pickFile();

                        m.file.value = filePath;
                        print("picked file : ${m.file.value}");
                      } catch (e) {
                        GBSystem_ManageCatchErrors().catchErrors(context,
                            message: e.toString(),
                            method: "pickFile",
                            page: "formulaire_demande_absence_widget");
                      }
                    },
                    child: Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        padding: EdgeInsets.symmetric(
                            vertical:
                                GBSystem_ScreenHelper.screenHeightPercentage(
                                    context, 0.02)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: m.file.value == null
                              ? Colors.grey.shade300
                              : GbsSystemStrings.str_primary_color
                                  .withOpacity(0.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: m.file.value == null
                                      ? Icon(
                                          CupertinoIcons.doc_fill,
                                          color: Colors.grey,
                                          size: 30,
                                        )
                                      : Icon(
                                          CupertinoIcons.doc_fill,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                ),
                                m.file.value != null
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: GBSystem_ScreenHelper
                                                .screenWidthPercentage(
                                                    context, 0.5),
                                            child: GBSystem_TextHelper()
                                                .normalText(
                                                    text: m.file.value!.name,
                                                    textColor: Colors.black,
                                                    maxLines: 2,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: GBSystem_ScreenHelper
                                                .screenWidthPercentage(
                                                    context, 0.5),
                                            child: GBSystem_TextHelper().smallText(
                                                text:
                                                    "${m.file.value!.size} bytes",
                                                textColor: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GBSystem_TextHelper().smallText(
                                              text: GbsSystemStrings
                                                  .str_choisie_un_fichier.tr,
                                              textColor: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          GBSystem_TextHelper().smallText(
                                              text: GbsSystemStrings
                                                  .str_aucune_fichier_choisie
                                                  .tr,
                                              textColor: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ],
                                      ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                m.file.value = null;
                              },
                              child: Visibility(
                                visible: m.file.value != null,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Icon(CupertinoIcons.delete),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButtonWithTrailling(
                        onTap: () async {
                          try {
                            if (m.compteurModel == null) {
                              updateLoading(true);

                              await GBSystem_AuthService(context)
                                  .chargerCompteur()
                                  .then((compteur) async {
                                updateLoading(false);

                                if (compteur != null) {
                                  m.compteurController.setCompteur = compteur;
                                  m.compteurModel = compteur;

                                  try {
                                    m.dialogCompteur(
                                        compteurModel: m.compteurModel!);
                                  } catch (e) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      m.dialogCompteur2(
                                          context: context,
                                          compteurModel: m.compteurModel!);
                                    });
                                  }
                                }
                              });
                            } else {
                              try {
                                m.dialogCompteur2(
                                    context: context,
                                    compteurModel: m.compteurModel!);
                              } catch (e) {
                                m.dialogCompteur2(
                                    context: context,
                                    compteurModel: m.compteurModel!);
                              }
                            }
                          } catch (e) {
                            updateLoading(false);
                            GBSystem_ManageCatchErrors().catchErrors(context,
                                message: e.toString(),
                                method: "chargerCompteur",
                                page: "formulaire_demande_absence_widget");
                          }
                        },
                        trailling: Icon(CupertinoIcons.pencil_outline,
                            color: Colors.white),
                        verPadding: 10,
                        horPadding: 5,
                        textSize: 12,
                        text: GbsSystemStrings.str_solde_des_absences.tr),
                    CustomButtonWithTrailling(
                        onTap: () async {
                          try {
                            if (m.vacaionShiftController.getCurrentDateDebut
                                        .value !=
                                    null &&
                                m.vacaionShiftController.getCurrentDateFin
                                        .value !=
                                    null) {
                              updateLoading(true);

                              String? base64File;
                              final salarieController =
                                  Get.put<GBSystemSalarieController>(
                                      GBSystemSalarieController());
                              if (m.file.value != null) {
                                print("pdf :123");
                                base64File = await PickFileService()
                                    .encodeFileToBase64(m.file.value!,
                                        extension: m.file.value?.extension);

                                print("pdf :$base64File");
                              }

                              // Charger RC_REST
                              await GBSystem_AuthService(context)
                                  .chargerCompteur()
                                  .then((compteur) async {
                                if (compteur != null) {
                                  m.compteurController.setCompteur = compteur;
                                  m.compteurModel = compteur;
                                }
                              });

                              await GBSystem_AuthService(context)
                                  .chargerDemandeAbsence(
                                      isTimeRequired: m
                                                  .typeAbsenceController
                                                  .getCurrentTypeAbsence
                                                  ?.TPH_WEB_HOUR ==
                                              "1"
                                          ? true
                                          : false,
                                      typeAbsenceModel: m.typeAbsenceController
                                          .getCurrentTypeAbsence!,
                                      salarie: salarieController
                                          .getSalarie!.salarieModel,
                                      dateDebut: m.vacaionShiftController
                                          .getCurrentDateDebut.value!,
                                      dateFin: m.vacaionShiftController
                                          .getCurrentDateFin.value!,
                                      comment: m.controllerComment.text,
                                      fileBase64: base64File,
                                      RC_REST: m.compteurController.getCompteur
                                              ?.RC_REST ??
                                          "0,00",
                                      fileSize:
                                          m.file.value?.size.toString() ?? "",
                                      fileTypeExtension: m.file.value?.extension != null
                                          ? (m.file.value?.extension
                                                      ?.replaceAll(" ", "") ==
                                                  "pdf"
                                              ? "application/${m.file.value?.extension}"
                                              : "image/${m.file.value?.extension}")
                                          : "")
                                  .then((value) {
                                updateLoading(false);

                                if (value != null && value.isNotEmpty) {
                                  final GBSystemAbsenceController
                                      absenceController =
                                      Get.put(GBSystemAbsenceController());

                                  absenceController.setAbsenceToRight =
                                      value.first;
                                  showSuccesDialog(
                                      context,
                                      GbsSystemStrings
                                          .str_operation_effectuer.tr);

                                  //  final m = Get.put<
                                  //           GBSystemDemandeAbsenceScreenController>(
                                  //       GBSystemDemandeAbsenceScreenController());
                                  // m.currentPageIndex.value = 1;
                                  // m.pageController.animateToPage(1,
                                  //     duration: Duration(milliseconds: 300),
                                  //     curve: Curves.bounceInOut);
                                }
                              });
                            } else {
                              showErrorDialog(
                                  context,
                                  GbsSystemStrings
                                      .str_svp_add_date_debut_fin.tr);
                            }
                          } catch (e) {
                            updateLoading(false);
                            GBSystem_ManageCatchErrors().catchErrors(context,
                                message: e.toString(),
                                method:
                                    "encodeFileToBase64-chargerDemandeAbsence",
                                page: "formulaire_demande_absence_widget");
                          }
                        },
                        trailling: Icon(CupertinoIcons.doc_chart_fill,
                            color: Colors.white),
                        verPadding: 10,
                        horPadding: 5,
                        text: GbsSystemStrings.kDemander.tr),
                  ],
                ),
                SizedBox(
                  height: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.02),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
