import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_indisponibiliter_controller.dart';
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
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/FORMULAIRE_DEMANDE_INDISPONIBILITER/formulaire_demande_indisponibiliter_widget_controller.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class FormulaireDemandeIndisponibiliterWidget extends StatelessWidget {
  FormulaireDemandeIndisponibiliterWidget({
    super.key,
    required this.updateLoading,
  });
  final Function updateLoading;

  @override
  Widget build(BuildContext context) {
    final m = Get.put<FormulaireDemandeIndisponibiliterWidgetController>(
        FormulaireDemandeIndisponibiliterWidgetController(context));
    return m.typeAbsenceIndisponibiliterController
                .getAllTypeAbsencesIndisponibiliter !=
            null
        ? MainWidget(updateLoading: updateLoading)
        : FutureBuilder(
            future: GBSystem_AuthService(context)
                .getListTypeAbsencesIndisponibiliter(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  m.typeAbsenceIndisponibiliterController.setAllTypeAbsence =
                      snapshot.data;
                  m.typeAbsenceIndisponibiliterController
                          .setCurrentTypeAbsenceIndisponibiliter =
                      snapshot.data?.first;
                  m.controllerAbsence.value.text = m
                      .typeAbsenceIndisponibiliterController
                      .getCurrentTypeAbsenceIndisponibiliter!
                      .TPH_LIB;
                  final hexColor = m
                      .typeAbsenceIndisponibiliterController
                      .getAllTypeAbsencesIndisponibiliter!
                      .first
                      .CLR_CODE_colorweb
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
    final m = Get.put<FormulaireDemandeIndisponibiliterWidgetController>(
        FormulaireDemandeIndisponibiliterWidgetController(context));
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal:
                  GBSystem_ScreenHelper.screenWidthPercentage(context, 0.04),
              vertical:
                  GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  width: 0.4, color: Colors.grey, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: -40,
                  blurRadius: 22,
                  offset: const Offset(10, 40),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: -40,
                  blurRadius: 22,
                  offset: const Offset(-10, -40), // changes the shadow position
                ),
              ]),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                m.typeAbsenceIndisponibiliterController
                                .getAllTypeAbsencesIndisponibiliter !=
                            null &&
                        m.typeAbsenceIndisponibiliterController
                                .getAllTypeAbsencesIndisponibiliter!.length >=
                            2
                    ? SizedBox(
                        height: 30,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: m
                              .getListParentsTypsAbsences(m
                                  .typeAbsenceIndisponibiliterController
                                  .getAllTypeAbsencesIndisponibiliter!)
                              .map((e) => e.TPH_CODE)
                              .toList()
                              .length,
                          itemBuilder: (context, index) {
                            return Obx(() => InkWell(
                                  onTap: () {
                                    try {
                                      List<TypeAbsenceModel> myList =
                                          m.getListParentsTypsAbsences(m
                                              .typeAbsenceIndisponibiliterController
                                              .getAllTypeAbsencesIndisponibiliter!);
                                      if (m.verifierHasChildren(
                                          myList[index],
                                          m.typeAbsenceIndisponibiliterController
                                              .getAllTypeAbsencesIndisponibiliter!)) {
                                        Get.to(GBSystem_SelectItemScreen(
                                          enabledDates: RxBool(false),
                                          selectedTypeAbsence: m
                                              .typeAbsenceIndisponibiliterController
                                              .getAllTypeAbsencesIndisponibiliter![index],
                                          controllerTxtField:
                                              m.controllerAbsence.value,
                                        ));
                                      } else {
                                        m.typeAbsenceIndisponibiliterController
                                                .setCurrentTypeAbsenceIndisponibiliter =
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
                                      }
                                    } catch (e) {
                                      GBSystem_ManageCatchErrors().catchErrors(
                                          context,
                                          message: e.toString(),
                                          method:
                                              "verifierHasChildren-getListParentsTypsAbsences",
                                          page:
                                              "formulaire_demande_indisponibiliter_widget");
                                    }
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
                                      color: (m.typeAbsenceIndisponibiliterController
                                                      .getCurrentTypeAbsenceIndisponibiliter ==
                                                  m.typeAbsenceIndisponibiliterController
                                                          .getAllTypeAbsencesIndisponibiliter![
                                                      index] ||
                                              m
                                                      .typeAbsenceIndisponibiliterController
                                                      .getCurrentTypeAbsenceIndisponibiliter!
                                                      .PTPH_IDF ==
                                                  m
                                                      .typeAbsenceIndisponibiliterController
                                                      .getAllTypeAbsencesIndisponibiliter![
                                                          index]
                                                      .TPH_IDF)
                                          ? m.typeAbsColor.value
                                          : Colors.grey.shade400
                                              .withOpacity(0.7),
                                    ),
                                    child: Center(
                                      child: GBSystem_TextHelper().smallText(
                                          textColor: Colors.white,
                                          text: m
                                              .typeAbsenceIndisponibiliterController
                                              .getAllTypeAbsencesIndisponibiliter![
                                                  index]
                                              .TPH_CODE),
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
                      child: CustomDatePicker(
                        addTime: m
                                    .typeAbsenceIndisponibiliterController
                                    .getCurrentTypeAbsenceIndisponibiliter
                                    ?.TPH_WEB_HOUR ==
                                "1"
                            ? true
                            : false,
                        selectedDate: m.dateDebut,
                        labelText: GbsSystemStrings.str_date_debut.tr,
                        // initialDate: DateTime.now(),
                        onDateSelected: (DateTime selectedDate) {
                          m.dateDebut = selectedDate;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomDatePicker(
                        addTime: m
                                    .typeAbsenceIndisponibiliterController
                                    .getCurrentTypeAbsenceIndisponibiliter
                                    ?.TPH_WEB_HOUR ==
                                "1"
                            ? true
                            : false,
                        selectedDate: m.dateFin,
                        labelText: GbsSystemStrings.str_date_fin.tr,
                        // initialDate: DateTime.now(),
                        onDateSelected: (DateTime selectedDate) {
                          m.dateFin = selectedDate;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.02),
                ),
                TextFieldAnimated(
                    controller: m.controllerComment,
                    hint: GbsSystemStrings.str_comment.tr),
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
                      } catch (e) {
                        GBSystem_ManageCatchErrors().catchErrors(context,
                            message: e.toString(),
                            method: "pickFile",
                            page: "formulaire_demande_indisponibiliter_widget");
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
                                          )),
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButtonWithTrailling(
                        onTap: () async {
                          try {
                            if (m.dateDebut != null && m.dateFin != null) {
                              updateLoading(true);
                              String? base64File;
                              final salarieController =
                                  Get.put<GBSystemSalarieController>(
                                      GBSystemSalarieController());
                              if (m.file.value != null) {
                                base64File = await PickFileService()
                                    .encodeFileToBase64(m.file.value!,
                                        extension: m.file.value?.extension);
                              }
                              // Charger RC_REST
                              await GBSystem_AuthService(context)
                                  .chargerCompteur()
                                  .then((compteur) async {
                                if (compteur != null) {
                                  m.compteurController.setCompteur = compteur;
                                }
                              });
                              await GBSystem_AuthService(context)
                                  .chargerDemandeAbsence(
                                      isTimeRequired: m
                                                  .typeAbsenceIndisponibiliterController
                                                  .getCurrentTypeAbsenceIndisponibiliter
                                                  ?.TPH_WEB_HOUR ==
                                              "1"
                                          ? true
                                          : false,
                                      typeAbsenceModel: m
                                          .typeAbsenceIndisponibiliterController
                                          .getCurrentTypeAbsenceIndisponibiliter!,
                                      salarie: salarieController
                                          .getSalarie!.salarieModel,
                                      dateDebut: m.dateDebut!,
                                      dateFin: m.dateFin!,
                                      comment: m.controllerComment.text,
                                      fileBase64: base64File,
                                      RC_REST: m.compteurController.getCompteur
                                              ?.RC_REST ??
                                          "0,00",
                                      fileSize:
                                          m.file.value?.size.toString() ?? "",
                                      fileTypeExtension: m.file.value?.extension !=
                                              null
                                          ? (m.file.value?.extension
                                                      ?.replaceAll(" ", "") ==
                                                  "pdf"
                                              ? "application/${m.file.value?.extension}"
                                              : "image/${m.file.value?.extension}")
                                          : "")
                                  .then((value) {
                                updateLoading(false);
                                if (value != null && value.isNotEmpty) {
                                  final GBSystemIndisponibiliterController
                                      indisponibiliterController = Get.put(
                                          GBSystemIndisponibiliterController());

                                  indisponibiliterController
                                      .setIndisponibiliterToRight = value.first;
                                  showSuccesDialog(
                                      context,
                                      GbsSystemStrings
                                          .str_operation_effectuer.tr);
                                  // final demandeAbsPageContr = Get.put<
                                  //         GBSystemDemandeAbsenceScreenController>(
                                  //     GBSystemDemandeAbsenceScreenController());
                                  // demandeAbsPageContr.currentPageIndex.value =
                                  //     1;
                                  // demandeAbsPageContr.pageController
                                  //     .animateToPage(1,
                                  //         duration: Duration(milliseconds: 300),
                                  //         curve: Curves.bounceInOut);

                                  updateLoading(false);
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
                                method: "chargerDemandeAbsence",
                                page:
                                    "formulaire_demande_indisponibiliter_widget");
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
