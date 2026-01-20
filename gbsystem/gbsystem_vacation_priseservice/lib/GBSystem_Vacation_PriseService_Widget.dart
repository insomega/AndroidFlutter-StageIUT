import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';

import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_root/GBSystem_waiting.dart';
import 'package:gbsystem_root/GBSystem_button_entrer_sortie.dart';

import 'GBSystem_Vacation_Title_Widget.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'GBSystem_Vacation_PriseService_Controller.dart';

class GBSystem_Vacation_PriseService_Widget extends Card {
  const GBSystem_Vacation_PriseService_Widget({
    super.key, //
    this.isPlanning = false,
    this.isClosePointageAfterExists = false,
    this.desconnectAfterSuccess = false,
    this.afficherPrecSuiv = true,
    this.afficherOpertaionsBar = true,
    this.isUpdatePause = false,
    required this.routeLogin,
  });

  final bool afficherPrecSuiv, afficherOpertaionsBar;
  final bool isPlanning;
  final bool desconnectAfterSuccess;
  final bool isUpdatePause, isClosePointageAfterExists;
  final String routeLogin;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      GBSystem_Vacation_PriseService_Controller(
        context: context, //
        isUpdatePause: isUpdatePause,
        isClosePointageAfterExists: isClosePointageAfterExists,
        routeLogin: routeLogin,
      ),
    );

    return Obx(
      () => Stack(
        children: [
          _buildMainContent(context, controller), //
          if (controller.isLoading.value) _buildLoadingOverlay(),
          // Obx(() {
          //   if (controller.isLoading.value) {
          //     return Waiting();
          //   } else {
          //     return _buildMainContent(context, controller);
          //   }
          // }),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, GBSystem_Vacation_PriseService_Controller controller) {
    return ImageFiltered(
      imageFilter: controller.isLoading.value
          ? //
            ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0)
          : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
      child: Container(
        height: 400,
        padding: EdgeInsets.symmetric(
          vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01), //
          horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.04),
        ),
        decoration: _buildContainerDecoration(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02), //
            vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildVacationTitle(controller),
                  if (controller.Vacation_Informations_Controller.currentVacation != null) const SizedBox(height: 10),
                  _buildVacationPages(context, controller),
                  SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.03)),
                  _buildOperationsBar(context, controller),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      border: Border.all(width: 0.4, color: Colors.grey, style: BorderStyle.solid),
      boxShadow: [
        BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: -40, blurRadius: 22, offset: const Offset(10, 40)),
        BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: -40, blurRadius: 22, offset: const Offset(-10, -40)),
      ],
    );
  }

  Widget _buildVacationTitle(GBSystem_Vacation_PriseService_Controller controller) {
    return Obx(
      () => Visibility(
        visible: controller.Vacation_Informations_Controller.currentVacation != null,
        child: GBSystem_Vacation_Title_Widget(title: controller.Vacation_Informations_Controller.currentVacation?.TITLE.trim() ?? ""),
      ),
    );
  }

  Widget _buildVacationPages(BuildContext context, GBSystem_Vacation_PriseService_Controller controller) {
    return Obx(() {
      final hasVacation = controller.Vacation_Informations_Controller.currentVacationRx.value != null;

      return SizedBox(
        height: 200,
        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
        child: hasVacation
            ? PageView(physics: const NeverScrollableScrollPhysics(), controller: controller.pageController, children: controller.vacationPages)
            : Center(
                child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_aucune_vacation, textColor: Colors.black),
              ),
      );
    });
  }

  Widget _buildOperationsBar(BuildContext context, GBSystem_Vacation_PriseService_Controller controller) {
    return Obx(() {
      final currentVacation = controller.Vacation_Informations_Controller.currentVacation;
      final shouldShowBar = currentVacation != null && afficherOpertaionsBar;
      final canShowActions = currentVacation?.TPH_PSA == "1";

      if (!shouldShowBar) return const SizedBox.shrink();

      return SizedBox(
        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, //
          children: [
            if (afficherPrecSuiv) _buildPrecedentButton(context, controller), //
            if (canShowActions) _buildEntrerButton(context, controller),
            if (canShowActions) _buildSortieButton(context, controller),
            if (afficherPrecSuiv) _buildSuivantButton(context, controller),
          ],
        ),
      );
    });
  }

  Widget _buildPrecedentButton(BuildContext context, GBSystem_Vacation_PriseService_Controller controller) {
    return ButtonEntrerSortieWithIcon(
      onTap: () => controller.precedentFunction(),
      color: GBSystem_Application_Strings.str_primary_color,
      verPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
      horPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.01),
      icon: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
    );
  }

  Widget _buildEntrerButton(BuildContext context, GBSystem_Vacation_PriseService_Controller controller) {
    final currentVacation = controller.Vacation_Informations_Controller.currentVacation;
    final isDisabled = isClosePointageAfterExists && currentVacation?.PNTGS_IN_NBR != null && currentVacation!.PNTGS_IN_NBR!.isNotEmpty;
    final pointageCount = currentVacation?.PNTGS_IN_NBR != null && currentVacation!.PNTGS_IN_NBR!.isNotEmpty ? int.tryParse(currentVacation.PNTGS_IN_NBR!) : null;

    return ButtonEntrerSortieWithIconAndText(
      disableBtn: isDisabled,
      onTap: () => controller.entrerFunction(desconnectAfterSuccess),
      number: pointageCount,
      icon: const Icon(CupertinoIcons.hand_draw_fill, color: Colors.white),
      verPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
      horPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.01),
      text: GBSystem_Application_Strings.str_entrer,
      color: Colors.green,
    );
  }

  Widget _buildSortieButton(BuildContext context, GBSystem_Vacation_PriseService_Controller controller) {
    final currentVacation = controller.Vacation_Informations_Controller.currentVacation;
    final isDisabled = isClosePointageAfterExists && currentVacation?.PNTGS_OUT_NBR != null && currentVacation!.PNTGS_OUT_NBR!.isNotEmpty;
    final pointageCount = currentVacation?.PNTGS_OUT_NBR != null && currentVacation!.PNTGS_OUT_NBR!.isNotEmpty ? int.tryParse(currentVacation.PNTGS_OUT_NBR!) : null;

    return ButtonEntrerSortieWithIconAndText(
      disableBtn: isDisabled,
      onTap: () => controller.sortieFunction(desconnectAfterSuccess),
      number: pointageCount,
      icon: const Icon(CupertinoIcons.hand_draw_fill, color: Colors.white),
      verPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
      horPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.01),
      text: GBSystem_Application_Strings.str_sortie,
      color: Colors.red,
    );
  }

  Widget _buildSuivantButton(BuildContext context, GBSystem_Vacation_PriseService_Controller controller) {
    return ButtonEntrerSortieWithIcon(
      onTap: () => controller.suivantFunction(),
      color: GBSystem_Application_Strings.str_primary_color,
      verPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
      horPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.01),
      icon: const Icon(CupertinoIcons.arrow_right, color: Colors.white),
    );
  }

  Widget _buildLoadingOverlay() {
    return Waiting(
      colorBackground: Colors.transparent, //
      text: GBSystem_Application_Strings.str_pointage_en_cours,
      loadingLottieSize: 30,
      borderRaduis: 10,
      height: 400,
      textColor: Colors.black,
      loadingLottieColor: Colors.black,
    );
  }
}

