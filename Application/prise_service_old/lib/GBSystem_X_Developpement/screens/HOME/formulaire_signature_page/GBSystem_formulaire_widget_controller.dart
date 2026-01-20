import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_evaluation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';

class GBSystemFormulaireWidgetController extends GetxController {
  GBSystemFormulaireWidgetController(this.context,
      {required this.questionModel});
  //// parametres
  final QuestionModel questionModel;
  final BuildContext context;
////

  RxInt? nombreImages = RxInt(0);
  Rx<DateTime>? selectedDate;
  List<String?>? listMemo = [];
  Rx<String?>? selectedMemo = Rx<String?>(null);

//// controller
  final evaluationController =
      Get.put<EvaluationController>(EvaluationController());

  ///
  @override
  void onInit() {
    listMemo =
        questionModel.LIEINSQMMO?.map((e) => e.LIEINSMMO_LIB).toList() ?? [];

    super.onInit();
  }

  List<String?>? filtreExistMemo() {
    for (var i = 0; i < (listMemo?.length ?? 0); i++) {
      if (listMemo!.contains(listMemo![i])) {
        listMemo!.remove(listMemo![i]);
      }
    }
    return listMemo;
  }

  void updateNombreImages(int newValue) {
    nombreImages?.value = newValue;
    update();
  }

  Future sendEvaluationNote(double note) async {
    try {
      await GBSystem_AuthService(context)
          .sendReponseQustionsNote(
              questionModel: questionModel, note: note.toInt())
          .then((eval) {
        if (eval != null) {
          evaluationController.setCuurentEvaluation = eval;
          showSuccesDialog(context, GbsSystemStrings.str_operation_effectuee);
        } else {
          showErrorDialog(context, GbsSystemStrings.str_error_send_data);
        }
      });
    } catch (e) {
      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "sendEvaluationNote",
        page: "GBSystem_formulaire_widget_controller",
      );
    }
  }

  // Future sendEvaluationLikeOrDislike(bool isLiked) async {
  //   likeBool?.value = isLiked;
  //   await GBSystem_AuthService(context)
  //       .sendReponseQustionsNote(
  //           questionModel: questionModel, note: isLiked ? 1 : 0)
  //       .then((eval) {
  //     // likeBool.value = false;
  //     if (eval != null) {
  //       evaluationController.setCuurentEvaluation = eval;
  //       showSuccesDialog(context, GbsSystemStrings.str_note_updated);
  //     } else {
  //       showErrorDialog(context, GbsSystemStrings.str_error_send_data);
  //     }
  //   });
  // }

  Future sendEvaluationImmediateBool(bool immediateBool) async {
    try {
      await GBSystem_AuthService(context)
          .sendReponseQustionsImmediateBool(
              questionModel: questionModel, immdiateBool: immediateBool)
          .then((eval) {
        if (eval != null) {
          evaluationController.setCuurentEvaluation = eval;
          showSuccesDialog(context, GbsSystemStrings.str_operation_effectuee);
        } else {
          showErrorDialog(context, GbsSystemStrings.str_error_send_data);
        }
      });
    } catch (e) {
      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "sendEvaluationImmediateBool",
        page: "GBSystem_formulaire_widget_controller",
      );
    }
  }

  Future sendEvaluationDiffererBool(bool differerBool) async {
    try {
      await GBSystem_AuthService(context)
          .sendReponseQustionsDiffererBool(
              questionModel: questionModel, defererBool: differerBool)
          .then((eval) {
        if (eval != null) {
          evaluationController.setCuurentEvaluation = eval;
          showSuccesDialog(context, GbsSystemStrings.str_operation_effectuee);
        } else {
          showErrorDialog(context, GbsSystemStrings.str_error_send_data);
        }
      });
    } catch (e) {
      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "sendEvaluationDiffererBool",
        page: "GBSystem_formulaire_widget_controller",
      );
    }
  }

  Future sendEvaluationMemo(String selectedMemo) async {
    // await GBSystem_AuthService(context)
    //     .sendReponseMemo(
    //         questionModel: questionModel, defererBool: differerBool)
    //     .then((eval) {
    //   if (eval != null) {
    //     evaluationController.setCuurentEvaluation = eval;
    //     showSuccesDialog(context, GbsSystemStrings.str_differer_bool_updated);
    //   } else {
    //     showErrorDialog(context, GbsSystemStrings.str_error_send_data);
    //   }
    // });
  }
  Future sendEvaluationDate(DateTime selectedDate) async {
    try {
      await GBSystem_AuthService(context)
          .sendReponseQustionsDate(
              questionModel: questionModel, date: selectedDate)
          .then((eval) {
        if (eval != null) {
          evaluationController.setCuurentEvaluation = eval;
          showSuccesDialog(context, GbsSystemStrings.str_operation_effectuee);
        } else {
          showErrorDialog(context, GbsSystemStrings.str_error_send_data);
        }
      });
    } catch (e) {
      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "sendEvaluationDate",
        page: "GBSystem_formulaire_widget_controller",
      );
    }
  }

  Future sendEvaluationComment(String comment) async {
    try {
      await GBSystem_AuthService(context)
          .sendReponseQustionsCommentaire(
              questionModel: questionModel, commentaire: comment)
          .then((eval) {
        if (eval != null) {
          evaluationController.setCuurentEvaluation = eval;
          showSuccesDialog(context, GbsSystemStrings.str_operation_effectuee);
        } else {
          showErrorDialog(context, GbsSystemStrings.str_error_send_data);
        }
      });
    } catch (e) {
      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "sendEvaluationComment",
        page: "GBSystem_formulaire_widget_controller",
      );
    }
  }

  Future sendEvaluationNonApplicableBool(bool nonApplicable) async {
    try {
      await GBSystem_AuthService(context)
          .sendReponseQustionsNonApplicableBool(
              questionModel: questionModel, nonApplicableBool: nonApplicable)
          .then((eval) {
        if (eval != null) {
          evaluationController.setCuurentEvaluation = eval;
          showSuccesDialog(context, GbsSystemStrings.str_operation_effectuee);
        }
      });
    } catch (e) {
      GBSystem_ManageCatchErrors().catchErrors(
        context,
        message: e.toString(),
        method: "sendEvaluationNonApplicableBool",
        page: "GBSystem_formulaire_widget_controller",
      );
    }
  }
}
