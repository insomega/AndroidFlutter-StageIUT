import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_map_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_vacation_model.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class VacationInformations extends StatelessWidget {
  VacationInformations({
    super.key,
    required this.isMapVacation,
  });

  final bool isMapVacation;

  final GBSystemVacationController vacationController =
      Get.put(GBSystemVacationController());
  final GBSystemVacationMapController vacationMapController =
      Get.put(GBSystemVacationMapController());

  @override
  Widget build(BuildContext context) {
    return isMapVacation == false
        ? vacationController.getCurrentVacation == null
            ? Center(
                child: GBSystem_TextHelper().smallText(
                    text: GbsSystemStrings.str_aucune_vacation.tr,
                    textColor: Colors.black),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 90,
                            child: GBSystem_TextHelper().superSmallText(
                                text:
                                    "${GbsSystemStrings.str_plages_horaires.tr} : ",
                                fontWeight: FontWeight.w500,
                                textColor: GbsSystemStrings.str_primary_color),
                          ),
                          Flexible(
                            child: Obx(
                              () => GBSystem_TextHelper().superSmallText(
                                  text: vacationController.getCurrentVacationRx
                                      .value!.VAC_HOUR_CALC,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.left,
                                  textColor: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 50,
                                child: GBSystem_TextHelper().superSmallText(
                                    text: "${GbsSystemStrings.str_duree.tr} : ",
                                    fontWeight: FontWeight.w500,
                                    textColor:
                                        GbsSystemStrings.str_primary_color),
                              ),
                              Flexible(
                                  child: Obx(
                                () => GBSystem_TextHelper().superSmallText(
                                    text: vacationController
                                        .getCurrentVacationRx
                                        .value!
                                        .VAC_DURATION,
                                    fontWeight: FontWeight.normal,
                                    textAlign: TextAlign.left,
                                    textColor: Colors.black),
                              )),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 50,
                                child: GBSystem_TextHelper().superSmallText(
                                    text: "${GbsSystemStrings.str_pause.tr} : ",
                                    fontWeight: FontWeight.w500,
                                    textColor:
                                        GbsSystemStrings.str_primary_color),
                              ),
                              Flexible(
                                // width: GBSystem_ScreenHelper.screenWidthPercentage(
                                //     context, 0.2),
                                child: Obx(
                                  () => GBSystem_TextHelper().superSmallText(
                                      text:
                                          "${vacationController.getCurrentVacationRx.value!.VAC_BREAK}",
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.left,
                                      textColor: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 80,
                            child: GBSystem_TextHelper().superSmallText(
                                text:
                                    "${GbsSystemStrings.str_qualification.tr} : ",
                                fontWeight: FontWeight.w500,
                                textColor: GbsSystemStrings.str_primary_color),
                          ),
                          Flexible(
                            // width: GBSystem_ScreenHelper.screenWidthPercentage(
                            //     context, 0.5),
                            child: Obx(
                              () => GBSystem_TextHelper().superSmallText(
                                  text: vacationController
                                      .getCurrentVacationRx.value!.JOB_LIB,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.left,
                                  textColor: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 80,
                            child: GBSystem_TextHelper().superSmallText(
                                text: "${GbsSystemStrings.str_telephone.tr} : ",
                                fontWeight: FontWeight.w500,
                                textColor: GbsSystemStrings.str_primary_color),
                          ),
                          Flexible(
                            // width: GBSystem_ScreenHelper.screenWidthPercentage(
                            //     context, 0.5),
                            child: Obx(
                              () => GBSystem_TextHelper().superSmallText(
                                  text: vacationController
                                      .getCurrentVacationRx.value!.LIE_TLPH,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.left,
                                  textColor: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 50,
                            child: GBSystem_TextHelper().superSmallText(
                                text: "${GbsSystemStrings.str_lieu.tr} : ",
                                fontWeight: FontWeight.w500,
                                textColor: GbsSystemStrings.str_primary_color),
                          ),
                          Flexible(
                            // width: GBSystem_ScreenHelper.screenWidthPercentage(
                            //     context, 0.6),
                            child: Obx(
                              () => GBSystem_TextHelper().superSmallText(
                                  text: vacationController
                                      .getCurrentVacationRx.value!.LIE_LIB,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.left,
                                  textColor: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 55,
                            child: GBSystem_TextHelper().superSmallText(
                                text: "${GbsSystemStrings.str_adresse.tr} : ",
                                fontWeight: FontWeight.w500,
                                textColor: GbsSystemStrings.str_primary_color),
                          ),
                          SizedBox(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.6),
                            child: Obx(
                              () => GBSystem_TextHelper().superSmallText(
                                  text: vacationController
                                      .getCurrentVacationRx.value!.LIE_ADR,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  textColor: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => Visibility(
                          visible:
                              vacationController.getCurrentVacationRx.value !=
                                      null &&
                                  vacationController.getCurrentVacationRx.value!
                                          .TPH_PSA ==
                                      "1",
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GBSystem_TextHelper().superSmallText(
                                      text:
                                          "${GbsSystemStrings.str_entrer.tr} : ",
                                      fontWeight: FontWeight.bold,
                                      textColor: Colors.green),
                                  SizedBox(
                                      width: GBSystem_ScreenHelper
                                          .screenWidthPercentage(context, 0.22),
                                      child: Obx(
                                        () => GBSystem_TextHelper()
                                            .superSmallText(
                                                text: vacationController
                                                            .getCurrentVacationRx
                                                            .value!
                                                            .PNTGS_START_HOUR_IN !=
                                                        null
                                                    ? (vacationController
                                                                    .getCurrentVacationRx
                                                                    .value!
                                                                    .PNTG_START_HOUR !=
                                                                null &&
                                                            vacationController
                                                                .getCurrentVacationRx
                                                                .value!
                                                                .PNTG_START_HOUR!
                                                                .isNotEmpty)
                                                        ? VacationModel.convertTime(
                                                            vacationController
                                                                .getCurrentVacationRx
                                                                .value!
                                                                .PNTGS_START_HOUR_IN!)
                                                        : "${VacationModel.convertTime(vacationController.getCurrentVacationRx.value!.PNTGS_START_HOUR_IN!)} *"
                                                    : "",
                                                maxLines: 2,
                                                textAlign: TextAlign.left,
                                                fontWeight: FontWeight.bold,
                                                textColor: Colors.green),
                                      )),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GBSystem_TextHelper().superSmallText(
                                      text:
                                          "${GbsSystemStrings.str_sortie.tr} : ",
                                      fontWeight: FontWeight.bold,
                                      textColor: Colors.red),
                                  SizedBox(
                                    width: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.22),
                                    child: Obx(
                                      () => GBSystem_TextHelper()
                                          .superSmallText(
                                              text: vacationController
                                                          .getCurrentVacationRx
                                                          .value!
                                                          .PNTGS_START_HOUR_OUT !=
                                                      null
                                                  ? (vacationController
                                                                  .getCurrentVacationRx
                                                                  .value!
                                                                  .PNTG_END_HOUR !=
                                                              null &&
                                                          vacationController
                                                              .getCurrentVacationRx
                                                              .value!
                                                              .PNTG_END_HOUR!
                                                              .isNotEmpty)
                                                      ? VacationModel.convertTime(
                                                          vacationController
                                                              .getCurrentVacationRx
                                                              .value!
                                                              .PNTGS_START_HOUR_OUT!)
                                                      : "${VacationModel.convertTime(vacationController.getCurrentVacationRx.value!.PNTGS_START_HOUR_OUT!)} *"
                                                  : "",
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                              fontWeight: FontWeight.bold,
                                              textColor: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
        : vacationMapController.getCurrentVacation == null
            ? Center(
                child: GBSystem_TextHelper().smallText(
                    text: GbsSystemStrings.str_aucune_vacation.tr,
                    textColor: Colors.black),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 90,
                            child: GBSystem_TextHelper().superSmallText(
                                text:
                                    "${GbsSystemStrings.str_plages_horaires.tr} : ",
                                fontWeight: FontWeight.w500,
                                textColor: GbsSystemStrings.str_primary_color),
                          ),
                          Flexible(
                            child: Obx(
                              () => GBSystem_TextHelper().superSmallText(
                                  text: vacationMapController
                                      .getCurrentVacationRx
                                      .value!
                                      .VAC_HOUR_CALC,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.left,
                                  textColor: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 50,
                                child: GBSystem_TextHelper().superSmallText(
                                    text: "${GbsSystemStrings.str_duree.tr} : ",
                                    fontWeight: FontWeight.w500,
                                    textColor:
                                        GbsSystemStrings.str_primary_color),
                              ),
                              Flexible(
                                  child: Obx(
                                () => GBSystem_TextHelper().superSmallText(
                                    text: vacationMapController
                                        .getCurrentVacationRx
                                        .value!
                                        .VAC_DURATION,
                                    fontWeight: FontWeight.normal,
                                    textAlign: TextAlign.left,
                                    textColor: Colors.black),
                              )),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 50,
                                child: GBSystem_TextHelper().superSmallText(
                                    text: "${GbsSystemStrings.str_pause.tr} : ",
                                    fontWeight: FontWeight.w500,
                                    textColor:
                                        GbsSystemStrings.str_primary_color),
                              ),
                              Flexible(
                                // width: GBSystem_ScreenHelper.screenWidthPercentage(
                                //     context, 0.2),
                                child: Obx(
                                  () => GBSystem_TextHelper().superSmallText(
                                      text:
                                          "${vacationMapController.getCurrentVacationRx.value!.VAC_BREAK}",
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.left,
                                      textColor: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 80,
                            child: GBSystem_TextHelper().superSmallText(
                                text:
                                    "${GbsSystemStrings.str_qualification.tr} : ",
                                fontWeight: FontWeight.w500,
                                textColor: GbsSystemStrings.str_primary_color),
                          ),
                          Flexible(
                            // width: GBSystem_ScreenHelper.screenWidthPercentage(
                            //     context, 0.5),
                            child: Obx(
                              () => GBSystem_TextHelper().superSmallText(
                                  text: vacationMapController
                                      .getCurrentVacationRx.value!.JOB_LIB,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.left,
                                  textColor: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 80,
                            child: GBSystem_TextHelper().superSmallText(
                                text: "${GbsSystemStrings.str_telephone.tr} : ",
                                fontWeight: FontWeight.w500,
                                textColor: GbsSystemStrings.str_primary_color),
                          ),
                          Flexible(
                            // width: GBSystem_ScreenHelper.screenWidthPercentage(
                            //     context, 0.5),
                            child: Obx(
                              () => GBSystem_TextHelper().superSmallText(
                                  text: vacationMapController
                                      .getCurrentVacationRx.value!.LIE_TLPH,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.left,
                                  textColor: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 50,
                            child: GBSystem_TextHelper().superSmallText(
                                text: "${GbsSystemStrings.str_lieu.tr} : ",
                                fontWeight: FontWeight.w500,
                                textColor: GbsSystemStrings.str_primary_color),
                          ),
                          Flexible(
                            // width: GBSystem_ScreenHelper.screenWidthPercentage(
                            //     context, 0.6),
                            child: Obx(
                              () => GBSystem_TextHelper().superSmallText(
                                  text: vacationMapController
                                      .getCurrentVacationRx.value!.LIE_LIB,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.left,
                                  textColor: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 55,
                            child: GBSystem_TextHelper().superSmallText(
                                text: "${GbsSystemStrings.str_adresse.tr} : ",
                                fontWeight: FontWeight.w500,
                                textColor: GbsSystemStrings.str_primary_color),
                          ),
                          SizedBox(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.6),
                            child: Obx(
                              () => GBSystem_TextHelper().superSmallText(
                                  text: vacationMapController
                                      .getCurrentVacationRx.value!.LIE_ADR,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  textColor: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => Visibility(
                          visible: vacationMapController
                                      .getCurrentVacationRx.value !=
                                  null &&
                              vacationMapController
                                      .getCurrentVacationRx.value!.TPH_PSA ==
                                  "1",
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GBSystem_TextHelper().superSmallText(
                                      text:
                                          "${GbsSystemStrings.str_entrer.tr} : ",
                                      fontWeight: FontWeight.bold,
                                      textColor: Colors.green),
                                  SizedBox(
                                      width: GBSystem_ScreenHelper
                                          .screenWidthPercentage(context, 0.22),
                                      child: Obx(
                                        () => GBSystem_TextHelper()
                                            .superSmallText(
                                                text: vacationMapController
                                                            .getCurrentVacationRx
                                                            .value!
                                                            .PNTGS_START_HOUR_IN !=
                                                        null
                                                    ? (vacationMapController
                                                                    .getCurrentVacationRx
                                                                    .value!
                                                                    .PNTG_START_HOUR !=
                                                                null &&
                                                            vacationMapController
                                                                .getCurrentVacationRx
                                                                .value!
                                                                .PNTG_START_HOUR!
                                                                .isNotEmpty)
                                                        ? VacationModel.convertTime(
                                                            vacationMapController
                                                                .getCurrentVacationRx
                                                                .value!
                                                                .PNTGS_START_HOUR_IN!)
                                                        : "${VacationModel.convertTime(vacationMapController.getCurrentVacationRx.value!.PNTGS_START_HOUR_IN!)} *"
                                                    : "",
                                                maxLines: 2,
                                                textAlign: TextAlign.left,
                                                fontWeight: FontWeight.bold,
                                                textColor: Colors.green),
                                      )),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GBSystem_TextHelper().superSmallText(
                                      text:
                                          "${GbsSystemStrings.str_sortie.tr} : ",
                                      fontWeight: FontWeight.bold,
                                      textColor: Colors.red),
                                  SizedBox(
                                    width: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.22),
                                    child: Obx(
                                      () => GBSystem_TextHelper()
                                          .superSmallText(
                                              text: vacationMapController
                                                          .getCurrentVacationRx
                                                          .value!
                                                          .PNTGS_START_HOUR_OUT !=
                                                      null
                                                  ? (vacationMapController
                                                                  .getCurrentVacationRx
                                                                  .value!
                                                                  .PNTG_END_HOUR !=
                                                              null &&
                                                          vacationMapController
                                                              .getCurrentVacationRx
                                                              .value!
                                                              .PNTG_END_HOUR!
                                                              .isNotEmpty)
                                                      ? VacationModel.convertTime(
                                                          vacationMapController
                                                              .getCurrentVacationRx
                                                              .value!
                                                              .PNTGS_START_HOUR_OUT!)
                                                      : "${VacationModel.convertTime(vacationMapController.getCurrentVacationRx.value!.PNTGS_START_HOUR_OUT!)} *"
                                                  : "",
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                              fontWeight: FontWeight.bold,
                                              textColor: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
  }
}
