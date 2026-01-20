import 'package:intl/intl.dart';

class ImageModel {
  final String Image_UIDF;
  final String Image_IDF;
  final String? LIEINSPSVRQU_IDF;
  final String? Image_DESCRIPTION;
  final DateTime? LAST_UPDT;
  final String USER_IDF;
  final String? Image_DEFAULT;
  final String? USR_LIB;

  const ImageModel({
    required this.Image_DEFAULT,
    required this.Image_DESCRIPTION,
    required this.Image_IDF,
    required this.Image_UIDF,
    required this.LAST_UPDT,
    required this.USER_IDF,
    required this.USR_LIB,
    required this.LIEINSPSVRQU_IDF,
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

  static ImageModel fromJson(json) {
    DateTime? LAST_UPDT;
    DateFormat originalFormat = DateFormat('dd/MM/yyyy');
    if (json["LAST_UPDT"] != null && json["LAST_UPDT"].toString().isNotEmpty) {
      LAST_UPDT = originalFormat.parse(json["LAST_UPDT"]);
    }

    return ImageModel(
      LAST_UPDT: LAST_UPDT,
      Image_DEFAULT: json["Image_DEFAULT"],
      Image_DESCRIPTION: json["Image_DESCRIPTION"],
      Image_IDF: json["Image_IDF"],
      Image_UIDF: json["Image_UIDF"],
      USER_IDF: json["USER_IDF"],
      USR_LIB: json["USR_LIB"],
      LIEINSPSVRQU_IDF: json["LIEINSPSVRQU_IDF"],
    );
  }

  static List<ImageModel> convertDynamictoListImages(
      List<dynamic> vacationsDynamic) {
    List<ImageModel> listVacations = [];
    for (var i = 0; i < vacationsDynamic.length; i++) {
      listVacations.add(ImageModel.fromJson(vacationsDynamic[i]));
    }
    return listVacations;
  }
}
