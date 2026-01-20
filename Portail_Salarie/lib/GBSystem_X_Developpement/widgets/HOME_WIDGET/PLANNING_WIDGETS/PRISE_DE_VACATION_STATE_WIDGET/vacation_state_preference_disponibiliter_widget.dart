import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_prise_de_vacation_state_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/vacation_title.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/button_entrer_sortie.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class PreferenceStateDisponibiliterWidget extends Card {
  PreferenceStateDisponibiliterWidget({
    super.key,
    required this.preferenceModel,
    this.onSaveTap,
    this.onDeleteTap,
  });

  final PriseDeVacationStateModel? preferenceModel;
  final void Function()? onSaveTap, onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return preferenceModel == null
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
                    context, 0.02)),
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
                        title: preferenceModel!.DISPONIBILITE_LIB ==
                                "str_exclu_ponctuelle"
                            ? GbsSystemStrings.str_exclu_ponctuelle.tr
                            : preferenceModel!.DISPONIBILITE_LIB ==
                                    "str_dispo_ponctuelle"
                                ? GbsSystemStrings.str_dispo_ponctuelle.tr
                                : preferenceModel!.DISPONIBILITE_LIB ==
                                        "str_dispo_recurrente"
                                    ? GbsSystemStrings.str_dispo_recurrente.tr
                                    : GbsSystemStrings.str_dispo_definitive.tr),
                  ],
                ),
                const SizedBox(
                  height: 10,
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
                          text:
                              "${preferenceModel!.START_DATE_EXCLU!.day}/${preferenceModel!.START_DATE_EXCLU!.month}/${preferenceModel!.START_DATE_EXCLU!.year}",
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
                          text: preferenceModel!.END_DATE_EXCLU != null
                              ? "${preferenceModel!.END_DATE_EXCLU?.day}/${preferenceModel!.END_DATE_EXCLU?.month}/${preferenceModel!.END_DATE_EXCLU?.year}"
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: preferenceModel!.EXCLUSION_LIB !=
                          "str_dispo_definitive",
                      child: ButtonEntrerSortieWithIcon(
                        onTap: onSaveTap,
                        horPadd: 5,
                        verPadd: 5,
                        icon: Icon(
                          CupertinoIcons.doc_text_fill,
                          color: Colors.white,
                        ),
                        color: GbsSystemStrings.str_primary_color,
                      ),
                    ),
                    Visibility(
                      visible: compareDateisBeforeDate(
                          firstDate: preferenceModel!.START_DATE_EXCLU!,
                          secondDate: DateTime.now()),

                      // (preferenceModel!.START_DATE_EXCLU!
                      //             .compareTo(DateTime.now()) ==
                      //         -1
                      //     ? false
                      //     : true),
                      //  preferenceModel!.EXCLUSION_LIB != "str_dispo_definitive" &&
                      child: ButtonEntrerSortieWithIcon(
                        onTap: onDeleteTap,
                        horPadd: 5,
                        verPadd: 5,
                        icon: Icon(
                          CupertinoIcons.delete,
                          color: Colors.white,
                        ),
                        color: GbsSystemStrings.str_primary_color,
                      ),
                    )
                  ],
                )
              ],
            ),
          );
  }

  bool compareDateisBeforeDate({
    required DateTime firstDate,
    required DateTime secondDate,
  }) {
    if (firstDate.day == secondDate.day &&
        firstDate.month == secondDate.month &&
        firstDate.year == secondDate.year) {
      return true;
    } else {
      if (preferenceModel!.START_DATE_EXCLU!.compareTo(DateTime.now()) == 1) {
        return true;
      } else {
        return false;
      }
    }
  }
}
