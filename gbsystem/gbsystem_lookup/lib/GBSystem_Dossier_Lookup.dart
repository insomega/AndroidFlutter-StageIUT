import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'GBSystem_Root_Lookup.dart';
import 'package:gbsystem_root/GBSystem_Root_DataModel.dart';
import 'package:gbsystem_root/GBSystem_response_model.dart';
import 'package:gbsystem_root/GBSystem_Root_Params.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

class GBSystem_Dossier_Lookup_Model extends GBSystem_Root_DataModel_Lookup {
  final String dos_idf;
  final String dos_lib;
  final String dos_code;

  GBSystem_Dossier_Lookup_Model({
    //
    required this.dos_idf,
    required this.dos_lib,
    required this.dos_code,
  });

  @override
  String get code => dos_code;

  @override
  String get libelle => '$dos_lib ($dos_code)';

  @override
  String get id => dos_idf;

  @override
  Map<String, dynamic> toJson() => {
    //
    'id': id,
    'dos_code': dos_code,
    'dos_lib': dos_lib,
  };
  static GBSystem_Dossier_Lookup_Model fromJson(json) {
    return GBSystem_Dossier_Lookup_Model(dos_idf: json["DOS_IDF"], dos_lib: json["DOS_LIB"], dos_code: json["DOS_CODE"]);
  }

  static List<GBSystem_Dossier_Lookup_Model>? fromResponse_List(ResponseModel response) {
    return response.get_Response_in_Datamodel_List<GBSystem_Dossier_Lookup_Model, List<GBSystem_Dossier_Lookup_Model>>(fromJson: (json) => GBSystem_Dossier_Lookup_Model.fromJson(json));
  }
}

// class GBSystem_Dossier_Lookup_TextField extends GBSystem_Root_Lookup_TextField {
//   GBSystem_Dossier_Lookup_TextField({
//     //
//     Key? key,
//     TextEditingController? controllerEmail,
//     TextEditingController? controllerPassword,
//   }) : super(
//          key: key,
//          controller_lookup: Get.put(
//            GBSystem_Dossier_Lookup_Controller(
//              controllerEmail: controllerEmail, //
//              controllerPassword: controllerPassword,
//            ),
//          ),
//        );
// }

class GBSystem_Dossier_Lookup_TextField extends GBSystem_Root_Lookup_TextField {
  const GBSystem_Dossier_Lookup_TextField({
    super.key, //
    required GBSystem_Dossier_Lookup_Controller controllerLookup,
  }) : super(
         controller_lookup: controllerLookup,
       );
}

class GBSystem_Dossier_Lookup_Controller extends GBSystem_Root_Lookup_Controller<GBSystem_Dossier_Lookup_Model> {
  final TextEditingController? controllerEmail;
  final TextEditingController? controllerPassword;

  GBSystem_Dossier_Lookup_Controller({this.controllerEmail, this.controllerPassword});

  /// Getter qui construit la map de connexion

  Map<String, String> loginPayload() {
    return {
      "OKey": "system_user,system_user,sysuser_dossier", //
      "USR_CODE": controllerEmail?.text ?? "",
      "USR_PASS": controllerPassword?.text ?? "",
      "CNX_APPLICATION": GBSystem_Application_Params_Manager.instance.CNX_APPLICATION.toString(),
      "CNX_TYPE": GBSystem_Application_Params_Manager.instance.CNX_TYPE.toString(),
    };
  }

  @override
  Future<List<GBSystem_Dossier_Lookup_Model>> loadData() async {
    try {
      ResponseModel data = await Execute_Server_post(
        data: loginPayload(),
        // {
        //   //
        //   "OKey": "system_user,system_user,sysuser_dossier",
        //   "USR_CODE": controllerEmail?.text ?? "",
        //   "USR_PASS": controllerPassword?.text ?? "",
        //   "CNX_APPLICATION": GBSystem_Application_Params_Manager.instance.CNX_APPLICATION,
        //   "CNX_TYPE": GBSystem_Application_Params_Manager.instance.CNX_TYPE,
        // },
      );

      // Utilisation de la méthode générique définie dans le modèle
      final dataList = GBSystem_Dossier_Lookup_Model.fromResponse_List(data);

      return dataList ?? []; // Toujours retourner une liste, même vide
    } catch (e) {
      // Log si besoin
      print("Erreur loadData: $e");
      return []; // en cas d'erreur, on renvoie une liste vide
    }
  }

  String get dos_code {
    final item = searchController.selectedItem;
    return item?.code ?? "";
  }

  @override
  String get labelText => GBSystem_Application_Strings.str_agence.tr;

  @override
  String get title => GBSystem_Application_Strings.str_agence.tr;

  // @override
  // Map<String, dynamic Function(GBSystem_Dossier_Lookup_Model item)> get availableFilters => {'Département': (item) => item.departement, 'Statut': (item) => item.statut, 'Année embauche': (item) => item.dateEmbauche.substring(0, 4)};
}

// class GBSystem_Dossier_InAPP_Lookup_TextField extends GBSystem_Root_Lookup_TextField {
//   GBSystem_Dossier_InAPP_Lookup_TextField({
//     //
//     Key? key,
//     TextEditingController? controllerEmail,
//     TextEditingController? controllerPassword,
//   }) : super(key: key, controller_lookup: Get.put(GBSystem_Dossier_InApp_Lookup_Controller()));
// }

