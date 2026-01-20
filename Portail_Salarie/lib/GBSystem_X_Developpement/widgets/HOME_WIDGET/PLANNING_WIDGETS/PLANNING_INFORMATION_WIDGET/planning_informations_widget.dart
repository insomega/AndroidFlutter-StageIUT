import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_planning_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_planning_dispo_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_publication_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PDF_PAGE/GBSystem_pdf_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PLANNING_SCREEN/PLANNING_SCREEN/GBSystem_planning_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/pdf_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_drop_down_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/PLANNING_INFORMATION_WIDGET/planning_informations_widget_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/planning_display_data_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

// ignore: must_be_immutable
class PlanningInformationsWidget extends StatelessWidget {
  PlanningInformationsWidget({super.key, required this.updateLoading});
  Function updateLoading;

  final planningController =
      Get.put<GBSystemPlanningController>(GBSystemPlanningController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GBSystem_AuthService(context).getListPlanning(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null &&
              snapshot.data!.planningDisponibleModel.isNotEmpty) {
            planningController.setCurrentPlanningPlanning = snapshot.data!;
            return MainWidget(
              length: planningController
                  .getCurrentPlanning!.planningDisponibleModel.length,
              planningController: planningController,
              updateLoading: updateLoading,
            );
          } else {
            return EmptyDataWidget();
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 250,
            child: WaitingWidgets(),
          );
        } else {
          return EmptyDataWidget();
        }
      },
    );
  }
}

// ignore: must_be_immutable
class MainWidget extends StatefulWidget {
  MainWidget(
      {super.key,
      required this.planningController,
      required this.updateLoading,
      required this.length});

  Function updateLoading;
  final GBSystemPlanningController planningController;
  final int length;

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final m = Get.put<PlanningInformationsWidgetController>(
      PlanningInformationsWidgetController());
  final planningScreenController = Get.put<GBSystemPlanningScreenController>(
      GBSystemPlanningScreenController());

  final String pageName = "planning_informations_widget";
  bool btnPrevVisibility = false;
  bool btnSuivVisibility = false;

