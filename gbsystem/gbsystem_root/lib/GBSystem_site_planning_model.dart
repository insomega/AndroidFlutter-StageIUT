import 'package:intl/intl.dart';
import 'GBSystem_vacation_model.dart';

class SitePlanningModel {
  final String LIE_IDF;
  final String LIE_CODE;
  final String LIE_LIB;

  final String EVT_IDF;
  final String EVT_CODE;
  final String EVT_LIB;

  final String LIE_TLPH;
  final String LIE_ADR1;
  final String? LIE_ADR2;
  final String CLI_LIB;
  final String VIL_LIB;
  final DateTime? START_DATE;
  final DateTime? END_DATE;

  const SitePlanningModel({
    required this.LIE_IDF,
    required this.LIE_CODE,
    required this.LIE_LIB,
    required this.EVT_IDF,
    required this.EVT_CODE,
    required this.EVT_LIB,
    required this.CLI_LIB,
    this.LIE_ADR2,
    this.END_DATE,
    required this.LIE_ADR1,
    required this.LIE_TLPH,
    required this.START_DATE,
    required this.VIL_LIB,
  });

//  compare with lie_idf , to use set()
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SitePlanningModel) return false;
    return LIE_IDF == other.LIE_IDF;
  }

  @override
  int get hashCode => LIE_IDF.hashCode;
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     if (other is! SitePlanningModel) return false;
//     return LIE_IDF == other.LIE_IDF && LIE_LIB == other.LIE_LIB;
//   }

//   @override
//   int get hashCode => Object.hash(LIE_IDF, LIE_LIB);
// //
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

  static SitePlanningModel fromJson(json) {
    DateTime? startDate, endDate;

    if (json["START_DATE"].toString().isNotEmpty) {
      startDate = DateFormat(detecteDateFormat(json["START_DATE"])).parse(json["START_DATE"]);
    }
    if (json["END_DATE"].toString().isNotEmpty) {
      endDate = DateFormat(detecteDateFormat(json["END_DATE"])).parse(json["END_DATE"]);
    }

    return SitePlanningModel(
      LIE_IDF: json["LIE_IDF"],
      LIE_CODE: json["LIE_CODE"],
      LIE_LIB: json["LIE_LIB"],
      //
      EVT_IDF: json["EVT_IDF"],
      EVT_CODE: json["EVT_CODE"],
      EVT_LIB: json["EVT_LIB"],
      //
      CLI_LIB: json["CLI_LIB"],
      LIE_ADR1: json["LIE_ADR1"],
      LIE_TLPH: json["LIE_TLPH"],
      VIL_LIB: json["VIL_LIB"],
      START_DATE: startDate,
      END_DATE: endDate,
      LIE_ADR2: json["LIE_ADR2"],
    );
  }

  static List<SitePlanningModel> convertDynamictoListSites(List<dynamic> sitesDynamic) {
    List<SitePlanningModel> listSites = [];
    for (var i = 0; i < sitesDynamic.length; i++) {
      listSites.add(SitePlanningModel.fromJson(sitesDynamic[i]));
    }
    return listSites;
  }

  factory SitePlanningModel.fromVacation(GBSystem_Vacation_Model vacation) {
    return SitePlanningModel(
      LIE_IDF: vacation.LIE_IDF,
      LIE_CODE: vacation.LIE_CODE,
      LIE_LIB: vacation.LIE_LIB,
//
      EVT_IDF: vacation.EVT_IDF,
      EVT_CODE: vacation.EVT_CODE,
      EVT_LIB: vacation.EVT_LIB,
//
      LIE_TLPH: vacation.LIE_TLPH,
      LIE_ADR1: vacation.LIE_ADR,
      LIE_ADR2: null,
      CLI_LIB: '', // À compléter si disponible
      VIL_LIB: '', // À compléter si disponible
      START_DATE: null,
      END_DATE: null,
    );
  }
}

/*
class SitePlanningModel {
  final String LIE_IDF;
  final String LIE_CODE;
  final String LIE_LIB;
  final String LIE_TLPH;
  final String LIE_ADR1;
  final String? LIE_ADR2;
  final String CLI_LIB;
  final String VIL_LIB;
  final DateTime? START_DATE;
  final DateTime? END_DATE;

  const SitePlanningModel({
    required this.LIE_IDF,
    required this.CLI_LIB,
    this.LIE_ADR2,
    this.END_DATE,
    required this.LIE_CODE,
    required this.LIE_LIB,
    required this.LIE_ADR1,
    required this.LIE_TLPH,
    required this.START_DATE,
    required this.VIL_LIB,
  });

//  compare with lie_idf , to use set()
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SitePlanningModel) return false;
    return LIE_IDF == other.LIE_IDF;
  }

  @override
  int get hashCode => LIE_IDF.hashCode;
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     if (other is! SitePlanningModel) return false;
//     return LIE_IDF == other.LIE_IDF && LIE_LIB == other.LIE_LIB;
//   }

//   @override
//   int get hashCode => Object.hash(LIE_IDF, LIE_LIB);
// //
  static String detecteDateFormat(String dateString) {
    List<String> formats = [
      'dd/MM/yyyy HH:mm:ss',
      'dd/MM/yyyy',
      'dd/MM/yyyy HH:mm:ss.SSS'
    ];
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

  static SitePlanningModel fromJson(json) {
    DateTime? startDate, endDate;

    if (json["START_DATE"].toString().isNotEmpty) {
      startDate = DateFormat(detecteDateFormat(json["START_DATE"]))
          .parse(json["START_DATE"]);
    }
    if (json["END_DATE"].toString().isNotEmpty) {
      endDate = DateFormat(detecteDateFormat(json["END_DATE"]))
          .parse(json["END_DATE"]);
    }

    return SitePlanningModel(
      CLI_LIB: json["CLI_LIB"],
      LIE_ADR1: json["LIE_ADR1"],
      LIE_CODE: json["LIE_CODE"],
      LIE_IDF: json["LIE_IDF"],
      LIE_LIB: json["LIE_LIB"],
      LIE_TLPH: json["LIE_TLPH"],
      VIL_LIB: json["VIL_LIB"],
      START_DATE: startDate,
      END_DATE: endDate,
      LIE_ADR2: json["LIE_ADR2"],
    );
  }

  static List<SitePlanningModel> convertDynamictoListSites(
      List<dynamic> sitesDynamic) {
    List<SitePlanningModel> listSites = [];
    for (var i = 0; i < sitesDynamic.length; i++) {
      listSites.add(SitePlanningModel.fromJson(sitesDynamic[i]));
    }
    return listSites;
  }
}
 */
