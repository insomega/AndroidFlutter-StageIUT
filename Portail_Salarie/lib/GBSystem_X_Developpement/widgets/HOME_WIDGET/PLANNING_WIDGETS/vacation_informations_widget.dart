import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_planning_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_planning_vacation_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_convert_date_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/vacation_display_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/vacation_informations_widget_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/vacation_title.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class VacationInformationsWidget extends StatefulWidget {
  VacationInformationsWidget({super.key});

  @override
  State<VacationInformationsWidget> createState() =>
      _VacationInformationsWidgetState();
}

class _VacationInformationsWidgetState
    extends State<VacationInformationsWidget> {
  final planningVacationController =
      Get.put<GBSystemPlanningVacationController>(
          GBSystemPlanningVacationController());
  final m = Get.put<VacationInformationsWidgetController>(
      VacationInformationsWidgetController());

  RxBool isLoading = RxBool(false);
  final vacationController = Get.put<GBSystemPlanningVacationController>(
      GBSystemPlanningVacationController());
  RxBool btnPrecVisibility = RxBool(true);
  // bool btnPrevVisibility = false;
  // bool btnSuivVisibility = false;

  @override
  void initState() {
    // if ((planningVacationController.getAllVacations?.length ?? 0) > 1) {
    //   btnSuivVisibility = true;
    // }

    // planningVacationController.setAllVacation = null;

    // pageController.addListener(() {
    //   currentIndex.value = pageController.page ?? 0.0;
    // });
    super.initState();
  }

  @override
  void dispose() {
    // pageController.dispose();
    super.dispose();
  }

  final String pageName = "vacation_informations_widget";
  @override
  Widget build(BuildContext context) {
    return planningVacationController.getAllVacations != null
        ? Column(
            children: [
              Obx(
                () => Visibility(
                  visible: planningVacationController.getPrecBool.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomButtonWithTrailling(
                        isMinSize: true,
                        textSize: 12,
                        horPadding: 10,
                        trailling: Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                          size: 15,
                        ),
                        verPadding: 10,
                        onTap: () async {
                          try {
                            isLoading.value = true;
                            await GBSystem_AuthService(context)
                                .getListVacationPrecedent()
                                .then((value) {
                              isLoading.value = false;
                              planningVacationController.setPrecBool = false;

                              if (value != null && value.isNotEmpty) {
                                setState(() {
                                  planningVacationController.setAllVacation =
                                      value;
                                  planningVacationController
                                      .setCurrentVacationVacation = value[0];
                                });
                              } else {
                                showWarningDialog(
                                    context, GbsSystemStrings.str_no_item.tr);
                              }
                            });
                          } catch (e) {
                            GBSystem_ManageCatchErrors().catchErrors(context,
                                message: e.toString(),
                                method: "getListVacationPrecedent",
                                page: pageName);
                          }
                        },
                        text: GbsSystemStrings.str_precedent.tr,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                width:
                    GBSystem_ScreenHelper.screenWidthPercentage(context, 0.9),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                          context, 0.01)),
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: m.pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        planningVacationController.getAllVacations?.length,
                    itemBuilder: (context, index) {
                      return MainWidget(
                          length: planningVacationController
                                  .getAllVacations?.length ??
                              0,
                          vacationInformationsWidgetController: m,
                          vacationModel: planningVacationController
                              .getAllVacations![index]);
                    },
                  ),
                ),
              ),
            ],
          )
        : FutureBuilder(
            future: GBSystem_AuthService(context).getListPlanningVacations(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  planningVacationController.setAllVacation = snapshot.data!;
                  planningVacationController.setCurrentVacationVacation =
                      snapshot.data![0];
                } else {
                  return Obx(() => Visibility(
                        visible: planningVacationController.getPrecBool.value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomButtonWithTrailling(
                              isMinSize: true,
                              textSize: 12,
                              horPadding: 10,
                              trailling: Icon(
                                CupertinoIcons.back,
                                color: Colors.white,
                                size: 15,
                              ),

                              verPadding: 10,
                              onTap: () async {
                                try {
                                  isLoading.value = true;
                                  await GBSystem_AuthService(context)
                                      .getListVacationPrecedent()
                                      .then((value) {
                                    isLoading.value = false;
                                    planningVacationController.setPrecBool =
                                        false;

                                    if (value != null && value.isNotEmpty) {
                                      setState(() {
                                        planningVacationController
                                            .setAllVacation = value;
                                        planningVacationController
                                                .setCurrentVacationVacation =
                                            value[0];
                                      });
                                    } else {
                                      showWarningDialog(context,
                                          GbsSystemStrings.str_no_item.tr);
                                    }
                                  });
                                } catch (e) {
                                  GBSystem_ManageCatchErrors().catchErrors(
                                      context,
                                      message: e.toString(),
                                      method: "getListVacationPrecedent 2",
                                      page: pageName);
                                }
                              },
                              // height: 50,
                              text: GbsSystemStrings.str_precedent.tr,
                            ),
                          ],
                        ),
                      ));
                  // return EmptyDataWidget();
                }

                return Column(
                  children: [
                    Obx(
                      () => Visibility(
                        visible: planningVacationController.getPrecBool.value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomButtonWithTrailling(
                              isMinSize: true,
                              textSize: 12,
                              horPadding: 10,
                              trailling: Icon(
                                CupertinoIcons.back,
                                color: Colors.white,
                                size: 15,
                              ),

                              verPadding: 10,
                              onTap: () async {
                                try {
                                  isLoading.value = true;
                                  await GBSystem_AuthService(context)
                                      .getListVacationPrecedent()
                                      .then((value) {
                                    isLoading.value = false;
                                    planningVacationController.setPrecBool =
                                        false;

                                    if (value != null && value.isNotEmpty) {
                                      setState(() {
                                        planningVacationController
                                            .setAllVacation = value;
                                        planningVacationController
                                                .setCurrentVacationVacation =
                                            value[0];
                                      });
                                    } else {
                                      showWarningDialog(context,
                                          GbsSystemStrings.str_no_item.tr);
                                    }
                                  });
                                } catch (e) {
                                  GBSystem_ManageCatchErrors().catchErrors(
                                      context,
                                      message: e.toString(),
                                      method: "getListVacationPrecedent 3 ",
                                      page: pageName);
                                }
                              },
                              // height: 50,
                              text: GbsSystemStrings.str_precedent.tr,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 200,
                      width: GBSystem_ScreenHelper.screenWidthPercentage(
                          context, 0.9),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                GBSystem_ScreenHelper.screenWidthPercentage(
                                    context, 0.01)),
                        child: PageView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: m.pageController,
                          itemCount: planningVacationController
                              .getAllVacations?.length,
                          itemBuilder: (context, index) {
                            return MainWidget(
                                length: planningVacationController
                                        .getAllVacations?.length ??
                                    0,
                                vacationInformationsWidgetController: m,
                                vacationModel: planningVacationController
                                    .getAllVacations![index]);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 250,
                  child: WaitingWidgets(),
                );
              } else {
                return Obx(() => Visibility(
                      visible: planningVacationController.getPrecBool.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomButtonWithTrailling(
                            isMinSize: true,
                            textSize: 12,
                            horPadding: 10,
                            trailling: Icon(
                              CupertinoIcons.back,
                              color: Colors.white,
                              size: 15,
                            ),

                            verPadding: 10,
                            onTap: () async {
                              try {
                                isLoading.value = true;
                                await GBSystem_AuthService(context)
                                    .getListVacationPrecedent()
                                    .then((value) {
                                  isLoading.value = false;
                                  planningVacationController.setPrecBool =
                                      false;

                                  if (value != null && value.isNotEmpty) {
                                    setState(() {
                                      planningVacationController
                                          .setAllVacation = value;
                                      planningVacationController
                                              .setCurrentVacationVacation =
                                          value[0];
                                    });
                                  } else {
                                    showWarningDialog(context,
                                        GbsSystemStrings.str_no_item.tr);
                                  }
                                });
                              } catch (e) {
                                GBSystem_ManageCatchErrors().catchErrors(
                                    context,
                                    message: e.toString(),
                                    method: "getListVacationPrecedent 4 ",
                                    page: pageName);
                              }
                            },
                            // height: 50,
                            text: GbsSystemStrings.str_precedent.tr,
                          ),
                        ],
                      ),
                    ));

                //  return EmptyDataWidget();
              }
            },
          );
  }
}

