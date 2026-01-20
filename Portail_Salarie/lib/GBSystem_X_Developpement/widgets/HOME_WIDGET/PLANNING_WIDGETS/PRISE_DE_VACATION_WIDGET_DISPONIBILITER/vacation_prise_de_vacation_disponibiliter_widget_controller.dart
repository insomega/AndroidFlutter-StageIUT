import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_prise_de_vacation_state_disponibiliter_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_prise_de_vacation_state_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/packages/calendar_package/src/components/month_view_components.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_date_picker.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class VacationPriseDeVacationDisponibiliterWidgetController
    extends GetxController {
  VacationPriseDeVacationDisponibiliterWidgetController(
    this.context,
  );
  BuildContext context;
  final priseDeVacationController =
      Get.put<GBSystemPriseDeVacationStateDisponibiliterController>(
          GBSystemPriseDeVacationStateDisponibiliterController());
  List<String> getWeekDaysName() {
    return List.generate(
      7,
      (index) {
        DateTime date = DateTime(2024, 1, 1).add(Duration(days: index));
        return DateFormat.EEEE(getLocaleApplication()).format(date);
      },
    );
  }

  Future<void> showDialogUpdatePriseVacation({
    required BuildContext context,
    required Function updateUI,
    required PriseDeVacationStateModel priseDeVacationStateModel,
  }) async {
    List<String> initDaysList() {
      Rx<List<String>> listSelectedWeekDays = Rx<List<String>>([]);
      if (priseDeVacationStateModel.DAY1_PRFR == "1") {
        listSelectedWeekDays.value.add("S");
      }
      if (priseDeVacationStateModel.DAY2_PRFR == "1") {
        listSelectedWeekDays.value.add("D");
      }
      if (priseDeVacationStateModel.DAY3_PRFR == "1") {
        listSelectedWeekDays.value.add("L");
      }
      if (priseDeVacationStateModel.DAY4_PRFR == "1") {
        listSelectedWeekDays.value.add("M");
      }
      if (priseDeVacationStateModel.DAY5_PRFR == "1") {
        listSelectedWeekDays.value.add("Me");
      }
      if (priseDeVacationStateModel.DAY6_PRFR == "1") {
        listSelectedWeekDays.value.add("J");
      }
      if (priseDeVacationStateModel.DAY7_PRFR == "1") {
        listSelectedWeekDays.value.add("V");
      }
      return listSelectedWeekDays.value;
    }

    List<String> listWeekDays = getWeekDaysName();

    //  ["S", "D", "L", "M", "Me", "J", "V"];
    Rx<List<String>> listSelectedWeekDays = Rx<List<String>>(initDaysList());

    Rx<DateTime?> selectedDateDebut =
            Rx<DateTime?>(priseDeVacationStateModel.START_DATE_EXCLU),
        selectedDateFin =
            Rx<DateTime?>(priseDeVacationStateModel.END_DATE_EXCLU);
    RxBool isLoading = RxBool(false);

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
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: priseDeVacationStateModel
                                                .DISPONIBILITE_LIB ==
                                            "str_dispo_recurrente"
                                        ? Column(
                                            children: [
                                              SizedBox(
                                                height: 50,
                                                width: 250,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      listWeekDays.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Obx(() => InkWell(
                                                          onTap: () {
                                                            if (listSelectedWeekDays
                                                                .value
                                                                .contains(
                                                                    listWeekDays[
                                                                        index])) {
                                                              int myIndex =
                                                                  listSelectedWeekDays
                                                                      .value
                                                                      .indexOf(
                                                                          listWeekDays[
                                                                              index]);
                                                              setState(() {
                                                                listSelectedWeekDays
                                                                    .value
                                                                    .removeAt(
                                                                        myIndex);
                                                              });
                                                            } else {
                                                              setState(() {
                                                                listSelectedWeekDays
                                                                    .value
                                                                    .add(listWeekDays[
                                                                        index]);
                                                              });
                                                            }
                                                          },
                                                          child:
                                                              AnimatedContainer(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        400),
                                                            margin: EdgeInsets.symmetric(
                                                                vertical: GBSystem_ScreenHelper
                                                                    .screenHeightPercentage(
                                                                        context,
                                                                        0.01),
                                                                horizontal: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.01)),
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.04)),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              color: listSelectedWeekDays
                                                                      .value
                                                                      .contains(
                                                                          listWeekDays[
                                                                              index])
                                                                  ? GbsSystemStrings
                                                                      .str_primary_color
                                                                  : Colors.grey
                                                                      .shade400
                                                                      .withOpacity(
                                                                          0.9),
                                                            ),
                                                            child: Center(
                                                              child: GBSystem_TextHelper()
                                                                  .smallText(
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      text: listWeekDays[
                                                                          index]),
                                                            ),
                                                          ),
                                                        ));
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Obx(
                                                () => CustomDatePicker(
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
                                                height: 20,
                                              ),
                                              Obx(
                                                () => CustomDatePicker(
                                                  selectedDate:
                                                      selectedDateFin.value,
                                                  labelText: GbsSystemStrings
                                                      .str_date_fin.tr,
                                                  initialDate:
                                                      selectedDateFin.value,
                                                  onDateSelected:
                                                      (DateTime selectedDate) {
                                                    selectedDateFin.value =
                                                        selectedDate;
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    backgroundColor:
                                                        GbsSystemStrings
                                                            .str_primary_color,
                                                    textStyle: TextStyle(
                                                        color: GbsSystemStrings
                                                            .str_primary_color)),
                                                onPressed: () async {
                                                  if (selectedDateDebut.value !=
                                                          null &&
                                                      selectedDateFin.value !=
                                                          null) {
                                                    isLoading.value = true;
                                                    await GBSystem_AuthService(
                                                            context)
                                                        .updatePreferencesVacationStateDisponibiliterRecurrent(
                                                            priseDeVacationStateModel:
                                                                priseDeVacationStateModel,
                                                            updatedDebut:
                                                                selectedDateDebut
                                                                    .value!,
                                                            updatedFin:
                                                                selectedDateFin
                                                                    .value!,
                                                            selectedWeekDays:
                                                                listSelectedWeekDays
                                                                    .value)
                                                        .then((value) async {
                                                      if (value != null) {
                                                        priseDeVacationController
                                                            .updateVacation(
                                                                priseDeVacationStateModel,
                                                                value);
                                                        isLoading.value = false;
                                                        updateUI();
                                                        showSuccesDialog(
                                                            context,
                                                            GbsSystemStrings
                                                                .str_operation_effectuer
                                                                .tr);
                                                      } else {
                                                        isLoading.value = false;
                                                      }
                                                    });
                                                  } else {
                                                    showErrorDialog(
                                                        context,
                                                        GbsSystemStrings
                                                            .str_svp_add_date_debut_fin
                                                            .tr);
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    GbsSystemStrings
                                                        .str_valider.tr,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Obx(
                                                () => CustomDatePicker(
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
                                                height: 20,
                                              ),
                                              Obx(
                                                () => CustomDatePicker(
                                                  selectedDate:
                                                      selectedDateFin.value,
                                                  labelText: GbsSystemStrings
                                                      .str_date_fin.tr,
                                                  initialDate:
                                                      selectedDateFin.value,
                                                  onDateSelected:
                                                      (DateTime selectedDate) {
                                                    selectedDateFin.value =
                                                        selectedDate;
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    backgroundColor:
                                                        GbsSystemStrings
                                                            .str_primary_color,
                                                    textStyle: TextStyle(
                                                        color: GbsSystemStrings
                                                            .str_primary_color)),
                                                onPressed: () async {
                                                  if (selectedDateDebut.value !=
                                                          null &&
                                                      selectedDateFin.value !=
                                                          null) {
                                                    isLoading.value = true;
                                                    await GBSystem_AuthService(
                                                            context)
                                                        .updatePreferencesVacationStateDisponibiliterPonctuelle(
                                                            priseDeVacationStateModel:
                                                                priseDeVacationStateModel,
                                                            updatedDebut:
                                                                selectedDateDebut
                                                                    .value!,
                                                            updatedFin:
                                                                selectedDateFin
                                                                    .value!)
                                                        .then((value) async {
                                                      if (value != null) {
                                                        priseDeVacationController
                                                            .updateVacation(
                                                                priseDeVacationStateModel,
                                                                value);
                                                        isLoading.value = false;
                                                        updateUI();

                                                        showSuccesDialog(
                                                            context,
                                                            GbsSystemStrings
                                                                .str_operation_effectuer
                                                                .tr);
                                                      } else {
                                                        isLoading.value = false;
                                                      }
                                                    });
                                                  } else {
                                                    showErrorDialog(
                                                        context,
                                                        GbsSystemStrings
                                                            .str_svp_add_date_debut_fin
                                                            .tr);
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    GbsSystemStrings
                                                        .str_valider.tr,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));
                              },
                            ),
                            actions: <Widget>[],
                          ),
                          isLoading.value ? Waiting() : Container()
                        ],
                      ),
                    ));
          });
    });
  }
}
