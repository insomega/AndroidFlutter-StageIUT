import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_state_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_vacation_state_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class VacationStateDisplayData extends StatelessWidget {
  VacationStateDisplayData({
    super.key,
    required this.vacationStateModel,
    required this.updateLoading,
  });
  final VacationStateModel? vacationStateModel;
  final Function updateLoading;
  @override
  Widget build(BuildContext context) {
    return vacationStateModel == null
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
                            text: vacationStateModel!.VAC_HOUR_CALC,
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
                                text: vacationStateModel!.VAC_DURATION,
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
                                text: "${vacationStateModel!.VAC_BREAK}",
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
                            text: vacationStateModel!.JOB_LIB,
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
                            text: vacationStateModel!.LIE_TLPH,
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
                            context, 0.5),
                        child: GBSystem_TextHelper().superSmallText(
                            text: vacationStateModel!.LIE_LIB,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.left,
                            textColor: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GBSystem_TextHelper().superSmallText(
                          text: "${GbsSystemStrings.str_adresse.tr} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemStrings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.5),
                        child: GBSystem_TextHelper().superSmallText(
                            text: vacationStateModel!.LIE_ADR,
                            fontWeight: FontWeight.normal,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            textColor: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(
                          text: "${GbsSystemStrings.str_publier_le.tr} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemStrings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.5),
                        child: GBSystem_TextHelper().superSmallText(
                            text: vacationStateModel!.VAC_PUB_DATE != null
                                ? VacationStateModel.convertDate(
                                    vacationStateModel!.VAC_PUB_DATE!)
                                : "",
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.left,
                            textColor: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(
                          text: "${GbsSystemStrings.str_distance.tr} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemStrings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.5),
                        child: GBSystem_TextHelper().superSmallText(
                            text: vacationStateModel!.DISTANCE != null &&
                                    vacationStateModel!.DISTANCE!.isNotEmpty
                                ? vacationStateModel!.DISTANCE!
                                : "0.000",
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.left,
                            textColor: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        vacationStateModel!.STATE == "str_en_attente"
                            ? CustomButtonWithTrailling(
                                onTap: () async {
                                  updateLoading(true);

                                  await GBSystem_AuthService(context)
                                      .vacationStateDemandeAction(
                                          vacationStateModel:
                                              vacationStateModel!)
                                      .then((value) async {
                                    if (value != null) {
                                      updateLoading(false);

                                      final vacationStateController = Get.put<
                                              GBSystemVacationStateController>(
                                          GBSystemVacationStateController());
                                      vacationStateController.updateVacation(
                                          vacationStateModel!, value);
                                      await GBSystem_AuthService(context)
                                          .getNombreVacationProposer()
                                          .then((nbrVac) async {
                                        if (nbrVac != null) {
                                          final vacationController = Get.put<
                                                  GBSystemVacationController>(
                                              GBSystemVacationController());
                                          vacationController
                                                  .setNumberVacationsProposer =
                                              nbrVac;
                                        }
                                      });
                                    }
                                  });
                                },
                                text: GbsSystemStrings.kDemander.tr,
                                textSize: 12,
                                horPadding: 10,
                                verPadding: 10,
                                trailling: Icon(
                                  CupertinoIcons.check_mark,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                color: Colors.green,
                              )
                            : Container(),
                        vacationStateModel!.STATE == "str_en_attente" ||
                                vacationStateModel!.STATE == "str_demandee" ||
                                vacationStateModel!.STATE == "str_refusee"
                            ? CustomButtonWithTrailling(
                                onTap: vacationStateModel!.STATE ==
                                        "str_en_attente"
                                    ? () async {
                                        updateLoading(true);

                                        await GBSystem_AuthService(context)
                                            .vacationStateRefuserAction(
                                                vacationStateModel:
                                                    vacationStateModel!)
                                            .then((value) async {
                                          updateLoading(false);

                                          if (value != null) {
                                            final vacationStateController = Get.put<
                                                    GBSystemVacationStateController>(
                                                GBSystemVacationStateController());
                                            vacationStateController
                                                .updateVacation(
                                                    vacationStateModel!, value);
                                            await GBSystem_AuthService(context)
                                                .getNombreVacationProposer()
                                                .then((nbrVac) async {
                                              if (nbrVac != null) {
                                                final vacationController = Get.put<
                                                        GBSystemVacationController>(
                                                    GBSystemVacationController());
                                                vacationController
                                                        .setNumberVacationsProposer =
                                                    nbrVac;
                                                // print(vacationController.getNumberVacationProposer);
                                              }
                                            });
                                          }
                                        });
                                      }
                                    : () async {
                                        updateLoading(true);

                                        await GBSystem_AuthService(context)
                                            .vacationStateAnnulerAction(
                                                vacationStateModel:
                                                    vacationStateModel!)
                                            .then((value) async {
                                          updateLoading(false);

                                          if (value != null) {
                                            final vacationStateController = Get.put<
                                                    GBSystemVacationStateController>(
                                                GBSystemVacationStateController());
                                            vacationStateController
                                                .updateVacation(
                                                    vacationStateModel!, value);
                                            await GBSystem_AuthService(context)
                                                .getNombreVacationProposer()
                                                .then((nbrVac) async {
                                              if (nbrVac != null) {
                                                final vacationController = Get.put<
                                                        GBSystemVacationController>(
                                                    GBSystemVacationController());
                                                vacationController
                                                        .setNumberVacationsProposer =
                                                    nbrVac;
                                                // print(vacationController.getNumberVacationProposer);
                                              }
                                            });
                                          }
                                        });
                                      },
                                text: vacationStateModel!.STATE ==
                                        "str_en_attente"
                                    ? GbsSystemStrings.kRefuser.tr
                                    : GbsSystemStrings.str_annuler.tr,
                                textSize: 12,
                                horPadding: 10,
                                verPadding: 10,
                                trailling: Icon(
                                  CupertinoIcons.multiply,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                color: Colors.red,
                              )
                            : Container(),
                        // CustomButtonWithTrailling(
                        //   onTap: () async {},
                        //   text: GbsSystemStrings.str_geolocaliser.tr,
                        //   textSize: 12,
                        //   horPadding: 10,
                        //   verPadding: 10,
                        //   trailling: Icon(
                        //     CupertinoIcons.location_solid,
                        //     color: Colors.white,
                        //     size: 10,
                        //   ),
                        //   color: Colors.blue,
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
  }
}
