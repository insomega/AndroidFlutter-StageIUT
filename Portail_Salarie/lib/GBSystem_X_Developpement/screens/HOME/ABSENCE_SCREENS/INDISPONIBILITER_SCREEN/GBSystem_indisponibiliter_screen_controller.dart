import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_indisponibiliter_absence_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_type_de_jour_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/SELECT_ITEM_TYPE_DE_JOUR/GBSystem_select_item_typeJour_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_date_picker.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_text_field.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/custom_date_picker2.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class indisponibiliterScreenController extends GetxController {
  RxBool isLoading = RxBool(false);

  Future<void> showDialogAddIndisponibiliter({
    required BuildContext context,
    required Function updateUI,
  }) async {
    Rx<DateTime?> selectedDateDebut = Rx<DateTime?>(null),
        selectedDateFin = Rx<DateTime?>(null);

    Rx<TimeOfDay?> selectedHourDebut =
            Rx<TimeOfDay?>(TimeOfDay(hour: 0, minute: 0)),
        selectedHourFin = Rx<TimeOfDay?>(TimeOfDay(hour: 0, minute: 0));
    TextEditingController controllerMotif = TextEditingController();
    TextEditingController controllerTypeDeJour = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (context, setState) => Obx(
                      () => Stack(
                        children: [
                          AlertDialog(
                            contentPadding: EdgeInsets.all(10),
                            scrollable: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Set your desired radius here
                            ),
                            backgroundColor: Colors.white,
                            content: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await GBSystem_AuthService(context)
                                            .getListTypeDeJour()
                                            .then((value) {
                                          if (value != null) {
                                            final GBSystemTypeDeJourController
                                                typeDeJourController = Get.put(
                                                    GBSystemTypeDeJourController());

                                            typeDeJourController
                                                .setAllTypeDeJour = value;
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              Get.to(
                                                  GBSystem_SelectItemTypeDeJourScreen(
                                                controllerTxtField:
                                                    controllerTypeDeJour,
                                              ));
                                            });
                                          }
                                        });
                                      },
                                      child: CustomTextField(
                                          controller: controllerTypeDeJour,
                                          enabled: false,
                                          text: GbsSystemStrings
                                              .str_type_jour.tr),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextField(
                                      text: GbsSystemStrings.str_motif.tr,
                                      controller: controllerMotif,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomDatePicker(
                                            selectedDate:
                                                selectedDateDebut.value,
                                            labelText: GbsSystemStrings
                                                .str_date_debut.tr,
                                            initialDate:
                                                selectedDateDebut.value,
                                            onDateSelected:
                                                (DateTime selectedDate) {
                                              selectedDateDebut.value =
                                                  selectedDate;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: CustomDatePicker(
                                            selectedDate: selectedDateFin.value,
                                            labelText: GbsSystemStrings
                                                .str_date_fin.tr,
                                            initialDate: selectedDateFin.value,
                                            onDateSelected:
                                                (DateTime selectedDate) {
                                              selectedDateFin.value =
                                                  selectedDate;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomTimePicker(
                                            initialDate:
                                                selectedHourDebut.value,
                                            getDate: (date) {
                                              selectedHourDebut.value = date;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: CustomTimePicker(
                                            initialDate: selectedHourFin.value,
                                            getDate: (date) {
                                              selectedHourFin.value = date;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                );
                              },
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        GbsSystemStrings.str_primary_color,
                                    textStyle: TextStyle(
                                        color: GbsSystemStrings
                                            .str_primary_color)),
                                onPressed: () async {
                                  final GBSystemTypeDeJourController
                                      typeDeJourController =
                                      Get.put(GBSystemTypeDeJourController());
                                  if (typeDeJourController
                                              .getCurrentTypeDeJour !=
                                          null &&
                                      selectedDateDebut.value != null &&
                                      selectedDateFin.value != null &&
                                      selectedHourDebut.value != null &&
                                      selectedHourFin.value != null &&
                                      controllerMotif.text.isNotEmpty) {
                                    isLoading.value = true;
                                    await GBSystem_AuthService(context)
                                        .addIndisponibiliter(
                                            dateFin: selectedDateFin.value!,
                                            hourDebut: selectedHourDebut.value!,
                                            hourFin: selectedHourFin.value!,
                                            dateDebut: selectedDateDebut.value!,
                                            motif: controllerMotif.text,
                                            typeDeJourModel:
                                                typeDeJourController
                                                    .getCurrentTypeDeJour!)
                                        .then((value) async {
                                      isLoading.value = false;
                                      if (value == true) {
                                        await GBSystem_AuthService(context)
                                            .getListIndisponibiliter()
                                            .then((value) {
                                          if (value != null) {
                                            final indisponibiliterController = Get.put<
                                                    GBSystemIndisponibiliterAbsenceController>(
                                                GBSystemIndisponibiliterAbsenceController());
                                            indisponibiliterController
                                                .setAllIndisponibiliter = value;
                                            updateUI();
                                          }
                                        });

                                        showSuccesDialog(
                                            context,
                                            GbsSystemStrings
                                                .str_operation_effectuer);
                                      }
                                    });
                                  } else {
                                    showErrorDialog(context,
                                        GbsSystemStrings.str_remplie_cases.tr);
                                  }

                                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                                  // });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    GbsSystemStrings.str_creer.tr,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isLoading.value ? Waiting() : Container()
                        ],
                      ),
                    ));
          });
    });
  }
}
