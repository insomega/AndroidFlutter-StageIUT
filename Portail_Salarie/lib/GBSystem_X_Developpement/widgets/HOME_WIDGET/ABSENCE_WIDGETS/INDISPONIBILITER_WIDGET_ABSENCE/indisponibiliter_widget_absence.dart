import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/INDISPONIBILITER_WIDGET_ABSENCE/indisponibiliter_absence_display_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/INDISPONIBILITER_WIDGET_ABSENCE/indisponibiliter_absence_widget_controller.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class IndisponibiliterAbsenceWidget extends StatelessWidget {
  IndisponibiliterAbsenceWidget({
    super.key,
    required this.updateLoading,
    required this.updateUI,
  });
  final Function updateLoading, updateUI;

  @override
  Widget build(BuildContext context) {
    final m = Get.put<IndisponibiliterAbsenceWidgetController>(
        IndisponibiliterAbsenceWidgetController(
      context,
    ));
    return m.indisponibiliterController.getAllIndisponibiliters != null
        ? MainWidget(updateUI: updateUI, updateLoading: updateLoading)
        : FutureBuilder(
            future: GBSystem_AuthService(context).getListIndisponibiliter(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  m.indisponibiliterController.setAllIndisponibiliter =
                      snapshot.data;
                  m.indisponibiliterController.setCurrentIndisponibiliter =
                      snapshot.data?.first;
                  return MainWidget(
                    updateUI: updateUI,
                    updateLoading: updateLoading,
                  );
                } else {
                  return EmptyDataWidget();
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 250,
                  child: Center(child: WaitingWidgets()),
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
    final m = Get.put<IndisponibiliterAbsenceWidgetController>(
        IndisponibiliterAbsenceWidgetController(
      context,
    ));
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01),
          horizontal:
              GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02)),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount:
            m.indisponibiliterController.getAllIndisponibiliters?.length ?? 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                    context, 0.01)),
            child: IndisponibiliterAbsenceDispalyDataWidget(
              onDeleteTap: () async {
                try {
                  showWarningSnackBar(
                      context, GbsSystemStrings.str_are_you_sure_want_delete.tr,
                      () async {
                    updateLoading(true);
                    await GBSystem_AuthService(context)
                        .deleteIndisponibiliter(
                            indisponibiliterModel: m.indisponibiliterController
                                .getAllIndisponibiliters![index])
                        .then((value) {
                      updateLoading(false);
                      if (value == true) {
                        m.indisponibiliterController.deleteIndisponibiliter(m
                            .indisponibiliterController
                            .getAllIndisponibiliters![index]);
                        showSuccesDialog(context,
                            GbsSystemStrings.str_deleted_with_success.tr);
                        updateUI();
                      }
                    });
                  });
                } catch (e) {
                  updateLoading(false);
                  GBSystem_ManageCatchErrors().catchErrors(context,
                      message: e.toString(),
                      method: "delete",
                      page: "indisponibiliter_widget_absence");
                }
              },
              indisponibiliterModel:
                  m.indisponibiliterController.getAllIndisponibiliters![index],
            ),
          );
        },
      ),
    );
  }
}
