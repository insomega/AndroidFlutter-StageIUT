import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_absences_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_absence_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class AbsenceWidget extends StatefulWidget {
  const AbsenceWidget(
      {super.key,
      required this.absenceModel,
      this.onTap,
      required this.updateLoading,
      required this.updateUI});
  final AbsenceModel absenceModel;
  final Function updateLoading, updateUI;
  final void Function()? onTap;

  @override
  State<AbsenceWidget> createState() => _AbsenceWidgetState();
}

class _AbsenceWidgetState extends State<AbsenceWidget> {
  PageController pageController = PageController();
  RxDouble currentIndex = 0.0.obs;

  @override
  void initState() {
    pageController.addListener(() {
      currentIndex.value = pageController.page ?? 0.0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                            context, 0.02),
                        horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                            context, 0.0)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      color: widget.absenceModel.PLATPH_ETAT == "AT"
                          ? Colors.blue.withOpacity(1)
                          : widget.absenceModel.PLATPH_ETAT == "AC"
                              ? Colors.green.withOpacity(1)
                              : widget.absenceModel.PLATPH_ETAT == "PR"
                                  ? Colors.orange.withOpacity(1)
                                  : widget.absenceModel.PLATPH_ETAT == "CL"
                                      ? Colors.black
                                      : Colors.red.withOpacity(1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GBSystem_TextHelper().normalText(
                          textColor: Colors.white,
                          text: widget.absenceModel.PLATPH_ETAT == "AT"
                              ? GbsSystemStrings.str_en_attente.tr
                              : widget.absenceModel.PLATPH_ETAT == "AC"
                                  ? GbsSystemStrings.str_accepter.tr
                                  : widget.absenceModel.PLATPH_ETAT == "PR"
                                      ? GbsSystemStrings.str_propositions.tr
                                      : widget.absenceModel.PLATPH_ETAT == "CL"
                                          ? GbsSystemStrings.str_cloturer.tr
                                          : GbsSystemStrings.str_refuser.tr,
                          maxLines: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: PageSalarie1(
                      absenceModel: widget.absenceModel,
                    ),
                  ),
                  Visibility(
                      visible: widget.absenceModel.PLATPH_ETAT == "PR",
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButtonWithTrailling(
                                onTap: () async {
                                  try {
                                    widget.updateLoading(true);
                                    await GBSystem_AuthService(context)
                                        .refuseAbsence(
                                            absenceModel: widget.absenceModel)
                                        .then((value) async {
                                      widget.updateLoading(false);

                                      final absenceController =
                                          Get.put<GBSystemAbsenceController>(
                                              GBSystemAbsenceController());

                                      setState(() {
                                        absenceController.setAllAbsence = value;
                                        if (value != null && value.isNotEmpty) {
                                          absenceController
                                                  .setCurrentAbsenceAbsence =
                                              value.first;
                                        }
                                      });

                                      // if (value != null) {
                                      //   await GBSystem_AuthService(context)
                                      //       .getListAbsences()
                                      //       .then((value) {
                                      //     widget.updateLoading(false);
                                      //     if (value != null &&
                                      //         value.isNotEmpty) {
                                      //       value.forEach((element) {
                                      //         print(
                                      //             "new : ${element.PLATPH_ETAT}");
                                      //       });
                                      //       final absenceController = Get.put<
                                      //               GBSystemAbsenceController>(
                                      //           GBSystemAbsenceController());

                                      //       setState(() {
                                      //         absenceController.setAllAbsence =
                                      //             value;

                                      //         absenceController
                                      //                 .setCurrentAbsenceAbsence =
                                      //             value.first;
                                      //       });
                                      //     }
                                      //   });
                                      // }
                                    });
                                  } catch (e) {
                                    widget.updateLoading(false);
                                    GBSystem_ManageCatchErrors().catchErrors(
                                        context,
                                        message: e.toString(),
                                        method: "refuseAbsence",
                                        page: "absence_widget");
                                  }
                                },
                                text: GbsSystemStrings.kRefuser.tr,
                                textSize: 10,
                                horPadding: 5,
                                verPadding: 5,
                                trailling: Icon(
                                  CupertinoIcons.multiply,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                color: Colors.red,
                              ),
                              CustomButtonWithTrailling(
                                onTap: () async {
                                  try {
                                    widget.updateLoading(true);
                                    await GBSystem_AuthService(context)
                                        .accepterAbsence(
                                            absenceModel: widget.absenceModel)
                                        .then((value) async {
                                      if (value != null) {
                                        await GBSystem_AuthService(context)
                                            .getListAbsences()
                                            .then((value) {
                                          widget.updateLoading(false);
                                          if (value != null) {
                                            final absenceController = Get.put<
                                                    GBSystemAbsenceController>(
                                                GBSystemAbsenceController());
                                            setState(() {
                                              absenceController.setAllAbsence =
                                                  value;

                                              absenceController
                                                      .setCurrentAbsenceAbsence =
                                                  value.first;
                                            });
                                          }
                                        });
                                      }
                                    });
                                  } catch (e) {
                                    widget.updateLoading(false);
                                    GBSystem_ManageCatchErrors().catchErrors(
                                        context,
                                        message: e.toString(),
                                        method: "accepterAbsence",
                                        page: "absence_widget");
                                  }
                                },
                                text: GbsSystemStrings.kAccepter.tr,
                                textSize: 10,
                                horPadding: 5,
                                verPadding: 5,
                                trailling: Icon(
                                  CupertinoIcons.check_mark,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
              Visibility(
                visible: false,
                child: Positioned(
                  bottom: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.0),
                  child: Obx(() {
                    return DotsIndicator(
                      decorator: const DotsDecorator(
                          activeColor: GbsSystemStrings.str_primary_color,
                          color: Colors.white,
                          activeSize: Size(10, 10),
                          size: Size(10, 10)),
                      dotsCount: 2,
                      position: currentIndex.round().toInt(),
                    );
                  }),
                ),
              ),
            ],
          )),
    );
  }
}

