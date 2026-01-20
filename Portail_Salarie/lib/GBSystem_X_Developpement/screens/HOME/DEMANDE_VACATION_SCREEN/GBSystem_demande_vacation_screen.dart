import 'package:animated_toggle/animated_toggle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/DEMANDE_VACATION_SCREEN/GBSystem_demande_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/MAP_SCREEN/Gbsystem_map_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PLANNING_SCREEN/PRISE_DE_VACATION/VACATION_STATE_DEPASSER_SCREEN/list_vacations_state_depasser_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/PRISE_DE_VACATION_WIDGET/vacation_prise_de_vacation_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/VACATION_WIDGETS/VACATION_STATE_WIDGET/vacation_state_accepter_refuser_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/VACATION_WIDGETS/VACATION_STATE_WIDGET/vacation_state_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemDemandeVacationScreen extends StatefulWidget {
  GBSystemDemandeVacationScreen(
      {super.key,
      this.isCommingFromOut = false,
      this.isPriseDeVacation = false});
  final bool isCommingFromOut;
  final bool isPriseDeVacation;

  @override
  State<GBSystemDemandeVacationScreen> createState() =>
      _GBSystemDemandeVacationScreenState();
}

class _GBSystemDemandeVacationScreenState
    extends State<GBSystemDemandeVacationScreen> {
  final m = Get.put<GBSystemDemandeVacationScreenController>(
      GBSystemDemandeVacationScreenController());

  updateLoading(bool myBool) {
    m.isLoading.value = myBool;
  }

  updateUI() {
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      m.pageController.jumpToPage(m.currentPageIndex.value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            Scaffold(
                extendBodyBehindAppBar: false,
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 4.0,
                  shadowColor: GbsSystemStrings.str_primary_color,
                  toolbarHeight: 80,
                  backgroundColor: GbsSystemStrings.str_primary_color,
                  title: Text(
                    widget.isPriseDeVacation
                        ? GbsSystemStrings.str_prise_de_vacations.tr
                        : GbsSystemStrings.str_demande_vacation.tr,
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: widget.isCommingFromOut
                      ? InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            CupertinoIcons.arrow_left,
                            color: Colors.white,
                          ),
                        )
                      : Container(),
                ),
                floatingActionButton: m.currentPageIndex.value == 1
                    ? FloatingActionButton(
                        backgroundColor: GbsSystemStrings.str_primary_color,
                        onPressed: () {
                          Get.to(ListVacationStateDepasserScreen(
                            updateLoading: updateLoading,
                            isCommingFromOut: true,
                          ));
                        },
                        child: Icon(
                          CupertinoIcons.time,
                          color: Colors.white,
                        ),
                      )
                    : m.currentPageIndex.value == 2
                        ? FloatingActionButton(
                            backgroundColor: GbsSystemStrings.str_primary_color,
                            onPressed: () {
                              m.showDialogAddPriseVacation(
                                  updateUI: updateUI, context: context);
                            },
                            child: Icon(
                              CupertinoIcons.add,
                              color: Colors.white,
                            ),
                          )
                        : m.currentPageIndex.value == 0
                            ? FloatingActionButton(
                                backgroundColor:
                                    GbsSystemStrings.str_primary_color,
                                onPressed: () {
                                  List<LatLng> listVacState = m
                                          .vacationStateController
                                          .getAllVacations
                                          .value
                                          ?.map(
                                            (vacationState) => LatLng(
                                                double.parse(vacationState
                                                    .LIE_LATITUDE
                                                    .replaceAll(",", ".")),
                                                double.parse(vacationState
                                                    .LIE_LONGITUDE
                                                    .replaceAll(",", "."))),
                                          )
                                          .toList() ??
                                      [];

                                  Get.to(GbsystemMapScreen(
                                    listCordonner: listVacState,
                                  ));
                                },
                                child: Icon(
                                  CupertinoIcons.map_fill,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                body: Column(
                  children: [
                    AnimatedHorizontalToggle(
                      taps: [
                        GbsSystemStrings.str_proposition_s.tr,
                        GbsSystemStrings.str_demander_refuser.tr,
                        GbsSystemStrings.str_list_preferences.tr,
                      ],
                      activeBoxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 1,
                          spreadRadius: 1,
                        ),
                      ],
                      width: MediaQuery.of(context).size.width - 10,
                      height: 45,
                      duration: const Duration(milliseconds: 200),
                      initialIndex: m.currentPageIndex.value,
                      background: Colors.grey.shade200.withOpacity(0.6),
                      activeColor: GbsSystemStrings.str_primary_color,
                      activeTextStyle: const TextStyle(
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      inActiveTextStyle: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: GbsSystemStrings.str_primary_color),
                      horizontalPadding: 0,
                      verticalPadding: 4,
                      activeHorizontalPadding: 0,
                      activeVerticalPadding: 4,
                      radius: 14,
                      activeButtonRadius: 14,
                      onChange: (int currentIndex, int targetIndex) {
                        m.currentPageIndex.value = targetIndex;

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          m.pageController.animateToPage(targetIndex,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.linear);
                        });
                      },
                      showActiveButtonColor: true,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: m.pageController,
                        scrollDirection: Axis.horizontal,
                        children: [
                          VacationStateWidget(updateLoading: updateLoading),
                          VacationStateAccepterRefuserWidget(
                              updateLoading: updateLoading),

                          // ListVacationStateWidget(updateLoading: updateLoading),
                          VacationPriseDeVacationWidget(
                              updateUI: updateUI, updateLoading: updateLoading)
                        ],
                      ),
                    ),
                  ],
                )),
            m.isLoading.value ? Waiting() : Container()
          ],
        ));
  }
}
