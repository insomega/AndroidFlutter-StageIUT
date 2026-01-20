import 'package:intl/intl.dart';

class ImageTypeTwoModel {
  final String IMAGE_IDF;
  final String IMAGE_DEFAULT;
  final String IMAGE_TYPE;
  final String USER_IDF;
  final DateTime? LAST_UPDT;

  const ImageTypeTwoModel({
    required this.IMAGE_DEFAULT,
    required this.IMAGE_IDF,
    required this.IMAGE_TYPE,
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

  static ImageTypeTwoModel fromJson(json) {
    DateTime? LAST_UPDT;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy');
    if (json["LAST_UPDT"] != null && json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = originalFormat.parse(json["LAST_UPDT"]);
    }

    return ImageTypeTwoModel(
      LAST_UPDT: LAST_UPDT,
      IMAGE_DEFAULT: json["IMAGE_DEFAULT"],
      IMAGE_IDF: json["IMAGE_IDF"],
      IMAGE_TYPE: json["IMAGE_TYPE"],
      USER_IDF: json["USER_IDF"],
    );
  }

  static List<ImageTypeTwoModel> convertDynamictoListImages(
      List<dynamic> vacationsDynamic) {
    List<ImageTypeTwoModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(ImageTypeTwoModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