// class GBSystem_Vacation_PriseService_Widget extends Card {
//   GBSystem_Vacation_PriseService_Widget({super.key, this.isPlanning = false, this.isClosePointageAfterExists = false, this.desconnectAfterSuccess = false, this.afficherPrecSuiv = true, this.afficherOpertaionsBar = true, this.isUpdatePause = false});

//   final bool afficherPrecSuiv, afficherOpertaionsBar;
//   final bool isPlanning;
//   final bool desconnectAfterSuccess;
//   final bool isUpdatePause, isClosePointageAfterExists;

//   @override
//   Widget build(BuildContext context) {
//     final m = Get.put<GBSystem_Vacation_PriseService_Controller>(GBSystem_Vacation_PriseService_Controller(context: context, isUpdatePause: isUpdatePause, isClosePointageAfterExists: isClosePointageAfterExists));
//     final vacationController = Get.put<GBSystem_Vacation_Informations_Controller>(GBSystem_Vacation_Informations_Controller());

//     return Obx(() => Stack(children: [_buildMainContent(context, m, vacationController), if (m.isLoading.value) _buildLoadingOverlay()]));
//   }

//   Widget _buildMainContent(BuildContext context, GBSystem_Vacation_PriseService_Controller m, GBSystem_Vacation_Informations_Controller vacationController) {
//     return ImageFiltered(
//       imageFilter: m.isLoading.value ? ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0) : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
//       child: Container(
//         height: 400,
//         padding: EdgeInsets.symmetric(vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01), horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.04)),
//         decoration: _buildContainerDecoration(),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02), vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   _buildVacationTitle(vacationController),
//                   if (vacationController.hasCurrentVacation) const SizedBox(height: 10),
//                   _buildVacationContent(context, m, vacationController),
//                   SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.03)),
//                   _buildOperationButtons(context, m, vacationController),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   BoxDecoration _buildContainerDecoration() {
//     return BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       color: Colors.white,
//       border: Border.all(width: 0.4, color: Colors.grey, style: BorderStyle.solid),
//       boxShadow: [
//         BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: -40, blurRadius: 22, offset: const Offset(10, 40)),
//         BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: -40, blurRadius: 22, offset: const Offset(-10, -40)),
//       ],
//     );
//   }

