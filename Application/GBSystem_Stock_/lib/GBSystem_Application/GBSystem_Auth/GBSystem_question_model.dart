import 'GBSystem_image_with_model.dart';
import 'GBSystem_memo_question_model.dart';
import 'GBSystem_question_without_memo_model.dart';

class QuestionModel {
  int? nombreImages;
  bool nonApplicableBool, differerBool, immediateBool, likeBool;
  DateTime? selectedDate;
  double? ratings;
  MemoQuestionModel? selectedMemo;
  String? commentaire;
  List<ImageWithModel>? listImages = [];
  final List<MemoQuestionModel>? LIEINSQMMO;
  final QuestionWithoutMemoModel questionWithoutMemoModel;

  QuestionModel({this.listImages, this.nombreImages, this.nonApplicableBool = false, this.differerBool = false, this.immediateBool = false, this.likeBool = false, this.selectedDate, this.selectedMemo, this.commentaire, required this.LIEINSQMMO, required this.questionWithoutMemoModel});

  void addImage({required ImageWithModel image}) {
    listImages?.add(image);
  }

  static String Add_zero(int? value) {
    if (value! < 10) {
      return "0$value";
    } else {
      return "$value";
    }
  }

  static String convertTime(DateTime dateTime) {
    return "${Add_zero(dateTime.hour)}:${Add_zero(dateTime.minute)}";
  }

  // static QuestionModel fromJson(json) {
  //   return QuestionModel(
  //       LIEINSPSVRQU_UIDF: json["LIEINSPSVRQU_UIDF"],
  //       LIEINSPCAT_CLR: json["LIEINSPCAT_CLR"],
  //       LIEINSPCAT_CODE: json["LIEINSPCAT_CODE"],
  //       LIEINSPCAT_COEF: json["LIEINSPCAT_COEF"],
  //       LIEINSPCAT_IDF: json["LIEINSPCAT_IDF"],
  //       LIEINSPCAT_LIB: json["LIEINSPCAT_LIB"],
  //       LIEINSPEVAL_COLOR: json["LIEINSPEVAL_COLOR"],
  //       LIEINSPQU_CODE: json["LIEINSPQU_CODE"],
  //       LIEINSPQU_HELP: json["LIEINSPQU_HELP"],
  //       LIEINSPQU_IDF: json["LIEINSPQU_IDF"],
  //       LIEINSPQU_LIB: json["LIEINSPQU_LIB"],
  //       LIEINSPQU_MAX: json["LIEINSPQU_MAX"],
  //       LIEINSPQU_NOTATION_TYPE: json["LIEINSPQU_NOTATION_TYPE"],
  //       LIEINSPQU_ORDER_NUM: json["LIEINSPQU_ORDER_NUM"],
  //       LIEINSPSVRQU_ACTION_LONG: json["LIEINSPSVRQU_ACTION_LONG"],
  //       LIEINSPSVRQU_ACTION_SHORT: json["LIEINSPSVRQU_ACTION_SHORT"],
  //       LIEINSPSVRQU_ALONG_DATE: LIEINSPSVRQU_ALONG_DATE,
  //       LIEINSPSVRQU_CLOSED_DATE: LIEINSPSVRQU_CLOSED_DATE,
  //       LIEINSPSVR_START_DATE: LIEINSPSVR_START_DATE,
  //       LIEINSPSVR_END_DATE: LIEINSPSVR_END_DATE,
  //       LIEINSPSVRQU_IDF: json["LIEINSPSVRQU_IDF"],
  //       LIEINSPSVRQU_MEMO: json["LIEINSPSVRQU_MEMO"],
  //       LIEINSPSVRQU_NOTE: json["LIEINSPSVRQU_NOTE"],
  //       LIEINSPSVRQU_STATUT: json["LIEINSPSVRQU_STATUT"],
  //       LIEINSPSVR_IDF: json["LIEINSPSVR_IDF"],
  //       LIEINSQMMO_IDF_ALONG: json["LIEINSQMMO_IDF_ALONG"],
  //       LIEINSQMMO_IDF_ASHORT: json["LIEINSQMMO_IDF_ASHORT"],
  //       LIE_CODE: json["LIE_CODE"],
  //       LIE_IDF: json["LIE_IDF"],
  //       LIE_LIB: json["LIE_LIB"],
  //       NBR_PHOTO: json["NBR_PHOTO"],
  //       SVR_CODE: json["SVR_CODE"],
  //       SVR_IDF: json["SVR_IDF"],
  //       SVR_LIB: json["SVR_LIB"],
  //       LIEINSQMMO: json["LIEINSQMMO"] != null
  //           ? MemoModel.convertDynamictoListMemo(json["LIEINSQMMO"])
  //           : null);
  // }

  // static List<QuestionModel> convertDynamictoListQuestions(
  //     List<dynamic> vacationsDynamic) {
  //   List<QuestionModel> listVacations = [];
  //   for (var i = 0; i < vacationsDynamic.length; i++) {
  //     listVacations.add(QuestionModel.fromJson(vacationsDynamic[i]));
  //   }
  //   return listVacations;
  // }
}
