import 'dart:ui';

import 'package:animated_toggle/animated_toggle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/PLANNING_CONTROLLERS/GBSystem_salarie_planning_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/PLANNING_CONTROLLERS/GBSystem_sites_planning_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_vacation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_toast.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/choose_mode_planning_screen/choose_mode_planning_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/home_planning_screen/GBSystem_home_planning_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/select_item_screen/GBSystem_select_item_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/select_item_vacation_screen/GBSystem_select_item_vacation_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/url_launcher_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_PLANNING_WIDGETS/GBSystem_Root_Card_Home_Widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/display_phone_number_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/slide_to_act_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_WIDGET/GBSystem_button_entrer_sortie.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_WIDGET/GBSystem_user_entrer_sortie.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class GBSystemHomePlanningScreen extends StatefulWidget {
  GBSystemHomePlanningScreen({super.key});

  @override
  State<GBSystemHomePlanningScreen> createState() => _GBSystemHomePlanningScreenState();
}

class _GBSystemHomePlanningScreenState extends State<GBSystemHomePlanningScreen> {
  final GBSystemHomePlanningController m = Get.put(GBSystemHomePlanningController());

  final GBSystemSalariePlanningController salariePlanningController = Get.put(GBSystemSalariePlanningController());

  final GBSystemSitesPlanningController sitePlanningController = Get.put(GBSystemSitesPlanningController());
  void updateUI() {
    setState(() {});
  }

  RxBool callBool = RxBool(false);
  String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    final vacationController = Get.put<GBSystemVacationController>(GBSystemVacationController());

