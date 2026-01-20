import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_historique_model.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class HistoriqueWidget extends StatefulWidget {
  const HistoriqueWidget({super.key, required this.historiqueModel});

  final HistoriqueModel historiqueModel;

  @override
  State<HistoriqueWidget> createState() => _HistoriqueWidgetState();
}

class _HistoriqueWidgetState extends State<HistoriqueWidget> {
  @override
  void initState() {
    initializeDateFormatting(getLocaleApplication(), null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal:
              GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
          vertical:
              GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Colors.grey.shade500),
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
        children: [
          GBSystem_TextHelper().smallText(
              text: getMessageHistorique(
                  historiqueModel: widget.historiqueModel)[0],
              maxLines: 5,
              textColor: Colors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text: getMessageHistorique(
                        historiqueModel: widget.historiqueModel)[1],
                    maxLines: 5,
                    textColor: Colors.black),
              ),
              Flexible(
                child: GBSystem_TextHelper().smallText(
                    text:
                        "${HistoriqueModel.convertDateAndTime(widget.historiqueModel.PUB_DATE!)}",
                    maxLines: 2,
                    textColor: GbsSystemStrings.str_primary_color),
              ),
            ],
          ),
          Visibility(
            visible:
                getMessageHistorique(historiqueModel: widget.historiqueModel)[2]
                    .isNotEmpty,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: GBSystem_TextHelper().smallText(
                      text: getMessageHistorique(
                          historiqueModel: widget.historiqueModel)[2],
                      maxLines: 5,
                      textColor: Colors.black),
                ),
                Flexible(
                  child: GBSystem_TextHelper().smallText(
                      text:
                          "${HistoriqueModel.convertDateAndTime(widget.historiqueModel.SVRHIST_DATE!)}",
                      maxLines: 2,
                      textColor: GbsSystemStrings.str_primary_color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> getMessageHistorique(
      {required HistoriqueModel historiqueModel}) {
    String message1 = "", message2 = "", message3 = "";
    String SVRHIST_ACTION_D_month_name = DateFormat.MMMM(getLocaleApplication())
        .format(historiqueModel.SVRHIST_ACTION_D!);

    // DateFormat('MMMM','es').format(historiqueModel.SVRHIST_ACTION_D!);
    // print("locale : ${getLocaleApplication()}");
    // print("locl : ${ui.window.locale.toString()}");

    //message 1
    if (historiqueModel.SVRHIST_TYP == "1") {
      message1 = message1 +
          "${GbsSystemStrings.str_planning_du_mois.tr} ${SVRHIST_ACTION_D_month_name} ${historiqueModel.SVRHIST_ACTION_D!.year}";
    } else {
      if (historiqueModel.TPH_TYPE == "IND") {
        message1 = message1 +
            "${GbsSystemStrings.str_demande_indisponibiliter.tr} ${GbsSystemStrings.str_du.tr} ${HistoriqueModel.convertDate(widget.historiqueModel.SVRHIST_ACTION_D!)} ${GbsSystemStrings.str_au.tr} ${verifierTwoDateYearIfTheSameAndDisplayDate(displayedDate: historiqueModel.SVRHIST_ACTION_F, comparedDate: historiqueModel.SVRHIST_ACTION_D!)}";
      } else {
        message1 = message1 +
            "${GbsSystemStrings.str_demande_absence_du.tr} ${HistoriqueModel.convertDate(widget.historiqueModel.SVRHIST_ACTION_D!)} ${GbsSystemStrings.str_au.tr} ${verifierTwoDateYearIfTheSameAndDisplayDate(displayedDate: historiqueModel.SVRHIST_ACTION_F, comparedDate: historiqueModel.SVRHIST_ACTION_D!)}";
      }
    }
    //// message 2
    if (historiqueModel.SVRHIST_TYP == "1") {
      message2 = message2 + "${GbsSystemStrings.str_publier.tr} ";
      // ${HistoriqueModel.convertDateAndTime(historiqueModel.PUB_DATE!)}
    } else {
      message2 = message2 + "${GbsSystemStrings.str_effectuee_le.tr} ";
      //  ${HistoriqueModel.convertDateAndTime(historiqueModel.PUB_DATE!)}
    }

    /// message 3
    if (historiqueModel.SVRHIST_TYP == "1") {
      message3 = message3 + "${GbsSystemStrings.str_consulter.tr} ";
    } else {
      if (historiqueModel.SVRHIST_DATE != null) {
        if (historiqueModel.PLATPH_ETAT == "AC") {
          message3 = message3 + "${GbsSystemStrings.str_accepter_le.tr} ";
          // ${HistoriqueModel.convertDateAndTime(historiqueModel.SVRHIST_DATE!)}
        } else if (historiqueModel.PLATPH_ETAT == "RF") {
          message3 = message3 + "${GbsSystemStrings.str_refuser_le.tr} ";
        } else if (historiqueModel.PLATPH_ETAT == "CL") {
          message3 = message3 + "${GbsSystemStrings.str_clotures_le.tr} ";
        } else if (historiqueModel.PLATPH_ETAT == "PR") {
          message3 = message3 + "${GbsSystemStrings.str_proposer_le.tr} ";
        }
      }
    }
    return [message1, message2, message3];
  }

  String getLocaleApplication() {
    return Get.locale.toString() != 'gr' ? Get.locale.toString() : 'en';
    // List<String> myLocales = ["fr", "en", "de", "es", "gr", "pt", "ro", "tr"];
    // if (myLocales.contains(ui.window.locale.toString().substring(0, 2))) {
    //   return ui.window.locale.toString().substring(0, 2);
    // } else {
    //   return "fr-FR";
    // }
  }

  String verifierTwoDateYearIfTheSameAndDisplayDate(
      {required DateTime? displayedDate, required DateTime comparedDate}) {
    String displayString = '';
    if (displayedDate != null) {
      if (displayedDate.year == comparedDate.year) {
        displayString = displayString +
            "${HistoriqueModel.Add_zero(displayedDate.day)}-${HistoriqueModel.Add_zero(displayedDate.month)}";
      } else {
        displayString = displayString +
            "${HistoriqueModel.Add_zero(displayedDate.day)}-${HistoriqueModel.Add_zero(displayedDate.month)}-${displayedDate.year}";
      }
    }

    return displayString;
  }
}