class PageSalarie1 extends StatelessWidget {
  PageSalarie1({
    super.key,
    required this.absenceModel,
  });
  final AbsenceModel absenceModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GBSystem_TextHelper().superSmallText(
                    text: "${GbsSystemStrings.str_date_demande.tr} : ",
                    fontWeight: FontWeight.w500,
                    textColor: GbsSystemStrings.str_primary_color),
                Flexible(
                  child: GBSystem_TextHelper().superSmallText(
                      text: absenceModel.PLATPH_DEMAND_DATE != null
                          ? AbsenceModel.convertDate(
                              absenceModel.PLATPH_DEMAND_DATE!)
                          : "",
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.left,
                      textColor: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GBSystem_TextHelper().superSmallText(
                    text: "${GbsSystemStrings.str_absence.tr} : ",
                    fontWeight: FontWeight.w500,
                    textColor: GbsSystemStrings.str_primary_color),
                Flexible(
                  child: GBSystem_TextHelper().superSmallText(
                      text: absenceModel.TPH_CODE ?? "",
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.left,
                      textColor: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width:
                      GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GBSystem_TextHelper().superSmallText(
                          text: "${GbsSystemStrings.str_date_debut.tr} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemStrings.str_primary_color),
                      Flexible(
                        child: GBSystem_TextHelper().superSmallText(
                            text: absenceModel.PLATPH_DEMAND_DATE != null
                                ? AbsenceModel.convertDate(
                                    absenceModel.PLATPH_START_HOUR!)
                                : "",
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.left,
                            textColor: Colors.black),
                      ),
                      Flexible(
                        child: GBSystem_TextHelper().superSmallText(
                            text: absenceModel.PLATPH_DEMAND_DATE != null
                                ? " ${AbsenceModel.convertTime(absenceModel.PLATPH_START_HOUR!)}"
                                : "",
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.left,
                            textColor: Colors.black),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   width: GBSystem_ScreenHelper.screenWidthPercentage(
                //       context, 0.35),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       GBSystem_TextHelper().superSmallText(
                //           text: "${GbsSystemStrings.str_hour_debut.tr} : ",
                //           fontWeight: FontWeight.w500,
                //           textColor: GbsSystemStrings.str_primary_color),
                //       Flexible(
                //         child: GBSystem_TextHelper().superSmallText(
                //             text: absenceModel.PLATPH_DEMAND_DATE != null
                //                 ? AbsenceModel.convertTime(
                //                     absenceModel.PLATPH_START_HOUR!)
                //                 : "",
                //             fontWeight: FontWeight.normal,
                //             textAlign: TextAlign.left,
                //             textColor: Colors.black),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width:
                      GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GBSystem_TextHelper().superSmallText(
                          text: "${GbsSystemStrings.str_date_fin.tr} : ",
                          fontWeight: FontWeight.w500,
                          textColor: GbsSystemStrings.str_primary_color),
                      Flexible(
                        child: GBSystem_TextHelper().superSmallText(
                            text: absenceModel.PLATPH_END_HOUR != null
                                ? AbsenceModel.convertDate(
                                    absenceModel.PLATPH_END_HOUR!)
                                : "",
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.left,
                            textColor: Colors.black),
                      ),
                      Flexible(
                        child: GBSystem_TextHelper().superSmallText(
                            text: absenceModel.PLATPH_END_HOUR != null
                                ? " ${AbsenceModel.convertTime(absenceModel.PLATPH_END_HOUR!)}"
                                : "",
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.left,
                            textColor: Colors.black),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   width: GBSystem_ScreenHelper.screenWidthPercentage(
                //       context, 0.35),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       GBSystem_TextHelper().superSmallText(
                //           text: "${GbsSystemStrings.str_hour_fin.tr} : ",
                //           fontWeight: FontWeight.w500,
                //           textColor: GbsSystemStrings.str_primary_color),
                //       Flexible(
                //         child: GBSystem_TextHelper().superSmallText(
                //             text: absenceModel.PLATPH_END_HOUR != null
                //                 ? AbsenceModel.convertTime(
                //                     absenceModel.PLATPH_END_HOUR!)
                //                 : "",
                //             fontWeight: FontWeight.normal,
                //             textAlign: TextAlign.left,
                //             textColor: Colors.black),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GBSystem_TextHelper().superSmallText(
                    text:
                        "${GbsSystemStrings.str_commentaire_planificateur.tr} : ",
                    fontWeight: FontWeight.w500,
                    textColor: GbsSystemStrings.str_primary_color),
                Flexible(
                  child: GBSystem_TextHelper().superSmallText(
                      text: absenceModel.PLATPH_MMO ?? "",
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.left,
                      textColor: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GBSystem_TextHelper().superSmallText(
                    text: "${GbsSystemStrings.str_commentaire_salarie.tr} : ",
                    fontWeight: FontWeight.w500,
                    textColor: GbsSystemStrings.str_primary_color),
                Flexible(
                  child: GBSystem_TextHelper().superSmallText(
                      text: absenceModel.PLATPH_MMO2 ?? "",
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.left,
                      textColor: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
