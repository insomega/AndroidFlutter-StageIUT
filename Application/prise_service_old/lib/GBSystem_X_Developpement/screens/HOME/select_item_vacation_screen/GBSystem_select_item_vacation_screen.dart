import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_toast.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_vacation_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/select_item_vacation_screen/GBSystem_select_item_vacation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/url_launcher_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_PLANNING_WIDGETS/GBSystem_Root_CardView_Widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/display_phone_number_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/slide_to_act_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_WIDGET/GBSystem_button_entrer_sortie.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class GBSystem_SelectItemVacationScreen extends StatefulWidget {
  const GBSystem_SelectItemVacationScreen(
      {super.key, this.toListVacations = false, required this.destination});

  final bool toListVacations;

  final Widget destination;

  @override
  State<GBSystem_SelectItemVacationScreen> createState() =>
      _GBSystem_SelectItemVacationScreenState();
}

class _GBSystem_SelectItemVacationScreenState
    extends State<GBSystem_SelectItemVacationScreen> {
  updateUI() {
    setState(() {});
  }

  RxBool callBool = RxBool(false);
  String? phoneNumber;
  @override
  Widget build(BuildContext context) {
    final GBSystemSelectItemVacationController m = Get.put(
        GBSystemSelectItemVacationController(
            context: context,
            destination: widget.destination,
            updateUI: updateUI));

    m.totalItems = (m.usedListVacation()).length;

    return Obx(() => Stack(
          children: [
            AbsorbPointer(
              absorbing: callBool.value,
              child: ImageFiltered(
                imageFilter: callBool.value == true
                    ? ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0)
                    : ImageFilter.blur(sigmaX: 00.0, sigmaY: 0.0),
                child: Scaffold(
                  extendBodyBehindAppBar: false,
                  appBar: AppBar(
                    elevation: 4.0,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    toolbarHeight: 70,
                    backgroundColor: GbsSystemServerStrings.str_primary_color,
                    centerTitle: true,
                    title: const Text(
                      GbsSystemStrings.str_home_page,
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: InkWell(
                        onTap: () {
                          m.vacationController.setFilterDebutBool = false;
                          m.vacationController.setFilterFinBool = false;
                          m.vacationController.setFilterLieuBool = false;
                          m.vacationController.setFilterEvenementsBool = false;

                          m.vacationController.setFilterDateDebut = null;
                          m.vacationController.setFilterDateFin = null;
                          m.vacationController.setAllFiltredLieu = null;
                          m.vacationController.setAllFiltredEvenements = null;

                          Get.back();
                        },
                        child: const Icon(
                          CupertinoIcons.arrow_left,
                          color: Colors.white,
                        )),
                    actions: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            builder: (context) => FilterBottomSheet(
                              updateUI: () {
                                setState(() {});
                              },
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.filter_list,
                              color: Colors.white,
                            ),
                            GBSystem_TextHelper().superSmallText(
                                text: GbsSystemStrings.str_filtre,
                                textColor: Colors.white)
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.02),
                        vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                            context, 0.02)),
                    child: Column(
                      children: [
                        SearchBar(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                          ),
                          hintText: GbsSystemStrings.str_rechercher,
                          controller: m.controllerSearch,
                          leading: const Icon(CupertinoIcons.search),
                          trailing: [
                            GestureDetector(
                                onTap: () async {
                                  m.controllerSearch.text = "";
                                  m.text?.value = "";
                                  m.vacationController.setSearchtext = "";
                                  await m.getItemsWithAllConditions();
                                },
                                child: const Icon(Icons.close))
                          ],
                          onChanged: (String query) {
                            m.filterDataSalarie(query);
                          },
                        ),
                        SizedBox(
                          height: GBSystem_ScreenHelper.screenHeightPercentage(
                              context, 0.01),
                        ),
                        // multiselect mode
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Switch Widget
                            Visibility(
                              visible: false,
                              child: ListTile(
                                title: Text(
                                  GbsSystemStrings.str_vacation_non_pointer,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                leading: SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CupertinoCheckbox(
                                    value: m.isVacationNonPointer.value,
                                    activeColor: GbsSystemServerStrings
                                        .str_primary_color,
                                    onChanged: (value) {
                                      setState(() {
                                        m.isVacationNonPointer.value =
                                            value ?? false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  GbsSystemStrings.str_multiselect_mode,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Switch(
                                  value: m.isSwitchOn,
                                  onChanged: (value) {
                                    setState(() {
                                      m.isSwitchOn = value;
                                      if (!m.isSwitchOn) {
                                        m.isSelectAllChecked = false;
                                        m.selectedItems = 0;
                                        m.vacationController
                                            .setAllSelectedVacation = [];
                                      }
                                    });
                                  },
                                  activeColor:
                                      GbsSystemServerStrings.str_primary_color,
                                ),
                              ],
                            ),
                            // Conditionally Visible Widget
                            if (m.isSwitchOn)
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CupertinoCheckbox(
                                            value: m.isSelectAllChecked,
                                            onChanged: (value) {
                                              setState(() {
                                                m.isSelectAllChecked =
                                                    value ?? false;
                                                m.selectedItems =
                                                    m.isSelectAllChecked
                                                        ? m.totalItems
                                                        : 0;
                                              });
                                              if (value ?? false) {
                                                m.vacationController
                                                    .setAllSelectedVacation = [];
                                                List<VacationModel>
                                                    allVacExists =
                                                    m.usedListVacation();
                                                for (var i = 0;
                                                    i < allVacExists.length;
                                                    i++) {
                                                  m.vacationController
                                                          .setSelectedVacation =
                                                      allVacExists[i];
                                                }
                                              } else {
                                                m.vacationController
                                                    .setAllSelectedVacation = [];
                                              }
                                            },
                                            activeColor: GbsSystemServerStrings
                                                .str_primary_color,
                                          ),
                                          Text(
                                            GbsSystemStrings
                                                .str_selectionner_tous,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${GbsSystemStrings.str_selected_vacations}: ${m.selectedItems} / ${m.totalItems}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: GbsSystemServerStrings
                                                  .str_primary_color,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ButtonEntrerSortieWithIconAndText(
                                              onTap: () async {
                                                try {
                                                  m.isLoading.value = true;
                                                  await m
                                                      .entrerFunction(context)
                                                      .then(
                                                    (value) async {
                                                      await m
                                                          .getDataNowWithChanges();

                                                      m.isLoading.value = false;
                                                    },
                                                  );
                                                } catch (e) {
                                                  m.isLoading.value = false;
                                                  GBSystem_ManageCatchErrors()
                                                      .catchErrors(context,
                                                          message: e.toString(),
                                                          method:
                                                              "entrerFunction",
                                                          page:
                                                              "GBSystem_user_entrer_sortie");
                                                }
                                              },
                                              number: null,
                                              icon: const Icon(
                                                CupertinoIcons.hand_draw_fill,
                                                color: Colors.white,
                                              ),
                                              verPadd: GBSystem_ScreenHelper
                                                  .screenWidthPercentage(
                                                      context, 0.02),
                                              horPadd: GBSystem_ScreenHelper
                                                  .screenWidthPercentage(
                                                      context, 0.02),
                                              text: GbsSystemStrings.str_entrer,
                                              color: Colors.green,
                                            ),
                                            ButtonEntrerSortieWithIconAndText(
                                              number: null,
                                              onTap: () async {
                                                try {
                                                  m.isLoading.value = true;
                                                  await m
                                                      .sortieFunction(context)
                                                      .then(
                                                    (value) async {
                                                      await m
                                                          .getDataNowWithChanges();

                                                      m.isLoading.value = false;
                                                    },
                                                  );
                                                } catch (e) {
                                                  m.isLoading.value = false;
                                                  GBSystem_ManageCatchErrors()
                                                      .catchErrors(context,
                                                          message: e.toString(),
                                                          method:
                                                              "sortieFunction",
                                                          page:
                                                              "GBSystem_user_entrer_sortie");
                                                }
                                              },
                                              icon: const Icon(
                                                CupertinoIcons.hand_draw_fill,
                                                color: Colors.white,
                                              ),
                                              verPadd: GBSystem_ScreenHelper
                                                  .screenWidthPercentage(
                                                      context, 0.02),
                                              horPadd: GBSystem_ScreenHelper
                                                  .screenWidthPercentage(
                                                      context, 0.02),
                                              text: GbsSystemStrings.str_sortie,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: GBSystem_ScreenHelper.screenHeightPercentage(
                              context, 0.01),
                        ),
                        Obx(
                          () => (m.usedListVacation().isNotEmpty)
                              ? Expanded(
                                  child: ListView.builder(
                                    itemCount: m.usedListVacation().length,
                                    itemBuilder: (context, index) {
                                      return GBSystem_Root_CardView_VacationWidget(
                                        onEnterTap: () async {
                                          await m.entrerFunctionSingle(context,
                                              currentVacation:
                                                  m.usedListVacation()[index]);
                                        },
                                        onSortieTap: () async {
                                          await m.sortieFunctionSingle(context,
                                              currentVacation:
                                                  m.usedListVacation()[index]);
                                        },
                                        onCallTap: () {
                                          callBool.value = true;
                                          phoneNumber = m
                                              .usedListVacation()[index]
                                              .SVR_TELPH;
                                        },
                                        isSelected: m.isSwitchOn &&
                                            (m.vacationController
                                                        .getAllSelectedVacations ??
                                                    [])
                                                .contains(m
                                                    .usedListVacation()[index]),
                                        tileColor: index % 2 == 0
                                            ? Colors.grey.withOpacity(0.2)
                                            : Colors.white,
                                        onTap: () {
                                          // m.vacationController
                                          //         .setCurrentVacationVacation =
                                          //     m.vacations[index];
                                          // updateUI();
                                          if (m.isSwitchOn) {
                                            m.selectItemAllSelectedVacationFunction(
                                                selectedVacation: m
                                                    .usedListVacation()[index]);
                                            if (m.totalItems ==
                                                m.selectedItems) {
                                              m.isSelectAllChecked = true;
                                            } else {
                                              m.isSelectAllChecked = false;
                                            }

                                            setState(() {});
                                          } else {
                                            m.selectItemAllVacationFunction(
                                                selectedVacation: m
                                                    .usedListVacation()[index]);
                                          }
                                        },
                                        vacation: m.usedListVacation()[index],
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: GBSystem_TextHelper().smallText(
                                  text: GbsSystemStrings.str_empty_data,
                                )),
                        ),

                        // SizedBox(
                        //   height: GBSystem_ScreenHelper.screenHeightPercentage(
                        //       context, 0.02),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            callBool.value == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SlideToActWidgetCall(
                        onSubmit: () async {
                          callBool.value = false;
                          if (phoneNumber != null && phoneNumber!.isNotEmpty) {
                            UrlLauncherService()
                                .callNumber(context, number: phoneNumber ?? "");
                          } else {
                            showToast(
                                text:
                                    GbsSystemStrings.str_numero_telephone_vide);
                          }
                        },
                      ),
                    ],
                  )
                : Container(),
            callBool.value == true
                ? Positioned(
                    top: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Transform.translate(
                          offset: Offset(
                              -GBSystem_ScreenHelper.screenWidthPercentage(
                                  context, 0.1),
                              0),
                          child: DisplayPhoneNumberWidget(
                            phoneNumber: phoneNumber ?? "",
                          ),
                        ),
                        CupertinoButton(
                          onPressed: () {
                            callBool.value = false;
                          },
                          child: Icon(
                            CupertinoIcons.xmark,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            m.isLoading.value ? Waiting() : Container()
          ],
        ));
  }
}
