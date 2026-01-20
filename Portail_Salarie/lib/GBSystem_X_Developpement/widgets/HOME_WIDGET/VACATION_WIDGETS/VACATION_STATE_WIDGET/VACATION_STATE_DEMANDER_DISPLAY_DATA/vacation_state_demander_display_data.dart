import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_vacation_state_demander_model.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class VacationStateDemanderDisplayData extends StatelessWidget {
  VacationStateDemanderDisplayData({
    super.key,
    required this.vacationStateModel,
    required this.updateLoading,
  });
  final VacationStateDemanderModel? vacationStateModel;
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
                          text: "${GbsSystemStrings.str_date_demande.tr} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemStrings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.4),
                        child: GBSystem_TextHelper().superSmallText(
                            text: vacationStateModel!.PLAPSVR_DEMANDE_DATE !=
                                    null
                                ? VacationStateDemanderModel.convertDate(
                                    vacationStateModel!.PLAPSVR_DEMANDE_DATE!)
                                : "",
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
                              text: "${GbsSystemStrings.str_debut.tr} : ",
                              fontWeight: FontWeight.w500,
                              textColor: GbsSystemStrings.str_primary_color),
                          SizedBox(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.2),
                            child: GBSystem_TextHelper().superSmallText(
                                text: vacationStateModel!.VAC_START_HOUR != null
                                    ? VacationStateDemanderModel.convertDate(
                                        vacationStateModel!.VAC_START_HOUR!)
                                    : "",
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
                              text: "${GbsSystemStrings.str_fin.tr} : ",
                              fontWeight: FontWeight.w500,
                              textColor: GbsSystemStrings.str_primary_color),
                          SizedBox(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.2),
                            child: GBSystem_TextHelper().superSmallText(
                                text: vacationStateModel!.VAC_END_HOUR != null
                                    ? "${VacationStateDemanderModel.convertDate(vacationStateModel!.VAC_END_HOUR!)}"
                                    : "",
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.left,
                                textColor: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GBSystem_TextHelper().superSmallText(
                              text: "${GbsSystemStrings.str_hour_debut.tr} : ",
                              fontWeight: FontWeight.w500,
                              textColor: GbsSystemStrings.str_primary_color),
                          SizedBox(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.13),
                            child: GBSystem_TextHelper().superSmallText(
                                text: vacationStateModel!.VAC_START_HOUR != null
                                    ? VacationStateDemanderModel.convertTime(
                                        vacationStateModel!.VAC_START_HOUR!)
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
                              text: "${GbsSystemStrings.str_hour_fin.tr} : ",
                              fontWeight: FontWeight.w500,
                              textColor: GbsSystemStrings.str_primary_color),
                          SizedBox(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.2),
                            child: GBSystem_TextHelper().superSmallText(
                                text: vacationStateModel!.VAC_END_HOUR != null
                                    ? VacationStateDemanderModel.convertTime(
                                        vacationStateModel!.VAC_END_HOUR!)
                                    : "",
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
                ],
              ),
            ],
          );
  }
}
