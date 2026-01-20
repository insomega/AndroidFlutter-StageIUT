import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_vacation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_vacation_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/custom_date_picker.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class VacationInformations extends StatefulWidget {
  VacationInformations({
    super.key,
    required this.isUpdatePause,
  });

  final bool isUpdatePause;

  @override
  State<VacationInformations> createState() => _VacationInformationsState();
}

class _VacationInformationsState extends State<VacationInformations> {
  final GBSystemVacationController vacationController =
      Get.put(GBSystemVacationController());

  TimeOfDay? hourDebut, hourFin;
  RxBool isLoading = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return vacationController.getCurrentVacation == null
        ? Center(
            child: GBSystem_TextHelper().smallText(
                text: GbsSystemStrings.str_aucune_vacation_trouver,
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
                          text: "${GbsSystemStrings.str_salarie} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemServerStrings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.4),
                        child: Obx(
                          () => GBSystem_TextHelper().superSmallText(
                              text: vacationController
                                  .getCurrentVacationRx!.value!.SVR_CODE_LIB,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.left,
                              textColor: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(
                          text: "${GbsSystemStrings.str_plages_horaires} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemServerStrings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.4),
                        child: Obx(
                          () => GBSystem_TextHelper().superSmallText(
                              text: vacationController
                                  .getCurrentVacationRx!.value!.VAC_HOUR_CALC,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.left,
                              textColor: Colors.black),
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
                          GBSystem_TextHelper().superSmallText(
                              text: "${GbsSystemStrings.str_duree} : ",
                              fontWeight: FontWeight.w500,
                              textColor:
                                  GbsSystemServerStrings.str_primary_color),
                          SizedBox(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.2),
                            child: Obx(
                              () => GBSystem_TextHelper().superSmallText(
                                  text: vacationController.getCurrentVacationRx!
                                      .value!.VAC_DURATION,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.left,
                                  textColor: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GBSystem_TextHelper().superSmallText(
                              text: "${GbsSystemStrings.str_pause} : ",
                              fontWeight: FontWeight.w500,
                              textColor:
                                  GbsSystemServerStrings.str_primary_color),
                          SizedBox(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.2),
                            child: Obx(
                              () => GBSystem_TextHelper().superSmallText(
                                  text:
                                      "${vacationController.getCurrentVacationRx!.value!.VAC_BREAK}",
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.left,
                                  textColor: Colors.black),
                            ),
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                ),
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.close),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          const Text(
                                            GbsSystemStrings.str_modifier_pause,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(
                                            Icons.close,
                                            color: Colors.transparent,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomTimePickerFrench(
                                          labelText:
                                              GbsSystemStrings.str_hour_debut,
                                          onDateSelected: (p0) {
                                            setState(() {
                                              hourDebut = p0;
                                            });
                                            print(hourDebut);
                                          },
                                          selectedDate: TimeOfDay.now()),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomTimePickerFrench(
                                          labelText:
                                              GbsSystemStrings.str_hour_fin,
                                          onDateSelected: (p0) {
                                            setState(() {
                                              hourFin = p0;
                                            });
                                            print(hourFin);
                                          },
                                          selectedDate: TimeOfDay.now()),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // Apply Button
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (hourDebut != null &&
                                              hourFin != null) {
                                            try {
                                              isLoading.value = true;
                                              await GBSystem_AuthService(
                                                      context)
                                                  .updatePauseVacation(
                                                      vacation: vacationController
                                                          .getCurrentVacation!,
                                                      debutPause: hourDebut!,
                                                      finPause: hourFin!)
                                                  .then(
                                                (value) {
                                                  print("result $value");

                                                  isLoading.value = false;
                                                  if (value != null) {
                                                    vacationController
                                                            .getCurrentVacation!
                                                            .VAC_BREAK =
                                                        value.VAC_BREAK;
                                                    vacationController
                                                            .getCurrentVacation!
                                                            .VAC_DURATION =
                                                        value.VAC_DURATION;
                                                    setState(() {});
                                                  }
                                                },
                                              );
                                            } catch (e) {
                                              isLoading.value = false;
                                            }

                                            hourDebut = null;
                                            hourFin = null;

                                            Navigator.pop(context);
                                          } else {
                                            showErrorDialog(
                                                context,
                                                GbsSystemStrings
                                                    .str_choisi_date_debut_fin);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              const Size(double.infinity, 50),
                                          backgroundColor:
                                              GbsSystemServerStrings
                                                  .str_primary_color,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Obx(
                                          () => isLoading.value
                                              ? SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : const Text(
                                                  GbsSystemStrings.str_valider,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Transform.translate(
                              offset: const Offset(-5, -2),
                              child: Icon(
                                Icons.edit,
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(
                          text: "${GbsSystemStrings.str_qualification} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemServerStrings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.5),
                        child: Obx(
                          () => GBSystem_TextHelper().superSmallText(
                              text: vacationController
                                  .getCurrentVacationRx!.value!.JOB_LIB,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.left,
                              textColor: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(
                          text: "${GbsSystemStrings.str_telephone} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemServerStrings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.5),
                        child: Obx(
                          () => GBSystem_TextHelper().superSmallText(
                              text: vacationController
                                  .getCurrentVacationRx!.value!.LIE_TLPH,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.left,
                              textColor: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(
                          text: "${GbsSystemStrings.str_lieu} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemServerStrings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.6),
                        child: Obx(
                          () => GBSystem_TextHelper().superSmallText(
                              text: vacationController
                                  .getCurrentVacationRx!.value!.LIE_LIB,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.left,
                              textColor: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(
                          text: "${GbsSystemStrings.str_adresse} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemServerStrings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.6),
                        child: Obx(
                          () => GBSystem_TextHelper().superSmallText(
                              text: vacationController
                                  .getCurrentVacationRx!.value!.LIE_ADR,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.left,
                              textColor: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => Visibility(
                      visible: // new
                          vacationController.getCurrentVacationRx?.value !=
                                  null &&
                              vacationController
                                      .getCurrentVacationRx!.value!.TPH_PSA ==
                                  "1",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GBSystem_TextHelper().superSmallText(
                                  text: "${GbsSystemStrings.str_entrer} : ",
                                  fontWeight: FontWeight.bold,
                                  textColor: Colors.green),
                              SizedBox(
                                width:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.22),
                                child: Obx(
                                  () => GBSystem_TextHelper().superSmallText(
                                      text: vacationController
                                                  .getCurrentVacationRx!
                                                  .value!
                                                  .PNTGS_START_HOUR_IN !=
                                              null
                                          ? VacationModel.convertTime(
                                              vacationController
                                                  .getCurrentVacationRx!
                                                  .value!
                                                  .PNTGS_START_HOUR_IN!)
                                          : "",
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                      fontWeight: FontWeight.normal,
                                      textColor: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GBSystem_TextHelper().superSmallText(
                                  text: "${GbsSystemStrings.str_sortie} : ",
                                  fontWeight: FontWeight.bold,
                                  textColor: Colors.red),
                              SizedBox(
                                width:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.22),
                                child: Obx(
                                  () => GBSystem_TextHelper().superSmallText(
                                      text: vacationController
                                                  .getCurrentVacationRx!
                                                  .value!
                                                  .PNTGS_START_HOUR_OUT !=
                                              null
                                          ? VacationModel.convertTime(
                                              vacationController
                                                  .getCurrentVacationRx!
                                                  .value!
                                                  .PNTGS_START_HOUR_OUT!)
                                          : "",
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                      fontWeight: FontWeight.normal,
                                      textColor: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
  }
}
