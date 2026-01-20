import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/PRISE_DE_VACATION_STATE_WIDGET/vacation_state_preference_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/PRISE_DE_VACATION_WIDGET/vacation_prise_de_vacation_widget_controller.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class VacationPriseDeVacationWidget extends StatelessWidget {
  VacationPriseDeVacationWidget({
    super.key,
    required this.updateLoading,
    required this.updateUI,
  });
  final Function updateLoading, updateUI;

  @override
  Widget build(BuildContext context) {
    final m = Get.put<VacationPriseDeVacationWidgetController>(
        VacationPriseDeVacationWidgetController(
      context,
    ));
    return m.priseDeVacationController.getAllVacationsState.value != null
        ? MainWidget(updateUI: updateUI, updateLoading: updateLoading)
        : FutureBuilder(
            future:
                GBSystem_AuthService(context).getListPriseDeVacationsState(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  m.priseDeVacationController.setAllVacation = snapshot.data;
                  m.priseDeVacationController.setCurrentVacation =
                      snapshot.data?.first;
                  return MainWidget(
                    updateUI: updateUI,
                    updateLoading: updateLoading,
                  );
                } else {
                  return EmptyDataWidget();
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    height: 250,
                    child: WaitingWidgets(),
                  ),
                );
              } else {
                return EmptyDataWidget();
              }
            },
          );
  }
}

class MainWidget extends StatelessWidget {
  MainWidget({
    super.key,
    required this.updateLoading,
    required this.updateUI,
  });
  final Function updateLoading, updateUI;

  @override
  Widget build(BuildContext context) {
    final m = Get.put<VacationPriseDeVacationWidgetController>(
        VacationPriseDeVacationWidgetController(
      context,
    ));
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical:
                GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01),
            horizontal:
                GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: m.priseDeVacationController.getAllVacationsState.value
                    ?.length ??
                0,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                        context, 0.01)),
                child: PreferenceStateWidget(
                  onDeleteTap: () async {
                    showWarningSnackBar(context,
                        GbsSystemStrings.str_are_you_sure_want_delete.tr,
                        () async {
                      updateLoading(true);
                      await GBSystem_AuthService(context)
                          .deletePriseDeVacationsState(
                              priseDeVacationStateModel: m
                                  .priseDeVacationController
                                  .getAllVacationsState
                                  .value![index])
                          .then((value) {
                        updateLoading(false);
                        if (value == true) {
                          m.priseDeVacationController.removeVacation(m
                              .priseDeVacationController
                              .getAllVacationsState
                              .value![index]);
                          showSuccesDialog(context,
                              GbsSystemStrings.str_deleted_with_success.tr);
                          updateUI();
                        }
                      });
                    });
                  },
                  onSaveTap: () {
                    m.showDialogUpdatePriseVacation(
                        context: context,
                        priseDeVacationStateModel: m.priseDeVacationController
                            .getAllVacationsState.value![index],
                        updateUI: updateUI);
                  },
                  preferenceModel: m.priseDeVacationController
                      .getAllVacationsState.value![index],
                ),
              );
            },
          ),
        ));
  }
}
