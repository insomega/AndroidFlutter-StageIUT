import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_en_cours_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_memo_questions_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_drop_down_button.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/custom_date_picker.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/ratings_bar_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/slide_to_act_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/text_field_reviews.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/add_image_screen/GBSystem_add_image_screen.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class FormulaireType extends StatefulWidget {
  FormulaireType({
    super.key,
    this.showDate = true,
    required this.questionModel,
    required this.coeff,
    this.onPrecTap,
    this.onSuivTap,
    this.width,
    this.isLikedBool = true,
    this.showSuivantButton = false,
    this.showPrecedentButton = false,
    this.isViewMode = false,
  });
  final bool isViewMode;

  final bool? isLikedBool;
  final QuestionModel questionModel;
  final int coeff;
  final bool showDate;
  double? width;
  final void Function()? onPrecTap, onSuivTap;
  final bool showSuivantButton, showPrecedentButton;

  @override
  State<FormulaireType> createState() => _FormulaireTypeState();
}

class _FormulaireTypeState extends State<FormulaireType> {
  // RxBool nonApplicableBool = RxBool(false),
  // RxBool differerBool = RxBool(false),
  //     immediateBool = RxBool(false),
  //     likeBool = RxBool(false);

  void updateUI() {
    setState(() {});
  }

  @override
  void initState() {
    if (widget.isViewMode) {
      print(
          "non applicable : ${widget.questionModel.questionWithoutMemoModel.LIEINSPSVRQU_STATUT}");
// init non applicable
      if (widget.questionModel.questionWithoutMemoModel.LIEINSPSVRQU_STATUT ==
          '1') {
        widget.questionModel.nonApplicableBool = false;
      } else {
        widget.questionModel.nonApplicableBool = true;
      }
      print(
          "type affichage note : ${widget.questionModel.questionWithoutMemoModel.LIEINSPQU_NOTATION_TYPE}");

      print(
          "note : ${widget.questionModel.questionWithoutMemoModel.LIEINSPSVRQU_NOTE}");
// init note
      if (widget
              .questionModel.questionWithoutMemoModel.LIEINSPQU_NOTATION_TYPE !=
          "YN") {
        print(
            "init ratinnnnnng ${widget.questionModel.questionWithoutMemoModel.LIEINSPSVRQU_NOTE}");
        widget.questionModel.ratings = double.parse(
            widget.questionModel.questionWithoutMemoModel.LIEINSPSVRQU_NOTE);
      } else {
        if (widget.questionModel.questionWithoutMemoModel.LIEINSPSVRQU_NOTE ==
            '0') {
          widget.questionModel.likeBool = false;
        } else {
          widget.questionModel.likeBool = true;
        }
      }

      print(
          "deferer : ${widget.questionModel.questionWithoutMemoModel.LIEINSPSVRQU_ACTION_LONG}");
// init deferer
      if (widget.questionModel.questionWithoutMemoModel
              .LIEINSPSVRQU_ACTION_LONG ==
          '0') {
        widget.questionModel.differerBool = false;
      } else {
        widget.questionModel.differerBool = true;
      }
      print(
          "immediate : ${widget.questionModel.questionWithoutMemoModel.LIEINSPSVRQU_ACTION_SHORT}");
      // init immediate
      if (widget.questionModel.questionWithoutMemoModel
              .LIEINSPSVRQU_ACTION_SHORT ==
          '0') {
        widget.questionModel.immediateBool = false;
      } else {
        widget.questionModel.immediateBool = true;
      }
      print(
          "memo : ${widget.questionModel.questionWithoutMemoModel.LIEINSPSVRQU_MEMO}");
      //init memo
      if (widget.questionModel.questionWithoutMemoModel.LIEINSPSVRQU_MEMO !=
          null) {
        widget.questionModel.commentaire =
            widget.questionModel.questionWithoutMemoModel.LIEINSPSVRQU_MEMO;
        //
        // controllerCommentaires.text =
        //     widget.questionModel.questionWithoutMemoModel.LIEINSPSVRQU_MEMO!;
      }
      print(
          "date : ${widget.questionModel.questionWithoutMemoModel.LIEINSPSVRQU_ALONG_DATE}");
// init date
      if (widget
              .questionModel.questionWithoutMemoModel.LIEINSPSVRQU_ALONG_DATE !=
          null) {
        widget.questionModel.selectedDate = widget
            .questionModel.questionWithoutMemoModel.LIEINSPSVRQU_ALONG_DATE;
      }

// init images
      // // if (widget.questionModel.questionWithoutMemoModel.NBR_PHOTO != null) {
      // widget.questionModel.nombreImages =
      //     int.parse(widget.questionModel.questionWithoutMemoModel.NBR_PHOTO);
      // print(
      //     "nbbbbbr ${widget.questionModel.questionWithoutMemoModel.NBR_PHOTO}");
      // // }

      widget.questionModel.nombreImages =
          int.parse(widget.questionModel.questionWithoutMemoModel.NBR_PHOTO);
    }

// in all cases !! init comment
    if (widget.questionModel.commentaire != null) {
      controllerCommentaires.text = widget.questionModel.commentaire!;
    }

    super.initState();
  }

