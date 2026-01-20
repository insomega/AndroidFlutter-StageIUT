import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_valider_document_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_vacation_model.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class VacationInformationsValideDocs extends StatelessWidget {
  VacationInformationsValideDocs({
    super.key,
  });
  final GBSystemValiderDocumentController validerDocsController =
      Get.put(GBSystemValiderDocumentController());

  @override
  Widget build(BuildContext context) {
    return validerDocsController.getCurrentVacation == null
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
                    children: [
                      GBSystem_TextHelper().superSmallText(
                          text: "${GbsSystemStrings.str_plages_horaires.tr} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemStrings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.4),
                        child: GBSystem_TextHelper().superSmallText(
                            text: validerDocsController
                                .getCurrentVacation!.VAC_HOUR_CALC,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.left,
                            textColor: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GBSystem_TextHelper().superSmallText(
                              text: "${GbsSystemStrings.str_duree.tr} : ",
                              fontWeight: FontWeight.w500,
                              textColor: GbsSystemStrings.str_primary_color),
                          SizedBox(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.2),
                            child: GBSystem_TextHelper().superSmallText(
                                text: validerDocsController
                                    .getCurrentVacation!.VAC_DURATION,
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.left,
                                textColor: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GBSystem_TextHelper().superSmallText(
                              text: "${GbsSystemStrings.str_pause.tr} : ",
                              fontWeight: FontWeight.w500,
                              textColor: GbsSystemStrings.str_primary_color),
                          SizedBox(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.2),
                            child: GBSystem_TextHelper().superSmallText(
                                text:
                                    "${validerDocsController.getCurrentVacation!.VAC_BREAK}",
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.left,
                                textColor: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(
                          text: "${GbsSystemStrings.str_qualification.tr} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemStrings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.5),
                        child: GBSystem_TextHelper().superSmallText(
                            text: validerDocsController
                                .getCurrentVacation!.JOB_LIB,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.left,
                            textColor: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(
                          text: "${GbsSystemStrings.str_telephone.tr} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemStrings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.5),
                        child: GBSystem_TextHelper().superSmallText(
                            text: validerDocsController
                                .getCurrentVacation!.LIE_TLPH,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.left,
                            textColor: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(
                          text: "${GbsSystemStrings.str_lieu.tr} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemStrings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.6),
                        child: GBSystem_TextHelper().superSmallText(
                            text: validerDocsController
                                .getCurrentVacation!.LIE_LIB,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.left,
                            textColor: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(
                          text: "${GbsSystemStrings.str_adresse.tr} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemStrings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.6),
                        child: GBSystem_TextHelper().superSmallText(
                            text: validerDocsController
                                .getCurrentVacation!.LIE_ADR,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.left,
                            textColor: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GBSystem_TextHelper().superSmallText(
                              text: "${GbsSystemStrings.str_entrer.tr} : ",
                              fontWeight: FontWeight.bold,
                              textColor: Colors.green),
                          SizedBox(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.22),
                            child: GBSystem_TextHelper().superSmallText(
                                text: validerDocsController.getCurrentVacation!
                                            .PNTGS_START_HOUR_IN !=
                                        null
                                    ? (validerDocsController.getCurrentVacation!
                                                    .PNTG_START_HOUR !=
                                                null &&
                                            validerDocsController
                                                .getCurrentVacation!
                                                .PNTG_START_HOUR!
                                                .isNotEmpty)
                                        ? VacationModel.convertTime(
                                            validerDocsController
                                                .getCurrentVacation!
                                                .PNTGS_START_HOUR_IN!)
                                        : "${VacationModel.convertTime(validerDocsController.getCurrentVacation!.PNTGS_START_HOUR_IN!)} *"
                                    : "",
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                fontWeight: FontWeight.bold,
                                textColor: Colors.green),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GBSystem_TextHelper().superSmallText(
                              text: "${GbsSystemStrings.str_sortie.tr} : ",
                              fontWeight: FontWeight.bold,
                              textColor: Colors.red),
                          SizedBox(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.22),
                            child: GBSystem_TextHelper().superSmallText(
                                text: validerDocsController.getCurrentVacation!
                                            .PNTGS_START_HOUR_OUT !=
                                        null
                                    ? (validerDocsController.getCurrentVacation!
                                                    .PNTG_END_HOUR !=
                                                null &&
                                            validerDocsController
                                                .getCurrentVacation!
                                                .PNTG_END_HOUR!
                                                .isNotEmpty)
                                        ? VacationModel.convertTime(
                                            validerDocsController
                                                .getCurrentVacation!
                                                .PNTGS_START_HOUR_OUT!)
                                        : "${VacationModel.convertTime(validerDocsController.getCurrentVacation!.PNTGS_START_HOUR_OUT!)} *"
                                    : "",
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                fontWeight: FontWeight.bold,
                                textColor: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          );
  }
}