//   Widget _buildVacationTitle(GBSystem_Vacation_Informations_Controller vacationController) {
//     return Visibility(
//       visible: vacationController.hasCurrentVacation,
//       child: GBSystem_Vacation_Title_Widget(title: vacationController.currentVacationTitle),
//     );
//   }

//   Widget _buildVacationContent(BuildContext context, GBSystem_Vacation_PriseService_Controller m, GBSystem_Vacation_Informations_Controller vacationController) {
//     return Obx(() {
//       //if (vacationController.currentVacationRx?.value != null) {
//       if (vacationController.hasCurrentVacation) {
//         return SizedBox(
//           height: 200,
//           width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
//           child: PageView(physics: const NeverScrollableScrollPhysics(), controller: m.pageController, children: m.vacationPages),
//         );
//       } else {
//         return SizedBox(
//           height: 200,
//           width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
//           child: Center(
//             child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_aucune_vacation, textColor: Colors.black),
//           ),
//         );
//       }
//     });
//   }

//   Widget _buildOperationButtons(BuildContext context, GBSystem_Vacation_PriseService_Controller m, GBSystem_Vacation_Informations_Controller vacationController) {
//     final canShowButtons = vacationController.hasCurrentVacation && afficherOpertaionsBar;
//     if (!canShowButtons) return const SizedBox.shrink();

//     return SizedBox(
//       width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           if (afficherPrecSuiv)
//             _buildNavigationButton(
//               context,
//               onTap: () => _handlePrecedentFunction(context, m),
//               icon: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
//             ),
//           if (vacationController.isCurrentVacationActive) _buildActionButton(context, vacationController, isEntry: true, onTap: () => _handleEntrerFunction(context, m, desconnectAfterSuccess), disableBtn: isClosePointageAfterExists && vacationController.hasEntryPointage),
//           if (vacationController.isCurrentVacationActive) _buildActionButton(context, vacationController, isEntry: false, onTap: () => _handleSortieFunction(context, m, desconnectAfterSuccess), disableBtn: isClosePointageAfterExists && vacationController.hasExitPointage),
//           if (afficherPrecSuiv)
//             _buildNavigationButton(
//               context,
//               onTap: () => _handleSuivantFunction(context, m),
//               icon: const Icon(CupertinoIcons.arrow_right, color: Colors.white),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavigationButton(BuildContext context, {required VoidCallback onTap, required Icon icon}) {
//     return ButtonEntrerSortieWithIcon(onTap: onTap, color: GBSystem_Application_Strings.str_primary_color, verPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02), horPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.01), icon: icon);
//   }