class GBSystem_Dossier_InApp_Lookup_Controller extends GBSystem_Dossier_Lookup_Controller {
  @override
  Map<String, String> loginPayload() {
    return {"OKey": "mobile_application,UserDossier_List,UserDossier_List"};
  }
}

// class GBSystem_Dossier_Lookup_Controller extends GBSystem_Root_Lookup_Controller<GBSystem_Dossier_Lookup_Model> {

//   final TextEditingController controllerEmail;
//   final TextEditingController controllerPassword;

//   @override
//   Future<List<GBSystem_Dossier_Lookup_Model>> loadData() async {
//     // Implémentation spécifique pour charger les salariés
//     // Par exemple:
//     // 1. Depuis une API
//     // return await SalarieApi.fetchAll();

//     // 2. Depuis une base de données locale
//     // return await DatabaseHelper.getSalaries();

//     // 3. Depuis des données mock (pour les tests)
//     return salarieData;
//   }

//   @override
//   String get labelText => GBSystem_Application_Strings.str_agence.tr;
//   @override
//   String get title => GBSystem_Application_Strings.str_agence.tr;

//   @override
//   Map<String, dynamic Function(GBSystem_Dossier_Lookup_Model item)> get availableFilters => {'Département': (item) => item.departement, 'Statut': (item) => item.statut, 'Année embauche': (item) => item.dateEmbauche.substring(0, 4)};
// }

// class GBSystem_Dossier_Lookup_Model extends GBSystem_Root_Lookup_Model {
//   final String DOS_CODE;
//   final String DOS_LIB;
//   final String DOS_IDF;
//   final DateTime? DOS_CLOSEDPLNG;
//   final String PRF_IDF;
//   final DateTime? USRDOS_END_DATE;
//   final DateTime? USRDOS_START_DATE;
//   final String? SYSTMZN_LIB;

//   @override
//   String get code => DOS_CODE;

//   @override
//   String get libelle => '$DOS_LIB ($DOS_CODE)';

//   @override
//   String get id => DOS_IDF;

//   const GBSystem_Dossier_Lookup_Model({required this.DOS_CLOSEDPLNG, required this.DOS_CODE, required this.DOS_IDF, required this.DOS_LIB, required this.PRF_IDF, required this.SYSTMZN_LIB, required this.USRDOS_END_DATE, required this.USRDOS_START_DATE});

//   static String Add_zero(int? value) {
//     if (value! < 10) {
//       return "0$value";
//     } else {
//       return "$value";
//     }
//   }

//   static String convertTime(DateTime dateTime) {
//     return "${Add_zero(dateTime.hour)}:${Add_zero(dateTime.minute)}";
//   }

//   static String convertDate(DateTime dateTime) {
//     return "${Add_zero(dateTime.day)}/${Add_zero(dateTime.month)}/${Add_zero(dateTime.year)}";
//   }

//   static String convertDateAndTime(DateTime dateTime) {
//     return "${Add_zero(dateTime.day)}/${Add_zero(dateTime.month)}/${Add_zero(dateTime.year)} ${Add_zero(dateTime.hour)}:${Add_zero(dateTime.minute)}";
//   }

//   static String detecteDateFormat(String dateString) {
//     List<String> formats = ['dd/MM/yyyy HH:mm:ss', 'dd/MM/yyyy', 'dd/MM/yyyy HH:mm:ss.SSS'];
//     for (var format in formats) {
//       try {
//         DateFormat(format).parseStrict(dateString);
//         return format;
//       } catch (e) {
//         // print(e.toString());
//       }
//     }
//     return 'dd/MM/yyyy';
//   }

//   static GBSystem_Dossier_Lookup_Model fromJson(json) {
//     DateTime? DOS_CLOSEDPLNG, USRDOS_START_DATE, USRDOS_END_DATE;

//     if (json["DOS_CLOSEDPLNG"].toString().isNotEmpty) {
//       DOS_CLOSEDPLNG = DateFormat(detecteDateFormat(json["DOS_CLOSEDPLNG"])).parse(json["DOS_CLOSEDPLNG"]);
//     }

//     if (json["USRDOS_START_DATE"].toString().isNotEmpty) {
//       USRDOS_START_DATE = DateFormat(detecteDateFormat(json["USRDOS_START_DATE"])).parse(json["USRDOS_START_DATE"]);
//     }

//     if (json["USRDOS_END_DATE"].toString().isNotEmpty) {
//       USRDOS_END_DATE = DateFormat(detecteDateFormat(json["USRDOS_END_DATE"])).parse(json["USRDOS_END_DATE"]);
//     }

//     return GBSystem_Dossier_Lookup_Model(DOS_CLOSEDPLNG: DOS_CLOSEDPLNG, USRDOS_END_DATE: USRDOS_END_DATE, USRDOS_START_DATE: USRDOS_START_DATE, DOS_CODE: json["DOS_CODE"], DOS_IDF: json["DOS_IDF"], DOS_LIB: json["DOS_LIB"], PRF_IDF: json["PRF_IDF"], SYSTMZN_LIB: json["SYSTMZN_LIB"]);
//   }

//   static List<GBSystem_Dossier_Lookup_Model> convertDynamictoList(List<dynamic> vacationsDynamic) {
//     List<GBSystem_Dossier_Lookup_Model> listVacations = [];
//     for (var i = 0; i < vacationsDynamic.length; i++) {
//       listVacations.add(GBSystem_Dossier_Lookup_Model.fromJson(vacationsDynamic[i]));
//     }
//     return listVacations;
//   }
// }
