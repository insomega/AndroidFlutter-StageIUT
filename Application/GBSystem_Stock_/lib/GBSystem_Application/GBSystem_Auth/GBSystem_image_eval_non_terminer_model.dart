import 'package:intl/intl.dart';

class ImageEvaluationNonTerminerModel {
  final String IMAGE_IDF;
  final String USER_IDF;
  final DateTime? LAST_UPDT;

  const ImageEvaluationNonTerminerModel({
    required this.IMAGE_IDF,
    required this.LAST_UPDT,
    required this.USER_IDF,
  });

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

  static ImageEvaluationNonTerminerModel fromJson(json) {
    DateTime? LAST_UPDT;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy');
    if (json["LAST_UPDT"] != null && json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = originalFormat.parse(json["LAST_UPDT"]);
    }

    return ImageEvaluationNonTerminerModel(
      LAST_UPDT: LAST_UPDT,
      IMAGE_IDF: json["IMAGE_IDF"],
      USER_IDF: json["USER_IDF"],
    );
  }

  static List<ImageEvaluationNonTerminerModel> convertDynamictoListImages(
      List<dynamic> vacationsDynamic) {
    List<ImageEvaluationNonTerminerModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations
          .add(ImageEvaluationNonTerminerModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
