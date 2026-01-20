import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class ConvertDateService {
  String formatSeconds({required String seconds}) {
    int mySeconds = int.parse(seconds);

    int hours = mySeconds ~/ 3600;
    int minutes = (mySeconds ~/ 3600) ~/ 60;
    int remainingSeconds = mySeconds % 60;

    String formattedTime = "";
    if (hours > 0) {
      formattedTime = formattedTime + "${Add_zero(hours)}:";
    }
    if (minutes > 0 || hours > 0) {
      formattedTime = formattedTime + "${Add_zero(minutes)}:";
    }
    formattedTime = formattedTime + "${Add_zero(remainingSeconds)}";

    return formattedTime;
  }

  int TimeOfDayToSeconds({required TimeOfDay timeOfDay}) {
    //  int timeOfDays = int.parse(timeOfDay.substring(0,timeOfDay.indexOf(':')));
    //  int minutes = int.parse(timeOfDay.substring(timeOfDay.indexOf(':'),timeOfDay.lastIndexOf(':')));
    //  int seconds = int.parse(timeOfDay.substring(timeOfDay.lastIndexOf(':')));

    return timeOfDay.hour * 3600 + timeOfDay.minute * 60;
  }

  static String Add_zero(int? value) {
    if (value! < 10) {
      return "0$value";
    } else {
      return "$value";
    }
  }

  String parseDate({required DateTime date}) {
    return "${Add_zero(date.day)}/${Add_zero(date.month)}/${Add_zero(date.year)}";
  }

  static String detecteDateFormat(String dateString) {
    List<String> formats = ['dd/MM/yyyy HH:mm:ss', 'dd/MM/yyyy', 'dd/MM/yyyy HH:mm:ss.SSS'];
    for (var format in formats) {
      try {
        DateFormat(format).parseStrict(dateString);
        return format;
      } catch (e) {
        // print(e.toString());
      }
    }
    return 'dd/MM/yyyy';
  }

  DateTime? parseDateTimeString({required String dateDynamic}) {
    return DateFormat(detecteDateFormat(dateDynamic)).parse(dateDynamic);
  }

  String formatDateTimeVacation(DateTime dateTime) {
    // Get the locale from GetX, e.g., 'fr', 'en'
    final locale = Get.locale?.languageCode ?? 'fr';

    // Full format: Day name, day number, month name, and time
    final DateFormat formatter = DateFormat('EEEE d MMMM HH:mm', locale);

    return formatter.format(dateTime);
  }

  String formatDatePlanning(DateTime dateTime) {
    // Get the locale from GetX, e.g., 'fr', 'en'
    final locale = Get.locale?.languageCode ?? 'fr';

    // Full format: Day name, day number, month name, and time
    final DateFormat formatter = DateFormat('MMMM yyyy', locale);

    return formatter.format(dateTime);
  }
}
