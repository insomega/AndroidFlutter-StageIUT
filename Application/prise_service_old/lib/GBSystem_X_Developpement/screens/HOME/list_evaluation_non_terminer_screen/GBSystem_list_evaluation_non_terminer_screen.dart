import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_toast.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/list_evaluation_non_terminer_screen/GBSystem_list_evaluation_non_terminer_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/url_launcher_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/GBSystem_evaluation_non_terminer_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/display_phone_number_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/slide_to_act_widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class GbsystemListEvaluationNonTerminerScreen extends StatelessWidget {
  GbsystemListEvaluationNonTerminerScreen({super.key});

  RxBool callBool = RxBool(false);

  String? phoneNumber;
  @override
  Widget build(BuildContext context) {
    final GbsystemListEvaluationNonTerminerController m =
        Get.put(GbsystemListEvaluationNonTerminerController(context: context));

    return Obx(() => Stack(
          children: [
            AbsorbPointer(
              absorbing: callBool.value,
              child: ImageFiltered(
                imageFilter: callBool.value == true
                    ? ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0)
                    : ImageFilter.blur(sigmaX: 00.0, sigmaY: 0.0),
                child: Scaffold(
                    appBar: AppBar(
                      elevation: 4.0,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      toolbarHeight: 80,
                      backgroundColor: GbsSystemServerStrings.str_primary_color,
                      title: const Text(
                        GbsSystemStrings.str_selectioner_salarie,
                        style: TextStyle(color: Colors.white),
                        maxLines: 1,
                      ),
                      leading: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            CupertinoIcons.arrow_left,
                            color: Colors.white,
                          )),
                    ),
                    body: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: SearchBar(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: const BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            hintText: GbsSystemStrings.str_rechercher,
                            controller: m.controllerSearch,
                            leading: const Icon(CupertinoIcons.search),
                            trailing: [
                              GestureDetector(
                                  onTap: () {
                                    m.controllerSearch.text = "";
                                    m.text?.value = "";
                                  },
                                  child: const Icon(Icons.close))
                            ],
                            onChanged: (String query) {
                              m.text?.value = query;
                            },
                          ),
                        ),
                        Expanded(
                          child: m.usedListSalaries().isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.02),
                                  ),
                                  child: ListView.builder(
                                    itemCount: m.usedListSalaries().length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: EvaluationNonTerminerWidget(
                                            onTap: () async {
                                              m
                                                          .usedListSalaries()[
                                                              index]
                                                          .LIEINSPQSNR_NOTATION_TYPE ==
                                                      GbsSystemStrings
                                                          .str_selected_type_questionnaire_qcm
                                                  ? m.getQCMData(
                                                      eval:
                                                          m.usedListSalaries()[
                                                              index])
                                                  : m.getFormulaireData(
                                                      eval:
                                                          m.usedListSalaries()[
                                                              index]);
                                            },
                                            evaluationNonTerminer:
                                                m.usedListSalaries()[index],
                                            imageSalarie: null),
                                      );
                                    },
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: EmptyDataWidget(
                                    heightLottie: GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.8),
                                  ),
                                ),
                        )
                      ],
                    )),
              ),
            ),
            callBool.value == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SlideToActWidgetCall(
                        onSubmit: () async {
                          callBool.value = false;
                          if (phoneNumber != null && phoneNumber!.isNotEmpty) {
                            UrlLauncherService()
                                .callNumber(context, number: phoneNumber ?? "");
                          } else {
                            showToast(
                                text:
                                    GbsSystemStrings.str_numero_telephone_vide);
                          }
                        },
                      ),
                    ],
                  )
                : Container(),
            callBool.value == true
                ? Positioned(
                    top: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Transform.translate(
                          offset: Offset(
                              -GBSystem_ScreenHelper.screenWidthPercentage(
                                  context, 0.1),
                              0),
                          child: DisplayPhoneNumberWidget(
                            phoneNumber: phoneNumber ?? "",
                          ),
                        ),
                        CupertinoButton(
                          onPressed: () {
                            callBool.value = false;
                          },
                          child: Icon(
                            CupertinoIcons.xmark,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            m.isLoading.value ? Waiting() : Container(),
          ],
        ));
  }
}
