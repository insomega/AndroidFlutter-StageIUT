import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/checked_with_type_reponse_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/qcm_reponse_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_list_qcm_with_his_reponses_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/formulaire_signature_page/GBSystem_qcm_widget_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/qcm_question_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/waiting_widget_quick_access.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

class QCMWidget extends StatefulWidget {
  const QCMWidget(
      {super.key, required this.questionModel, this.isViewMode = false});

  final QCMWithHisReponsesModel questionModel;
  final bool isViewMode;
  @override
  State<QCMWidget> createState() => _QCMWidgetState();
}

class _QCMWidgetState extends State<QCMWidget> {
  RxBool isLoading = RxBool(false);
  bool showQuestions = true;

  double turns = 0.0;
  final QCMWidgetController m = Get.put(QCMWidgetController());
  final EvaluationController evaluationController =
      Get.put(EvaluationController());

  @override
  void initState() {
    // init focuse qcm
    // widget.questionModel.questionsFocus = widget.questionModel.qcmQuestion
    //             .questionWithoutMemoModel.LIEINSPSVRQU_STATUT ==
    //         "0"
    //     ? false
    //     : true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.linear,
              padding: EdgeInsets.symmetric(
                  vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.01)),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 10,
                        spreadRadius: 3,
                        offset: const Offset(2, 2))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CupertinoCheckbox(
                        value: widget.questionModel.questionsFocus,
                        onChanged: (value) async {
                          if (value == false) {
                            try {
                              isLoading.value = true;
                              await GBSystem_AuthService(context)
                                  .checkQCMQuickAccess(
                                      questionModel:
                                          widget.questionModel.qcmQuestion,
                                      checkBool: value ?? false)
                                  .then((evaluation) {
                                isLoading.value = false;
                                if (evaluation != null) {
                                  setState(() {
                                    widget.questionModel.questionsFocus
                                        ? widget.questionModel.questionsFocus =
                                            false
                                        : widget.questionModel.questionsFocus =
                                            true;
                                  });
                                  evaluationController.setCuurentEvaluation =
                                      evaluation;
                                  // init state moy in view mode
                                  if (widget.isViewMode) {
                                    evaluationController
                                        .setCuurentEvaluationView = evaluation;
                                  }
                                  //
                                  showSuccesDialog(context,
                                      GbsSystemStrings.str_operation_effectuer);
                                } else {
                                  setState(() {
                                    widget.questionModel.questionsFocus
                                        ? widget.questionModel.questionsFocus =
                                            false
                                        : widget.questionModel.questionsFocus =
                                            true;
                                  });
                                  // showErrorDialog(context,
                                  //     GbsSystemStrings.str_error_send_data);
                                }
                              });
                            } catch (e) {
                              isLoading.value = false;

                              GBSystem_ManageCatchErrors().catchErrors(
                                context,
                                message: e.toString(),
                                method: "checkQCMQuickAccess",
                                page: "qcm_widget",
                              );
                            }
                          } else {
                            showWarningDialog(
                              context,
                              GbsSystemStrings.str_action_non_autoriser,
                            );
                            // setState(() {
                            //   widget.questionModel.questionsFocus
                            //       ? widget.questionModel.questionsFocus = false
                            //       : widget.questionModel.questionsFocus = true;
                            // });
                          }
                        },
                      ),
                      Flexible(
                        child: GBSystem_TextHelper().smallText(
                            text: widget.questionModel.qcmQuestion
                                .questionWithoutMemoModel.LIEINSPQU_LIB,
                            maxLines: 10),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            showQuestions
                                ? showQuestions = false
                                : showQuestions = true;
                            turns += 1;
                          });
                        },
                        child: SizedBox(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(
                              context, 0.35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GBSystem_TextHelper().superSmallText(
                                  text: GbsSystemStrings.str_choix_multiple,
                                  maxLines: 1,
                                  fontWeight: FontWeight.w500),
                              const SizedBox(
                                width: 5,
                              ),
                              AnimatedRotation(
                                duration: const Duration(seconds: 1),
                                turns: turns,
                                child: Container(
                                    height: 17,
                                    width: 17,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: showQuestions == false
                                        ? const Icon(
                                            Icons.arrow_downward,
                                            size: 14,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.arrow_upward,
                                            size: 14,
                                            color: Colors.white,
                                          )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AbsorbPointer(
                    absorbing: widget.questionModel.questionsFocus,
                    child: AnimatedOpacity(
                      duration: const Duration(seconds: 1, milliseconds: 300),
                      opacity: showQuestions ? 1.0 : 0.0,
                      child: AnimatedSize(
                          duration: const Duration(seconds: 1),
                          child: SizedBox(
                            height: showQuestions ? null : 0.0,
                            child: Column(
                              children: [
                                Divider(
                                  color: Colors.grey.shade400,
                                  thickness: 0.8,
                                ),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    ImageFiltered(
                                      imageFilter:
                                          widget.questionModel.questionsFocus
                                              ? ImageFilter.blur(
                                                  sigmaX: 3, sigmaY: 3)
                                              : ImageFilter.blur(
                                                  sigmaX: 0, sigmaY: 0),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: widget
                                            .questionModel.reponses.length,
                                        itemBuilder: (context, index) {
                                          return Obx(() => QCMQuestionWidget(
                                              onTap: () async {
                                                try {
                                                  isLoading.value = true;
                                                  await GBSystem_AuthService(
                                                          context)
                                                      .getQCM_LIEINSPQU_MAX(
                                                          questionModel: widget
                                                              .questionModel
                                                              .qcmQuestion)
                                                      .then(
                                                          (LIEINSPQU_MAX) async {
                                                    print(
                                                        "max ! :: ${LIEINSPQU_MAX}");
                                                    if (LIEINSPQU_MAX != null) {
                                                      await GBSystem_AuthService(
                                                              context)
                                                          .sendReponseQCMQuickAccess(
                                                              questionModel: widget
                                                                  .questionModel
                                                                  .qcmQuestion,
                                                              reponseQCMModel: widget
                                                                  .questionModel
                                                                  .reponses[index])
                                                          .then((value) {
                                                        isLoading.value = false;
                                                        print(
                                                            "reponse evaluation :${value?.EVAL_MOYENNE} , ${value?.EVAL_STAT}");
                                                        if (value != null) {
                                                          evaluationController
                                                                  .setCuurentEvaluation =
                                                              value;
                                                          // init state moy in view mode
                                                          if (widget
                                                              .isViewMode) {
                                                            evaluationController
                                                                    .setCuurentEvaluationView =
                                                                value;
                                                          }
                                                          //
                                                          m.updateSelectedReponse(
                                                            questionWithSelectedReponse: QCMReponseModel(
                                                                questionModel:
                                                                    widget
                                                                        .questionModel,
                                                                selectedReponse:
                                                                    widget.questionModel
                                                                            .reponses[
                                                                        index]),
                                                          );
                                                          setState(() {});
                                                          showSuccesDialog(
                                                              context,
                                                              GbsSystemStrings
                                                                  .str_operation_effectuer);
                                                        } else {
                                                          showErrorDialog(
                                                              context,
                                                              GbsSystemStrings
                                                                  .str_error_send_data);
                                                        }
                                                      });
                                                    }
                                                  });
                                                } catch (e) {
                                                  isLoading.value = false;

                                                  GBSystem_ManageCatchErrors()
                                                      .catchErrors(
                                                    context,
                                                    message: e.toString(),
                                                    method:
                                                        "getQCM_LIEINSPQU_MAX",
                                                    page: "qcm_widget",
                                                  );
                                                }
                                              },
                                              reponseQCMModel: widget
                                                  .questionModel
                                                  .reponses[index],
                                              index: index + 1,
                                              showChecked: CheckedWithTypeReponseModel(
                                                  isChecked: chackExistElementInList(
                                                      listElement:
                                                          m.selectedReponseList,
                                                      myElement: QCMReponseModel(
                                                          questionModel: widget
                                                              .questionModel,
                                                          selectedReponse: widget
                                                                  .questionModel
                                                                  .reponses[
                                                              index])),
                                                  isTrueAnswer: true)));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            isLoading.value
                ? const GBSystemWaitingWidgetQuickAccess()
                : Container()
          ],
        ));
  }

  bool chackExistElementInList(
      {required Rx<List<QCMReponseModel>> listElement,
      required QCMReponseModel myElement}) {
    bool check = false;
    for (var i = 0; i < listElement.value.length; i++) {
      if (listElement.value[i].questionModel == myElement.questionModel &&
          listElement.value[i].selectedReponse == myElement.selectedReponse) {
        check = true;
      }
    }
    return check;
  }
}