  final TextEditingController controllerCommentaires = TextEditingController();

  final evaluationController =
      Get.put<EvaluationController>(EvaluationController());

  // DateTime? selectedDate;

  // List<String?>? listMemo = [];
  // Rx<MemoQuestionModel?>? selectedMemo = Rx<MemoQuestionModel?>(null);

  final GBSystemMemoQuestionController memoQuestionController =
      Get.put(GBSystemMemoQuestionController());
  final GbsystemEvaluationEnCoursController evaluationEnCoursController =
      Get.put(GbsystemEvaluationEnCoursController());

  double? precValueToSendNote;
  @override
  Widget build(BuildContext context) {
    print(
        "nonnnnnnnnn ${widget.questionModel.questionWithoutMemoModel.LIEINSPSVRQU_STATUT}");
    print(
        "rejerjkjkerjkerjkjker ${widget.questionModel.questionWithoutMemoModel.LIEINSPQU_NOTATION_TYPE}");
    print("isView Mode : ${widget.isViewMode}");
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        AbsorbPointer(
          absorbing: widget.questionModel.nonApplicableBool == false,
          child: ImageFiltered(
            imageFilter: widget.questionModel.nonApplicableBool == false
                ? ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0)
                : ImageFilter.blur(sigmaX: 00.0, sigmaY: 0.0),
            child: Container(
              width:
                  // GBSystem_ScreenHelper.screenWidthPercentage(context, 0.95),
                  widget.width ??
                      GBSystem_ScreenHelper.screenWidthPercentage(context, 0.9),
              clipBehavior: Clip.hardEdge,
              padding: EdgeInsets.symmetric(
                  vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                      context, 0.01),
                  horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                      context, 0.02)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                        context, 0.01)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(
                              context, 0.9),
                          child: GBSystem_TextHelper().smallText(
                            text: widget.questionModel.questionWithoutMemoModel
                                .LIEINSPQU_LIB,
                            textAlign: TextAlign.left,
                            textColor: Colors.black,
                            maxLines: 5,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade400,
                                        blurRadius: 10,
                                        spreadRadius: 3,
                                        offset: const Offset(2, 2))
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40)),
                              child: widget
                                          .questionModel
                                          .questionWithoutMemoModel
                                          .LIEINSPQU_NOTATION_TYPE ==
                                      "YN"
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            // m.sendEvaluationLikeOrDislike(
                                            //     false);
                                            try {
                                              setState(() {
                                                widget.questionModel.likeBool =
                                                    false;
                                                widget
                                                    .questionModel
                                                    .questionWithoutMemoModel
                                                    .LIEINSPSVRQU_NOTE = "0";
                                              });
                                              await GBSystem_AuthService(
                                                      context)
                                                  .sendReponseQustionsNote(
                                                      questionModel:
                                                          widget.questionModel,
                                                      note: widget.questionModel
                                                              .likeBool
                                                          ? 1
                                                          : 0)
                                                  .then((eval) {
                                                if (eval != null) {
                                                  evaluationController
                                                          .setCuurentEvaluation =
                                                      eval;

                                                  // init state moy in view mode
                                                  if (widget.isViewMode) {
                                                    evaluationController
                                                            .setCuurentEvaluationView =
                                                        eval;
                                                  }
                                                  //
                                                  print(
                                                      "evallll EVAL_STAT :${eval.EVAL_STAT} , if changed :${evaluationEnCoursController.getSelectedEval.value!.EVAL_STAT}");
                                                  print(
                                                      "evallll EVAL_MOYENNE :${eval.EVAL_MOYENNE} , if changed :${evaluationEnCoursController.getSelectedEval.value!.EVAL_MOYENNE}");

                                                  showSuccesDialog(
                                                      context,
                                                      GbsSystemStrings
                                                          .str_operation_effectuee);
                                                } else {
                                                  showErrorDialog(
                                                      context,
                                                      GbsSystemStrings
                                                          .str_error_send_data);
                                                }
                                              });
                                            } catch (e) {
                                              GBSystem_ManageCatchErrors()
                                                  .catchErrors(
                                                context,
                                                message: e.toString(),
                                                method:
                                                    "sendReponseQustionsNote3",
                                                page:
                                                    "GBSystem_formulaire_widget",
                                              );
                                            }
                                          },
                                          child: widget
                                                      .questionModel.likeBool ==
                                                  true
                                              ? ColorFiltered(
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.grey.shade500,
                                                      BlendMode.modulate),
                                                  child: Lottie.asset(
                                                      GbsSystemServerStrings
                                                          .str_sad_face_path,
                                                      width: 50,
                                                      height: 50,
                                                      animate: false),
                                                )
                                              : Lottie.asset(
                                                  GbsSystemServerStrings
                                                      .str_sad_face_path,
                                                  width: 50,
                                                  height: 50,
                                                ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            // m.sendEvaluationLikeOrDislike(
                                            //     true);
                                            try {
                                              setState(() {
                                                widget.questionModel.likeBool =
                                                    true;
                                                widget
                                                    .questionModel
                                                    .questionWithoutMemoModel
                                                    .LIEINSPSVRQU_NOTE = "1";
                                              });
                                              await GBSystem_AuthService(
                                                      context)
                                                  .sendReponseQustionsNote(
                                                      questionModel:
                                                          widget.questionModel,
                                                      note: widget.questionModel
                                                              .likeBool
                                                          ? 1
                                                          : 0)
                                                  .then((eval) {
                                                if (eval != null) {
                                                  evaluationController
                                                          .setCuurentEvaluation =
                                                      eval;
                                                  // init state moy in view mode
                                                  if (widget.isViewMode) {
                                                    evaluationController
                                                            .setCuurentEvaluationView =
                                                        eval;
                                                  }
                                                  //
                                                  showSuccesDialog(
                                                      context,
                                                      GbsSystemStrings
                                                          .str_operation_effectuee);
                                                } else {
                                                  showErrorDialog(
                                                      context,
                                                      GbsSystemStrings
                                                          .str_error_send_data);
                                                }
                                              });
                                            } catch (e) {
                                              GBSystem_ManageCatchErrors()
                                                  .catchErrors(
                                                context,
                                                message: e.toString(),
                                                method:
                                                    "sendReponseQustionsNote2",
                                                page:
                                                    "GBSystem_formulaire_widget",
                                              );
                                            }
                                          },
                                          child: widget
                                                      .questionModel.likeBool ==
                                                  false
                                              ? ColorFiltered(
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.grey.shade500,
                                                      BlendMode.modulate),
                                                  child: Lottie.asset(
                                                      GbsSystemServerStrings
                                                          .str_happy_face_path,
                                                      width: 50,
                                                      height: 50,
                                                      animate: false),
                                                )
                                              : Lottie.asset(
                                                  GbsSystemServerStrings
                                                      .str_happy_face_path,
                                                  width: 50,
                                                  height: 50,
                                                ),
                                        ),
                                      ],
                                    )
                                  : widget
                                              .questionModel
                                              .questionWithoutMemoModel
                                              .LIEINSPQU_NOTATION_TYPE ==
                                          "SL"
                                      ? RatingsBarFacesWidget(
                                          initialRating:
                                              widget.questionModel.ratings,
                                          count: int.parse(widget
                                              .questionModel
                                              .questionWithoutMemoModel
                                              .LIEINSPQU_MAX),
                                          onRatingUpdate: (value) async {
                                            if (precValueToSendNote != value) {
                                              try {
                                                await GBSystem_AuthService(
                                                        context)
                                                    .sendReponseQustionsNote(
                                                        questionModel: widget
                                                            .questionModel,
                                                        note: value.toInt())
                                                    .then((eval) {
                                                  if (eval != null) {
                                                    evaluationController
                                                            .setCuurentEvaluation =
                                                        eval;
                                                    // init state moy in view mode
                                                    if (widget.isViewMode) {
                                                      evaluationController
                                                              .setCuurentEvaluationView =
                                                          eval;
                                                    }
                                                    //
                                                    widget.questionModel
                                                        .ratings = value;
                                                    widget
                                                            .questionModel
                                                            .questionWithoutMemoModel
                                                            .LIEINSPSVRQU_NOTE =
                                                        value
                                                            .toInt()
                                                            .toString();

                                                    showSuccesDialog(
                                                        context,
                                                        GbsSystemStrings
                                                            .str_operation_effectuee);
                                                  } else {
                                                    showErrorDialog(
                                                        context,
                                                        GbsSystemStrings
                                                            .str_error_send_data);
                                                  }
                                                });
                                              } catch (e) {
                                                GBSystem_ManageCatchErrors()
                                                    .catchErrors(
                                                  context,
                                                  message: e.toString(),
                                                  method:
                                                      "sendReponseQustionsNote1",
                                                  page:
                                                      "GBSystem_formulaire_widget",
                                                );
                                              }

                                              precValueToSendNote = value;
                                              setState(() {});
                                            }
                                          },
                                        )
                                      : RatingsBarWidget(
                                          initialRating:
                                              widget.questionModel.ratings,
                                          count: int.parse(widget
                                              .questionModel
                                              .questionWithoutMemoModel
                                              .LIEINSPQU_MAX),
                                          onRatingUpdate: (value) async {
                                            if (precValueToSendNote != value) {
                                              try {
                                                await GBSystem_AuthService(
                                                        context)
                                                    .sendReponseQustionsNote(
                                                        questionModel: widget
                                                            .questionModel,
                                                        note: value.toInt())
                                                    .then((eval) {
                                                  if (eval != null) {
                                                    evaluationController
                                                            .setCuurentEvaluation =
                                                        eval;
                                                    // init state moy in view mode
                                                    if (widget.isViewMode) {
                                                      evaluationController
                                                              .setCuurentEvaluationView =
                                                          eval;
                                                    }
                                                    //
                                                    widget.questionModel
                                                        .ratings = value;
                                                    widget
                                                            .questionModel
                                                            .questionWithoutMemoModel
                                                            .LIEINSPSVRQU_NOTE =
                                                        value
                                                            .toInt()
                                                            .toString();

                                                    showSuccesDialog(
                                                        context,
                                                        GbsSystemStrings
                                                            .str_operation_effectuee);
                                                  } else {
                                                    showErrorDialog(
                                                        context,
                                                        GbsSystemStrings
                                                            .str_error_send_data);
                                                  }
                                                });
                                              } catch (e) {
                                                GBSystem_ManageCatchErrors()
                                                    .catchErrors(
                                                  context,
                                                  message: e.toString(),
                                                  method:
                                                      "sendReponseQustionsNote1",
                                                  page:
                                                      "GBSystem_formulaire_widget",
                                                );
                                              }

                                              precValueToSendNote = value;
                                              setState(() {});
                                            }
                                          },
                                        )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                GBSystem_ScreenHelper.screenHeightPercentage(
                                    context, 0.01)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${GbsSystemStrings.str_action_corrective} : ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CupertinoSwitch(
                                value: widget.questionModel.immediateBool,
                                onChanged: (bool value) async {
                                  try {
                                    setState(() {
                                      widget.questionModel.immediateBool =
                                          value;
                                      widget
                                              .questionModel
                                              .questionWithoutMemoModel
                                              .LIEINSPSVRQU_ACTION_SHORT =
                                          value ? "1" : "0";
                                    });
                                    // make diffirer false

                                    if (widget.questionModel.differerBool) {
                                      setState(() {
                                        widget.questionModel.differerBool =
                                            false;
                                        widget
                                            .questionModel
                                            .questionWithoutMemoModel
                                            .LIEINSPSVRQU_ACTION_LONG = "0";
                                      });
                                      await GBSystem_AuthService(context)
                                          .sendReponseQustionsDiffererBool(
                                              questionModel:
                                                  widget.questionModel,
                                              defererBool: false)
                                          .then((eval) {
                                        if (eval != null) {
                                          evaluationController
                                              .setCuurentEvaluation = eval;
                                          // init state moy in view mode
                                          if (widget.isViewMode) {
                                            evaluationController
                                                    .setCuurentEvaluationView =
                                                eval;
                                          }
                                          //
                                        }
                                      });
                                    }

                                    // widget.questionModel.differerBool = false;
                                    await GBSystem_AuthService(context)
                                        .sendReponseQustionsImmediateBool(
                                            questionModel: widget.questionModel,
                                            immdiateBool: widget
                                                .questionModel.immediateBool)
                                        .then((eval) {
                                      if (eval != null) {
                                        evaluationController
                                            .setCuurentEvaluation = eval;
                                        // init state moy in view mode
                                        if (widget.isViewMode) {
                                          evaluationController
                                              .setCuurentEvaluationView = eval;
                                        }
                                        //
                                        showSuccesDialog(
                                            context,
                                            GbsSystemStrings
                                                .str_operation_effectuee);
                                      } else {
                                        // showErrorDialog(
                                        //     context,
                                        //     GbsSystemStrings
                                        //         .str_error_send_data);
                                      }
                                    });
                                  } catch (e) {
                                    GBSystem_ManageCatchErrors().catchErrors(
                                      context,
                                      message: e.toString(),
                                      method:
                                          "sendReponseQustionsImmediateBool",
                                      page: "GBSystem_formulaire_widget",
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.2),
                                child: const Text(
                                  GbsSystemStrings.str_immediate,
                                  overflow: TextOverflow.visible,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CupertinoSwitch(
                                value: widget.questionModel.differerBool,
                                onChanged: (bool value) async {
                                  try {
                                    setState(() {
                                      widget.questionModel.differerBool = value;
                                      widget
                                              .questionModel
                                              .questionWithoutMemoModel
                                              .LIEINSPSVRQU_ACTION_LONG =
                                          value ? "1" : "0";
                                    });
                                    // widget.questionModel.immediateBool = false;
                                    if (widget.questionModel.immediateBool) {
                                      setState(() {
                                        widget.questionModel.immediateBool =
                                            false;
                                        widget
                                            .questionModel
                                            .questionWithoutMemoModel
                                            .LIEINSPSVRQU_ACTION_SHORT = "0";
                                      });
                                      await GBSystem_AuthService(context)
                                          .sendReponseQustionsImmediateBool(
                                              questionModel:
                                                  widget.questionModel,
                                              immdiateBool: false)
                                          .then((eval) {
                                        if (eval != null) {
                                          evaluationController
                                              .setCuurentEvaluation = eval;
                                          // init state moy in view mode
                                          if (widget.isViewMode) {
                                            evaluationController
                                                    .setCuurentEvaluationView =
                                                eval;
                                          }
                                          //
                                        }
                                      });
                                    }

                                    await GBSystem_AuthService(context)
                                        .sendReponseQustionsDiffererBool(
                                            questionModel: widget.questionModel,
                                            defererBool: widget
                                                .questionModel.differerBool)
                                        .then((eval) {
                                      if (eval != null) {
                                        evaluationController
                                            .setCuurentEvaluation = eval;
                                        // init state moy in view mode
                                        if (widget.isViewMode) {
                                          evaluationController
                                              .setCuurentEvaluationView = eval;
                                        }
                                        //
                                        showSuccesDialog(
                                            context,
                                            GbsSystemStrings
                                                .str_operation_effectuee);
                                      } else {
                                        // showErrorDialog(
                                        //     context,
                                        //     GbsSystemStrings
                                        //         .str_error_send_data);
                                      }
                                    });
                                  } catch (e) {
                                    GBSystem_ManageCatchErrors().catchErrors(
                                      context,
                                      message: e.toString(),
                                      method: "sendReponseQustionsDiffererBool",
                                      page: "GBSystem_formulaire_widget",
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width:
                                    GBSystem_ScreenHelper.screenWidthPercentage(
                                        context, 0.2),
                                child: const Text(
                                  GbsSystemStrings.str_differer,
                                  overflow: TextOverflow.visible,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                GBSystem_ScreenHelper.screenHeightPercentage(
                                    context, 0.02)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomDropDownButtonMemo(
                                width: widget.questionModel.differerBool == true
                                    ? GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.4)
                                    : GBSystem_ScreenHelper
                                        .screenWidthPercentage(context, 0.8),
                                onChanged: (p0) async {
                                  setState(() {
                                    widget.questionModel.selectedMemo = p0!;

                                    widget
                                            .questionModel
                                            .questionWithoutMemoModel
                                            .LIEINSPSVRQU_MEMO =
                                        widget.questionModel.selectedMemo!
                                            .LIEINSMMO_MEMO;

                                    controllerCommentaires.text = widget
                                        .questionModel
                                        .selectedMemo!
                                        .LIEINSMMO_MEMO;
                                    widget.questionModel.commentaire = widget
                                        .questionModel
                                        .selectedMemo!
                                        .LIEINSMMO_MEMO;
                                  });

                                  if (p0 != null) {
                                    await GBSystem_AuthService(context)
                                        .sendReponseQustionsCommentaire(
                                            questionModel: widget.questionModel,
                                            commentaire: widget.questionModel
                                                .selectedMemo!.LIEINSMMO_MEMO)
                                        .then((eval) {
                                      if (eval != null) {
                                        evaluationController
                                            .setCuurentEvaluation = eval;
                                        // init state moy in view mode
                                        if (widget.isViewMode) {
                                          evaluationController
                                              .setCuurentEvaluationView = eval;
                                        }
                                        //
                                        showSuccesDialog(
                                            context,
                                            GbsSystemStrings
                                                .str_operation_effectuee);
                                      } else {
                                        showErrorDialog(
                                            context,
                                            GbsSystemStrings
                                                .str_error_send_data);
                                      }
                                    });
                                  }
                                },
                                selectedItem: widget.questionModel.selectedMemo,
                                listItems: memoQuestionController
                                    .getAllMemoFiltredWith_LIEINSPQU_IDF(widget
                                        .questionModel
                                        .questionWithoutMemoModel
                                        .LIEINSPQU_IDF)
                                    ?.toSet()
                                    .toList()
                                //  memoQuestionController
                                //         .getAllMemoFiltred() ??
                                //     widget.questionModel.LIEINSQMMO
                                ,
                                hint: GbsSystemStrings.str_memo),
                            Visibility(
                              visible: widget.questionModel.differerBool,
                              // widget.showDate,
                              child: SizedBox(
                                width: 150,
                                child: CustomDatePickerFrench(
                                  selectedDate:
                                      widget.questionModel.selectedDate,
                                  labelText:
                                      GbsSystemStrings.str_selectDatelabel,
                                  initialDate:
                                      widget.questionModel.selectedDate,
                                  onDateSelected: (value) async {
                                    try {
                                      setState(() {
                                        widget.questionModel.selectedDate =
                                            value;
                                        widget
                                            .questionModel
                                            .questionWithoutMemoModel
                                            .LIEINSPSVRQU_ALONG_DATE = value;
                                      });
                                      // m.sendEvaluationDate(value);
                                      await GBSystem_AuthService(context)
                                          .sendReponseQustionsDate(
                                              questionModel:
                                                  widget.questionModel,
                                              date: widget
                                                  .questionModel.selectedDate!)
                                          .then((eval) {
                                        if (eval != null) {
                                          evaluationController
                                              .setCuurentEvaluation = eval;
                                          // init state moy in view mode
                                          if (widget.isViewMode) {
                                            evaluationController
                                                    .setCuurentEvaluationView =
                                                eval;
                                          }
                                          //
                                          showSuccesDialog(
                                              context,
                                              GbsSystemStrings
                                                  .str_operation_effectuee);
                                        } else {
                                          showErrorDialog(
                                              context,
                                              GbsSystemStrings
                                                  .str_error_send_data);
                                        }
                                      });
                                    } catch (e) {
                                      GBSystem_ManageCatchErrors().catchErrors(
                                        context,
                                        message: e.toString(),
                                        method: "sendReponseQustionsDate",
                                        page: "GBSystem_formulaire_widget",
                                      );
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldReviews(
                          keyboardType: TextInputType.text,
                          onSaved: (p0) async {
                            if (p0 != null) {
                              widget.questionModel.commentaire = p0;

                              // m.sendEvaluationComment(p0);
                              await GBSystem_AuthService(context)
                                  .sendReponseQustionsCommentaire(
                                      questionModel: widget.questionModel,
                                      commentaire: p0)
                                  .then((eval) {
                                if (eval != null) {
                                  evaluationController.setCuurentEvaluation =
                                      eval;
                                  // init state moy in view mode
                                  if (widget.isViewMode) {
                                    evaluationController
                                        .setCuurentEvaluationView = eval;
                                  }
                                  //
                                  setState(() {
                                    widget
                                        .questionModel
                                        .questionWithoutMemoModel
                                        .LIEINSPSVRQU_MEMO = p0;
                                  });
                                  showSuccesDialog(context,
                                      GbsSystemStrings.str_operation_effectuee);
                                } else {
                                  showErrorDialog(context,
                                      GbsSystemStrings.str_error_send_data);
                                }
                              });
                            }
                          },
                          controller: controllerCommentaires,
                          hint: "${GbsSystemStrings.str_comment} ... "),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                GBSystem_ScreenHelper.screenHeightPercentage(
                                    context, 0.02)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              onTap: () {
                                Get.to(AddImageScreen(
                                  updateUI: updateUI,
                                  questionModel: widget.questionModel,
                                  isNonTerminatedEval: true,
                                ));
                              },
                              color: Colors.grey.shade300,
                              textColor: Colors.black,
                              verPadding: 10,
                              horPadding: 25,
                              text: GbsSystemStrings.str_photo,
                              numberImage: widget.questionModel.nombreImages,
                              showNumber: true,
                            ),
                            Visibility(
                              visible: widget.showSuivantButton,
                              child: CustomButton(
                                  onTap: widget.onSuivTap,
                                  color:
                                      GbsSystemServerStrings.str_primary_color,
                                  textColor: Colors.white,
                                  verPadding: 10,
                                  horPadding: 25,
                                  text: GbsSystemStrings.str_suivant),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: widget.showPrecedentButton,
                        child: CustomButton(
                            onTap: widget.onPrecTap,
                            color: GbsSystemServerStrings.str_primary_color,
                            textColor: Colors.white,
                            verPadding: 10,
                            horPadding: 15,
                            text: GbsSystemStrings.str_precedent),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        widget.questionModel.nonApplicableBool == false
            ? SlideToActWidget(
                onSubmit: () async {
                  setState(() {
                    widget.questionModel.nonApplicableBool = true;
                    widget.questionModel.questionWithoutMemoModel
                        .LIEINSPSVRQU_STATUT = "0";
                  });
                  // m.sendEvaluationNonApplicableBool(true);
                  await GBSystem_AuthService(context)
                      .sendReponseQustionsNonApplicableBool(
                          questionModel: widget.questionModel,
                          nonApplicableBool:
                              widget.questionModel.nonApplicableBool)
                      .then((eval) {
                    if (eval != null) {
                      evaluationController.setCuurentEvaluation = eval;
                      // init state moy in view mode
                      if (widget.isViewMode) {
                        evaluationController.setCuurentEvaluationView = eval;
                      }
                      //
                      showSuccesDialog(
                          context, GbsSystemStrings.str_operation_effectuee);
                    }
                  });
                },
              )
            : Container(),
      ],
    );
  }
}
