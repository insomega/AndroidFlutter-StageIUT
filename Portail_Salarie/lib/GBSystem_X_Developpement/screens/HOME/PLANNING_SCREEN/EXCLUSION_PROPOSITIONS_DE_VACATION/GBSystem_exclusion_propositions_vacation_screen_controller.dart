import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_prise_de_vacation_state_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_type_absence_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_type_absence_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/packages/calendar_package/src/components/month_view_components.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_date_picker.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemExclusionPropositionsVacationScreenController
    extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  RxInt currentPageIndex = 0.obs;
  PageController pageControllerDialog = PageController(initialPage: 0);
  RxInt currentPageIndexDialog = 0.obs;

  final typeAbsenceController =
      Get.put<GBSystemTypeAbsenceController>(GBSystemTypeAbsenceController());
  List<TypeAbsenceModel>? listTypeAbcences;
  RxBool isLoading = RxBool(false);

  @override
  void onClose() {
    pageController.dispose();
    pageControllerDialog.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    listTypeAbcences = typeAbsenceController.getAllTypeAbsences;
    super.onInit();
  }

  List<String> getWeekDaysName() {
    return List.generate(
      7,
      (index) {
        DateTime date = DateTime(2024, 1, 1).add(Duration(days: index));
        return DateFormat.EEEE(getLocaleApplication()).format(date);
      },
    );
  }

  Future<void> showDialogAddPriseVacation(
      {required BuildContext context, required Function updateUI}) async {
    List<String> listItems = [
      GbsSystemStrings.str_exclu_ponctuelle.tr,
      GbsSystemStrings.str_exclu_recurrente.tr,
      GbsSystemStrings.str_exclu_definitive.tr
    ];
    List<String> listWeekDays = getWeekDaysName();
    // ["S", "D", "L", "M", "Me", "J", "V"];
    Rx<List<String>> listSelectedWeekDays = Rx<List<String>>([]);

    Rx<DateTime?> selectedDateDebut = Rx<DateTime?>(null),
        selectedDateFin = Rx<DateTime?>(null);
    RxString selectedItem = GbsSystemStrings.str_exclu_ponctuelle.tr.obs;
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
                            // backgroundColor:
                            //     GbsSystemStrings.str_primary_color.withOpacity(0.85),
                            backgroundColor: Colors.white,
                            content: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 50,
                                            width: 250,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: listItems.length,
                                              itemBuilder: (context, index) {
                                                return Obx(() => InkWell(
                                                      onTap: () async {
                                                        selectedItem.value =
                                                            listItems[index];
                                                        pageControllerDialog
                                                            .animateToPage(
                                                                index,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        300),
                                                                curve: Curves
                                                                    .linear);
                                                      },
                                                      child: AnimatedContainer(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    400),
                                                        margin: EdgeInsets.symmetric(
                                                            vertical:
                                                                GBSystem_ScreenHelper
                                                                    .screenHeightPercentage(
                                                                        context,
                                                                        0.01),
                                                            horizontal:
                                                                GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.01)),
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                GBSystem_ScreenHelper
                                                                    .screenWidthPercentage(
                                                                        context,
                                                                        0.04)),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: selectedItem
                                                                      .value ==
                                                                  listItems[
                                                                      index]
                                                              ? GbsSystemStrings
                                                                  .str_primary_color
                                                              : Colors
                                                                  .grey.shade400
                                                                  .withOpacity(
                                                                      0.9),
                                                        ),
                                                        child: Center(
                                                          child: GBSystem_TextHelper()
                                                              .smallText(
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  text: listItems[
                                                                      index]),
                                                        ),
                                                      ),
                                                    ));
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: GBSystem_ScreenHelper
                                          .screenHeightPercentage(
                                              context, 0.43),
                                      width: 250,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: PageView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          controller: pageControllerDialog,
                                          children: [
                                            // Page 1
                                            Column(
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.spaceBetween,
                                              children: [
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
                                                    onDateSelected: (DateTime
                                                        selectedDate) {
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
                                                    onDateSelected: (DateTime
                                                        selectedDate) {
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
                                                    try {
                                                      if (selectedDateDebut
                                                                  .value !=
                                                              null &&
                                                          selectedDateFin
                                                                  .value !=
                                                              null) {
                                                        isLoading.value = true;
                                                        await GBSystem_AuthService(
                                                                context)
                                                            .addPreferencesVacationStatePonctuelle(
                                                                dateDebut:
                                                                    selectedDateDebut
                                                                        .value!,
                                                                dateFin:
                                                                    selectedDateFin
                                                                        .value!)
                                                            .then((value) {
                                                          isLoading.value =
                                                              false;
                                                          if (value != null &&
                                                              value
                                                                  .isNotEmpty) {
                                                            final priseDeVacationController =
                                                                Get.put<GBSystemPriseDeVacationStateController>(
                                                                    GBSystemPriseDeVacationStateController());
                                                            priseDeVacationController
                                                                    .setVacationToRight =
                                                                value.first;
                                                            //  setState(() {
                                                            // });
                                                            updateUI();

                                                            showSuccesDialog(
                                                                context,
                                                                GbsSystemStrings
                                                                    .str_operation_effectuer
                                                                    .tr);
                                                          }
                                                        });
                                                      } else {
                                                        showErrorDialog(
                                                            context,
                                                            GbsSystemStrings
                                                                .str_svp_add_date_debut_fin
                                                                .tr);
                                                      }
                                                    } catch (e) {
                                                      isLoading.value = false;
                                                      GBSystem_ManageCatchErrors()
                                                          .catchErrors(context,
                                                              message:
                                                                  e.toString(),
                                                              method:
                                                                  "addPreferencesVacationStatePonctuelle",
                                                              page:
                                                                  "GBSystem_exclusion_propositions_vacation_screen_controller");
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                      GbsSystemStrings
                                                          .str_valider.tr,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Page 2
                                            Column(
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
                                                                            listWeekDays[index]);
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
                                                                        .contains(listWeekDays[
                                                                            index])
                                                                    ? GbsSystemStrings
                                                                        .str_primary_color
                                                                    : Colors
                                                                        .grey
                                                                        .shade400
                                                                        .withOpacity(
                                                                            0.9),
                                                              ),
                                                              child: Center(
                                                                child: GBSystem_TextHelper().smallText(
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
                                                    onDateSelected: (DateTime
                                                        selectedDate) {
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
                                                    onDateSelected: (DateTime
                                                        selectedDate) {
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
                                                    try {
                                                      if (selectedDateDebut
                                                              .value !=
                                                          null) {
                                                        isLoading.value = true;
                                                        await GBSystem_AuthService(
                                                                context)
                                                            .addPreferencesVacationStateReccurente(
                                                                dateDebut:
                                                                    selectedDateDebut
                                                                        .value!,
                                                                dateFin:
                                                                    selectedDateFin
                                                                        .value,
                                                                selectedWeekDays:
                                                                    listSelectedWeekDays
                                                                        .value)
                                                            .then((value) {
                                                          isLoading.value =
                                                              false;
                                                          if (value != null &&
                                                              value
                                                                  .isNotEmpty) {
                                                            final priseDeVacationController =
                                                                Get.put<GBSystemPriseDeVacationStateController>(
                                                                    GBSystemPriseDeVacationStateController());
                                                            priseDeVacationController
                                                                    .setVacationToRight =
                                                                value.first;

                                                            updateUI();

                                                            showSuccesDialog(
                                                                context,
                                                                GbsSystemStrings
                                                                    .str_operation_effectuer
                                                                    .tr);
                                                          }
                                                        });
                                                      } else {
                                                        showErrorDialog(
                                                            context,
                                                            GbsSystemStrings
                                                                .str_svp_add_date_debut_fin
                                                                .tr);
                                                      }
                                                    } catch (e) {
                                                      isLoading.value = false;
                                                      GBSystem_ManageCatchErrors()
                                                          .catchErrors(context,
                                                              message:
                                                                  e.toString(),
                                                              method:
                                                                  "addPreferencesVacationStateReccurente",
                                                              page:
                                                                  "GBSystem_exclusion_propositions_vacation_screen_controller");
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
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
                                            // Page 3
                                            ,
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                        value: true,
                                                        onChanged: null),
                                                    GBSystem_TextHelper()
                                                        .smallText(
                                                            text: GbsSystemStrings
                                                                .str_definitif
                                                                .tr),
                                                  ],
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
                                                    try {
                                                      isLoading.value = true;
                                                      await GBSystem_AuthService(
                                                              context)
                                                          .addPreferencesVacationStateDeffinitive()
                                                          .then((value) {
                                                        isLoading.value = false;
                                                        if (value != null &&
                                                            value.isNotEmpty) {
                                                          final priseDeVacationController =
                                                              Get.put<GBSystemPriseDeVacationStateController>(
                                                                  GBSystemPriseDeVacationStateController());
                                                          priseDeVacationController
                                                                  .setVacationToRight =
                                                              value.first;

                                                          updateUI();

                                                          showSuccesDialog(
                                                              context,
                                                              GbsSystemStrings
                                                                  .str_operation_effectuer
                                                                  .tr);
                                                        }
                                                      });
                                                    } catch (e) {
                                                      isLoading.value = false;
                                                      GBSystem_ManageCatchErrors()
                                                          .catchErrors(context,
                                                              message:
                                                                  e.toString(),
                                                              method:
                                                                  "addPreferencesVacationStateDeffinitive",
                                                              page:
                                                                  "GBSystem_exclusion_propositions_vacation_screen_controller");
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
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
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                            actions: <Widget>[],
                          ),
                          isLoading.value
                              ? Center(child: Waiting())
                              : Container()
                        ],
                      ),
                    ));
          });
    });
  }

  // Future<void> showDialogAddPriseVacation(
  //     {required BuildContext context, required Function updateUI}) async {
  //   List<String> listItems = [
  //     GbsSystemStrings.str_dispo_ponctuelle.tr,
  //     GbsSystemStrings.str_dispo_recurrente.tr,

  //   ];
  //   List<String> listWeekDays = ["S", "D", "L", "M", "Me", "J", "V"];
  //   Rx<List<String>> listSelectedWeekDays = Rx<List<String>>([]);

  //   Rx<DateTime?> selectedDateDebut = Rx<DateTime?>(null),
  //       selectedDateFin = Rx<DateTime?>(null);
  //   RxString selectedItem = GbsSystemStrings.str_exclu_ponctuelle.tr.obs;
  //   RxBool isLoading = RxBool(false);
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return StatefulBuilder(
  //             builder: (context, setState) =>
  //             Obx(() =>
  //                 Stack(
  //               children: [
  //                 AlertDialog(
  //                   contentPadding: EdgeInsets.all(10),
  //                   scrollable: true,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(
  //                         16.0), // Set your desired radius here
  //                   ),
  //                   // backgroundColor:
  //                   //     GbsSystemStrings.str_primary_color.withOpacity(0.85),
  //                   backgroundColor: Colors.white,
  //                   content: StatefulBuilder(
  //                     builder: (context, setState) {
  //                       return Column(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Expanded(
  //                                 child: SizedBox(
  //                                   height: 50,
  //                                   child: ListView.builder(
  //                                     shrinkWrap: true,
  //                                     scrollDirection: Axis.horizontal,
  //                                     itemCount: listItems.length,
  //                                     itemBuilder: (context, index) {
  //                                       return Obx(() => InkWell(
  //                                             onTap: () async {
  //                                               selectedItem.value =
  //                                                   listItems[index];
  //                                               pageControllerDialog
  //                                                   .animateToPage(
  //                                                       index,
  //                                                       duration: Duration(
  //                                                           milliseconds: 300),
  //                                                       curve:
  //                                                           Curves.bounceInOut);
  //                                             },
  //                                             child: AnimatedContainer(
  //                                               duration: const Duration(
  //                                                   milliseconds: 400),
  //                                               margin: EdgeInsets.symmetric(
  //                                                   vertical: GBSystem_ScreenHelper
  //                                                       .screenHeightPercentage(
  //                                                           context, 0.01),
  //                                                   horizontal:
  //                                                       GBSystem_ScreenHelper
  //                                                           .screenWidthPercentage(
  //                                                               context, 0.01)),
  //                                               padding: EdgeInsets.symmetric(
  //                                                   horizontal:
  //                                                       GBSystem_ScreenHelper
  //                                                           .screenWidthPercentage(
  //                                                               context, 0.04)),
  //                                               decoration: BoxDecoration(
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(8),
  //                                                 color: selectedItem.value ==
  //                                                         listItems[index]
  //                                                     ? GbsSystemStrings
  //                                                         .str_primary_color
  //                                                     : Colors.grey.shade400
  //                                                         .withOpacity(0.9),
  //                                               ),
  //                                               child: Center(
  //                                                 child: GBSystem_TextHelper()
  //                                                     .smallText(
  //                                                         textColor:
  //                                                             Colors.white,
  //                                                         text:
  //                                                             listItems[index]),
  //                                               ),
  //                                             ),
  //                                           ));
  //                                     },
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                           SizedBox(
  //                             height:
  //                                 GBSystem_ScreenHelper.screenHeightPercentage(
  //                                     context, 0.43),
  //                             child: Padding(
  //                               padding:
  //                                   const EdgeInsets.symmetric(vertical: 20),
  //                               child: PageView(
  //                                 physics: const NeverScrollableScrollPhysics(),
  //                                 controller: pageControllerDialog,
  //                                 children: [
  //                                   // Page 1
  //                                   Column(
  //                                     // mainAxisAlignment:
  //                                     //     MainAxisAlignment.spaceBetween,
  //                                     children: [
  //                                        SizedBox(
  //                                         height: 10,
  //                                       ),
  //                                       Expanded(
  //                                           child: Obx(
  //                                         () => CustomDatePicker(
  //                                           selectedDate:
  //                                               selectedDateDebut.value,
  //                                           labelText: GbsSystemStrings
  //                                               .str_date_debut.tr,
  //                                           initialDate:
  //                                               selectedDateDebut.value,
  //                                           onDateSelected:
  //                                               (DateTime selectedDate) {
  //                                             selectedDateDebut.value =
  //                                                 selectedDate;
  //                                           },
  //                                         ),
  //                                       )),
  //                                     SizedBox(
  //                                         height: 10,
  //                                       ),
  //                                       Expanded(
  //                                           child: Obx(
  //                                         () => CustomDatePicker(
  //                                           selectedDate: selectedDateFin.value,
  //                                           labelText: GbsSystemStrings
  //                                               .str_date_fin.tr,
  //                                           initialDate: selectedDateFin.value,
  //                                           onDateSelected:
  //                                               (DateTime selectedDate) {
  //                                             selectedDateFin.value =
  //                                                 selectedDate;
  //                                           },
  //                                         ),
  //                                       )),
  //                                        SizedBox(
  //                                         height: 10,
  //                                       ),
  //                                       ElevatedButton(
  //                                         style: ElevatedButton.styleFrom(
  //                                             shape: RoundedRectangleBorder(
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(8)),
  //                                             backgroundColor: GbsSystemStrings
  //                                                 .str_primary_color,
  //                                             textStyle: TextStyle(
  //                                                 color: GbsSystemStrings
  //                                                     .str_primary_color)),
  //                                         onPressed: () async {
  //                                           try {
  //                                              if (selectedDateDebut.value !=
  //                                                   null &&
  //                                               selectedDateFin.value != null) {
  //                                             isLoading.value = true;
  //                                             await GBSystem_AuthService(
  //                                                     context)
  //                                                 .addPreferencesVacationStatePonctuelle(
  //                                                     dateDebut:
  //                                                         selectedDateDebut
  //                                                             .value!,
  //                                                     dateFin: selectedDateFin
  //                                                         .value!)
  //                                                 .then((value) {
  //                                               isLoading.value = false;
  //                                               if (value != null &&
  //                                                   value.isNotEmpty) {
  //                                                 final priseDeVacationController =
  //                                                     Get.put<GBSystemPriseDeVacationStateController>(
  //                                                         GBSystemPriseDeVacationStateController());
  //                                                 priseDeVacationController
  //                                                         .setVacationToRight =
  //                                                     value.first;
  //                                                 //  setState(() {
  //                                                 // });
  //                                                 updateUI();

  //                                                 showSuccesDialog(
  //                                                     context,
  //                                                     GbsSystemStrings
  //                                                         .str_dialog_succes
  //                                                         .tr);
  //                                               }
  //                                             });
  //                                           } else {
  //                                             showErrorDialog(
  //                                                 context,
  //                                                 GbsSystemStrings
  //                                                     .str_svp_add_date_debut_fin
  //                                                     .tr);
  //                                           }
  //                                           } catch (e) {
  //                                              GBSystem_ManageCatchErrors().catchErrors(
  //                                           context,
  //                                           message: e.toString(),method: "addPreferencesVacationStatePonctuelle" , page: "GBSystem_exclusion_propositions_vacation_screen_controller");

  //                                           }

  //                                         },
  //                                         child: Padding(
  //                                           padding: const EdgeInsets.all(4.0),
  //                                           child: Text(
  //                                             GbsSystemStrings.str_valider.tr,
  //                                             style: TextStyle(
  //                                                 color: Colors.white),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                   // Page 2
  //                                   Column(
  //                                     children: [
  //                                       SizedBox(
  //                                         height: 50,
  //                                         child: ListView.builder(
  //                                           shrinkWrap: true,
  //                                           scrollDirection: Axis.horizontal,
  //                                           itemCount: listWeekDays.length,
  //                                           itemBuilder: (context, index) {
  //                                             return Obx(() => InkWell(
  //                                                   onTap: () {
  //                                                     if (listSelectedWeekDays
  //                                                         .value
  //                                                         .contains(
  //                                                             listWeekDays[
  //                                                                 index])) {
  //                                                       int myIndex =
  //                                                           listSelectedWeekDays
  //                                                               .value
  //                                                               .indexOf(
  //                                                                   listWeekDays[
  //                                                                       index]);
  //                                                       setState(() {
  //                                                         listSelectedWeekDays
  //                                                             .value
  //                                                             .removeAt(
  //                                                                 myIndex);
  //                                                       });
  //                                                     } else {
  //                                                       setState(() {
  //                                                         listSelectedWeekDays
  //                                                             .value
  //                                                             .add(listWeekDays[
  //                                                                 index]);
  //                                                       });
  //                                                     }
  //                                                   },
  //                                                   child: AnimatedContainer(
  //                                                     duration: const Duration(
  //                                                         milliseconds: 400),
  //                                                     margin: EdgeInsets.symmetric(
  //                                                         vertical:
  //                                                             GBSystem_ScreenHelper
  //                                                                 .screenHeightPercentage(
  //                                                                     context,
  //                                                                     0.01),
  //                                                         horizontal:
  //                                                             GBSystem_ScreenHelper
  //                                                                 .screenWidthPercentage(
  //                                                                     context,
  //                                                                     0.01)),
  //                                                     padding: EdgeInsets.symmetric(
  //                                                         horizontal:
  //                                                             GBSystem_ScreenHelper
  //                                                                 .screenWidthPercentage(
  //                                                                     context,
  //                                                                     0.04)),
  //                                                     decoration: BoxDecoration(
  //                                                       borderRadius:
  //                                                           BorderRadius
  //                                                               .circular(100),
  //                                                       color: listSelectedWeekDays
  //                                                               .value
  //                                                               .contains(
  //                                                                   listWeekDays[
  //                                                                       index])
  //                                                           ? GbsSystemStrings
  //                                                               .str_primary_color
  //                                                           : Colors
  //                                                               .grey.shade400
  //                                                               .withOpacity(
  //                                                                   0.9),
  //                                                     ),
  //                                                     child: Center(
  //                                                       child: GBSystem_TextHelper()
  //                                                           .smallText(
  //                                                               textColor:
  //                                                                   Colors
  //                                                                       .white,
  //                                                               text:
  //                                                                   listWeekDays[
  //                                                                       index]),
  //                                                     ),
  //                                                   ),
  //                                                 ));
  //                                           },
  //                                         ),
  //                                       ),
  //                                       SizedBox(
  //                                         height: 10,
  //                                       ),
  //                                       Expanded(
  //                                           child: Obx(
  //                                         () => CustomDatePicker(
  //                                           selectedDate:
  //                                               selectedDateDebut.value,
  //                                           labelText: GbsSystemStrings
  //                                               .str_date_debut.tr,
  //                                           initialDate:
  //                                               selectedDateDebut.value,
  //                                           onDateSelected:
  //                                               (DateTime selectedDate) {
  //                                             selectedDateDebut.value =
  //                                                 selectedDate;
  //                                           },
  //                                         ),
  //                                       )),
  //                                       SizedBox(
  //                                         height: 10,
  //                                       ),
  //                                       Expanded(
  //                                           child: Obx(
  //                                         () => CustomDatePicker(
  //                                           selectedDate: selectedDateFin.value,
  //                                           labelText: GbsSystemStrings
  //                                               .str_date_fin.tr,
  //                                           initialDate: selectedDateFin.value,
  //                                           onDateSelected:
  //                                               (DateTime selectedDate) {
  //                                             selectedDateFin.value =
  //                                                 selectedDate;
  //                                           },
  //                                         ),
  //                                       )),
  //                                       ElevatedButton(
  //                                         style: ElevatedButton.styleFrom(
  //                                             shape: RoundedRectangleBorder(
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(8)),
  //                                             backgroundColor: GbsSystemStrings
  //                                                 .str_primary_color,
  //                                             textStyle: TextStyle(
  //                                                 color: GbsSystemStrings
  //                                                     .str_primary_color)),
  //                                         onPressed: () async {
  //                                           try {
  //                                               if (selectedDateDebut.value !=
  //                                                   null ) {
  //                                             isLoading.value = true;
  //                                             await GBSystem_AuthService(
  //                                                     context)
  //                                                 .addPreferencesVacationStateReccurente(
  //                                                     dateDebut:
  //                                                         selectedDateDebut
  //                                                             .value!,
  //                                                     dateFin: selectedDateFin
  //                                                         .value,
  //                                                     selectedWeekDays:
  //                                                         listSelectedWeekDays
  //                                                             .value)
  //                                                 .then((value) {
  //                                               isLoading.value = false;
  //                                               if (value != null &&
  //                                                   value.isNotEmpty) {
  //                                                 final priseDeVacationController =
  //                                                     Get.put<GBSystemPriseDeVacationStateController>(
  //                                                         GBSystemPriseDeVacationStateController());
  //                                                 priseDeVacationController
  //                                                         .setVacationToRight =
  //                                                     value.first;

  //                                                 updateUI();

  //                                                 showSuccesDialog(
  //                                                     context,
  //                                                     GbsSystemStrings
  //                                                         .str_dialog_succes
  //                                                         .tr);
  //                                               }
  //                                             });
  //                                           } else {
  //                                             showErrorDialog(
  //                                                 context,
  //                                                 GbsSystemStrings
  //                                                     .str_svp_add_date_debut_fin
  //                                                     .tr);
  //                                           }
  //                                           } catch (e) {
  //                                                 GBSystem_ManageCatchErrors().catchErrors(
  //                                           context,
  //                                           message: e.toString(),method: "addPreferencesVacationStateReccurente" , page: "GBSystem_exclusion_propositions_vacation_screen_controller");

  //                                           }

  //                                         },
  //                                         child: Padding(
  //                                           padding: const EdgeInsets.all(4.0),
  //                                           child: Text(
  //                                             GbsSystemStrings.str_valider.tr,
  //                                             style: TextStyle(
  //                                                 color: Colors.white),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   )
  //                                   // Page 3
  //                                   ,
  //                                 ],
  //                               ),
  //                             ),
  //                           )

  //                         ],
  //                       );
  //                     },
  //                   ),
  //                   actions: <Widget>[],
  //                 ),
  //                 isLoading.value ? Waiting() : Container()
  //               ],
  //             ),

  //             )
  //           );
  //         });
  //   });
  // }
}
