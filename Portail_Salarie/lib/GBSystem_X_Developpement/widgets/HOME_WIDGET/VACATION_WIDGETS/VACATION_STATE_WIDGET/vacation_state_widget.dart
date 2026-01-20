import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/vacation_title.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/VACATION_WIDGETS/VACATION_STATE_WIDGET/vacation_state_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/VACATION_WIDGETS/VACATION_STATE_WIDGET/vacation_state_display_data.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class VacationStateWidget extends StatelessWidget {
  VacationStateWidget({
    super.key,
    required this.updateLoading,
  });
  final Function updateLoading;

  @override
  Widget build(BuildContext context) {
    final m = Get.put<VacationStateWidgetController>(
        VacationStateWidgetController(context));
    return m.vacationStateController.getAllVacationsEnAttente.value != null
        ? m.vacationStateController.getAllVacationsEnAttente.value!.isNotEmpty
            ? MainWidget(updateLoading: updateLoading)
            : EmptyDataWidget()
        : FutureBuilder(
            future: GBSystem_AuthService(context).getListVacationsState(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  m.vacationStateController.setAllVacation = snapshot.data;
                  m.vacationStateController.setCurrentVacationVacation =
                      snapshot.data?.first;
                  final hexColor = m.vacationStateController.getAllVacations
                      .value!.first.STATE_COLOR
                      .replaceAll(r"#", "")
                      .replaceAll(r"$", "");
                  final color = Color(int.parse(
                    '0xFF$hexColor',
                  ));
                  m.typeAbsColor.value = color;
                  return m.vacationStateController.getAllVacationsEnAttente
                                  .value !=
                              null &&
                          m.vacationStateController.getAllVacationsEnAttente
                              .value!.isNotEmpty
                      ? MainWidget(
                          updateLoading: updateLoading,
                        )
                      : EmptyDataWidget();
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
  });
  final Function updateLoading;

  @override
  Widget build(BuildContext context) {
    final m = Get.put<VacationStateWidgetController>(
        VacationStateWidgetController(context));
    return Stack(
      children: [
        Container(
            padding: EdgeInsets.symmetric(
                horizontal:
                    GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
                vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                    context, 0.01)),
            child: Obx(() => ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: m.vacationStateController.getAllVacationsEnAttente
                              .value !=
                          null
                      ? m.vacationStateController.getAllVacationsEnAttente
                          .value!.length
                      : 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                              width: 0.4,
                              color: Colors.grey,
                              style: BorderStyle.solid),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: GBSystem_ScreenHelper
                                    .screenHeightPercentage(context, 0.02),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
                                color: m
                                            .vacationStateController
                                            .getAllVacationsEnAttente
                                            .value![index]
                                            .STATE ==
                                        "str_en_attente"
                                    ? Colors.blue.withOpacity(1)
                                    : m
                                                .vacationStateController
                                                .getAllVacationsEnAttente
                                                .value![index]
                                                .STATE ==
                                            "str_acceptee"
                                        ? Colors.green.withOpacity(1)
                                        : m
                                                    .vacationStateController
                                                    .getAllVacationsEnAttente
                                                    .value![index]
                                                    .STATE ==
                                                "str_demandee"
                                            ? Colors.orange.withOpacity(1)
                                            : m
                                                        .vacationStateController
                                                        .getAllVacationsEnAttente
                                                        .value![index]
                                                        .STATE ==
                                                    "str_refusee"
                                                ? Colors.red.withOpacity(1)
                                                : Colors.blue.withOpacity(1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GBSystem_TextHelper().normalText(
                                    textColor: Colors.white,
                                    text: m
                                                .vacationStateController
                                                .getAllVacationsEnAttente
                                                .value![index]
                                                .STATE ==
                                            "str_en_attente"
                                        ? GbsSystemStrings.str_en_attente.tr
                                        : m
                                                    .vacationStateController
                                                    .getAllVacationsEnAttente
                                                    .value![index]
                                                    .STATE ==
                                                "str_acceptee"
                                            ? GbsSystemStrings.str_accepter.tr
                                            : m
                                                        .vacationStateController
                                                        .getAllVacationsEnAttente
                                                        .value![index]
                                                        .STATE ==
                                                    "str_demandee"
                                                ? GbsSystemStrings
                                                    .str_demander.tr
                                                : m
                                                            .vacationStateController
                                                            .getAllVacationsEnAttente
                                                            .value![index]
                                                            .STATE ==
                                                        "str_refusee"
                                                    ? GbsSystemStrings
                                                        .str_refuser.tr
                                                    : GbsSystemStrings
                                                        .str_en_attente.tr,
                                    maxLines: 2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: GBSystem_ScreenHelper
                                    .screenHeightPercentage(context, 0.0),
                                horizontal:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.04),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Obx(
                                    () => VacationTitle(
                                        textColor: Colors.black,
                                        color: Colors.white,
                                        title: m
                                            .vacationStateController
                                            .getAllVacationsEnAttente
                                            .value![index]
                                            .TITLE),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 200,
                                    width: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.8),
                                    child: Obx(() => VacationStateDisplayData(
                                          updateLoading: updateLoading,
                                          vacationStateModel: m
                                              .vacationStateController
                                              .getAllVacationsEnAttente
                                              .value![index],
                                        )),
                                  ),
                                  SizedBox(
                                    height: GBSystem_ScreenHelper
                                        .screenHeightPercentage(context, 0.01),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ))

            // : Container(),
            ),
      ],
    );
  }
}