  @override
  void initState() {
    if (widget.planningController.getCurrentPlanning!.planningDisponibleModel
            .length >
        1) {
      btnPrevVisibility = true;
    }

    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        m.pageController.jumpToPage(widget.planningController
                .getCurrentPlanning!.planningDisponibleModel.length -
            1);
      });
    } catch (e) {
      GBSystem_ManageCatchErrors().catchErrors(context,
          message: e.toString(),
          method: "lastPageIndexJump (init state)",
          page: pageName);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Visibility(
            // visible: widget.length > 1,
            visible: btnPrevVisibility,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                try {
                  int previousPageIndex = m.pageController.page!.round() - 1;
                  m.pageController.animateToPage(previousPageIndex,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear);

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
              },
              child: Icon(
                CupertinoIcons.arrow_left_circle_fill,
                color: GbsSystemStrings.str_primary_color,
              ),
            ),
          ),
          Container(
            height: 220,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 220,
                  width: GBSystem_ScreenHelper.screenWidthPercentage(
                      context, 0.75),
                  child: PageView.builder(
                    controller: m.pageController,
                    itemCount: widget.planningController.getCurrentPlanning!
                        .planningDisponibleModel.length,
                    itemBuilder: (context, index) {
                      Map<int, PlanningDisponibleModel> indexAndModelMap = {};
                      for (int i = 0;
                          i <
                              widget.planningController.getCurrentPlanning!
                                  .planningDisponibleModel.length;
                          i++) {
                        indexAndModelMap[i] = widget.planningController
                            .getCurrentPlanning!.planningDisponibleModel[i];
                      }

                      return PlanningDisplayDataWidget(
                        showDownloadBtn: true,
                        // btnTelechargerText: GbsSystemStrings.str_afficher.tr +
                        //     " / " +
                        //     GbsSystemStrings.str_partager.tr,
                        onZoomTap: () async {
                          try {
                            await showDialogMoisSelection(
                                context: context,
                                mapIndexAndDropDownItems: indexAndModelMap,
                                selectedItem: widget
                                    .planningController
                                    .getCurrentPlanning!
                                    .planningDisponibleModel[index]);
                          } catch (e) {
                            GBSystem_ManageCatchErrors().catchErrors(context,
                                message: e.toString(),
                                method: "onZoomTap",
                                page: pageName);
                          }
                        },
                        onTelechargerTap: () async {
                          try {
                            widget.updateLoading(true);
                            await GBSystem_AuthService(context)
                                .getPlanningPDF(
                                    planningDisponibleModel: widget
                                        .planningController
                                        .getCurrentPlanning!
                                        .planningDisponibleModel[index])
                                .then((value) async {
                              widget.updateLoading(false);
                              print("tessst value $value");
                              print(
                                  "tessst ${widget.planningController.getCurrentPlanning!.planningDisponibleModel[index].SVRPPH_START_DATE}");

                              print(
                                  "tessst ${widget.planningController.getCurrentPlanning!.planningDisponibleModel[index].SVRPPH_START_DATE != null}");

                              print(
                                  "tessst ${PublicationModel.convertDate(widget.planningController.getCurrentPlanning!.planningDisponibleModel[index].SVRPPH_START_DATE!, separateur: "_")}");

                              if (value != null) {
                                String namePdf = widget
                                            .planningController
                                            .getCurrentPlanning!
                                            .planningDisponibleModel[index]
                                            .SVRPPH_START_DATE !=
                                        null
                                    ? "${PublicationModel.convertDate(widget.planningController.getCurrentPlanning!.planningDisponibleModel[index].SVRPPH_START_DATE!, separateur: "_")}"
                                    : "planningPDF";
                                print("tessst $namePdf");
                                Uint8List bytes = PDFService()
                                    .cleanPDFStringAndConvertToUnit8List(
                                        stringPDF: value);
                                await PDFService().downloadAndSavePDF(
                                    namePdf, bytes, context,
                                    autoShare: false);
                                Get.to(
                                  GBSystemPDFScreen(
                                    pageName:
                                        "${GbsSystemStrings.str_planning.tr}",
                                    fileName: namePdf,
                                    pdfBytes: bytes,
                                  ),
                                );
                              }
                            });
                            planningScreenController.selectedIndex.value = 1;
                          } catch (e) {
                            GBSystem_ManageCatchErrors().catchErrors(context,
                                message: e.toString(),
                                method: "onTelechargerTap",
                                page: pageName);
                          }
                        },
                        onAfficherTap: () async {
                          try {
                            widget.updateLoading(true);

                            await GBSystem_AuthService(context)
                                .getListPlanningVacationsDependPlanningDispo(
                                    planningDisponibleModel: widget
                                        .planningController
                                        .getCurrentPlanning!
                                        .planningDisponibleModel[index])
                                .then((vacations) {
                              m.vacationController.setAllVacation = vacations;
                              m.vacationController.setPrecBool = false;
                            });

                            await GBSystem_AuthService(context)
                                .getListEventsDependPlanningDispo(
                                    planningDisponibleModel: widget
                                        .planningController
                                        .getCurrentPlanning!
                                        .planningDisponibleModel[index])
                                .then((events) {
                              m.eventController.setAllEvent =
                                  events?.listEventModel;
                              m.eventController.setAllEventAbsence =
                                  events?.listEventAbsenceModel;

                              widget.updateLoading(false);
                            });

                            planningScreenController.pageController
                                .animateToPage(2,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.linear)
                                .then(
                              (value) {
                                planningScreenController.selectedIndex.value =
                                    2;
                              },
                            );
                          } catch (e) {
                            widget.updateLoading(false);

                            GBSystem_ManageCatchErrors().catchErrors(context,
                                message: e.toString(),
                                method: "onAfficherTap",
                                page: pageName);
                          }
                        },
                        planningDownloadModel: widget.planningController
                            .getCurrentPlanning!.planningDownloadModel,
                        planningDisponibleModel: widget.planningController
                            .getCurrentPlanning!.planningDisponibleModel[index],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Visibility(
            // visible: widget.length > 1,
            visible: btnSuivVisibility,

            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                try {
                  int nextPageIndex = m.pageController.page!.round() + 1;
                  m.pageController.animateToPage(nextPageIndex,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear);

                  setState(() {
                    btnPrevVisibility = true;
                  });
                  if (m.pageController.page!.round() >=
                      widget.planningController.getCurrentPlanning!
                              .planningDisponibleModel.length -
                          2) {
                    setState(() {
                      btnSuivVisibility = false;
                    });
                  }
                } catch (e) {
                  GBSystem_ManageCatchErrors().catchErrors(context,
                      message: e.toString(),
                      method: "nextPageIndex",
                      page: pageName);
                }
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

  Future<void> showDialogMoisSelection(
      {required BuildContext context,
      required Map<int, PlanningDisponibleModel> mapIndexAndDropDownItems,
      required PlanningDisponibleModel selectedItem}) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                backgroundColor: Colors.white,
                content: StatefulBuilder(
                  builder: (context, setState) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GBSystem_TextHelper().normalText(
                              text: GbsSystemStrings.str_planning_du_mois.tr,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              textColor: Colors.black54,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            height: 20,
                          ),
                          CustomDropDownButtonPlanningDisponible(
                              onChanged: (selectedModel) {
                                try {
                                  int selectedIndex =
                                      mapIndexAndDropDownItems.entries
                                          .firstWhere(
                                            (entry) =>
                                                entry.value == selectedModel,
                                          )
                                          .key;
                                  Get.back();
                                  m.pageController.animateToPage(selectedIndex,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.linear);
                                } catch (e) {
                                  GBSystem_ManageCatchErrors().catchErrors(
                                      context,
                                      message: e.toString(),
                                      method: "dialog(select planning dispo)",
                                      page: "planning_informations_widget");
                                }
                                // Find the index of the selected model
                              },
                              selectedItem: selectedItem,
                              listItems:
                                  mapIndexAndDropDownItems.values.map((model) {
                                return model;
                              }).toList(),
                              hint: GbsSystemStrings.str_mois_de_selection.tr)
                        ],
                      ),
                    );
                  },
                ),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: GbsSystemStrings.str_primary_color,
                        textStyle: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        GbsSystemStrings.str_quitter.tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}
