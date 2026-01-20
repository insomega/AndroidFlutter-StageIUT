import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_prise_de_vacation_model.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class VacationPriseDeVacationWidget extends Card {
  VacationPriseDeVacationWidget({
    super.key,
    required this.priseDeVacationModel,
  });

  final PriseDeVacationModel? priseDeVacationModel;

  @override
  Widget build(BuildContext context) {
    return priseDeVacationModel == null
        ? Center(
            child: GBSystem_TextHelper().smallText(
                text: GbsSystemStrings.str_aucune_vacation_trouver.tr,
                textColor: Colors.black),
          )
        : Container(
            padding: EdgeInsets.symmetric(
                horizontal:
                    GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
                vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                    context, 0.01)),
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
                    offset: const Offset(10, 40), // changes the shadow position
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: -40,
                    blurRadius: 22,
                    offset:
                        const Offset(-10, -40), // changes the shadow position
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GBSystem_TextHelper().superSmallText(
                        text: "${GbsSystemStrings.str_vacation.tr} : ",
                        fontWeight: FontWeight.w500,
                        textColor: GbsSystemStrings.str_primary_color),
                    Flexible(
                      child: GBSystem_TextHelper().superSmallText(
                          text: priseDeVacationModel!.JOB_LIB,
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
                        text: "${GbsSystemStrings.str_date_demande.tr} : ",
                        fontWeight: FontWeight.w500,
                        textColor: GbsSystemStrings.str_primary_color),
                    Flexible(
                      // width: GBSystem_ScreenHelper.screenWidthPercentage(
                      //     context, 0.2),
                      child: GBSystem_TextHelper().superSmallText(
                          text:
                              "${priseDeVacationModel!.VAC_PUB_DATE!.day}/${priseDeVacationModel!.VAC_PUB_DATE!.month}/${priseDeVacationModel!.VAC_PUB_DATE!.year}",
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.left,
                          textColor: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GBSystem_TextHelper().superSmallText(
                        text: "${GbsSystemStrings.str_date_debut.tr} : ",
                        fontWeight: FontWeight.w500,
                        textColor: GbsSystemStrings.str_primary_color),
                    Flexible(
                      // width: GBSystem_ScreenHelper.screenWidthPercentage(
                      //     context, 0.5),
                      child: GBSystem_TextHelper().superSmallText(
                          text:
                              "${priseDeVacationModel!.VAC_START_HOUR!.day}/${priseDeVacationModel!.VAC_START_HOUR!.month}/${priseDeVacationModel!.VAC_START_HOUR!.year}",
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.left,
                          textColor: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GBSystem_TextHelper().superSmallText(
                        text: "${GbsSystemStrings.str_hour_debut.tr} : ",
                        fontWeight: FontWeight.w500,
                        textColor: GbsSystemStrings.str_primary_color),
                    Flexible(
                      // width: GBSystem_ScreenHelper.screenWidthPercentage(
                      //     context, 0.5),
                      child: GBSystem_TextHelper().superSmallText(
                          text:
                              "${priseDeVacationModel!.VAC_START_HOUR!.hour}:${priseDeVacationModel!.VAC_START_HOUR!.minute}",
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.left,
                          textColor: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GBSystem_TextHelper().superSmallText(
                        text: "${GbsSystemStrings.str_date_fin.tr} : ",
                        fontWeight: FontWeight.w500,
                        textColor: GbsSystemStrings.str_primary_color),
                    Flexible(
                      // width: GBSystem_ScreenHelper.screenWidthPercentage(
                      //     context, 0.6),
                      child: GBSystem_TextHelper().superSmallText(
                          text:
                              "${priseDeVacationModel!.VAC_END_HOUR!.day}/${priseDeVacationModel!.VAC_END_HOUR!.month}/${priseDeVacationModel!.VAC_END_HOUR!.year}",
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
                    Flexible(
                      // width: GBSystem_ScreenHelper.screenWidthPercentage(
                      //     context, 0.6),
                      child: GBSystem_TextHelper().superSmallText(
                          text:
                              "${priseDeVacationModel!.VAC_END_HOUR!.hour}:${priseDeVacationModel!.VAC_END_HOUR!.minute}",
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
                    Flexible(
                      // width: GBSystem_ScreenHelper.screenWidthPercentage(
                      //     context, 0.6),
                      child: GBSystem_TextHelper().superSmallText(
                          text: priseDeVacationModel!.LIE_LIB,
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
                            text: "${GbsSystemStrings.str_etat.tr} : ",
                            fontWeight: FontWeight.bold,
                            textColor: Colors.black),
                        SizedBox(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(
                              context, 0.22),
                          child: GBSystem_TextHelper().superSmallText(
                              text: priseDeVacationModel!.PLAPSVR_STATE,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              fontWeight: FontWeight.normal,
                              textColor: Colors.black),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
  }
}
