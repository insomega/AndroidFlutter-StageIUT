import 'package:animated_toggle/animated_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PLANNING_SCREEN/PRISE_DE_VACATION/GBSystem_prise_de_vacation_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/PRISE_DE_VACATION_STATE_WIDGET/vacation_prise_de_vacation_state_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/PRISE_DE_VACATION_WIDGET/vacation_preference_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemPriseDeVacationScreen extends StatelessWidget {
  GBSystemPriseDeVacationScreen({super.key, this.isCommingFromOut = false});

  final bool isCommingFromOut;
  final m = Get.put<GBSystemPriseDeVacationScreenController>(
      GBSystemPriseDeVacationScreenController());
  final String pageName = "GBSystem_prise_de_vacation_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 4.0,
          shadowColor: GbsSystemStrings.str_primary_color,
          toolbarHeight: 80,
          backgroundColor: GbsSystemStrings.str_primary_color,
          title: Text(
            GbsSystemStrings.str_prise_de_vacations.tr,
            style: TextStyle(color: Colors.white),
          ),
          leading: isCommingFromOut
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
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical:
                    GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02),
              ),
              child: AnimatedHorizontalToggle(
                taps: m.listType,
                width: MediaQuery.of(context).size.width - 20,
                height: 48,
                duration: const Duration(milliseconds: 200),
                initialIndex: 0,
                background: Colors.grey.shade200.withOpacity(0.6),
                activeColor: GbsSystemStrings.str_primary_color,
                activeTextStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                inActiveTextStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: GbsSystemStrings.str_primary_color),
                horizontalPadding: 4,
                verticalPadding: 4,
                activeHorizontalPadding: 2,
                activeVerticalPadding: 4,
                radius: 14,
                activeButtonRadius: 14,
                onChange: (int currentIndex, int targetIndex) {
                  try {
                    // write Your Personal Code Here
                    m.selectedType.value = m.listType[targetIndex];
                    m.pageController.animateToPage(currentIndex,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear);
                  } catch (e) {
                    GBSystem_ManageCatchErrors().catchErrors(context,
                        message: e.toString(),
                        method: "AnimatedHorizontalToggle",
                        page: pageName);
                  }
                },
                showActiveButtonColor: true,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.03),
                    vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                        context, 0.02)),
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: m.pageController,
                  children: [
                    m.listPriseDeVacation != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: m.listPriseDeVacation!.length,
                            itemBuilder: (context, index) {
                              return VacationPriseDeVacationWidget(
                                  priseDeVacationModel:
                                      m.listPriseDeVacation![index]);
                            },
                          )
                        : FutureBuilder(
                            future: GBSystem_AuthService(context)
                                .getListPriseDeVacation(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data != null &&
                                    snapshot.data!.isNotEmpty) {
                                  m.priseDeVacationController.setAllVacation =
                                      snapshot.data;
                                  m.priseDeVacationController
                                          .setCurrentVacationVacation =
                                      snapshot.data!.first;
                                  m.listPriseDeVacation = snapshot.data;
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: m.listPriseDeVacation?.length ?? 1,
                                  itemBuilder: (context, index) {
                                    return m.listPriseDeVacation != null &&
                                            m.listPriseDeVacation!.isNotEmpty
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    GBSystem_ScreenHelper
                                                        .screenWidthPercentage(
                                                            context, 0.01),
                                                vertical: GBSystem_ScreenHelper
                                                    .screenHeightPercentage(
                                                        context, 0.01)),
                                            child:
                                                VacationPriseDeVacationWidget(
                                                    priseDeVacationModel:
                                                        m.listPriseDeVacation![
                                                            index]),
                                          )
                                        : EmptyDataWidget();
                                  },
                                );
                              } else {
                                return WaitingWidgets();
                              }
                            },
                          ),
                    ///// Page 2
                    m.listPreferences != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: m.listPreferences!.length,
                            itemBuilder: (context, index) {
                              return PreferenceWidget(
                                  preferenceModel: m.listPreferences![index]);
                            },
                          )
                        : FutureBuilder(
                            future: GBSystem_AuthService(context)
                                .getListPreferences(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data != null &&
                                    snapshot.data!.isNotEmpty) {
                                  m.preferencesController.setAllPrefernce =
                                      snapshot.data;
                                  m.preferencesController.setCurrentPreference =
                                      snapshot.data!.first;
                                  m.listPreferences = snapshot.data;
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: m.listPreferences?.length ?? 1,
                                  itemBuilder: (context, index) {
                                    return m.listPreferences != null &&
                                            m.listPreferences!.isNotEmpty
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    GBSystem_ScreenHelper
                                                        .screenWidthPercentage(
                                                            context, 0.01),
                                                vertical: GBSystem_ScreenHelper
                                                    .screenHeightPercentage(
                                                        context, 0.01)),
                                            child: PreferenceWidget(
                                                preferenceModel:
                                                    m.listPreferences![index]),
                                          )
                                        : EmptyDataWidget();
                                  },
                                );
                              } else {
                                return WaitingWidgets();
                              }
                            },
                          ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
