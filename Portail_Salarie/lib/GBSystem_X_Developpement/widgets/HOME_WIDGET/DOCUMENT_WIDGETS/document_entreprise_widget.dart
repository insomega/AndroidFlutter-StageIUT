import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_document_entreprise_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/vacation_title.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class DocumentEntrepriseWidget extends Card {
  DocumentEntrepriseWidget({
    super.key,
    required this.docEntreprise,
    this.onTelechargerTap,
  });

  final DocumentEntrepriseModel? docEntreprise;
  final void Function()? onTelechargerTap;

  @override
  Widget build(BuildContext context) {
    return docEntreprise == null
        ? Center(
            child: GBSystem_TextHelper().smallText(
                text: GbsSystemStrings.str_empty_data.tr,
                textColor: Colors.black),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
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
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.8),
                        maxLines: 2,
                        title: docEntreprise?.DOCAN_LIB ?? ""),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GBSystem_TextHelper().smallText(
                        text: "${GbsSystemStrings.str_document.tr.tr} : ",
                        fontWeight: FontWeight.w500,
                        textColor: GbsSystemStrings.str_primary_color),
                    Flexible(
                      child: GBSystem_TextHelper().smallText(
                          text: "${docEntreprise!.DOCAN_CODE}",
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
                        text: "${GbsSystemStrings.str_type_document.tr.tr} : ",
                        fontWeight: FontWeight.w500,
                        textColor: GbsSystemStrings.str_primary_color),
                    Flexible(
                      child: GBSystem_TextHelper().smallText(
                          text: "${docEntreprise!.TYPDOC_CODE}",
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
                        text: "${GbsSystemStrings.str_entreprise.tr.tr} : ",
                        fontWeight: FontWeight.w500,
                        textColor: GbsSystemStrings.str_primary_color),
                    Flexible(
                      child: GBSystem_TextHelper().smallText(
                          text: "${docEntreprise!.ENT_CODE}",
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
                        text: "${GbsSystemStrings.str_creation.tr} : ",
                        fontWeight: FontWeight.w500,
                        textColor: GbsSystemStrings.str_primary_color),
                    Flexible(
                      child: GBSystem_TextHelper().smallText(
                          text: docEntreprise!.DOCAN_DATE_CREATED != null
                              ? DocumentEntrepriseModel.convertDateAndTime(
                                  docEntreprise!.DOCAN_DATE_CREATED!)
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
                        text: "${GbsSystemStrings.str_telechargement.tr} : ",
                        fontWeight: FontWeight.w500,
                        textColor: GbsSystemStrings.str_primary_color),
                    Flexible(
                      child: GBSystem_TextHelper().smallText(
                          text: docEntreprise!.LAST_UPDT != null
                              ? DocumentEntrepriseModel.convertDateAndTime(
                                  docEntreprise!.LAST_UPDT!)
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
                        text:
                            "${GbsSystemStrings.str_nombre_des_telechargement.tr.tr} : ",
                        fontWeight: FontWeight.w500,
                        textColor: GbsSystemStrings.str_primary_color),
                    Flexible(
                      child: GBSystem_TextHelper().smallText(
                          text: "${docEntreprise!.DOCAN_DWNLD_NBR}",
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
                    CustomButtonWithTrailling(
                      trailling: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),
                      ),
                      text: GbsSystemStrings.str_afficher.tr +
                          " / " +
                          GbsSystemStrings.str_partager.tr,
                      onTap: onTelechargerTap,
                      horPadding: 5,
                      verPadding: 5,
                    )
                  ],
                )
              ],
            ),
          );
  }
}