    return Obx(
      () => Stack(
        children: [
          AbsorbPointer(
            absorbing: callBool.value,
            child: ImageFiltered(
              imageFilter: callBool.value == true ? ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0) : ImageFilter.blur(sigmaX: 00.0, sigmaY: 0.0),
              child: Scaffold(
                appBar: AppBar(
                  elevation: 4.0,
                  centerTitle: true,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  toolbarHeight: 70,
                  leading: InkWell(
                    onTap: () {
                      // Get.back();
                      Get.off(ChooseModePlanningScreen());
                    },
                    child: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
                  ),
                  backgroundColor: GbsSystemServerStrings.str_primary_color,
                  title: const Text(GBSystem_Application_Strings.str_home_page, style: TextStyle(color: Colors.white)),
                  actions: [
                    IconButton(
                      onPressed: () async {
                        showWarningSnackBar(context, GBSystem_Application_Strings.str_deconnexion_question, () async {
                          try {
                            await m.deconnexion();
                          } catch (e) {
                            m.isloading.value = false;
                            GBSystem_ManageCatchErrors().catchErrors(context, message: e.toString(), method: "deconnexion", page: "GBSystem_home_planning_screen");
                          }
                          // Get.back();
                          // await m.deconnexion();
                        });
                      },
                      icon: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.logout, color: Colors.white),
                          GBSystem_TextHelper().superSmallText(text: GBSystem_Application_Strings.str_deconnecter, textColor: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02), vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        sitePlanningController.getCurrentSite != null
                            ? GBSystem_Root_CardViewHome_Widget_Generique(
                                title: GBSystem_Application_Strings.str_site,
                                onSearchTap: () {
                                  Get.to(const GBSystem_SelectItemScreen(type: GBSystem_Application_Strings.str_type_site));
                                },
                                opt1: sitePlanningController.getCurrentSite?.LIE_LIB,
                                opt2: sitePlanningController.getCurrentSite?.LIE_CODE,
                                opt3: sitePlanningController.getCurrentSite?.VIL_LIB,
                                opt4: sitePlanningController.getCurrentSite?.LIE_TLPH,

                                // site: sitePlanningController.getCurrentSite
                              )
                            : Container(
                                height: 150,
                                child: Center(child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_no_site)),
                              ),
                        SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.015)),
                        ///////// button begin here ///////////////////
                        ///
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1)],
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: AnimatedHorizontalToggle(
                            taps: [GBSystem_Application_Strings.str_salarie, GBSystem_Application_Strings.str_vacation],
                            width: MediaQuery.of(context).size.width - 20,
                            height: 58,
                            activeBoxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1)],
                            duration: const Duration(milliseconds: 200),
                            initialIndex: 0,
                            background: Colors.white,
                            activeColor: GbsSystemServerStrings.str_primary_color,
                            activeTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                            inActiveTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: GbsSystemServerStrings.str_primary_color),
                            horizontalPadding: 4,
                            verticalPadding: 4,
                            activeHorizontalPadding: 2,
                            activeVerticalPadding: 4,
                            radius: 14,
                            activeButtonRadius: 14,
                            onChange: (int currentIndex, int targetIndex) {
                              m.onTapSheetChanged(targetIndex);
                              setState(() {});
                            },
                            showActiveButtonColor: true,
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          height: GBSystem_ScreenHelper.screenWidth(context),
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: m.pageController,
                            children: [
                              salariePlanningController.getCurrentSalarie != null
                                  ? Column(
                                      children: [
                                        GBSystem_Root_CardViewHome_Salarie_Widget(
                                          onCallTap: () {
                                            callBool.value = true;
                                            phoneNumber = salariePlanningController.getCurrentSalarie!.SVR_TELPOR;
                                          },
                                          onEnterTap: () async {
                                            try {
                                              m.isloading.value = true;
                                              await GBSystem_AuthService(context).pointageEntrerSorieSalarie(Sens: "1", salarie: salariePlanningController.getCurrentSalarie!, site: sitePlanningController.getCurrentSite!).then((value) {
                                                m.isloading.value = false;
                                                if (value != null) {
                                                  showSuccesDialog(context, GBSystem_Application_Strings.str_pointage_entrer_succes);
                                                }
                                              });
                                            } catch (e) {
                                              m.isloading.value = false;
                                              GBSystem_ManageCatchErrors().catchErrors(context, message: e.toString(), method: "pointageEntrerSorieSalarie", page: "GBSystem_home_planning_screen");
                                            }
                                          },
                                          onSortieTap: () async {
                                            try {
                                              m.isloading.value = true;

                                              await GBSystem_AuthService(context).pointageEntrerSorieSalarie(Sens: "2", salarie: salariePlanningController.getCurrentSalarie!, site: sitePlanningController.getCurrentSite!).then((value) {
                                                m.isloading.value = false;
                                                if (value != null) {
                                                  showSuccesDialog(context, GBSystem_Application_Strings.str_pointage_sortie_succes);
                                                }
                                              });
                                            } catch (e) {
                                              m.isloading.value = false;
                                              GBSystem_ManageCatchErrors().catchErrors(context, message: e.toString(), method: "pointageEntrerSorieSalarie2", page: "GBSystem_home_planning_screen");
                                            }
                                          },
                                          title: GBSystem_Application_Strings.str_salarie,
                                          onSearchTap: () {
                                            Get.to(const GBSystem_SelectItemScreen(type: GBSystem_Application_Strings.str_type_salarie));
                                          },
                                          salarie: salariePlanningController.getCurrentSalarie,
                                        ),
                                      ],
                                    )
                                  : Container(
                                      child: Center(child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_no_salarie)),
                                    ),
                              UserEnterSortie(isClosePointageAfterExists: true, isUpdatePause: true, isPlanning: true, afficherPrecSuiv: true, afficherOpertaionsBar: true),
                              ButtonEntrerSortieWithIconAndText(
                                shadowBool: true,
                                onTap: () async {
                                  try {
                                    await m.deconnexion();
                                  } catch (e) {
                                    m.isloading.value = false;
                                    GBSystem_ManageCatchErrors().catchErrors(context, message: e.toString(), method: "deconnexion", page: "GBSystem_home_planning_screen");
                                  }
                                },
                                verPadd: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01),
                                horPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
                                icon: const Icon(Icons.logout_rounded, color: Colors.white),
                                text: GBSystem_Application_Strings.str_deconnecter,
                                color: GbsSystemServerStrings.str_primary_color,
                                number: null,
                              ),
                            ],
                          ),
                        ),
                        Obx(
                          () => vacationController.getAllVacationsRx?.value != null && vacationController.getAllVacationsRx!.value!.isNotEmpty && m.currentIndex.value.toInt() == 1
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await m.selectItemSiteFunction(context).then((value) {
                                          Get.to(GBSystem_SelectItemVacationScreen(destination: GBSystemHomePlanningScreen()));
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(width: 1, color: Colors.black45),
                                            color: Colors.white,
                                          ),
                                          child: Icon(Icons.more_horiz, color: GbsSystemServerStrings.str_primary_color),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ),
                      ],
                    ),
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
                          UrlLauncherService().callNumber(context, number: phoneNumber ?? "");
                        } else {
                          showToast(text: GBSystem_Application_Strings.str_numero_telephone_vide);
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
                      SizedBox(height: 10),
                      Transform.translate(
                        offset: Offset(-GBSystem_ScreenHelper.screenWidthPercentage(context, 0.1), 0),
                        child: DisplayPhoneNumberWidget(phoneNumber: phoneNumber ?? ""),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          callBool.value = false;
                        },
                        child: Icon(CupertinoIcons.xmark, size: 40, color: Colors.white),
                      ),
                    ],
                  ),
                )
              : Container(),
          m.isloading.value ? Waiting() : Container(),
        ],
      ),
    );
  }
}
