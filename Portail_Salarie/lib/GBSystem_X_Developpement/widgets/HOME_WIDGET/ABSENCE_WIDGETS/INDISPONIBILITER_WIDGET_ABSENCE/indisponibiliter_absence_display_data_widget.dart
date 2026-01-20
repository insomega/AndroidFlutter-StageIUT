import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_indisponibiliter_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_convert_date_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/vacation_title.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/button_entrer_sortie.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class IndisponibiliterAbsenceDispalyDataWidget extends Card {
  IndisponibiliterAbsenceDispalyDataWidget({
    super.key,
    required this.indisponibiliterModel,
    this.onDeleteTap,
  });

  final IndisponibiliterModel? indisponibiliterModel;
  final void Function()? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return indisponibiliterModel == null
        ? Center(
            child: GBSystem_TextHelper().smallText(
                text: GbsSystemStrings.str_empty_data.tr,
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
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    VacationTitle(
                        title: indisponibiliterModel?.SVRHOR_LIB ?? ""),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GBSystem_TextHelper().smallText(
                        text: "${GbsSystemStrings.str_description.tr} : ",
                        fontWeight: FontWeight.w500,
                        textColor: GbsSystemStrings.str_primary_color),
                    Flexible(
                      child: GBSystem_TextHelper().smallText(
                          text: "${indisponibiliterModel!.SYSDAY_SHORTDESC}",
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.left,
                          textColor: Colors.black),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GBSystem_TextHelper().smallText(
                        text: "${GbsSystemStrings.str_debut.tr} : ",
                        fontWeight: FontWeight.w500,
                        textColor: GbsSystemStrings.str_primary_color),
                    Flexible(
                      child: GBSystem_TextHelper().smallText(
                          text: indisponibiliterModel!.SVRHOR_DATD != null
                              ? "${indisponibiliterModel!.SVRHOR_DATD!.day}/${indisponibiliterModel!.SVRHOR_DATD!.month}/${indisponibiliterModel!.SVRHOR_DATD!.year}"
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
                    GBSystem_TextHelper().smallText(
                        text: "${GbsSystemStrings.str_fin.tr} : ",
                        fontWeight: FontWeight.w500,
                        textColor: GbsSystemStrings.str_primary_color),
                    Flexible(
                      // width: GBSystem_ScreenHelper.screenWidthPercentage(
                      //     context, 0.2),
                      child: GBSystem_TextHelper().smallText(
                          text: indisponibiliterModel!.SVRHOR_DATF != null
                              ? "${indisponibiliterModel!.SVRHOR_DATF?.day}/${indisponibiliterModel!.SVRHOR_DATF?.month}/${indisponibiliterModel!.SVRHOR_DATF?.year}"
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
                    GBSystem_TextHelper().smallText(
                        text: "${GbsSystemStrings.str_hour_debut.tr} : ",
                        fontWeight: FontWeight.w500,
                        textColor: GbsSystemStrings.str_primary_color),
                    Flexible(
                      // width: GBSystem_ScreenHelper.screenWidthPercentage(
                      //     context, 0.2),
                      child: GBSystem_TextHelper().smallText(
                          text: indisponibiliterModel?.SVRHOR_HEUD != null
                              ? "${ConvertDateService().formatSeconds(seconds: indisponibiliterModel!.SVRHOR_HEUD)}"
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
                    GBSystem_TextHelper().smallText(
                        text: "${GbsSystemStrings.str_hour_fin.tr} : ",
                        fontWeight: FontWeight.w500,
                        textColor: GbsSystemStrings.str_primary_color),
                    Flexible(
                      // width: GBSystem_ScreenHelper.screenWidthPercentage(
                      //     context, 0.2),
                      child: GBSystem_TextHelper().smallText(
                          text: indisponibiliterModel?.SVRHOR_HEUF != null
                              ? "${ConvertDateService().formatSeconds(seconds: indisponibiliterModel!.SVRHOR_HEUF)}"
                              : "",
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.left,
                          textColor: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(
                  color: Colors.grey.shade200,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonEntrerSortieWithIcon(
                      onTap: onDeleteTap,
                      horPadd: 5,
                      verPadd: 5,
                      icon: Icon(
                        CupertinoIcons.delete,
                        color: Colors.white,
                      ),
                      color: GbsSystemStrings.str_primary_color,
                    )
                  ],
                )
              ],
            ),
          );
  }
}