//   Widget _buildActionButton(BuildContext context, GBSystem_Vacation_Informations_Controller vacationController, {required bool isEntry, required VoidCallback onTap, required bool disableBtn}) {
//     return ButtonEntrerSortieWithIconAndText(
//       disableBtn: disableBtn,
//       onTap: onTap,
//       number: isEntry ? vacationController.entryPointageNumber : vacationController.exitPointageNumber,
//       icon: const Icon(CupertinoIcons.hand_draw_fill, color: Colors.white),
//       verPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
//       horPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.01),
//       text: isEntry ? GBSystem_Application_Strings.str_entrer : GBSystem_Application_Strings.str_sortie,
//       color: isEntry ? Colors.green : Colors.red,
//     );
//   }

//   Widget _buildLoadingOverlay() {
//     return Waiting(
//       colorBackground: Colors.transparent, //
//       text: GBSystem_Application_Strings.str_pointage_en_cours,
//       loadingLottieSize: 30,
//       borderRaduis: 10,
//       height: 400,
//       textColor: Colors.black,
//       loadingLottieColor: Colors.black,
//     );
//   }

//   Future<void> _handlePrecedentFunction(BuildContext context, GBSystem_Vacation_PriseService_Controller m) async {
//     try {
//       await m.precedentFunction(context);
//     } catch (e) {
//       m.isLoading.value = false;
//       GBSystem_LogEvent().logEvent(message: e.toString(), method: "precedentFunction", page: "GBSystem_user_entrer_sortie");
//     }
//   }

//   Future<void> _handleSuivantFunction(BuildContext context, GBSystem_Vacation_PriseService_Controller m) async {
//     try {
//       await m.suivantFunction(context);
//     } catch (e) {
//       m.isLoading.value = false;
//       GBSystem_LogEvent().logEvent(message: e.toString(), method: "suivantFunction", page: "GBSystem_user_entrer_sortie");
//     }
//   }

//   Future<void> _handleEntrerFunction(BuildContext context, GBSystem_Vacation_PriseService_Controller m, bool desconnectAfterSuccess) async {
//     try {
//       await m.entrerFunction(context, desconnectAfterSuccess);
//     } catch (e) {
//       m.isLoading.value = false;
//       GBSystem_LogEvent().logEvent(message: e.toString(), method: "entrerFunction", page: "GBSystem_user_entrer_sortie");
//     }
//   }

//   Future<void> _handleSortieFunction(BuildContext context, GBSystem_Vacation_PriseService_Controller m, bool desconnectAfterSuccess) async {
//     try {
//       await m.sortieFunction(context, desconnectAfterSuccess);
//     } catch (e) {
//       m.isLoading.value = false;
//       GBSystem_LogEvent().logEvent(message: e.toString(), method: "sortieFunction", page: "GBSystem_user_entrer_sortie");
//     }
//   }
// }

