import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gbsystem_root/custom_date_picker.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_snack_bar.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';

import 'GBSystem_Vacation_Informations_Controller.dart';
import 'package:gbsystem_root/GBSystem_vacation_model.dart';

class GBSystem_Vacation_Informations_Widget extends StatefulWidget {
  const GBSystem_Vacation_Informations_Widget({super.key, required this.isUpdatePause});

  final bool isUpdatePause;

  @override
  State<GBSystem_Vacation_Informations_Widget> createState() => _VacationInformationsState();
}

class _VacationInformationsState extends State<GBSystem_Vacation_Informations_Widget> {
  //

  final GBSystem_Vacation_Informations_Controller Vacation_Informations_Controller = Get.put(GBSystem_Vacation_Informations_Controller());

  TimeOfDay? hourDebut, hourFin;
  RxBool isLoading = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Vacation_Informations_Controller.currentVacation == null
        ? Center(
            child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_aucune_vacation_trouver, textColor: Colors.black),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //ligne salarié
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(text: "${GBSystem_Application_Strings.str_salarie} : ", fontWeight: FontWeight.w500, textColor: GBSystem_System_Strings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.4),
                        child: Obx(
                          () => GBSystem_TextHelper().superSmallText(
                            text: Vacation_Informations_Controller.currentVacationSafe_SVR_CODE_LIB, //
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.left,
                            textColor: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Ligne plage horraire
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(text: "${GBSystem_Application_Strings.str_plages_horaires} : ", fontWeight: FontWeight.w500, textColor: GBSystem_System_Strings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.4),
                        child: Obx(() => GBSystem_TextHelper().superSmallText(text: Vacation_Informations_Controller.currentVacationSafe_VAC_HOUR_CALC, fontWeight: FontWeight.normal, textAlign: TextAlign.left, textColor: Colors.black)),
                      ),
                    ],
                  ),
                  //Ligne durée
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Ligne durée
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GBSystem_TextHelper().superSmallText(
                            text: "${GBSystem_Application_Strings.str_duree} : ", //
                            fontWeight: FontWeight.w500,
                            textColor: GBSystem_System_Strings.str_primary_color,
                          ),
                          SizedBox(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                            child: Obx(() => GBSystem_TextHelper().superSmallText(text: Vacation_Informations_Controller.currentVacationSafe_VAC_DURATION, fontWeight: FontWeight.normal, textAlign: TextAlign.left, textColor: Colors.black)),
                          ),
                        ],
                      ),
                      // Ligne pause
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GBSystem_TextHelper().superSmallText(
                            text: "${GBSystem_Application_Strings.str_pause} : ", //
                            fontWeight: FontWeight.w500,
                            textColor: GBSystem_System_Strings.str_primary_color,
                          ),
                          SizedBox(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.2),
                            child: Obx(
                              () => GBSystem_TextHelper().superSmallText(
                                //text: "${Vacation_Informations_Controller.currentVacationSafe_VAC_BREAK}", //
                                text: "${Vacation_Informations_Controller.currentVacationRx.value?.Safe_VAC_BREAK ?? ''}",

                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.left,
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          widget.isUpdatePause ? buildModifierPauseButton(context) : SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(text: "${GBSystem_Application_Strings.str_qualification} : ", fontWeight: FontWeight.w500, textColor: GBSystem_System_Strings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.5),
                        child: Obx(() => GBSystem_TextHelper().superSmallText(text: Vacation_Informations_Controller.currentVacationRx.value!.JOB_LIB, fontWeight: FontWeight.normal, textAlign: TextAlign.left, textColor: Colors.black)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(text: "${GBSystem_Application_Strings.str_telephone} : ", fontWeight: FontWeight.w500, textColor: GBSystem_System_Strings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.5),
                        child: Obx(() => GBSystem_TextHelper().superSmallText(text: Vacation_Informations_Controller.currentVacationRx.value!.LIE_TLPH, fontWeight: FontWeight.normal, textAlign: TextAlign.left, textColor: Colors.black)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(text: "${GBSystem_Application_Strings.str_lieu} : ", fontWeight: FontWeight.w500, textColor: GBSystem_System_Strings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.6),
                        child: Obx(() => GBSystem_TextHelper().superSmallText(text: Vacation_Informations_Controller.currentVacationRx.value!.LIE_LIB, fontWeight: FontWeight.normal, textAlign: TextAlign.left, textColor: Colors.black)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GBSystem_TextHelper().superSmallText(text: "${GBSystem_Application_Strings.str_adresse} : ", fontWeight: FontWeight.w500, textColor: GBSystem_System_Strings.str_primary_color),
                      SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.6),
                        child: Obx(() => GBSystem_TextHelper().superSmallText(text: Vacation_Informations_Controller.currentVacationRx.value!.LIE_ADR, fontWeight: FontWeight.normal, textAlign: TextAlign.left, textColor: Colors.black)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => Visibility(
                      visible: // new
                          Vacation_Informations_Controller.currentVacationRx.value != null && Vacation_Informations_Controller.currentVacationRx.value!.TPH_PSA == "1",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GBSystem_TextHelper().superSmallText(text: "${GBSystem_Application_Strings.str_entrer} : ", fontWeight: FontWeight.bold, textColor: Colors.green),
                              SizedBox(
                                width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.22),
                                child: Obx(
                                  () => GBSystem_TextHelper().superSmallText(
                                    text: Vacation_Informations_Controller.currentVacationRx.value!.PNTGS_START_HOUR_IN != null ? GBSystem_Vacation_Model.convertTime(Vacation_Informations_Controller.currentVacationRx.value!.PNTGS_START_HOUR_IN!) : "",
                                    maxLines: 2,
                                    textAlign: TextAlign.left,
                                    fontWeight: FontWeight.normal,
                                    textColor: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GBSystem_TextHelper().superSmallText(text: "${GBSystem_Application_Strings.str_sortie} : ", fontWeight: FontWeight.bold, textColor: Colors.red),
                              SizedBox(
                                width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.22),
                                child: Obx(
                                  () => GBSystem_TextHelper().superSmallText(
                                    text: Vacation_Informations_Controller.currentVacationRx.value!.PNTGS_START_HOUR_OUT != null ? GBSystem_Vacation_Model.convertTime(Vacation_Informations_Controller.currentVacationRx.value!.PNTGS_START_HOUR_OUT!) : "",
                                    maxLines: 2,
                                    textAlign: TextAlign.left,
                                    fontWeight: FontWeight.normal,
                                    textColor: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }

  Widget buildModifierPauseButton(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                    const Text(GBSystem_Application_Strings.str_modifier_pause, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Icon(Icons.close, color: Colors.transparent),
                  ],
                ),
                const SizedBox(height: 10),
                CustomTimePickerFrench(
                  labelText: GBSystem_Application_Strings.str_hour_debut,
                  onDateSelected: (p0) {
                    hourDebut = p0;
                  },
                  selectedDate: TimeOfDay.now(),
                ),
                const SizedBox(height: 10),
                CustomTimePickerFrench(
                  labelText: GBSystem_Application_Strings.str_hour_fin,
                  onDateSelected: (p0) {
                    hourFin = p0;
                  },
                  selectedDate: TimeOfDay.now(),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    Get.back();
                    if (hourDebut != null && hourFin != null) {
                      try {
                        isLoading.value = true;
                        await Vacation_Informations_Controller.updatePauseVacation(vacation: Vacation_Informations_Controller.currentVacation!, debutPause: hourDebut!, finPause: hourFin!);
                      } catch (e) {
                        isLoading.value = false;
                      } finally {
                        isLoading.value = false;
                      }

                      hourDebut = null;
                      hourFin = null;
                      //                      Get.back();
                    } else {
                      showErrorDialog(GBSystem_Application_Strings.str_choisi_date_debut_fin);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: GBSystem_System_Strings.str_primary_color,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Obx(() => isLoading.value ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white)) : const Text(GBSystem_Application_Strings.str_valider, style: TextStyle(color: Colors.white))),
                ),
              ],
            ),
          ),
        );
      },
      child: Transform.translate(offset: const Offset(-5, -2), child: const Icon(Icons.edit, size: 20)),
    );
  }
}
