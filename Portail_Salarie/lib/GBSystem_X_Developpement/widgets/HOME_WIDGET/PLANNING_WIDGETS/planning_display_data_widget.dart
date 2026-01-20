import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_absence_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_planning_dispo_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_planning_download_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_convert_date_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/vacation_title.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class PlanningDisplayDataWidget extends StatefulWidget {
  const PlanningDisplayDataWidget(
      {super.key,
      required this.planningDownloadModel,
      required this.planningDisponibleModel,
      this.onTelechargerTap,
      this.onAfficherTap,
      this.onZoomTap,
      this.showDownloadBtn = true,
      this.btnTelechargerText});
  final bool showDownloadBtn;
  final String? btnTelechargerText;
  final List<PlanningDownloadModel>? planningDownloadModel;
  final PlanningDisponibleModel? planningDisponibleModel;
  final void Function()? onTelechargerTap, onAfficherTap, onZoomTap;

  @override
  State<PlanningDisplayDataWidget> createState() =>
      _PlanningDisplayDataWidgetState();
}

class _PlanningDisplayDataWidgetState extends State<PlanningDisplayDataWidget> {
  PlanningDownloadModel? selectedPlanningDownloadModel;

  @override
  void initState() {
    selectedPlanningDownloadModel = widget.planningDownloadModel!
        .where(
          (element) =>
              element.SVRPPH_IDF == widget.planningDisponibleModel!.SVRPPH_IDF,
        )
        .firstOrNull;
    // print(selectedPlanningDownloadModel);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.planningDisponibleModel == null
        ? EmptyDataWidget()
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VacationTitle(
                      title:
                          widget.planningDisponibleModel?.SVRPPH_START_DATE !=
                                  null
                              ? ConvertDateService().formatDatePlanning(widget
                                  .planningDisponibleModel!.SVRPPH_START_DATE!)
                              : ""
                      // title:
                      // s
                      // widget.planningDisponibleModel!.MONTH_NAME
                      ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "${GbsSystemStrings.str_consultation.tr} : ",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: GbsSystemStrings.str_primary_color),
                  ),
                  Flexible(
                    child: Text(
                      selectedPlanningDownloadModel?.SVRPPH_DATE_VUE != null
                          ?
                          // "${planningDownloadModel!.SVRPPH_DATE_VUE!.day}/${planningDownloadModel!.SVRPPH_DATE_VUE!.month}/${planningDownloadModel!.SVRPPH_DATE_VUE!.year} ${planningDownloadModel!.SVRPPH_DATE_VUE!.hour}:${planningDownloadModel!.SVRPPH_DATE_VUE!.minute}"
                          "${AbsenceModel.convertDateAndTime(widget.planningDownloadModel!.where((element) => element.SVRPPH_IDF == widget.planningDisponibleModel!.SVRPPH_IDF).first.SVRPPH_DATE_VUE!)}"
                          : "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${GbsSystemStrings.str_telechargement.tr} : ",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: GbsSystemStrings.str_primary_color),
                  ),
                  Flexible(
                    child: Text(
                      selectedPlanningDownloadModel?.SVRPPH_DATE_DWNL != null
                          ?
                          // "${planningDownloadModel!.SVRPPH_DATE_DWNL?.day}/${planningDownloadModel!.SVRPPH_DATE_DWNL?.month}/${planningDownloadModel!.SVRPPH_DATE_DWNL?.year} ${planningDownloadModel!.SVRPPH_DATE_DWNL?.hour}:${planningDownloadModel!.SVRPPH_DATE_DWNL?.minute}"
                          "${AbsenceModel.convertDateAndTime(widget.planningDownloadModel!.where((element) => element.SVRPPH_IDF == widget.planningDisponibleModel!.SVRPPH_IDF).first.SVRPPH_DATE_DWNL!)}"
                          : "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${GbsSystemStrings.str_publication.tr} : ",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: GbsSystemStrings.str_primary_color),
                  ),
                  Flexible(
                    child: Text(
                      selectedPlanningDownloadModel?.LAST_UPDT != null
                          ?
                          //  "${planningDownloadModel!.LAST_UPDT!.day}/${planningDownloadModel!.LAST_UPDT!.month}/${planningDownloadModel!.LAST_UPDT!.year} ${planningDownloadModel!.LAST_UPDT!.hour}:${planningDownloadModel!.LAST_UPDT!.minute}"
                          "${AbsenceModel.convertDateAndTime(widget.planningDownloadModel!.where((element) => element.SVRPPH_IDF == widget.planningDisponibleModel!.SVRPPH_IDF).first.LAST_UPDT!)}"
                          : "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: widget.showDownloadBtn,
                    child: CustomButtonWithTrailling(
                        onTap: widget.onTelechargerTap,
                        trailling: Icon(
                          Icons.picture_as_pdf,
                          color: Colors.white,
                          size: 14,
                        ),
                        textSize: 10,
                        verPadding: 10,
                        horPadding: 5,
                        text: widget.btnTelechargerText ??
                            GbsSystemStrings.str_pdf.tr),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CustomButtonWithTrailling(
                      horPadding: 5,
                      onTap: widget.onAfficherTap,
                      trailling: Icon(
                        CupertinoIcons.eye,
                        color: Colors.white,
                        size: 14,
                      ),
                      textSize: 10,
                      verPadding: 10,
                      // horPadding: 2,
                      text: GbsSystemStrings.str_afficher.tr),
                  SizedBox(
                    width: 5,
                  ),
                  CustomIconButton(
                    onTap: widget.onZoomTap,
                    icon: Icon(
                      CupertinoIcons.zoom_in,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              )
            ],
          );
  }
}