/*
class GBSystem_Vacation_PriseService_Widget extends Card {
  GBSystem_Vacation_PriseService_Widget({
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
    final m = Get.put<GBSystem_Vacation_PriseService_Controller>(GBSystem_Vacation_PriseService_Controller(context: context, isUpdatePause: isUpdatePause, isClosePointageAfterExists: isClosePointageAfterExists));
    final vacationController = Get.put<GBSystem_Vacation_Informations_Controller>(GBSystem_Vacation_Informations_Controller());
    return Obx(() => Stack(
          children: [
            ImageFiltered(
              imageFilter: m.isLoading.value == true ? ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0) : ImageFilter.blur(sigmaX: 00.0, sigmaY: 0.0),
              child: Container(
                height: 400,
                padding: EdgeInsets.symmetric(
                  vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01),
                  horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.04),
                ),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, border: Border.all(width: 0.4, color: Colors.grey, style: BorderStyle.solid), boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: -40,
                    blurRadius: 22,
                    offset: const Offset(10, 40), // changes the shadow position
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: -40,
                    blurRadius: 22,
                    offset: const Offset(-10, -40), // changes the shadow position
                  ),
                ]),
                child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
                      vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: vacationController.currentVacation != null,
                              //child: GBSystem_Vacation_Title_Widget(title: vacationController.currentVacation?.TITLE ?? vacationController.currentVacation?.TITLE ?? ""),
                              child: GBSystem_Vacation_Title_Widget(title: vacationController.currentVacation?.TITLE.trim() ?? ""),
                            ),
                            vacationController.currentVacation != null ? const SizedBox(height: 10) : const SizedBox(),
                            Obx(
                              () => vacationController.currentVacationRx?.value != null
                                  ? SizedBox(
                                      height: 200,
                                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                                      child: PageView(
                                        physics: const NeverScrollableScrollPhysics(),
                                        controller: m.pageController,
                                        children: m.vacationPages,
                                      ),
                                    )
                                  : SizedBox(
                                      height: 200,
                                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                                      child: Center(
                                        child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_aucune_vacation, textColor: Colors.black),
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.03),
                            ),
                            Visibility(
                              visible: (vacationController.currentVacation != null && afficherOpertaionsBar),
                              child: SizedBox(
                                width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Visibility(
                                      visible: afficherPrecSuiv,
                                      child: ButtonEntrerSortieWithIcon(
                                        onTap: () async {
                                          try {
                                            await m.precedentFunction(context);
                                          } catch (e) {
                                            m.isLoading.value = false;
                                            GBSystem_LogEvent().logEvent(context, message: e.toString(), method: "precedentFunction", page: "GBSystem_user_entrer_sortie");
                                          }
                                        },
                                        color: GBSystem_Application_Strings.str_primary_color,
                                        verPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
                                        horPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.01),
                                        icon: const Icon(
                                          CupertinoIcons.arrow_left,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: vacationController.currentVacation != null &&
                                          // new
                                          vacationController.currentVacation!.TPH_PSA == "1",
                                      child: ButtonEntrerSortieWithIconAndText(
                                        disableBtn: isClosePointageAfterExists && vacationController.currentVacation!.PNTGS_IN_NBR != null && vacationController.currentVacation!.PNTGS_IN_NBR!.isNotEmpty,
                                        onTap: () async {
                                          try {
                                            await m.entrerFunction(context, desconnectAfterSuccess);
                                          } catch (e) {
                                            m.isLoading.value = false;
                                            GBSystem_LogEvent().logEvent(context, message: e.toString(), method: "entrerFunction", page: "GBSystem_user_entrer_sortie");
                                          }
                                        },
                                        number: vacationController.currentVacation?.PNTGS_IN_NBR != null && vacationController.currentVacation!.PNTGS_IN_NBR!.isNotEmpty ? int.parse(vacationController.currentVacation!.PNTGS_IN_NBR!) : null,
                                        icon: const Icon(
                                          CupertinoIcons.hand_draw_fill,
                                          color: Colors.white,
                                        ),
                                        verPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
                                        horPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.01),
                                        text: GBSystem_Application_Strings.str_entrer,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Visibility(
                                      visible: vacationController.currentVacation != null &&
                                          // new
                                          vacationController.currentVacation!.TPH_PSA == "1",
                                      child: ButtonEntrerSortieWithIconAndText(
                                        disableBtn: isClosePointageAfterExists && vacationController.currentVacation!.PNTGS_OUT_NBR != null && vacationController.currentVacation!.PNTGS_OUT_NBR!.isNotEmpty,
                                        number: vacationController.currentVacation?.PNTGS_OUT_NBR != null && vacationController.currentVacation!.PNTGS_OUT_NBR!.isNotEmpty ? int.parse(vacationController.currentVacation!.PNTGS_OUT_NBR!) : null,
                                        onTap: () async {
                                          // print("press sortie");
                                          try {
                                            await m.sortieFunction(context, desconnectAfterSuccess);
                                          } catch (e) {
                                            m.isLoading.value = false;
                                            GBSystem_LogEvent().logEvent(context, message: e.toString(), method: "sortieFunction", page: "GBSystem_user_entrer_sortie");
                                          }
                                        },
                                        icon: const Icon(
                                          CupertinoIcons.hand_draw_fill,
                                          color: Colors.white,
                                        ),
                                        verPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
                                        horPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.01),
                                        text: GBSystem_Application_Strings.str_sortie,
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
                                            GBSystem_LogEvent().logEvent(context, message: e.toString(), method: "suivantFunction", page: "GBSystem_user_entrer_sortie");
                                          }
                                        },
                                        color: GBSystem_Application_Strings.str_primary_color,
                                        verPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
                                        horPadd: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.01),
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
                    text: GBSystem_Application_Strings.str_pointage_en_cours,
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
*/
