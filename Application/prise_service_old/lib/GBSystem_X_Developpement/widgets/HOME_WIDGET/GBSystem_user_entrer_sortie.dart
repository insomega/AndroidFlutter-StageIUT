import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_vacation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_WIDGET/GBSystem_button_entrer_sortie.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/home_screen/GBSystem_user_entrer_sortie_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_WIDGET/GBSystem_vacation_title.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class UserEnterSortie extends Card {
  UserEnterSortie({
    super.key,
    this.isPlanning = false,
    this.isClosePointageAfterExists = false,
    this.desconnectAfterSuccess = false,
    this.afficherPrecSuiv = true,
    this.afficherOpertaionsBar = true,
    this.isUpdatePause = false,
  });

  final bool afficherPrecSuiv, afficherOpertaionsBar;
  final bool isPlanning;
  final bool desconnectAfterSuccess;
  final bool isUpdatePause, isClosePointageAfterExists;

  @override
  Widget build(BuildContext context) {
    final m = Get.put<UserEntrerSortieController>(UserEntrerSortieController(
        context: context,
        isUpdatePause: isUpdatePause,
        isClosePointageAfterExists: isClosePointageAfterExists));
    final vacationController =
        Get.put<GBSystemVacationController>(GBSystemVacationController());
    return Obx(() => Stack(
          children: [
            ImageFiltered(
              imageFilter: m.isLoading.value == true
                  ? ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0)
                  : ImageFilter.blur(sigmaX: 00.0, sigmaY: 0.0),
              child: Container(
                height: 400,
                padding: EdgeInsets.symmetric(
                  vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.01),
                  horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                      context, 0.04),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                        width: 0.4,
                        color: Colors.grey,
                        style: BorderStyle.solid),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: -40,
                        blurRadius: 22,
                        offset:
                            const Offset(10, 40), // changes the shadow position
                      ),
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: -40,
                        blurRadius: 22,
                        offset: const Offset(
                            -10, -40), // changes the shadow position
                      ),
                    ]),
                child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                          context, 0.02),
                      vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Visibility(
                              visible:
                                  vacationController.getCurrentVacation != null,
                              child: VacationTitle(
                                  title: vacationController
                                          .getCurrentVacation?.TITLE ??
                                      vacationController
                                          .getCurrentVacation?.TITLE ??
                                      ""),
                            ),
                            vacationController.getCurrentVacation != null
                                ? const SizedBox(
                                    height: 10,
                                  )
                                : const SizedBox(),
                            Obx(
                              () => vacationController
                                          .getCurrentVacationRx?.value !=
                                      null
                                  ? SizedBox(
                                      height: 200,
                                      width: GBSystem_ScreenHelper
                                          .screenWidthPercentage(context, 0.8),
                                      child: PageView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        controller: m.pageController,
                                        children: m.vacationPages,
                                      ),
                                    )
                                  : SizedBox(
                                      height: 200,
                                      width: GBSystem_ScreenHelper
                                          .screenWidthPercentage(context, 0.8),
                                      child: Center(
                                        child: GBSystem_TextHelper().smallText(
                                            text: GbsSystemStrings
                                                .str_aucune_vacation,
                                            textColor: Colors.black),
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height:
                                  GBSystem_ScreenHelper.screenHeightPercentage(
                                      context, 0.03),
                            ),
                            Visibility(
                              visible: (vacationController.getCurrentVacation !=
                                      null &&
                                  afficherOpertaionsBar),
                              child: SizedBox(
                                width:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Visibility(
                                      visible: afficherPrecSuiv,
                                      child: ButtonEntrerSortieWithIcon(
                                        onTap: () async {
                                          try {
                                            await m.precedentFunction(context);
                                          } catch (e) {
                                            m.isLoading.value = false;
                                            GBSystem_ManageCatchErrors()
                                                .catchErrors(context,
                                                    message: e.toString(),
                                                    method: "precedentFunction",
                                                    page:
                                                        "GBSystem_user_entrer_sortie");
                                          }
                                        },
                                        color: GbsSystemServerStrings
                                            .str_primary_color,
                                        verPadd: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.02),
                                        horPadd: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.01),
                                        icon: const Icon(
                                          CupertinoIcons.arrow_left,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: vacationController
                                                  .getCurrentVacation !=
                                              null &&
                                          // new
                                          vacationController.getCurrentVacation!
                                                  .TPH_PSA ==
                                              "1",
                                      child: ButtonEntrerSortieWithIconAndText(
                                        disableBtn:
                                            isClosePointageAfterExists &&
                                                vacationController
                                                        .getCurrentVacation!
                                                        .PNTGS_IN_NBR !=
                                                    null &&
                                                vacationController
                                                    .getCurrentVacation!
                                                    .PNTGS_IN_NBR!
                                                    .isNotEmpty,
                                        onTap: () async {
                                          try {
                                            await m.entrerFunction(context,
                                                desconnectAfterSuccess);
                                          } catch (e) {
                                            m.isLoading.value = false;
                                            GBSystem_ManageCatchErrors()
                                                .catchErrors(context,
                                                    message: e.toString(),
                                                    method: "entrerFunction",
                                                    page:
                                                        "GBSystem_user_entrer_sortie");
                                          }
                                        },
                                        number: vacationController
                                                        .getCurrentVacation
                                                        ?.PNTGS_IN_NBR !=
                                                    null &&
                                                vacationController
                                                    .getCurrentVacation!
                                                    .PNTGS_IN_NBR!
                                                    .isNotEmpty
                                            ? int.parse(vacationController
                                                .getCurrentVacation!
                                                .PNTGS_IN_NBR!)
                                            : null,
                                        icon: const Icon(
                                          CupertinoIcons.hand_draw_fill,
                                          color: Colors.white,
                                        ),
                                        verPadd: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.02),
                                        horPadd: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.01),
                                        text: GbsSystemStrings.str_entrer,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Visibility(
                                      visible: vacationController
                                                  .getCurrentVacation !=
                                              null &&
                                          // new
                                          vacationController.getCurrentVacation!
                                                  .TPH_PSA ==
                                              "1",
                                      child: ButtonEntrerSortieWithIconAndText(
                                        disableBtn:
                                            isClosePointageAfterExists &&
                                                vacationController
                                                        .getCurrentVacation!
                                                        .PNTGS_OUT_NBR !=
                                                    null &&
                                                vacationController
                                                    .getCurrentVacation!
                                                    .PNTGS_OUT_NBR!
                                                    .isNotEmpty,
                                        number: vacationController
                                                        .getCurrentVacation
                                                        ?.PNTGS_OUT_NBR !=
                                                    null &&
                                                vacationController
                                                    .getCurrentVacation!
                                                    .PNTGS_OUT_NBR!
                                                    .isNotEmpty
                                            ? int.parse(vacationController
                                                .getCurrentVacation!
                                                .PNTGS_OUT_NBR!)
                                            : null,
                                        onTap: () async {
                                          // print("press sortie");
                                          try {
                                            await m.sortieFunction(context,
                                                desconnectAfterSuccess);
                                          } catch (e) {
                                            m.isLoading.value = false;
                                            GBSystem_ManageCatchErrors()
                                                .catchErrors(context,
                                                    message: e.toString(),
                                                    method: "sortieFunction",
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
                                                context, 0.01),
                                        text: GbsSystemStrings.str_sortie,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Visibility(
                                      visible: afficherPrecSuiv,
                                      child: ButtonEntrerSortieWithIcon(
                                        onTap: () async {
                                          try {
                                            await m.suivantFunction(context);
                                          } catch (e) {
                                            m.isLoading.value = false;
                                            GBSystem_ManageCatchErrors()
                                                .catchErrors(context,
                                                    message: e.toString(),
                                                    method: "suivantFunction",
                                                    page:
                                                        "GBSystem_user_entrer_sortie");
                                          }
                                        },
                                        color: GbsSystemServerStrings
                                            .str_primary_color,
                                        verPadd: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.02),
                                        horPadd: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.01),
                                        icon: const Icon(
                                          CupertinoIcons.arrow_right,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            m.isLoading.value
                ? Waiting(
                    colorBackground: Colors.transparent,
                    // Colors.grey.shade300.withOpacity(0.6),
                    text: GbsSystemStrings.str_pointage_en_cours,
                    loadingLottieSize: 30,
                    borderRaduis: 10,
                    height: 400,
                    textColor: Colors.black,
                    loadingLottieColor: Colors.black,
                  )
                : Container()
          ],
        ));
  }
}
