import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PLANNING_SCREEN/PRISE_DE_VACATION/VACATION_STATE_DEPASSER_SCREEN/list_vacation_state_depasser_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/vacation_title.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/VACATION_WIDGETS/VACATION_STATE_WIDGET/VACATION_STATE_DEMANDER_DISPLAY_DATA/vacation_state_demander_display_data.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class ListVacationStateDepasserScreen extends StatelessWidget {
  ListVacationStateDepasserScreen({
    super.key,
    required this.updateLoading,
    this.isCommingFromOut = false,
  });
  final Function updateLoading;
  final bool isCommingFromOut;

  @override
  Widget build(BuildContext context) {
    final m = Get.put<ListVacationStateDepasserScreenController>(
        ListVacationStateDepasserScreenController(context));
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 4.0,
        shadowColor: GbsSystemStrings.str_primary_color,
        toolbarHeight: 80,
        backgroundColor: GbsSystemStrings.str_primary_color,
        title: Text(
          GbsSystemStrings.str_historique.tr,
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
      body: FutureBuilder(
        future: GBSystem_AuthService(context).getListVacationsStateDemander(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data!.isNotEmpty) {
              m.vacationStateController.setAllVacationDemander = snapshot.data;
              m.vacationStateController.setCurrentVacationDemander =
                  snapshot.data?.first;

              return m.vacationStateController
                              .getAllVacationsStateDemanderDepasser.value !=
                          null &&
                      m
                          .vacationStateController
                          .getAllVacationsStateDemanderDepasser
                          .value!
                          .isNotEmpty
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
      ),
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
    final m = Get.put<ListVacationStateDepasserScreenController>(
        ListVacationStateDepasserScreenController(context));
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal:
                  GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
              vertical:
                  GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
          child: m.vacationStateController.getAllVacationsStateDemanderDepasser
                          .value !=
                      null &&
                  m.vacationStateController.getAllVacationsStateDemanderDepasser
                      .value!.isNotEmpty
              ? Obx(() => ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: m.vacationStateController
                                .getAllVacationsStateDemanderDepasser.value !=
                            null
                        ? m.vacationStateController
                            .getAllVacationsStateDemanderDepasser.value!.length
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
                                              .getAllVacationsStateDemanderDepasser
                                              .value![index]
                                              .PLAPSVR_STATE ==
                                          "RF"
                                      ? Colors.red.withOpacity(1)
                                      : m
                                                  .vacationStateController
                                                  .getAllVacationsStateDemanderDepasser
                                                  .value![index]
                                                  .PLAPSVR_STATE ==
                                              "AC"
                                          ? Colors.green.withOpacity(1)
                                          : m
                                                      .vacationStateController
                                                      .getAllVacationsStateDemanderDepasser
                                                      .value![index]
                                                      .PLAPSVR_STATE ==
                                                  "DE"
                                              ? Colors.blue.withOpacity(1)
                                              : m
                                                          .vacationStateController
                                                          .getAllVacationsStateDemanderDepasser
                                                          .value![index]
                                                          .PLAPSVR_STATE ==
                                                      "DP"
                                                  ? Colors.amber.withOpacity(1)
                                                  : Colors.blue.withOpacity(1),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GBSystem_TextHelper().normalText(
                                      textColor: Colors.white,
                                      text: m
                                                  .vacationStateController
                                                  .getAllVacationsStateDemanderDepasser
                                                  .value![index]
                                                  .PLAPSVR_STATE ==
                                              "DE"
                                          ? GbsSystemStrings.str_en_attente.tr
                                          : m
                                                      .vacationStateController
                                                      .getAllVacationsStateDemanderDepasser
                                                      .value![index]
                                                      .PLAPSVR_STATE ==
                                                  "AC"
                                              ? GbsSystemStrings.str_accepter.tr
                                              : m
                                                          .vacationStateController
                                                          .getAllVacationsStateDemanderDepasser
                                                          .value![index]
                                                          .PLAPSVR_STATE ==
                                                      "RF"
                                                  ? GbsSystemStrings
                                                      .str_refuser.tr
                                                  : m
                                                              .vacationStateController
                                                              .getAllVacationsStateDemanderDepasser
                                                              .value![index]
                                                              .PLAPSVR_STATE ==
                                                          "DP"
                                                      ? GbsSystemStrings
                                                          .str_depasser.tr
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
                                      .screenHeightPercentage(context, 0.01),
                                  horizontal: GBSystem_ScreenHelper
                                      .screenWidthPercentage(context, 0.04),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Obx(
                                      () => VacationTitle(
                                          color: Colors.transparent,
                                          textColor: Colors.black,
                                          title: m
                                              .vacationStateController
                                              .getAllVacationsStateDemanderDepasser
                                              .value![index]
                                              .JOB_LIB),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 150,
                                      width: GBSystem_ScreenHelper
                                          .screenWidthPercentage(context, 0.8),
                                      child: Obx(() =>
                                          VacationStateDemanderDisplayData(
                                            updateLoading: updateLoading,
                                            vacationStateModel: m
                                                .vacationStateController
                                                .getAllVacationsStateDemanderDepasser
                                                .value![index],
                                          )),
                                    ),
                                    SizedBox(
                                      height: GBSystem_ScreenHelper
                                          .screenHeightPercentage(
                                              context, 0.03),
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
              : Container(),
        ),
      ],
    );
  }
}