class MainWidget extends StatefulWidget {
  MainWidget({
    super.key,
    required this.vacationModel,
    required this.length,
    required this.vacationInformationsWidgetController,
  });

  final PlanningVacationModel vacationModel;
  final VacationInformationsWidgetController
      vacationInformationsWidgetController;
  final int length;

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final m = Get.put<VacationInformationsWidgetController>(
      VacationInformationsWidgetController());

  final String pageName = "vacation_informations_widget";

  bool btnPrevVisibility = false;
  bool btnSuivVisibility = false;
  @override
  void initState() {
    if (widget.length > 1) {
      btnSuivVisibility = true;
    }

    super.initState();
  }

  void updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black54),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Visibility(
            // visible: widget.length > 1,
            // visible: btnPrevVisibility,

            child: InkWell(
              onTap: () {
                try {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    int previousPageIndex = m.pageController.page!.round() - 1;
                    m.pageController.animateToPage(previousPageIndex,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceInOut);
                  });

                  setState(() {
                    btnSuivVisibility = true;
                  });
                  if (m.pageController.page!.round() <= 1) {
                    setState(() {
                      btnPrevVisibility = false;
                    });
                  }
                } catch (e) {
                  GBSystem_ManageCatchErrors().catchErrors(context,
                      message: e.toString(),
                      method: "previousPageIndex",
                      page: pageName);
                }
                // try {
                //   WidgetsBinding.instance.addPostFrameCallback((_) {
                //     int previousPageIndex = m.pageController.page!.round() - 1;
                //     m.pageController.animateToPage(previousPageIndex,
                //         duration: Duration(milliseconds: 300),
                //         curve: Curves.bounceInOut);
                //   });

                //   // setState(() {
                //   //   btnSuivVisibility = true;
                //   // });
                //   // if (widget.pageController.page!.round() <= 1) {
                //   //   setState(() {
                //   //     btnPrevVisibility = false;
                //   //   });
                //   // }
                // } catch (e) {
                //   GBSystem_ManageCatchErrors().catchErrors(context,
                //       message: e.toString(),
                //       method: "previousPageIndex",
                //       page: pageName);
                // }
              },
              child: Icon(
                CupertinoIcons.arrow_left_circle_fill,
                color: GbsSystemStrings.str_primary_color,
              ),
            ),
          ),
          Container(
            height: 220,
            width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.7),
            child: Column(
              children: [
                VacationTitle(
                    title: widget.vacationModel.VAC_START_HOUR != null
                        ? ConvertDateService().formatDateTimeVacation(
                            widget.vacationModel.VAC_START_HOUR!)
                        : ""

                    //   title:

                    //  widget.vacationModel.TITLE

                    ),
                const SizedBox(
                  height: 15,
                ),
                VacationDisplayDataWidgetPlanning(
                    vacationModel: widget.vacationModel),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GBSystem_TextHelper().smallText(
                            text: GbsSystemStrings.str_entrer.tr + " : ",
                            textColor: Colors.green),
                        SizedBox(
                          width: 60,
                          child: GBSystem_TextHelper().smallText(
                              text: widget.vacationModel.PNTG_START_HOUR != null
                                  ? "${PlanningVacationModel.Add_zero(widget.vacationModel.PNTG_START_HOUR?.hour)}:${PlanningVacationModel.Add_zero(widget.vacationModel.PNTG_START_HOUR?.minute)}"
                                  : "",
                              textColor: Colors.green),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GBSystem_TextHelper().smallText(
                            text: GbsSystemStrings.str_sortie.tr + " : ",
                            textColor: Colors.red),
                        SizedBox(
                          width: 60,
                          child: GBSystem_TextHelper().smallText(
                              text: widget.vacationModel.PNTG_END_HOUR != null
                                  ? "${PlanningVacationModel.Add_zero(widget.vacationModel.PNTG_END_HOUR?.hour)}:${PlanningVacationModel.Add_zero(widget.vacationModel.PNTG_END_HOUR?.minute)}"
                                  : "",
                              textColor: Colors.red),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Visibility(
            // visible: widget.length > 1,
            // visible: btnSuivVisibility,
            child: InkWell(
              onTap: () {
                try {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    int nextPageIndex = m.pageController.page!.round() + 1;
                    m.pageController.animateToPage(nextPageIndex,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceInOut);
                  });

                  // int nextPageIndex = m.pageController.page!.round() + 1;
                  // m.pageController.animateToPage(nextPageIndex,
                  //     duration: Duration(milliseconds: 300),
                  //     curve: Curves.bounceInOut);

                  // setState(() {
                  //   btnPrevVisibility = true;
                  // });
                } catch (e) {
                  GBSystem_ManageCatchErrors().catchErrors(context,
                      message: e.toString(),
                      method: "nextPageIndex",
                      page: pageName);
                }

                // try {
                //   Future.delayed(
                //     Duration(milliseconds: 100),
                //     () {
                //       // m.pageController.addListener(() {
                //       //   m.currentIndex.value = m.pageController.page ?? 0.0;
                //       // });
                //       // print(widget.pageController.hasClients);
                //       // print(widget.pageController.position != null);
                //       // print(widget.pageController.positions.isNotEmpty);

                //       // if (m.pageController.hasClients &&
                //       //     m.pageController.position != null &&
                //       //     m.pageController.positions.isNotEmpty) {
                //       WidgetsBinding.instance.addPostFrameCallback((_) {
                //         late int nextPageIndex =
                //             m.pageController.page?.round() ?? 0 + 1;
                //         m.pageController.jumpToPage(
                //           nextPageIndex,
                //           // duration: Duration(milliseconds: 300),
                //           // curve: Curves.bounceInOut
                //         );
                //       });
                //       // } else {
                //       //   WidgetsBinding.instance.addPostFrameCallback((_) {
                //       //     int nextPageIndex = 1;
                //       //     m.pageController.jumpToPage(
                //       //       nextPageIndex,
                //       //       // duration: Duration(milliseconds: 300),
                //       //       // curve: Curves.bounceInOut
                //       //     );
                //       //   });
                //       // }
                //     },
                //   );

                //   // setState(() {
                //   //   btnPrevVisibility = true;
                //   // });
                //   // // print(widget.pageController.page?.round());
                //   // // print(widget.length - 2.5);
                //   // // print(
                //   // //     widget.pageController.page!.round() >= widget.length - 2.5);
                //   // if (widget.pageController.page!.round() >= widget.length - 3) {
                //   //   setState(() {
                //   //     btnSuivVisibility = false;
                //   //   });
                //   // }
                // } catch (e) {
                //   GBSystem_ManageCatchErrors().catchErrors(context,
                //       message: e.toString(),
                //       method: "nextPageIndex",
                //       page: pageName);
                // }
              },
              child: Icon(
                CupertinoIcons.arrow_right_circle_fill,
                color: GbsSystemStrings.str_primary_color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
