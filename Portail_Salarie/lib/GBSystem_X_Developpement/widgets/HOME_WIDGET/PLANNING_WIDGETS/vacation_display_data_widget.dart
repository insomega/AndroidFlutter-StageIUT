import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_planning_vacation_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class VacationDisplayDataWidget extends StatelessWidget {
  const VacationDisplayDataWidget({super.key, required this.vacationModel});

  final PlanningVacationModel? vacationModel;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return vacationModel == null
        ? EmptyDataWidget()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text(
                    "${GbsSystemStrings.str_plages_horaires.tr} : ",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: GbsSystemStrings.str_primary_color),
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    child: Text(
                      vacationModel!.VAC_HOUR_CALC,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${GbsSystemStrings.str_duree.tr} : ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: GbsSystemStrings.str_primary_color),
                      ),
                      SizedBox(
                        width: size.width * 0.2,
                        child: Text(
                          "${vacationModel!.VAC_DURATION}",
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
                        "${GbsSystemStrings.str_pause.tr} : ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: GbsSystemStrings.str_primary_color),
                      ),
                      SizedBox(
                        width: size.width * 0.2,
                        child: Text(
                          "${vacationModel!.VAC_BREAK}",
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
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "${GbsSystemStrings.str_qualification.tr} : ",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: GbsSystemStrings.str_primary_color),
                  ),
                  SizedBox(
                    width: size.width * 0.5,
                    child: Text(
                      vacationModel!.JOB_LIB,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "${GbsSystemStrings.str_telephone.tr} : ",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: GbsSystemStrings.str_primary_color),
                  ),
                  SizedBox(
                    width: size.width * 0.5,
                    child: Text(
                      vacationModel!.LIE_TLPH,
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
                children: [
                  Text(
                    "${GbsSystemStrings.str_lieu.tr} : ",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: GbsSystemStrings.str_primary_color),
                  ),
                  SizedBox(
                    width: size.width * 0.6,
                    child: Text(
                      vacationModel!.LIE_LIB,
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
                children: [
                  Text(
                    "${GbsSystemStrings.str_adresse.tr} : ",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: GbsSystemStrings.str_primary_color),
                  ),
                  SizedBox(
                    width: size.width * 0.6,
                    child: Text(
                      vacationModel!.LIE_ADR
                      // .replaceAll("Ã©", "é")
                      ,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}

class VacationDisplayDataWidgetPlanning extends StatelessWidget {
  const VacationDisplayDataWidgetPlanning(
      {super.key, required this.vacationModel});

  final PlanningVacationModel? vacationModel;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return vacationModel == null
        ? EmptyDataWidget()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text(
                    "${GbsSystemStrings.str_plages_horaires.tr} : ",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: GbsSystemStrings.str_primary_color),
                  ),
                  Flexible(
                    // width: size.width * 0.4,
                    child: Text(
                      vacationModel!.VAC_HOUR_CALC,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${GbsSystemStrings.str_duree.tr} : ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: GbsSystemStrings.str_primary_color),
                      ),
                      SizedBox(
                        width: size.width * 0.1,
                        child: Text(
                          "${vacationModel!.VAC_DURATION}",
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
                        "${GbsSystemStrings.str_pause.tr} : ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: GbsSystemStrings.str_primary_color),
                      ),
                      SizedBox(
                        width: size.width * 0.1,
                        child: Text(
                          "${vacationModel!.VAC_BREAK}",
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
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "${GbsSystemStrings.str_qualification.tr} : ",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: GbsSystemStrings.str_primary_color),
                  ),
                  Flexible(
                    // width: size.width * 0.5,
                    child: Text(
                      vacationModel!.JOB_LIB,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "${GbsSystemStrings.str_telephone.tr} : ",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: GbsSystemStrings.str_primary_color),
                  ),
                  Flexible(
                    // width: size.width * 0.5,
                    child: Text(
                      vacationModel!.LIE_TLPH,
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
                children: [
                  Text(
                    "${GbsSystemStrings.str_lieu.tr} : ",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: GbsSystemStrings.str_primary_color),
                  ),
                  Flexible(
                    // width: size.width * 0.6,
                    child: Text(
                      vacationModel!.LIE_LIB,
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
                children: [
                  Text(
                    "${GbsSystemStrings.str_adresse.tr} : ",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: GbsSystemStrings.str_primary_color),
                  ),
                  Flexible(
                    // width: size.width * 0.6,
                    child: Text(
                      vacationModel!.LIE_ADR
                      // .replaceAll("Ã©", "é")
                      ,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
