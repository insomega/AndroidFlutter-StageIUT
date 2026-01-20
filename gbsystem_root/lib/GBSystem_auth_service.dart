// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'GBSystem_salarie_controller.dart';
// import 'GBSystem_Root_Params.dart';
// import 'GBSystem_cet_model.dart';
// import 'GBSystem_document_main_model.dart';
// import 'GBSystem_event_agenda_model.dart';
// import 'GBSystem_list_messages_with_count_model.dart';
// import 'GBSystem_planning_model.dart';
// import 'GBSystem_position_with_error_model.dart';
// import 'GBSystem_response_model.dart';
// import 'GBSystem_salarie_photo_model.dart';
// import 'GBSystem_user_model.dart';
// import 'GBSystem_valider_document_model%20copy.dart';
// import 'GBSystem_valider_document_model.dart';
// import 'FIND_PLACES_API_MODELS/GBSystem_place_model.dart';
// import 'GBSystem_agrement_model.dart';
// import 'GBSystem_agrement_select_item_model.dart';
// import 'GBSystem_app_info_model.dart';
// import 'GBSystem_article_model.dart';
// import 'GBSystem_compteur_model.dart';
// import 'GBSystem_diplome_model.dart';
// import 'GBSystem_diplome_select_item_model.dart';
// import 'GBSystem_document_entreprise_model.dart';
// import 'GBSystem_document_model.dart';
// import 'GBSystem_document_officiel_model.dart';
// import 'GBSystem_document_officiel_select_item_model.dart';
// import 'GBSystem_event_absence_model.dart';
// import 'GBSystem_event_model.dart';
// import 'GBSystem_habilitation_model.dart';
// import 'GBSystem_habiliter_select_item_model.dart';
// import 'GBSystem_historique_model.dart';
// import 'GBSystem_indisponibiliter_model.dart';
// import 'GBSystem_message_model.dart';
// import 'GBSystem_nombre_jour_max_model.dart';
// import 'GBSystem_planning_dispo_model.dart';
// import 'GBSystem_planning_download_model.dart';
// import 'GBSystem_planning_vacation_model.dart';
// import 'GBSystem_preferences_model.dart';
// import 'GBSystem_prise_de_vacation_model.dart';
// import 'GBSystem_prise_de_vacation_state_model.dart';
// import 'GBSystem_publication_model.dart';
// import 'GBSystem_salarie_model.dart';
// import 'GBSystem_salarie_update_data_model.dart';
// import 'GBSystem_absence_model.dart';
// import 'GBSystem_topic_model.dart';
// import 'GBSystem_type_absence_model.dart';
// import 'GBSystem_type_de_jour_model.dart';
// import 'GBSystem_type_filtre_model.dart';
// import 'GBSystem_vacation_model.dart';
// import 'GBSystem_vacation_shift_model.dart';
// import 'GBSystem_vacation_state_demander_model.dart';
// import 'GBSystem_vacation_state_model.dart';
// import 'GBSystem_ville_model.dart';
// import 'data_server_model.dart';
// import 'GBSystem_AjoutGBSystem_convert_date_service.dart';
// import 'GBSystem_AjoutGBSystem_location_service.dart';
// import 'package:gbsystem_root/api.dart';
// import 'package:gbsystem_root/GBSystem_response_model.dart';
 // import 'GBSystem_Ajoutpackage_info_service.dart';
// import 'GBSystem_Ajoutportail_salarie_api.dart';
// import 'GBSystem_System_Strings.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class GBSystem_AuthService {
//   Future<DataServerModel?> getSiteS19Client({required String entrepriseName}) async {
//     ResponseModel responseServer = await Api(context).get(
//       //boubaker 17/06/2025 For Build APK #Portail_Salarie Update this
//       url:
//           //    "https://192.168.1.120/BMServerR.dll/BMDP81679E6763294DE3827D7D93EEE89436A?d-page=D1BAA8F26A9E418093FB0CDA98846062&SYSMENT_CODE=$entrepriseName&SYSMENT_APPNAME=BMSERVER-MBLN",
//           //   "https://192.168.1.30:8010/BMServerR.dll/BMDP81679E6763294DE3827D7D93EEE89436A?d-page=D1BAA8F26A9E418093FB0CDA98846062&SYSMENT_CODE=$entrepriseName&SYSMENT_APPNAME=BMSERVER-MBLN",
//           // "https://192.168.1.60:8010/BMServerR.dll/BMDP81679E6763294DE3827D7D93EEE89436A?d-page=D1BAA8F26A9E418093FB0CDA98846062&SYSMENT_CODE=$entrepriseName&SYSMENT_APPNAME=BMSERVER-MBLN",
//           "https://www.bmplanning.com/BMServerR.dll/BMDP81679E6763294DE3827D7D93EEE89436A?d-page=D1BAA8F26A9E418093FB0CDA98846062&SYSMENT_CODE=$entrepriseName&SYSMENT_APPNAME=BMSERVER-MBLN",
//     );
//     print(responseServer.data);
//     if (responseServer.isRequestSucces()) {
//       if ((responseServer.getElementFromDataList() as List).isNotEmpty) {
//         DataServerModel dataServerModel = DataServerModel.fromJson(responseServer.getFirstElementFromDataList());
//         return dataServerModel;
//       }
//       //@
//     } else {
//       return null;
//     }
//     return null;
//   }

  /* BuildContext context;
  GBSystem_AuthService(this.context);

  Future<ResponseModel> loginUser({required UserModel userModel}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ActiveS19 = prefs.getString(GBSystem_System_Strings.kS19) ??
        GBSystem_System_Strings.kMyS19Standard;
    ResponseModel data = await PortailSalarieApi(context)
        .post(
            needWID: false,
            data: ActiveApplication_Params.get_ConnexionData(
                userModel, ActiveS19))
        .then((value) async {
      print("login portail : ${value.data}");
      return value;
    });

    return data;
  }

  Future<GBSystem_Serveur_Info_Photo_Model?> getInfoSalarie() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": GBSystem_System_Strings.str_server_okey,
        "ACT_ID": "44E1F828CA8245DB8FFD4209C0CB275C",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      GbsystemAppInfoModel? appInfo;
      List<GbsystemTopicModel>? listTopics;
      GBSystem_Serveur_Info_Model? GBSystem_Serveur_Info_Model =
          GBSystem_Serveur_Info_Model.fromJson(data.getFirstElementFromDataList());
      String? imageSalarie =
          data.getElementFromDataList(elementName: "BinaryData").toString();
      String? tokenMap = data
          .getElementFromDataList(elementName: "MapboxAccessToken")
          .toString();
      if ((data.getElementFromDataList(elementName: "Topics") as List)
          .isNotEmpty) {
        listTopics = GbsystemTopicModel.convertDynamictoList(
            data.getElementFromDataList(elementName: "Topics"));
      }

      if ((data.getElementFromDataList(elementName: "App_Info") as List)
          .isNotEmpty) {
        appInfo = GbsystemAppInfoModel.fromJson(
            data.getFirstElementFromDataList(elementName: "App_Info"));
      }

      return GBSystem_Serveur_Info_Photo_Model(
        GBSystem_Serveur_Info_Model: GBSystem_Serveur_Info_Model,
        imageSalarie: imageSalarie,
        mapToken: tokenMap,
        listTopics: listTopics,
        appInfo: appInfo,
      );
    } else {
      return null;
    }
  }

  Future<List<GBSystem_Vacation_Model>?> getVacationsHome() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "VAC_LOAD_ETAT": "0",
        "ACT_ID": "B563858EFCEA4379B4A583910CA5B728",
      },
      needWID: true,
    );
    print(data.data);
    if (data.isRequestSucces()) {
      List<GBSystem_Vacation_Model>? vacationList =
          GBSystem_Vacation_Model.convertDynamictoListVacations(
              data.getElementFromDataList(elementName: "Planning_Vacations"));

      return vacationList;
    } else {
      return null;
    }
  }

  Future<GBSystem_Vacation_Model?> getInfoVacationPrecedent({String? VAC_IDF}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": GBSystem_System_Strings.str_server_okey,
        "VAC_LOAD_ETAT": "-1",
        "VAC_IDF": VAC_IDF ?? "",
        "ACT_ID": "B563858EFCEA4379B4A583910CA5B728",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      GBSystem_Vacation_Model GBSystem_Vacation_Model = GBSystem_Vacation_Model.fromJson(
          data.getFirstElementFromDataList(elementName: "Planning_Vacations"));

      return GBSystem_Vacation_Model;
    } else {
      return null;
    }
  }

  Future<GBSystem_Vacation_Model?> getInfoVacationSuivant({String? VAC_IDF}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": GBSystem_System_Strings.str_server_okey,
        "VAC_LOAD_ETAT": "1",
        "VAC_IDF": VAC_IDF ?? "378315",
        "ACT_ID": "B563858EFCEA4379B4A583910CA5B728",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      GBSystem_Vacation_Model GBSystem_Vacation_Model = GBSystem_Vacation_Model.fromJson(
          data.getFirstElementFromDataList(elementName: "Planning_Vacations"));

      return GBSystem_Vacation_Model;
    } else {
      return null;
    }
  }

  Future<GBSystem_Vacation_Model?> pointageEntrerSorie({
    required String Sens,
    required GBSystem_Vacation_Model vacation,
    String? NFC,
    String? ERR_NFC,
    String? QRCODE,
    String? ERR_QRCODE,
    // new NFC
    bool? isNFCErrror,
    bool? isNFCNotSupported,
    bool? isPermissionNFCDenied,
    bool? isUserIgnoreNFC,
    String? messageErrNFC,
    // new QR
    bool? isQRErrror,
    bool? isUserIgnoreQR,
    String? messageErrQR,
  }) async {
    PositionWithErrorModel currentPosition =
        await LocationService().determinePositionWithErrorsPointage();

    Map<String, String> myMap = {
      "OKey": GBSystem_System_Strings.str_server_okey,
      "ACT_ID": "A17131199E234B73A417A42D8502447E",
      "VAC_IDF": vacation.VAC_IDF,
      "PNTGS_SENS": Sens, //"1",= entrée 2 = sortie
      "LATITUDE":
          currentPosition.position?.latitude.toString().replaceAll(".", ",") ??
              "",
      "LONGITUDE":
          currentPosition.position?.longitude.toString().replaceAll(".", ",") ??
              "",
      "ERR_NFC": ERR_NFC ?? "",
      "NFC": NFC ?? "",
      "QRCODE": QRCODE ?? "",
      "ERR_QRCODE": ERR_QRCODE ?? "",
      "ERR_GPS": currentPosition.position == null
          ? "impossible d'accéder à la localisation"
          : "",
      "PNTGL_CODE": GBSystem_System_Strings.Pointage_LecteurName_BmMob_PS1,
    };

    // case error location
    if (currentPosition.position == null) {
      myMap.addAll({
        "SYSSTR_CODE_GPS": currentPosition.isPermissionNotGranted
            ? "PS_01"
            : currentPosition.isPhoneDontSupport
                ? "PS_02"
                : currentPosition.isTimeOut
                    ? "PS_03"
                    : "",
        "VACPNTGSE_MSG_GPS": currentPosition.messageErr ?? "",
        "VACPNTGSE_CODE_GPS": currentPosition.isPermissionNotGranted
            ? "1"
            : currentPosition.isPhoneDontSupport
                ? "2"
                : currentPosition.isTimeOut
                    ? "3"
                    : "",
        "VACPNTGSE_TYPE_GPS": 'GPS',
      });
    }
    // case error nfc
    if (isNFCErrror ?? false) {
      myMap.addAll({
        "SYSSTR_CODE": (isNFCNotSupported ?? false)
            ? "PS_05"
            : (isPermissionNFCDenied ?? false)
                ? "PS_06"
                : (isUserIgnoreNFC ?? false)
                    ? "PS_07"
                    : "",
        "VACPNTGSE_MSG": messageErrNFC ?? '',
        "VACPNTGSE_CODE": (isNFCNotSupported ?? false)
            ? "1"
            : (isPermissionNFCDenied ?? false)
                ? "2"
                : (isUserIgnoreNFC ?? false)
                    ? "3"
                    : "",
        "VACPNTGSE_TYPE": 'NFC',
      });
    }
    // case error qr
    if (isQRErrror ?? false) {
      myMap.addAll({
        "SYSSTR_CODE": (isUserIgnoreQR ?? false) ? "PS_08" : "",
        "VACPNTGSE_MSG": messageErrQR ?? "",
        "VACPNTGSE_CODE": (isUserIgnoreQR ?? false) ? "1" : "",
        "VACPNTGSE_TYPE": 'QRCODE',
      });
    }

    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: myMap,
      needWID: true,
    );

// {
//         "OKey": GBSystem_System_Strings.str_server_okey,
//         "ACT_ID": "A17131199E234B73A417A42D8502447E",
//         "VAC_IDF": vacation.VAC_IDF,
//         "PNTGS_SENS": Sens, //"1",= entrée 2 = sortie
//         "LATITUDE":
//             currentPosition?.latitude.toString().replaceAll(".", ",") ?? "",
//         "LONGITUDE":
//             currentPosition?.longitude.toString().replaceAll(".", ",") ?? "",
//         "ERR_NFC": ERR_NFC ?? "",
//         "NFC": NFC ?? "",
//         "QRCODE": QRCODE ?? "",
//         "ERR_QRCODE": ERR_QRCODE ?? "",
//         "ERR_GPS": currentPosition == null
//             ? "impossible d'accéder à la localisation"
//             : "",
//         "PNTGL_CODE": GBSystem_System_Strings.Pointage_LecteurName_BmMob_PS1,
//       }
    if (responseServer.isRequestSucces()) {
      GBSystem_Vacation_Model? myVacation = GBSystem_Vacation_Model.fromJson(responseServer
          .getFirstElementFromDataList(elementName: "Planning_Vacations"));

      return myVacation;
    } else {
      return null;
    }
  }

  Future<String?> getMapToken() async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "ACT_ID": "44E1F828CA8245DB8FFD4209C0CB275C",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      String? token = responseServer.getElementFromDataList(
          elementName: "MapboxAccessToken");

      return token;
    } else {
      return null;
    }
  }

  Future<int?> getNombreVacationProposer() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "Get_Count": "1",
        "ACT_ID": "57FC843A53C240CD8C0DAA6A0D5DD501",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      int nbrVac = int.parse(data.data["Data"][0]["ClientData"][0]["VACS_NBR"]);

      return nbrVac;
    } else {
      return null;
    }
  }

  Future<String?> moteDePasseOublier({required String mail}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ActiveS19 = prefs.getString(GBSystem_System_Strings.kS19);
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "B1D8D4F9B49A412FBD91B42B1EC5CA7D",
        // "OKey": "Server,system_user,NEW_PASSWORD",
        "ITEM_CODE": mail,
        "s19": ActiveS19 ?? '',
      },
      needWID: false,
    );
    if (data.isRequestSucces()) {
      print(data.data);

      String nbrVac = data.getFirstElementFromDataList()["ITEM_CODE"];
      // String nbrVac = data.data["Data"][0]["ClientData"][0]["ITEM_CODE"];

      return nbrVac;
    } else {
      return null;
    }
  }

  Future<String?> changeMotDePasse({
    required String mail,
    required String ancientPass,
    required String newPass,
    required String newPassConf,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ActiveS19 = prefs.getString(GBSystem_System_Strings.kS19);

    ResponseModel data = await PortailSalarieApi(context).post(data: {
      "OKey": "B0A7449C3A164E1FAFCF68CDF44852E9",
      "CNX_TYPE": "server",
      "CNX_APPLICATION": "BMSERVER",
      "SVR_CODE": mail,
      "SVR_PASSWORD": "",
      "SVR_MAIL": mail,
      "SVR_PASS_OLD": ancientPass,
      "SVR_PASS_NEW": newPass,
      "SVR_PASS_CHECK": newPassConf,
      "s19": ActiveS19 ?? '',
    }, needWID: false);

    if (data.isRequestSucces()) {
      // String nbrVac = data.data["Data"][0]["ClientData"][0]["COLUMN1"];
      String nbrVac = data.getFirstElementFromDataList()["COLUMN1"];
      return nbrVac;
    } else {
      return null;
    }
  }

  Future<SalarieUpdateDataModel?> updateAdresse({
    required GBSystem_Serveur_Info_Photo_Model salarie,
    required String adresse1,
    required String adresse2,
  }) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Server,Update_Info_Serveur,Update_Info_Serveur",
        "SVR_IDF": salarie.GBSystem_Serveur_Info_Model.SVR_IDF,
        "Update_TYPE": "1",
        "VIL_IDF": salarie.GBSystem_Serveur_Info_Model.VIL_IDF,
        "SVR_ADR1": adresse1,
        "SVR_ADR2": adresse2,
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      SalarieUpdateDataModel GBSystem_Serveur_Info_Model =
          SalarieUpdateDataModel.fromJson(data.getFirstElementFromDataList());

      return GBSystem_Serveur_Info_Model;
    } else {
      return null;
    }
  }

  Future<SalarieUpdateDataModel?> updateAdresseNew({
    required GbsystemVilleModel? ville,
    required String adresse1,
    required String adresse2,
    required GbsystemPlaceModel? place,
  }) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Server,Portail_Salarie,Portail_Salarie",
        "Update_TYPE": "1",
        "VIL_IDF": ville?.VIL_IDF ?? "",
        "SVR_ADR1": place?.label ?? adresse1,
        "SVR_ADR2": adresse2,
        "ACT_ID": "1E40CD53914445A98F96EAAA47CE0DB7",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      SalarieUpdateDataModel GBSystem_Serveur_Info_Model =
          SalarieUpdateDataModel.fromJson(data.getFirstElementFromDataList());

      return GBSystem_Serveur_Info_Model;
    } else {
      return null;
    }
  }

  Future<List<GbsystemVilleModel>?> getAllVille() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,ville_int,select",
        "_search": "false",
        "nd": "1729068855738",
        "rows": "0",
        "page": '1',
        "sidx": "VIL_CODE",
        "sord": "asc",
        "Prefix": "VIL",
        "Count": "0",
        "FieldsToShow": "1",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      List<GbsystemVilleModel> listVille =
          GbsystemVilleModel.convertDynamictoList(
              data.getElementFromDataList()["rows"]);

      return listVille;
    } else {
      return null;
    }
  }

  Future<SalarieUpdateDataModel?> updateTelephone(
      {required GBSystem_Serveur_Info_Photo_Model salarie,
      required String newPortable,
      required String newTelephone}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Server,Update_Info_Serveur,Update_Info_Serveur",
        "SVR_IDF": salarie.GBSystem_Serveur_Info_Model.SVR_IDF,
        "FUNC_TYPE": "1",
        "Update_TYPE": "2",
        "SVR_TELPH": newTelephone,
        "SVR_TELPOR": newPortable,
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      SalarieUpdateDataModel? GBSystem_Serveur_Info_Model =
          SalarieUpdateDataModel.fromJson(data.getFirstElementFromDataList());

      return GBSystem_Serveur_Info_Model;
    } else {
      return null;
    }
  }

  Future<bool> updateTelephoneNew(
      {required String newPortable, required String newTelephone}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Server,Portail_Salarie,Portail_Salarie",
        "FUNC_TYPE": "1",
        "Update_TYPE": "2",
        "SVR_TELPH": newTelephone,
        "SVR_TELPOR": newPortable,
        "ACT_ID": "1E40CD53914445A98F96EAAA47CE0DB7",
      },
      needWID: true,
    );
    if (data.isDataAndErrorsEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> valideSMSTelephone({
    required GBSystem_Serveur_Info_Photo_Model salarie,
    required String SMSCode,
  }) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Server,Update_Info_Serveur,Update_Info_Serveur",
        "SVR_IDF": salarie.GBSystem_Serveur_Info_Model.SVR_IDF,
        "telph_code": SMSCode,
        "FUNC_TYPE": "2",
        "Update_TYPE": "2",
      },
      needWID: true,
    );

    if (data.isDataAndErrorsEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> valideSMSTelephoneNew({
    required String SMSCode,
  }) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Server,Portail_Salarie,Portail_Salarie",
        "telph_code": SMSCode,
        "FUNC_TYPE": "2",
        "Update_TYPE": "2",
        "ACT_ID": "1E40CD53914445A98F96EAAA47CE0DB7",
      },
      needWID: true,
    );
    print("result server phone : ${data.data}");
    if (data.isRequestSucces()) {
      return true;
    } else {
      return false;
    }
  }

  Future<SalarieUpdateDataModel?> updateEmail({
    required GBSystem_Serveur_Info_Photo_Model salarie,
    required String newEmail,
  }) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Server,Update_Info_Serveur,Update_Info_Serveur",
        "SVR_IDF": salarie.GBSystem_Serveur_Info_Model.SVR_IDF,
        "FUNC_TYPE": "1",
        "Update_TYPE": "3",
        "SVR_EMAIL": newEmail,
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      SalarieUpdateDataModel GBSystem_Serveur_Info_Model =
          SalarieUpdateDataModel.fromJson(data.getFirstElementFromDataList());

      return GBSystem_Serveur_Info_Model;
    } else {
      return null;
    }
  }

  Future<bool> updateEmailNew({
    required String newEmail,
  }) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Server,Portail_Salarie,Portail_Salarie",
        "FUNC_TYPE": "1",
        "Update_TYPE": "3",
        "SVR_EMAIL": newEmail,
        "ACT_ID": "1E40CD53914445A98F96EAAA47CE0DB7",
      },
      needWID: true,
    );
    if (data.isDataAndErrorsEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> valideSMSEmail({
    required GBSystem_Serveur_Info_Photo_Model salarie,
    required String SMSCode,
  }) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Server,Update_Info_Serveur,Update_Info_Serveur",
        "SVR_IDF": salarie.GBSystem_Serveur_Info_Model.SVR_IDF,
        "email_code": SMSCode,
        "FUNC_TYPE": "2",
        "Update_TYPE": "3",
      },
      needWID: true,
    );
    if (data.isDataAndErrorsEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> valideSMSEmailNew({
    required String SMSCode,
  }) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Server,Portail_Salarie,Portail_Salarie",
        "email_code": SMSCode,
        "FUNC_TYPE": "2",
        "Update_TYPE": "3",
        "ACT_ID": "1E40CD53914445A98F96EAAA47CE0DB7",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<HistoriqueModel>?> getListHistorique() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "ACT_ID": "5367BE9BD69D41E8B750BC3EABE1A2D1",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      List<HistoriqueModel>? historique =
          HistoriqueModel.convertDynamictoList(data.getElementFromDataList());

      return historique;
    } else {
      return null;
    }
  }

  DateTime? getFirstDate(List<DateTime>? listDates) {
    DateTime? firstDate;

    if (listDates != null && listDates.isNotEmpty) {
      firstDate = listDates.first;
      for (var i = 0; i < listDates.length; i++) {
        // new date is before the current value
        if (firstDate!.compareTo(listDates[i]) == 1) {
          firstDate = listDates[i];
        }
      }
    }
    return firstDate;
  }

  DateTime? getLastDate(List<DateTime>? listDates) {
    DateTime? lastDate;

    if (listDates != null && listDates.isNotEmpty) {
      lastDate = listDates.first;
      for (var i = 0; i < listDates.length; i++) {
        // new date is before the current value
        if (lastDate!.compareTo(listDates[i]) == -1) {
          lastDate = listDates[i];
        }
      }
    }
    return lastDate;
  }

  Future<PlanningModel?> getListPlanning() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "MONTH_NBR": "3",
        "ACT_ID": "5A39038E26184C5AB121AA461CB85FD7",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      List<PlanningDownloadModel> planningDownload =
          PlanningDownloadModel.convertDynamictoListPlanningDown(
              data.getElementFromDataList(elementName: "Planning_to_download"));
      List<PlanningDisponibleModel> planningDispo =
          PlanningDisponibleModel.convertDynamictoListPlanningDispo(
              data.getElementFromDataList(
                  elementName: "Planning_to_download_dispo"));
      //// add planning download neccésaire pour les planning disponibles
      DateTime? firstDate =
          getFirstDate(planningDispo.map((e) => e.SVRPPH_START_DATE!).toList());
      DateTime? endDate =
          getLastDate(planningDispo.map((e) => e.SVRPPH_START_DATE!).toList());
      if (firstDate != null && endDate != null) {
        await getListPlanningDownload(
                length: planningDispo.length + 1,
                startDate: firstDate,
                endDate: endDate)
            // startDate: firstDate, endDate: endDate
            .then((value) {
          if (value != null && value.isNotEmpty) {
            planningDownload.addAll(value);
          }
        });
      }
// end adding planning download
      return PlanningModel(
          planningDisponibleModel: planningDispo,
          planningDownloadModel: planningDownload);
    } else {
      return null;
    }
  }

  Future<List<PlanningDownloadModel>?> getListPlanningDownload(
      {required DateTime startDate,
      required DateTime endDate,
      required int length}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "START_DATE": "${AbsenceModel.convertDate(startDate)}",
        "END_DATE": "${AbsenceModel.convertDate(endDate)}",
        "MONTH_NBR": "20",
        "ACT_ID": "5A39038E26184C5AB121AA461CB85FD7",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      List<PlanningDownloadModel>? planningDownload =
          PlanningDownloadModel.convertDynamictoListPlanningDown(
              data.getElementFromDataList(elementName: "Planning_to_download"));

      return planningDownload;
    } else {
      return null;
    }
  }

  Future<List<PlanningVacationModel>?> getListPlanningVacations() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "ACT_ID": "B563858EFCEA4379B4A583910CA5B728",
      },
      needWID: true,
    );
    print(data.data);
    if (data.isRequestSucces()) {
      List<PlanningVacationModel> planningVacations =
          PlanningVacationModel.convertDynamictoListPlanningVacations(
              data.getElementFromDataList(elementName: "Planning_Vacations"));

      return planningVacations;
    } else {
      return null;
    }
  }

  Future<List<PlanningVacationModel>?>
      getListPlanningVacationsDependPlanningDispo(
          {required PlanningDisponibleModel planningDisponibleModel}) async {
    DateTime endDate = DateTime(planningDisponibleModel.SVRPPH_START_DATE!.year,
            (planningDisponibleModel.SVRPPH_START_DATE!.month + 1), 1)
        .subtract(Duration(days: 1));

    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "START_DATE":
            "1/${planningDisponibleModel.SVRPPH_START_DATE!.month}/${planningDisponibleModel.SVRPPH_START_DATE!.year}",
        "END_DATE": "${endDate.day}/${endDate.month}/${endDate.year}",
        "ACT_ID": "B563858EFCEA4379B4A583910CA5B728",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      List<PlanningVacationModel>? planningVacations =
          PlanningVacationModel.convertDynamictoListPlanningVacations(
              data.getElementFromDataList(elementName: "Planning_Vacations"));

      return planningVacations;
    } else {
      return null;
    }
  }

  Future<GBSystemEventAgendaModel?> getListEvents() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "USE_CURRENT_MONTH": "1",
        "ACT_ID": "554935B53848490E852DB1CA4DFF01EB",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      List<EventModel> listEvents = [];
      List<EventAbsenceModel> listEventsAbsence = [];
      final List<dynamic> myData =
          (data.data["Data"][0]["ClientData"]["events"] as List);
      for (var item in myData) {
        if (item.containsKey('VAC_START_HOUR')) {
          listEvents.add(EventModel.fromJson(item));
        } else {
          listEventsAbsence.add(EventAbsenceModel.fromJson(item));
        }
      }

      return GBSystemEventAgendaModel(
          listEventAbsenceModel: listEventsAbsence, listEventModel: listEvents);
    } else {
      return null;
    }
  }

  Future<GBSystemEventAgendaModel?> getListEventsDependPlanningDispo(
      {required PlanningDisponibleModel planningDisponibleModel}) async {
    DateTime endDate = DateTime(planningDisponibleModel.SVRPPH_START_DATE!.year,
            (planningDisponibleModel.SVRPPH_START_DATE!.month + 1), 1)
        .subtract(Duration(days: 1));

    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "START_DATE":
            "01/${planningDisponibleModel.SVRPPH_START_DATE!.month}/${planningDisponibleModel.SVRPPH_START_DATE!.year}",
        "END_DATE": "${endDate.day}/${endDate.month}/${endDate.year}",
        "ACT_ID": "554935B53848490E852DB1CA4DFF01EB",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      List<EventModel> listEvents = [];
      List<EventAbsenceModel> listEventsAbsence = [];

      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null &&
            data.data["Data"][i] is Map &&
            data.data["Data"][i]["ClientData"] != null &&
            data.data["Data"][i]["ClientData"]["events"] != null) {
          final List<dynamic> myData =
              (data.data["Data"][i]["ClientData"]["events"] as List);
          for (var item in myData) {
            if (item.containsKey('VAC_START_HOUR')) {
              listEvents.add(EventModel.fromJson(item));
            } else {
              listEventsAbsence.add(EventAbsenceModel.fromJson(item));
            }
          }
        }
      }

      return GBSystemEventAgendaModel(
          listEventAbsenceModel: listEventsAbsence, listEventModel: listEvents);
    } else {
      return null;
    }
  }

  Future<String?> getPlanningPDF(
      {required PlanningDisponibleModel planningDisponibleModel}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "SVRPPH_IDF": planningDisponibleModel.SVRPPH_IDF!,
        "ACT_ID": "5401AC7D6A084EB9B7FC0F2D1E176196",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      String binary = data.data["Data"][0]["BinaryData"];

      return binary;
    } else {
      return null;
    }
  }

  Future<List<PriseDeVacationModel>?> getListPriseDeVacation() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey":
            "Shift_CalendarPlanning_NG,get_server_demanded_vac,get_server_demanded_vac",
        "_search": "false",
        "page": "1",
        "rows": "200",
        "sord": "asc",
        "Count": "0",
        "sidx": "SVR_IDF",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      List<PriseDeVacationModel> listVacs =
          PriseDeVacationModel.convertDynamictoListPriseDeVacations(
              data.data["Data"][0]["ClientData"]["rows"]);

      return listVacs;
    } else {
      return null;
    }
  }

  Future<List<PreferencesModel>?> getListPreferences() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,PLAPSVRPRFR,select",
        "SVR_IDF": "2771",
        "START_DATE_EXCLU": "01/02/2024",
        "GROUPBY_SVR": "1",
        "PRFR_DISPO1_EXCLU0": "0",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      List<PreferencesModel> listPrefs =
          PreferencesModel.convertDynamictoListPreferences(
              data.data["Data"][0]["ClientData"]);

      return listPrefs;
    } else {
      return null;
    }
  }

  Future<GBSystemListMessagesWithCountModel?> getListMessages(
      {required int page, required int rows, required bool isDesc}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,Chat_Message,Get_Chat_Message",
        "page": page.toString(),
        // != null ? page.toString() : "1",
        "rows": rows.toString(),
        // rows != null ? rows.toString() : "20",
        "Count": "0",
        "sidx": "SYSUM_IDF",
        "sord": isDesc ? "desc" : "asc", //"asc",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      int? count;

      List<MessageModel> listMessages =
          MessageModel.convertDynamictoListMessages(
              data.data["Data"][0]["ClientData"]["rows"]);

      try {
        count = int.parse(data.data["Data"][0]["ClientData"]["total"]);
      } catch (e) {
        count = null;
      }

      return GBSystemListMessagesWithCountModel(
          listMessages: listMessages, count: count);
    } else {
      return null;
    }
  }

  Future<List<AbsenceModel>?> getListAbsences() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Absence_NG,,Liste_ABS",
        "pagination": "1",
        "page": "1",
        "rows": "200",
        "sidx": "PLATPHD_IDF",
        "sord": "asc",
        "Count": "0",
        "FieldsToShow": "-1",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      List<AbsenceModel> listTypeAbcences = AbsenceModel.convertDynamicToList(
          data.data["Data"][0]["ClientData"]["rows"]);

      return listTypeAbcences;
    } else {
      return null;
    }
  }

  Future<List<TypeAbsenceModel>?> getListTypsAbsences() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Hour_Type,hour_type,select",
        "_search": "false",
        "rows": "200",
        "page": "1",
        "sidx": "TPH_WEB_ORDRE-(TPH_WEB_ORDRE/100)*100",
        "sord": "asc",
        "Prefix": "TPHABS",
        "ConvertColor": "CLR_CODE",
        "Count": "0",
        "TPH_FILTER": "7",
        "FieldsToShow": "4",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      List<TypeAbsenceModel> listTypeAbcences =
          TypeAbsenceModel.convertDynamicToList(
              data.data["Data"][0]["ClientData"]["rows"]);

      return listTypeAbcences;
    } else {
      return null;
    }
  }

  Future<String?> calculateDuree(
      {required DateTime dateDebut,
      required TypeAbsenceModel typeAbsenceModel,
      required DateTime dateFin}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        // "OKey": "Server,,Get_SERVEUR_COMPT_Web",
        "OKey": "CACB4E292F3F44319D411C16184883A3",

        "START_DATE_ABS":
            "${dateDebut.day}/${dateDebut.month}/${dateDebut.year} ${dateDebut.hour}:${dateDebut.minute}",
        "END_DATE_ABS":
            "${dateFin.day}/${dateFin.month}/${dateFin.year} ${dateFin.hour}:${dateFin.minute}",
        "TPH_IDF": typeAbsenceModel.TPH_IDF,
        "ACt_ID": "E47EFDA2BB1C450383276E521ED9B90C",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      String duree = data.data["Data"][0]["ClientData"][0]["dureeCP"];

      return duree;
    } else {
      return null;
    }
  }

  Future<List<AbsenceModel>?> chargerDemandeAbsence(
      {required TypeAbsenceModel typeAbsenceModel,
      required GBSystem_Serveur_Info_Model salarie,
      required DateTime dateDebut,
      required DateTime dateFin,
      required String? comment,
      required String? fileBase64,
      required String? fileTypeExtension,
      required String? fileSize,
      required String? RC_REST,
      required bool isTimeRequired}) async {
    print(
        "date debut ${"${dateDebut.day}/${dateDebut.month}/${dateDebut.year} ${dateDebut.hour}:${dateDebut.minute}"}");
    print(
        "date fin ${"${dateFin.day}/${dateFin.month}/${dateFin.year} ${dateFin.hour}:${dateFin.minute}"}");

    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Absence_NG,,server_demande_abs",
        "TPH_IDF": typeAbsenceModel.TPH_IDF,
        // "SVR_IDF": salarie.SVR_IDF,
        "PLATPH_START_HOUR": isTimeRequired
            ? "${dateDebut.day}/${dateDebut.month}/${dateDebut.year} ${dateDebut.hour}:${dateDebut.minute}"
            : "${dateDebut.day}/${dateDebut.month}/${dateDebut.year}",
        "PLATPH_END_HOUR": isTimeRequired
            ? "${dateFin.day}/${dateFin.month}/${dateFin.year} ${dateFin.hour}:${dateFin.minute}"
            : "${dateFin.day}/${dateFin.month}/${dateFin.year}",
        "PLATPH_MMO2": comment ?? "",
        "PLATPH_ETAT": "AT",
        "PLATPH_DEMAND_DATE":
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}",
        "DOC_DESCRIPTION": comment ?? "",
        // "TPH_WEB_ATTACH": typeAbsenceModel.TPH_WEB_ATTACH != null &&
        //         typeAbsenceModel.TPH_WEB_ATTACH!.isNotEmpty
        //     ? typeAbsenceModel.TPH_WEB_ATTACH!
        //     : "0",
        "PLATPH_VAC_IDF": "",
        "FileSize": fileSize ?? "",
        "FileExtention": fileTypeExtension ?? "",
        // "TPH_WEB_RC": typeAbsenceModel.TPH_WEB_RC != null &&
        //         typeAbsenceModel.TPH_WEB_RC!.isNotEmpty
        //     ? typeAbsenceModel.TPH_WEB_RC!
        //     : "0",
        //    "RC_REST": RC_REST ?? "",
        // "TPH_WEB_CP": typeAbsenceModel.TPH_WEB_CP != null &&
        //         typeAbsenceModel.TPH_WEB_CP!.isNotEmpty
        //     ? typeAbsenceModel.TPH_WEB_CP!
        //     : "0",
        "DOC_DATA": fileBase64 ?? "",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      List<AbsenceModel>? listAbcences = AbsenceModel.convertDynamicToList(
          data.getElementFromDataList(elementName: "Reconcile"));

      return listAbcences;
    } else {
      return null;
    }
  }

  Future<CompteurModel?> chargerCompteur() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        // "OKey": "Server,,Get_SERVEUR_COMPT_Web",
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "ACT_ID": "E47EFDA2BB1C450383276E521ED9B90C",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      print("sqssqsqsqqs ${data.data}");
      CompteurModel compteurModel =
          CompteurModel.fromJson(data.data["Data"][0]["ClientData"][0]);

      return compteurModel;
    } else {
      return null;
    }
  }

  Future<List<IndisponibiliterModel>?> getListIndisponibiliter() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Server,serveur_horaire,Serveur_Disponible_Liste",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      List<IndisponibiliterModel> listIndisponibiliter =
          IndisponibiliterModel.convertDynamicToList(
              data.data["Data"][0]["ClientData"]);

      return listIndisponibiliter;
    } else {
      return null;
    }
  }

  Future<List<AbsenceModel>?> getListIndisponibiliter2() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Indisponibilite,,Liste_ABS",
        "pagination": "1",
        "page": "1",
        "rows": "200",
        "sidx": "PLATPHD_IDF",
        "sord": "asc",
        "Count": "0",
        "FieldsToShow": "-1",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      List<AbsenceModel> listIndisponibiliter =
          AbsenceModel.convertDynamicToList(
              data.data["Data"][0]["ClientData"]["rows"]);

      return listIndisponibiliter;
    } else {
      return null;
    }
  }

  Future<List<AbsenceModel>?> refuseAbsence(
      {required AbsenceModel absenceModel}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Absence_NG,,server_refus_abs",
        "PPLATPHD_IDF": absenceModel.PLATPHD_IDF ?? "",
        "ABS_ORIGN_ETAT": "CL",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      List<AbsenceModel> listAbs =
          AbsenceModel.convertDynamicToList(data.data["Data"][0]["ClientData"]);

      return listAbs;
    } else {
      return null;
    }
  }

  Future<List<AbsenceModel>?> accepterAbsence(
      {required AbsenceModel absenceModel}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Absence_NG,,server_demande_abs",
        "TPH_IDF": absenceModel.TPH_IDF ?? "",
        // "SVR_IDF": absenceModel.SVR_IDF ?? "",
        "PLATPH_START_HOUR": absenceModel.PLATPH_START_HOUR != null
            ? "${absenceModel.PLATPH_START_HOUR?.day}/${absenceModel.PLATPH_START_HOUR?.month}/${absenceModel.PLATPH_START_HOUR?.year}"
            : "",
        "PLATPH_END_HOUR": absenceModel.PLATPH_END_HOUR != null
            ? "${absenceModel.PLATPH_END_HOUR?.day}/${absenceModel.PLATPH_END_HOUR?.month}/${absenceModel.PLATPH_END_HOUR?.year}"
            : "",
        "PLATPH_MMO": absenceModel.PLATPH_MMO ?? "",
        "PLATPH_ETAT": "AT",
        "PLATPH_DEMAND_DATE": absenceModel.PLATPH_DEMAND_DATE != null
            ? "${absenceModel.PLATPH_DEMAND_DATE?.day}/${absenceModel.PLATPH_DEMAND_DATE?.month}/${absenceModel.PLATPH_DEMAND_DATE?.year} ${absenceModel.PLATPH_DEMAND_DATE?.hour}:${absenceModel.PLATPH_DEMAND_DATE?.minute}"
            : "",
        "PLATPH_ETAT_DATE": absenceModel.PLATPH_ETAT_DATE != null
            ? "${absenceModel.PLATPH_ETAT_DATE?.day}/${absenceModel.PLATPH_ETAT_DATE?.month}/${absenceModel.PLATPH_ETAT_DATE?.year} ${absenceModel.PLATPH_DEMAND_DATE?.hour}:${absenceModel.PLATPH_DEMAND_DATE?.minute}:${absenceModel.PLATPH_DEMAND_DATE?.second}"
            : "",
        "PPLATPHD_IDF": absenceModel.PLATPHD_IDF ?? "",
        "ABS_ORIGN_ETAT": "AT",
        "PLATPH_IDF_TO_DEL": absenceModel.PPLATPHD_IDF ?? "",
        "PLATPH_ETAT_TO_DEL": "PR",
        "DOC_DESCRIPTION": "",
        "DOC_DATA": "",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      List<AbsenceModel> listAbs =
          AbsenceModel.convertDynamicToList(data.data["Data"][1]["ClientData"]);

      return listAbs;
    } else {
      return null;
    }
  }

  Future<List<TypeAbsenceModel>?> getListTypeAbsencesIndisponibiliter() async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Hour_Type,hour_type,select",
        "_search": "false",
        "page": "1",
        "rows": "200",
        "sord": "asc",
        "Count": "0",
        "sidx": "TPH_CODE",
        "Prefix": "TPH",
        "ConvertColor": "CLR_CODE",
        "TPH_FILTER": "4",
        "FieldsToShow": "4",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      List<TypeAbsenceModel> indisponibiliter =
          TypeAbsenceModel.convertDynamicToList(
              responseServer.data["Data"][0]["ClientData"]["rows"]);

      return indisponibiliter;
    } else {
      return null;
    }
  }

  Future<bool> verifierGetDateRC({required DateTime selectedDate}) async {
    DateTime nextMonth = DateTime(selectedDate.year, selectedDate.month + 1, 1);
    DateTime endDate = nextMonth.subtract(Duration(days: 1));
    // print("end date :  $endDate");
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Shift_CalendarPlanning_NG,,Load_shift_planning_server_Web",
        "START_DATE":
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
        "END_DATE": "${endDate.day}/${endDate.month}/${endDate.year}",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<VacationShiftModel>?> getListVacationsShift(
      {required DateTime selectedDate, required String? TPH_IDF}) async {
    print('-------------vac shift ------');
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        // "OKey": "Server,,Get_SERVEUR_shifts_Web",
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "ACT_ID": "73F2247E9CFE48889DD1D7F592893CE5",
        "START_DATE":
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
        // "RC_REST": RC_REST?.replaceAll(",", ".") ?? "",
        "TPH_IDF": TPH_IDF ?? "",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      List<VacationShiftModel> vacationsShift =
          VacationShiftModel.convertDynamictoListVacations(
              responseServer.data["Data"][0]["ClientData"]);

      return vacationsShift;
    } else {
      return null;
    }
  }

  Future<List<VacationStateModel>?> getListVacationsState() async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "ACT_ID": "57FC843A53C240CD8C0DAA6A0D5DD501",
      },
      needWID: true,
    );
    if (responseServer.isRequestSucces()) {
      List<VacationStateModel> vacationsState =
          VacationStateModel.convertDynamictoListVacations(
              responseServer.data["Data"][0]["ClientData"]);

      return vacationsState;
    } else {
      return null;
    }
  }

  Future<VacationStateModel?> vacationStateDemandeAction(
      {required VacationStateModel vacationStateModel}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "VAC_IDF": vacationStateModel.VAC_IDF,
        "ETAT": "1",
        "ACT_ID": "A8812427CE7545C58923BFBD3CEC440F",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      VacationStateModel vacationsState = VacationStateModel.fromJson(
          responseServer.data["Data"][0]["ClientData"][0]);

      return vacationsState;
    } else {
      return null;
    }
  }

  Future<VacationStateModel?> vacationStateAnnulerAction(
      {required VacationStateModel vacationStateModel}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "VAC_IDF": vacationStateModel.VAC_IDF,
        "ETAT": "0",
        "ACT_ID": "A8812427CE7545C58923BFBD3CEC440F",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      VacationStateModel vacationsState = VacationStateModel.fromJson(
          responseServer.data["Data"][0]["ClientData"][0]);

      return vacationsState;
    } else {
      return null;
    }
  }

  Future<VacationStateModel?> vacationStateRefuserAction(
      {required VacationStateModel vacationStateModel}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "VAC_IDF": vacationStateModel.VAC_IDF,
        "ACT_ID": "4A15CEE23AEC43FE9BEFC7BB79A9AA36",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      VacationStateModel vacationsState = VacationStateModel.fromJson(
          responseServer.data["Data"][0]["ClientData"][0]);

      return vacationsState;
    } else {
      return null;
    }
  }

  Future<String?> downloadPublicationPDF(
      {required PublicationModel publicationModel}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "SVRPPH_IDF": publicationModel.SVRPPH_IDF,
        "ACT_ID": "C2C7B638AFF54D3AA74C9AB76F9DB63B",
      },
      needWID: true,
    );
    if (responseServer.isRequestSucces()) {
      String binaryData = responseServer.data["Data"][0]["BinaryData"];

      return binaryData;
    } else {
      return null;
    }
  }

  Future<String?> downloadDocumentPDF(
      {required DocumentModel documentModel}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "DOCAN_IDF": documentModel.DOCAN_IDF,
        "ACT_ID": "3AB015711F3C4A7CBC37365601DD543C",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      String binaryData = responseServer.data["Data"][0]["BinaryData"];

      return binaryData;
    } else {
      return null;
    }
  }

  Future<List<MessageModel>?> sendMessage(
      {required String messageString, required String type}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,Chat_Message,Send_Chat_Message",
        "SYSUM_MESSAGE": messageString,
        "SYSUM_MSG_TYPE": type,
        "PSYSUM_IDF": "",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      List<MessageModel> messageList =
          MessageModel.convertDynamictoListMessages(
              responseServer.data["Data"][0]["ClientData"]);

      print(messageList.length);

      return messageList;
    } else {
      return null;
    }
  }

  Future<bool> deleteMessage({required MessageModel messageModel}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "FDFBA732ABA54F5B8E322BD14030BEB9",
        "SYSUM_IDF": messageModel.SYSUM_IDF,
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      bool deleted =
          (responseServer.data["Data"][0]["ClientData"] as List).isEmpty;

      return deleted;
    } else {
      return false;
    }
  }

  Future<List<VacationShiftModel>?> getListVacationsDemander() async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey":
            "Shift_CalendarPlanning_NG,get_server_demanded_vac,get_server_demanded_vac",
        "_search": "false",
        "page": "1",
        "rows": "200",
        "sord": "asc",
        "Count": "0",
        "sidx": "SVR_IDF",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      List<VacationShiftModel> vacList =
          VacationShiftModel.convertDynamictoListVacations(
              responseServer.data["Data"][0]["ClientData"]["rows"]);

      return vacList;
    } else {
      return null;
    }
  }

  Future<String?> loadPDFSalarie() async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey":
            "Print_server_doc_officiel,server_catre_pro_form,Report_Server_Catre_PRO",
        "ED_TYPE": "-1",
        "PRT_SALARIE": "1",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      String pdf = responseServer.data["Data"][0]["file_pdf"];

      return pdf;
    } else {
      return null;
    }
  }

  Future<List<VacationStateDemanderModel>?>
      getListVacationsStateDemander() async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey":
            "Shift_CalendarPlanning_NG,get_server_demanded_vac,get_server_demanded_vac",
        "_search": "false",
        "page": "1",
        "rows": "200",
        "sord": "asc",
        "Count": "0",
        "sidx": "SVR_IDF",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      List<VacationStateDemanderModel> vacList =
          VacationStateDemanderModel.convertDynamictoList(
              responseServer.data["Data"][0]["ClientData"]["rows"]);

      return vacList;
    } else {
      return null;
    }
  }

  Future<List<PriseDeVacationStateModel>?>
      getListPriseDeVacationsState() async {
    final salarieController =
        Get.put<GBSystemSalarieController>(GBSystemSalarieController());
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,PLAPSVRPRFR,select",
        "SVR_IDF": salarieController.getSalarie?.GBSystem_Serveur_Info_Model.SVR_IDF ?? "1840",
        "START_DATE_EXCLU":
            "01/${GBSystem_Vacation_Model.Add_zero(DateTime.now().month)}/${DateTime.now().year}",
        "GROUPBY_SVR": "1",
        "PRFR_DISPO1_EXCLU0": "0",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      List<PriseDeVacationStateModel> vacList =
          PriseDeVacationStateModel.convertDynamictoList(
              responseServer.data["Data"][0]["ClientData"]);

      return vacList;
    } else {
      return null;
    }
  }

  Future<List<PriseDeVacationStateModel>?>
      getListPriseDeVacationsStateDisponilibiliter() async {
    final salarieController =
        Get.put<GBSystemSalarieController>(GBSystemSalarieController());
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,PLAPSVRPRFR,select",
        "SVR_IDF": salarieController.getSalarie?.GBSystem_Serveur_Info_Model.SVR_IDF ?? "1840",
        "START_DATE_EXCLU":
            "01/${GBSystem_Vacation_Model.Add_zero(DateTime.now().month)}/${DateTime.now().year}",
        "GROUPBY_SVR": "1",
        "PRFR_DISPO1_EXCLU0": "1",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      List<PriseDeVacationStateModel> vacList =
          PriseDeVacationStateModel.convertDynamictoList(
              responseServer.data["Data"][0]["ClientData"]);

      return vacList;
    } else {
      return null;
    }
  }

  Future<bool> deletePriseDeVacationsState(
      {required PriseDeVacationStateModel priseDeVacationStateModel}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,PLAPSVRPRFR,delete",
        "PLAPSVRPRFR_IDF": priseDeVacationStateModel.PLAPSVRPRFR_IDF,
        "USER_IDF": priseDeVacationStateModel.USER_IDF,
      },
      needWID: true,
    );

    if (responseServer.isDataAndErrorsEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deletePriseDeVacationsStateDisponibiliter(
      {required PriseDeVacationStateModel priseDeVacationStateModel}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,PLAPSVRPRFR,delete",
        "PLAPSVRPRFR_IDF": priseDeVacationStateModel.PLAPSVRPRFR_IDF,
        "USER_IDF": priseDeVacationStateModel.USER_IDF,
      },
      needWID: true,
    );

    if (responseServer.isDataAndErrorsEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<PriseDeVacationStateModel>?>
      addPreferencesVacationStatePonctuelle({
    required DateTime dateDebut,
    required DateTime dateFin,
  }) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,PLAPSVRPRFR,insert",
        "START_DATE_EXCLU":
            "${PriseDeVacationStateModel.convertDate(dateDebut)}",
        "END_DATE_EXCLU": "${PriseDeVacationStateModel.convertDate(dateFin)}",
        "DAY1_PRFR": "0",
        "DAY2_PRFR": "0",
        "DAY3_PRFR": "0",
        "DAY4_PRFR": "0",
        "DAY5_PRFR": "0",
        "DAY6_PRFR": "0",
        "DAY7_PRFR": "0",
        "TYPE_INDISPO": "0",
        "PLAPSVRPRFR_TYPE": "1",
        "PLAPSVRPRFR_DFNTF": "0",
        "PRFR_DISPO1_EXCLU0": "0",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      List<PriseDeVacationStateModel> vacList =
          PriseDeVacationStateModel.convertDynamictoList(
              responseServer.data["Data"][0]["Reconcile"]);

      return vacList;
    } else {
      return null;
    }
  }

  Future<List<PriseDeVacationStateModel>?>
      addPreferencesVacationStateDisponibiliterPonctuelle({
    required DateTime dateDebut,
    required DateTime dateFin,
  }) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,PLAPSVRPRFR,insert",
        "START_DATE_EXCLU":
            "${PriseDeVacationStateModel.convertDate(dateDebut)}",
        "END_DATE_EXCLU": "${PriseDeVacationStateModel.convertDate(dateFin)}",
        "DAY1_PRFR": "0",
        "DAY2_PRFR": "0",
        "DAY3_PRFR": "0",
        "DAY4_PRFR": "0",
        "DAY5_PRFR": "0",
        "DAY6_PRFR": "0",
        "DAY7_PRFR": "0",
        "TYPE_INDISPO": "0",
        "PLAPSVRPRFR_TYPE": "1",
        "PRFR_DISPO1_EXCLU0": "1",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      List<PriseDeVacationStateModel> vacList =
          PriseDeVacationStateModel.convertDynamictoList(
              responseServer.data["Data"][0]["Reconcile"]);

      return vacList;
    } else {
      return null;
    }
  }

  Future<List<PriseDeVacationStateModel>?>
      addPreferencesVacationStateReccurente(
          {required DateTime dateDebut,
          required DateTime? dateFin,
          required List<String> selectedWeekDays}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,PLAPSVRPRFR,insert",
        "START_DATE_EXCLU":
            "${PriseDeVacationStateModel.convertDate(dateDebut)}",
        "END_DATE_EXCLU": dateFin != null
            ? "${PriseDeVacationStateModel.convertDate(dateFin)}"
            : "0",
        "DAY1_PRFR": selectedWeekDays.contains("S") ? "1" : "0",
        "DAY2_PRFR": selectedWeekDays.contains("D") ? "1" : "0",
        "DAY3_PRFR": selectedWeekDays.contains("L") ? "1" : "0",
        "DAY4_PRFR": selectedWeekDays.contains("M") ? "1" : "0",
        "DAY5_PRFR": selectedWeekDays.contains("Me") ? "1" : "0",
        "DAY6_PRFR": selectedWeekDays.contains("J") ? "1" : "0",
        "DAY7_PRFR": selectedWeekDays.contains("V") ? "1" : "0",
        "TYPE_INDISPO": "1",
        "PLAPSVRPRFR_TYPE": "1",
        "PLAPSVRPRFR_DFNTF": "0",
        "PRFR_DISPO1_EXCLU0": "0",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      List<PriseDeVacationStateModel> vacList =
          PriseDeVacationStateModel.convertDynamictoList(
              responseServer.data["Data"][0]["Reconcile"]);

      return vacList;
    } else {
      return null;
    }
  }

  Future<List<PriseDeVacationStateModel>?>
      addPreferencesVacationStateDisponibiliterReccurente(
          {required DateTime dateDebut,
          required DateTime? dateFin,
          required List<String> selectedWeekDays}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,PLAPSVRPRFR,insert",
        "START_DATE_EXCLU":
            "${PriseDeVacationStateModel.convertDate(dateDebut)}",
        "END_DATE_EXCLU": dateFin != null
            ? "${PriseDeVacationStateModel.convertDate(dateFin)}"
            : "0",
        "DAY1_PRFR": selectedWeekDays.contains("S") ? "1" : "0",
        "DAY2_PRFR": selectedWeekDays.contains("D") ? "1" : "0",
        "DAY3_PRFR": selectedWeekDays.contains("L") ? "1" : "0",
        "DAY4_PRFR": selectedWeekDays.contains("M") ? "1" : "0",
        "DAY5_PRFR": selectedWeekDays.contains("Me") ? "1" : "0",
        "DAY6_PRFR": selectedWeekDays.contains("J") ? "1" : "0",
        "DAY7_PRFR": selectedWeekDays.contains("V") ? "1" : "0",
        "TYPE_INDISPO": "1",
        "PLAPSVRPRFR_TYPE": "1",
        "PRFR_DISPO1_EXCLU0": "1",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      List<PriseDeVacationStateModel> vacList =
          PriseDeVacationStateModel.convertDynamictoList(
              responseServer.data["Data"][0]["Reconcile"]);

      return vacList;
    } else {
      return null;
    }
  }

  Future<List<PriseDeVacationStateModel>?>
      addPreferencesVacationStateDeffinitive() async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,PLAPSVRPRFR,insert",
        "START_DATE_EXCLU": "0",
        "END_DATE_EXCLU": "0",
        "DAY1_PRFR": "0",
        "DAY2_PRFR": "0",
        "DAY3_PRFR": "0",
        "DAY4_PRFR": "0",
        "DAY5_PRFR": "0",
        "DAY6_PRFR": "0",
        "DAY7_PRFR": "0",
        "TYPE_INDISPO": "2",
        "PLAPSVRPRFR_TYPE": "1",
        "PLAPSVRPRFR_DFNTF": "1",
        "PRFR_DISPO1_EXCLU0": "0",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      List<PriseDeVacationStateModel> vacList =
          PriseDeVacationStateModel.convertDynamictoList(
              responseServer.data["Data"][0]["Reconcile"]);

      return vacList;
    } else {
      return null;
    }
  }

  Future<PriseDeVacationStateModel?> updatePreferencesVacationStatePonctuelle({
    required PriseDeVacationStateModel priseDeVacationStateModel,
    required DateTime updatedDebut,
    required DateTime updatedFin,
  }) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,PLAPSVRPRFR,update",
        "PLAPSVRPRFR_IDF": priseDeVacationStateModel.PLAPSVRPRFR_IDF,
        "USER_IDF": priseDeVacationStateModel.USER_IDF,
        "START_DATE_EXCLU":
            "${PriseDeVacationStateModel.convertDate(updatedDebut)}",
        "END_DATE_EXCLU":
            "${PriseDeVacationStateModel.convertDate(updatedFin)}",
        "DAY1_PRFR": "1",
        "DAY2_PRFR": "1",
        "DAY3_PRFR": "1",
        "DAY4_PRFR": "1",
        "DAY5_PRFR": "1",
        "DAY6_PRFR": "1",
        "DAY7_PRFR": "1",
        "TYPE_INDISPO": "0",
        "PLAPSVRPRFR_TYPE": "1",
        "PLAPSVRPRFR_DFNTF": "0",
        "PRFR_DISPO1_EXCLU0": "0",
      },
      needWID: true,
    );

    print('reposssos : ${responseServer.data}');
    if (responseServer.isRequestSucces()) {
      PriseDeVacationStateModel priseDeVacationStateMode =
          PriseDeVacationStateModel.fromJson(
              responseServer.data["Data"][0]["Reconcile"][0]);
      return priseDeVacationStateMode;
    } else {
      return null;
    }
  }

  Future<PriseDeVacationStateModel?>
      updatePreferencesVacationStateDisponibiliterPonctuelle({
    required PriseDeVacationStateModel priseDeVacationStateModel,
    required DateTime updatedDebut,
    required DateTime updatedFin,
  }) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,PLAPSVRPRFR,update",
        "PLAPSVRPRFR_IDF": priseDeVacationStateModel.PLAPSVRPRFR_IDF,
        "USER_IDF": priseDeVacationStateModel.USER_IDF,
        "START_DATE_EXCLU":
            "${PriseDeVacationStateModel.convertDate(updatedDebut)}",
        "END_DATE_EXCLU":
            "${PriseDeVacationStateModel.convertDate(updatedFin)}",
        "DAY1_PRFR": "1",
        "DAY2_PRFR": "1",
        "DAY3_PRFR": "0",
        "DAY4_PRFR": "1",
        "DAY5_PRFR": "0",
        "DAY6_PRFR": "0",
        "DAY7_PRFR": "0",
        "TYPE_INDISPO": "0",
        "PLAPSVRPRFR_TYPE": "1",
        "PLAPSVRPRFR_DFNTF": "0",
        "PRFR_DISPO1_EXCLU0": "1",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      PriseDeVacationStateModel priseDeVacationStateMode =
          PriseDeVacationStateModel.fromJson(
              responseServer.data["Data"][0]["Reconcile"][0]);
      return priseDeVacationStateMode;
    } else {
      return null;
    }
  }

  Future<PriseDeVacationStateModel?> updatePreferencesVacationStateRecurrent(
      {required PriseDeVacationStateModel priseDeVacationStateModel,
      required DateTime updatedDebut,
      required DateTime updatedFin,
      required List<String> selectedWeekDays}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,PLAPSVRPRFR,update",
        "PLAPSVRPRFR_IDF": priseDeVacationStateModel.PLAPSVRPRFR_IDF,
        "USER_IDF": priseDeVacationStateModel.USER_IDF,
        "START_DATE_EXCLU":
            "${PriseDeVacationStateModel.convertDate(updatedDebut)}",
        "END_DATE_EXCLU":
            "${PriseDeVacationStateModel.convertDate(updatedFin)}",
        "DAY1_PRFR": selectedWeekDays.contains("S") ? "1" : "0",
        "DAY2_PRFR": selectedWeekDays.contains("D") ? "1" : "0",
        "DAY3_PRFR": selectedWeekDays.contains("L") ? "1" : "0",
        "DAY4_PRFR": selectedWeekDays.contains("M") ? "1" : "0",
        "DAY5_PRFR": selectedWeekDays.contains("Me") ? "1" : "0",
        "DAY6_PRFR": selectedWeekDays.contains("J") ? "1" : "0",
        "DAY7_PRFR": selectedWeekDays.contains("V") ? "1" : "0",
        "TYPE_INDISPO": "1",
        "PLAPSVRPRFR_TYPE": "1",
        "PLAPSVRPRFR_DFNTF": "0",
        "PRFR_DISPO1_EXCLU0": "0",
      },
      needWID: true,
    );
    if (responseServer.isRequestSucces()) {
      PriseDeVacationStateModel priseDeVacationStateMode =
          PriseDeVacationStateModel.fromJson(
              responseServer.data["Data"][0]["Reconcile"][0]);
      return priseDeVacationStateMode;
    } else {
      return null;
    }
  }

  Future<PriseDeVacationStateModel?>
      updatePreferencesVacationStateDisponibiliterRecurrent(
          {required PriseDeVacationStateModel priseDeVacationStateModel,
          required DateTime updatedDebut,
          required DateTime updatedFin,
          required List<String> selectedWeekDays}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,PLAPSVRPRFR,update",
        "PLAPSVRPRFR_IDF": priseDeVacationStateModel.PLAPSVRPRFR_IDF,
        "USER_IDF": priseDeVacationStateModel.USER_IDF,
        "START_DATE_EXCLU":
            "${PriseDeVacationStateModel.convertDate(updatedDebut)}",
        "END_DATE_EXCLU":
            "${PriseDeVacationStateModel.convertDate(updatedFin)}",
        "DAY1_PRFR": selectedWeekDays.contains("S") ? "1" : "0",
        "DAY2_PRFR": selectedWeekDays.contains("D") ? "1" : "0",
        "DAY3_PRFR": selectedWeekDays.contains("L") ? "1" : "0",
        "DAY4_PRFR": selectedWeekDays.contains("M") ? "1" : "0",
        "DAY5_PRFR": selectedWeekDays.contains("Me") ? "1" : "0",
        "DAY6_PRFR": selectedWeekDays.contains("J") ? "1" : "0",
        "DAY7_PRFR": selectedWeekDays.contains("V") ? "1" : "0",
        "TYPE_INDISPO": "1",
        "PLAPSVRPRFR_TYPE": "1",
        "PLAPSVRPRFR_DFNTF": "0",
        "PRFR_DISPO1_EXCLU0": "1",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      PriseDeVacationStateModel priseDeVacationStateMode =
          PriseDeVacationStateModel.fromJson(
              responseServer.data["Data"][0]["Reconcile"][0]);
      return priseDeVacationStateMode;
    } else {
      return null;
    }
  }

  Future<GBSystemValiderDocumentsModel?> getValiderDocuments() async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "act_id": "75408E921C6C490A97CC0C63C755136D",
      },
      needWID: true,
    );
    print("data vald dcm act auth : ${responseServer.data}");
    print(responseServer.isRequestSucces());
    if (responseServer.isRequestSucces()) {
      List<PublicationModel>? listPublications =
          responseServer.getElementFromDataList(elementName: "publa") != null
              ? PublicationModel.convertDynamictoList(
                  responseServer.getElementFromDataList(elementName: "publa"))
              : [];

      List<DocumentModel>? listDocuments =
          responseServer.getElementFromDataList(elementName: "doc_ent") != null
              ? DocumentModel.convertDynamictoList(
                  responseServer.getElementFromDataList(elementName: "doc_ent"))
              : [];

      List<GBSystem_Vacation_Model>? listVacations = responseServer
                  .getElementFromDataList(elementName: "Planning_Vacations") !=
              null
          ? GBSystem_Vacation_Model.convertDynamictoListVacations(responseServer
              .getElementFromDataList(elementName: "Planning_Vacations"))
          : [];

      return GBSystemValiderDocumentsModel(
          listVacations: listVacations,
          listDocuments: listDocuments,
          listPublications: listPublications);
    } else {
      return null;
    }
  }

  Future<bool> changePasswordMain({
    required String ancientPass,
    required String newPass,
    required String newPassConf,
  }) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey":
            "Server,update_password_server_Connect,update_password_server_Connect",
        "SVR_PASS_OLD": ancientPass,
        "SVR_PASS_NEW": newPass,
        "SVR_PASS_CHECK": newPassConf,
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      return true;
    } else {
      return false;
    }
  }

  Future<GBSystemDocumentsMainModel?> getDocumentsMain() async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Server,Get_Serveur_DocDetail_Web,Get_Serveur_DocDetail_Web",
        "_search": "false",
        "page": "1",
        "rows": "200",
        "sord": "asc",
        "Count": "0",
        "sidx": "SVR_IDF",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      List<HabilitationModel>? listHabilitations =
          HabilitationModel.convertDynamictoList(
              responseServer.getElementFromDataList(
                  elementName: "Server_Formation_list")["rows"]);
      List<AgrementModel>? listAgrements = AgrementModel.convertDynamictoList(
          responseServer.getElementFromDataList(
              elementName: 'Server_Habilitation_List')["rows"]);

      List<DiplomeModel>? listDiplomes = DiplomeModel.convertDynamictoList(
          responseServer.getElementFromDataList(
              elementName: "Server_Diplome_List")["rows"]);
      List<DocumentOfficielModel>? listDocumentsOfficiel =
          DocumentOfficielModel.convertDynamictoList(
              responseServer.getElementFromDataList(
                  elementName: "Server_Documents_List")["rows"]);

      return GBSystemDocumentsMainModel(
          listAgrements: listAgrements,
          listDiplomes: listDiplomes,
          listDocumentsOfficiel: listDocumentsOfficiel,
          listHabilitations: listHabilitations);
    } else {
      return null;
    }
  }

  Future<bool> deleteHabilitation(
      {required HabilitationModel habilitationModel}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "server_formation,svrformat,delete",
        "SFOR_IDF": habilitationModel.SFOR_IDF,
        "DOCAN_IDF": habilitationModel.DOCAN_IDF ?? "",
        "SVR_PASS_CHECK":
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}.${DateTime.now().millisecond}",
        "USER_IDF": habilitationModel.USER_IDF,
      },
      needWID: true,
    );

    if (data.isDataAndErrorsEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<getHabiliterSelectItemModel>?> getHabiliterSelectItem() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,formation_int,select",
        "_search": "false",
        "nd": "1710841203256",
        "rows": "200",
        "page": "1",
        "sidx": "FOR_CODE",
        "sord": "asc",
        "Prefix": "FOR",
        "Count": "0",
        "FieldsToShow": "1",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      List<getHabiliterSelectItemModel> habList = getHabiliterSelectItemModel
          .convertDynamictoList(data.data["Data"][0]["ClientData"]["rows"]);

      return habList;
    } else {
      return null;
    }
  }

  Future<bool> updateHabiliter(
      {required HabilitationModel habilitationModel,
      required String? comment,
      required DateTime dateDebut,
      required DateTime? dateFin,
      required String? fileName,
      required String? fileBytes,
      required getHabiliterSelectItemModel? habiliterSelectItemModel}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "server_formation,svrformat,update",
        "SFOR_IDF": habilitationModel.SFOR_IDF,
        "FOR_IDF":
            habiliterSelectItemModel?.FOR_IDF ?? habilitationModel.FOR_IDF,
        "SVR_IDF": habilitationModel.SVR_IDF,
        "SFOR_COMM": comment ?? "",
        "SFOR_DATD": HabilitationModel.convertDate(dateDebut),
        "SFOR_DATF":
            dateFin != null ? HabilitationModel.convertDate(dateFin) : "",
        "LAST_UPDT":
            "${HabilitationModel.convertDateAndTime(DateTime.now())}.116",
        "USER_IDF": habilitationModel.USER_IDF,
        "DOCAN_CODE": fileName ?? "",
        "DOCAN_VALUE": fileBytes ?? "",
      },
      needWID: true,
    );
    // print(data.data);
    if (data.isRequestSucces()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addHabiliter(
      {required String? comment,
      required DateTime dateDebut,
      required DateTime? dateFin,
      required String? fileName,
      required String? fileBytes,
      required getHabiliterSelectItemModel habiliterSelectItemModel,
      required GBSystem_Serveur_Info_Model GBSystem_Serveur_Info_Model}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "server_formation,svrformat,insert",
        "FOR_IDF": habiliterSelectItemModel.FOR_IDF,
        "SVR_IDF": GBSystem_Serveur_Info_Model.SVR_IDF,
        "SFOR_COMM": comment ?? "",
        "SFOR_DATD": HabilitationModel.convertDate(dateDebut),
        "SFOR_DATF":
            dateFin != null ? HabilitationModel.convertDate(dateFin) : "",
        "LAST_UPDT":
            "${HabilitationModel.convertDateAndTime(DateTime.now())}.116",
        "DOCAN_CODE": fileName ?? "",
        "DOCAN_VALUE": fileBytes ?? "",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteAgrement({required AgrementModel agrementModel}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "server_habilitation,svrhabilita,delete",
        "SHAB_IDF": agrementModel.SHAB_IDF,
        "DOCAN_IDF": agrementModel.DOCAN_IDF ?? "",
        "LAST_UPDT":
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}.${DateTime.now().millisecond}",
        "USER_IDF": agrementModel.USER_IDF,
      },
      needWID: true,
    );

    if (data.isDataAndErrorsEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateAgrement(
      {required AgrementModel agrementModel,
      required DateTime dateDebut,
      required DateTime? dateFin,
      required String? fileBytes,
      required String? fileName,
      required getAgrementSelectItemModel? agrementSelectItemModel}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "server_habilitation,svrhabilita,update",
        "SHAB_UIDF": agrementModel.SHAB_UIDF,
        "SHAB_IDF": agrementModel.SHAB_IDF,
        "SVR_IDF": agrementModel.SVR_IDF,
        "SHAB_DATD": HabilitationModel.convertDate(dateDebut),
        "SHAB_DATF":
            dateFin != null ? HabilitationModel.convertDate(dateFin) : "",
        "USER_IDF": agrementModel.USER_IDF,
        "HAB_IDF": agrementSelectItemModel?.HAB_IDF ?? agrementModel.HAB_IDF,
        "DOCAN_IDF": agrementModel.DOCAN_IDF ?? "",
        "DOCAN_CODE": fileName ?? "",
        "DOCAN_VALUE": fileBytes ?? "",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<getAgrementSelectItemModel>?> getAgrementSelectItem() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,habilitation_int,select",
        "_search": "false",
        "nd": "1711010523451",
        "rows": "200",
        "page": "1",
        "sidx": "HAB_CODE",
        "sord": "asc",
        "Prefix": "HAB",
        "Count": "0",
        "FieldsToShow": "1",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      List<getAgrementSelectItemModel> habList = getAgrementSelectItemModel
          .convertDynamictoList(data.data["Data"][0]["ClientData"]["rows"]);

      return habList;
    } else {
      return null;
    }
  }

  Future<bool> addAgrement(
      {required DateTime dateDebut,
      required DateTime? dateFin,
      required String? fileName,
      required String? fileBytes,
      required getAgrementSelectItemModel agrementSelectItemModel,
      required GBSystem_Serveur_Info_Model GBSystem_Serveur_Info_Model}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "server_habilitation,svrhabilita,insert",
        "HAB_IDF": agrementSelectItemModel.HAB_IDF,
        "SVR_IDF": GBSystem_Serveur_Info_Model.SVR_IDF,
        "SHAB_DATD": HabilitationModel.convertDate(dateDebut),
        "SHAB_DATF":
            dateFin != null ? HabilitationModel.convertDate(dateFin) : "",
        "LAST_UPDT":
            "${HabilitationModel.convertDateAndTime(DateTime.now())}.116",
        "DOCAN_VALUE": fileBytes ?? "",
        "DOCAN_CODE": fileName ?? "",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteDiplome({required DiplomeModel diplomeModel}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,serveur_diplome,delete",
        "SVRDIP_IDF": diplomeModel.SVRDIP_IDF,
        "DOCAN_IDF": diplomeModel.DOCAN_IDF,
        "LAST_UPDT":
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}.${DateTime.now().millisecond}",
        "USER_IDF": diplomeModel.USER_IDF,
      },
      needWID: true,
    );

    if (data.isDataAndErrorsEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateDiplome(
      {required DiplomeModel diplomeModel,
      required DateTime dateDebut,
      required String? fileBytes,
      required String? fileName,
      required getDiplomeSelectItemModel? diplomeSelectItem}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,serveur_diplome,update",
        "SVRDIP_UIDF": diplomeModel.SVRDIP_UIDF,
        "SVRDIP_IDF": diplomeModel.SVRDIP_IDF,
        "DIP_IDF": diplomeSelectItem?.DIP_IDF ?? diplomeModel.DIP_IDF,
        "SVR_IDF": diplomeModel.SVR_IDF,
        "SVRDIP_DATD": HabilitationModel.convertDate(dateDebut),
        "USER_IDF": diplomeModel.USER_IDF,
        "DOCAN_CODE": fileName ?? "",
        "DOCAN_VALUE": fileBytes ?? "",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<getDiplomeSelectItemModel>?> getDiplomeSelectItem() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,diplome,select",
        "_search": "false",
        "nd": "1711015092656",
        "rows": "200",
        "page": "1",
        "sidx": "DIP_CODE",
        "sord": "asc",
        "Prefix": "DIP",
        "Count": "0",
        "FieldsToShow": "1",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      List<getDiplomeSelectItemModel> habList = getDiplomeSelectItemModel
          .convertDynamictoList(data.data["Data"][0]["ClientData"]["rows"]);

      return habList;
    } else {
      return null;
    }
  }

  Future<bool> addDiplome(
      {required DateTime dateDebut,
      required String? fileName,
      required String? fileBytes,
      required getDiplomeSelectItemModel diplomeSelectItemModel,
      required GBSystem_Serveur_Info_Model GBSystem_Serveur_Info_Model}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,serveur_diplome,insert",
        "DIP_IDF": diplomeSelectItemModel.DIP_IDF,
        "SVR_IDF": GBSystem_Serveur_Info_Model.SVR_IDF,
        "SVRDIP_DATD": HabilitationModel.convertDate(dateDebut),
        "LAST_UPDT":
            "${HabilitationModel.convertDateAndTime(DateTime.now())}.116",
        "DOCAN_VALUE": fileBytes ?? "",
        "DOCAN_CODE": fileName ?? "",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteDocumentOfficiel(
      {required DocumentOfficielModel documentOfficielModel}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,serveur_docoff,delete",
        "SDF_IDF": documentOfficielModel.SDF_IDF,
        "DOCAN_IDF": documentOfficielModel.DOCAN_IDF ?? "",
        "LAST_UPDT":
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}.${DateTime.now().millisecond}",
        "USER_IDF": documentOfficielModel.USER_IDF,
      },
      needWID: true,
    );

    if (data.isDataAndErrorsEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> downloadDocument({required String DOCAN_IDF}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,Serveur_Document_annexe_Int,Get_Document_Annexe",
        "DOCAN_IDF": DOCAN_IDF,
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      String? binaryData =
          data.getElementFromDataList(elementName: "BinaryData");

      return binaryData;
    } else {
      return null;
    }
  }

  Future<bool> updateDocumentOfficiel({
    required DocumentOfficielModel documentOfficielModel,
    required DateTime? dateDebut,
    required DateTime? dateFin,
    required String? fileBytes,
    required String? fileName,
    required getDocumentOfficielSelectItemModel?
        documentOfficielSelectItemModel,
    // required DateTime? datePro
  }) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,serveur_docoff,update",
        "SDF_UIDF": documentOfficielModel.SDF_UIDF,
        "SDF_IDF": documentOfficielModel.SDF_IDF,
        "DOCOFF_IDF": documentOfficielSelectItemModel?.DOCOFF_IDF ??
            documentOfficielModel.DOCOFF_IDF,
        "SVR_IDF": documentOfficielModel.SVR_IDF,
        "SDF_DATD":
            dateDebut != null ? HabilitationModel.convertDate(dateDebut) : "",
        "SDF_DATF":
            dateFin != null ? HabilitationModel.convertDate(dateFin) : "",
        "SDF_NUM": documentOfficielModel.SDF_NUM,
        "SDF_PRO_DAY": dateDebut?.day != null
            ? dateDebut!.day.toString()
            : documentOfficielModel.SDF_PRO_DAY,
        "SDF_PRO_MONTH": dateDebut?.month != null
            ? dateDebut!.month.toString()
            : documentOfficielModel.SDF_PRO_MONTH,
        "SDF_PRO_YEAR": dateDebut?.year != null
            ? dateDebut!.year.toString()
            : documentOfficielModel.SDF_PRO_YEAR,
        "SDF_PRO_DEPTM": documentOfficielModel.SDF_PRO_DEPTM,
        "SDF_PRO_TYPE": documentOfficielModel.SDF_PRO_TYPE,
        "DOCAN_IDF": documentOfficielModel.DOCAN_IDF ?? "",
        "USER_IDF": documentOfficielModel.USER_IDF,
        "DOCAN_CODE": fileName ?? "",
        "DOCAN_VALUE": fileBytes ?? "",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<getDocumentOfficielSelectItemModel>?>
      getDocumentOfficielSelectItem() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,docoff,select",
        "_search": "false",
        "nd": "1711019150049",
        "rows": "200",
        "page": "1",
        "sidx": "DOCOFF_CODE",
        "sord": "asc",
        "Prefix": "DOCOFF",
        "Count": "0",
        "FieldsToShow": "1",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      List<getDocumentOfficielSelectItemModel> habList =
          getDocumentOfficielSelectItemModel
              .convertDynamictoList(data.data["Data"][0]["ClientData"]["rows"]);

      return habList;
    } else {
      return null;
    }
  }

  Future<bool> addDocumentOfficiel(
      {required DateTime dateDebut,
      required DateTime? dateFin,
      required String? fileName,
      required String? fileBytes,
      required getDocumentOfficielSelectItemModel diplomeSelectItemModel,
      required GBSystem_Serveur_Info_Model GBSystem_Serveur_Info_Model,
      required String numeroDoc,
      // required DateTime datePro,
      required String departement,
      required String type}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,serveur_docoff,insert",
        "DOCOFF_IDF": diplomeSelectItemModel.DOCOFF_IDF,
        "SVR_IDF": GBSystem_Serveur_Info_Model.SVR_IDF,
        "SDF_DATD": HabilitationModel.convertDate(dateDebut),
        "SDF_DATF":
            dateFin != null ? HabilitationModel.convertDate(dateFin) : "",
        "SDF_NUM": numeroDoc.toString(),
        "SDF_PRO_DAY": dateDebut.day.toString(),
        "SDF_PRO_MONTH": dateDebut.month.toString(),
        "SDF_PRO_YEAR": dateDebut.year.toString(),
        "SDF_PRO_DEPTM": departement,
        "SDF_PRO_TYPE": type,
        "DOCAN_CODE": fileName ?? "",
        "DOCAN_VALUE": fileBytes ?? "",
      },
      needWID: true,
    );
    // print(data.data);
    if (data.isRequestSucces()) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<PlanningVacationModel>?> getListVacationPrecedent() async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "USE_CURRENT_MONTH": "1",
        "ACT_ID": "B563858EFCEA4379B4A583910CA5B728",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      List<PlanningVacationModel>? listVacations =
          PlanningVacationModel.convertDynamictoListPlanningVacations(
              responseServer.getElementFromDataList(
                  elementName: "Planning_Vacations"));

      return listVacations;
    } else {
      return null;
    }
  }

  Future<bool> deleteIndisponibiliter(
      {required IndisponibiliterModel indisponibiliterModel}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,serveur_horaire,delete",
        "SVRHOR_IDF": indisponibiliterModel.SVRHOR_IDF,
        "USER_IDF": indisponibiliterModel.USER_IDF,
      },
      needWID: true,
    );

    if (responseServer.isDataAndErrorsEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addIndisponibiliter({
    required TypeDeJourModel typeDeJourModel,
    required String motif,
    required TimeOfDay hourDebut,
    required TimeOfDay hourFin,
    required DateTime dateDebut,
    required DateTime dateFin,
  }) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Server,serveur_horaire,server_indespo_insert",
        "SYSDAY_IDF": typeDeJourModel.SYSDAY_IDF,
        "SVRHOR_LIB": motif,
        "SVRHOR_DATD": HabilitationModel.convertDate(dateDebut),
        "SVRHOR_DATF": HabilitationModel.convertDate(dateFin),
        "SVRHOR_HEUD": GBSystem_convert_date_service()
            .TimeOfDayToSeconds(timeOfDay: hourDebut)
            .toString(),
        "SVRHOR_HEUF": GBSystem_convert_date_service()
            .TimeOfDayToSeconds(timeOfDay: hourFin)
            .toString(),
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<TypeDeJourModel>?> getListTypeDeJour() async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,SYS_DAYNUM,select",
        "_search": "false",
        "nd": "1711373990975",
        "rows": "200",
        "page": "1",
        "sidx": "SYSDAY_NUM",
        "sord": "asc",
        "Prefix": "SYSDAY",
        "Count": "0",
        "ACT_ID": "B563858EFCEA4379B4A583910CA5B728",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      List<TypeDeJourModel>? listTypeDeJour =
          TypeDeJourModel.convertDynamicToList(
              responseServer.getElementFromDataList()["rows"]);

      return listTypeDeJour;
    } else {
      return null;
    }
  }

  Future<GBSystemCETModel?> getCompteurCET() async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        // "OKey": "Server,,Get_SERVEUR_COMPT_Web",
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "ACT_ID": "E47EFDA2BB1C450383276E521ED9B90C",
        "IS_CET": "True",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      CompteurModel? compteurModel =
          CompteurModel.fromJson(responseServer.getFirstElementFromDataList());
      List<NombreJourMaxModel> listNombreDesJours =
          NombreJourMaxModel.convertDynamicToList(responseServer
              .getElementFromDataList(elementName: 'Nbr_Jours_Max'));

      return GBSystemCETModel(
          compteurModel: compteurModel, listNombreDesJours: listNombreDesJours);
    } else {
      return null;
    }
  }

  Future<GBSystemValiderCompteurCETModel?> validerCompteurCET(
      {required String nombreJourValue, required String type}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "VACCET_VALUE": nombreJourValue,
        "VACCET_TYPE": "1",
        "TPH_CODE": type == "CP"
            ? "CPCET"
            : type == "RC"
                ? "RCCET"
                : "RTTCET",
        "ACT_ID": "8ABA728738B94AF0BDF3F2FB573CB8A7",
      },
      needWID: true,
    );

    if (responseServer.isRequestSucces()) {
      DateTime? DEMANDE_DATE = GBSystem_convert_date_service().parseDateTimeString(
          dateDynamic: responseServer
              .getFirstElementFromDataList()["DEMANDE_DATE"]
              .toString());
      String? NOMBRE_JOURS =
          responseServer.getFirstElementFromDataList()["NOMBRE_JOURS"];

      return GBSystemValiderCompteurCETModel(
          DEMANDE_DATE: DEMANDE_DATE!, NOMBRE_JOURS: NOMBRE_JOURS!);
    } else {
      return null;
    }
  }

  Future<GBSystemValiderCompteurCETModel?> validerCompteurCETRachat(
      {required String nombreJourValue}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "VACCET_VALUE": nombreJourValue,
        "VACCET_TYPE": "2",
        "TPH_CODE": "RACCET",
        "ACT_ID": "8ABA728738B94AF0BDF3F2FB573CB8A7",
      },
      needWID: true,
    );
    if (responseServer.isRequestSucces()) {
      DateTime? DEMANDE_DATE = GBSystem_convert_date_service().parseDateTimeString(
          dateDynamic: responseServer
              .getFirstElementFromDataList()["DEMANDE_DATE"]
              .toString());

      String? NOMBRE_JOURS =
          responseServer.getFirstElementFromDataList()["NOMBRE_JOURS"];

      return GBSystemValiderCompteurCETModel(
          DEMANDE_DATE: DEMANDE_DATE!, NOMBRE_JOURS: NOMBRE_JOURS!);
    } else {
      return null;
    }
  }

  Future<GBSystemValiderCompteurCETModel?> validerCompteurCETPriseDeJour(
      {required String nombreJourValue}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "VACCET_VALUE": nombreJourValue,
        "VACCET_TYPE": "3",
        "TPH_CODE": "",
        "ACT_ID": "8ABA728738B94AF0BDF3F2FB573CB8A7",
      },
      needWID: true,
    );
    if (responseServer.isRequestSucces()) {
      DateTime? DEMANDE_DATE = GBSystem_convert_date_service().parseDateTimeString(
          dateDynamic: responseServer
              .getFirstElementFromDataList()["DEMANDE_DATE"]
              .toString());
      String? NOMBRE_JOURS =
          responseServer.getFirstElementFromDataList()["NOMBRE_JOURS"];

      return GBSystemValiderCompteurCETModel(
          DEMANDE_DATE: DEMANDE_DATE!, NOMBRE_JOURS: NOMBRE_JOURS!);
    } else {
      return null;
    }
  }

  Future<List<DocumentEntrepriseModel>?> getListDocumentEntreprise(
      {int? filtre}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Server,Portail_Salarie,Portail_Salarie",
        "TYPDOC_IDF": filtre != null
            ? filtre.toString()
            : "", // null = tous , 3 = administratif , contrat = 2 ,
        "act_id": "74E80AB9F5264909B90788E686E16BAF",
        "page": "1",
        "rows": "200",
        "sidx": "DOCAN_DATE_CREATED",
        "sord": "desc",
        "Count": "0",
        "FieldsToShow": "-1",
      },
      needWID: true,
    );
    if (responseServer.isRequestSucces()) {
      List<DocumentEntrepriseModel>? listDocuemntEntreprise =
          DocumentEntrepriseModel.convertDynamictoList(
              responseServer.getElementFromDataList()["rows"]);

      return listDocuemntEntreprise;
    } else {
      return null;
    }
  }

  Future<String?> downloadDocumentEntreprisePDF(
      {required DocumentEntrepriseModel documentModel}) async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "DOCAN_IDF": documentModel.DOCAN_IDF,
        "DOCAN_SEL_IDF": documentModel.DOCAN_SEL_IDF,
        "ACT_ID": "3AB015711F3C4A7CBC37365601DD543C",
      },
      needWID: true,
    );
    if (responseServer.isRequestSucces()) {
      String? binaryData =
          responseServer.getElementFromDataList(elementName: "BinaryData");

      return binaryData;
    } else {
      return null;
    }
  }

  Future<List<TypeFiltreModel>?> getListFiltreType() async {
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "CACB4E292F3F44319D411C16184883A3",
        "GETTYPDOC": "1",
        "ACT_ID": "74E80AB9F5264909B90788E686E16BAF",
      },
      needWID: true,
    );
    if (responseServer.isRequestSucces()) {
      List<TypeFiltreModel>? listTypeFiltre =
          TypeFiltreModel.convertDynamictoList(
              responseServer.getElementFromDataList(elementName: "doc_type"));

      return listTypeFiltre;
    } else {
      return null;
    }
  }

  Future<bool> GBSystem_LogEvent_ToServer({
    required String page,
    required String functionName,
    required String msg,
  }) async {
    String appVersion = await PackageInfoService().getAppVersion();
    String appVersionCode = await PackageInfoService().getAppVersionCode();
    String androidVersion = await PackageInfoService().getAndroidVersion();
    ResponseModel responseServer = await PortailSalarieApi(context).post(
      data: {
        "OKey": "39A5552F5E2B49F8959D3CA7468D2D67",
        "sender": page,
        "functionName":
            "$functionName :  appVersion:$appVersionCode($appVersion)|$androidVersion)",
        "msg": msg,
        "LOG_SERVER": "1",
      },
      needWID: true,
    );
    if (responseServer.isDataAndErrorsEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  Future<GBSystem_Vacation_Model?> getInfoVacationAgenda({String? VAC_IDF}) async {
    print("vac idf : $VAC_IDF");
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": GBSystem_System_Strings.str_server_okey,
        "VAC_IDF": VAC_IDF ?? "378315",
        "ACT_ID": "B563858EFCEA4379B4A583910CA5B728",
      },
      needWID: true,
    );
    print("inffff : ${data.data}");
    if (data.isRequestSucces()) {
      GBSystem_Vacation_Model? GBSystem_Vacation_Model = GBSystem_Vacation_Model.fromJson(
          data.getFirstElementFromDataList(elementName: "Planning_Vacations"));

      return GBSystem_Vacation_Model;
    } else {
      return null;
    }
  }

  Future<bool> sendTokenNotification({required String token}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Mobile_Application,Notification,Save_User_Mobile_Device",
        "token": token,
      },
      needWID: true,
    );
    if (data.isDataAndErrorsEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<GbsystemArticleModel>?> getAllArticles(
      {required GBSystem_Serveur_Info_Photo_Model salarie}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey":
            "ArticleRef_Manager,Visualiser_Articles_Ref_Affectes,Visualiser_Articles_Ref_Affectes",
        "ITEM_IDF": "0",
        "ITEM_STOCK_TYPE": "0",
        "ITEM_CODE": salarie.GBSystem_Serveur_Info_Model.SVR_IDF,
      },
      needWID: true,
    );
    print(data.data);
    if (data.isRequestSucces()) {
      List<GbsystemArticleModel> listArticles =
          GbsystemArticleModel.convertDynamictoList(
              data.getElementFromDataList());

      return listArticles;
    } else {
      return null;
    }
  }

  Future<GbsystemVilleModel?> getSelectedVille(
      {required GbsystemPlaceModel selectedPlace}) async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,address,get_ville_for_address",
        "VIL_CODE": selectedPlace.postcode ?? "",
        "VIL_LIB": selectedPlace.city ?? "",
      },
      needWID: true,
    );
    if (data.isRequestSucces()) {
      GbsystemVilleModel ville =
          GbsystemVilleModel.fromJson(data.getFirstElementFromDataList());

      return ville;
    } else {
      return null;
    }
  }

  Future<String?> getNombreNotiChat() async {
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Parameters,Chat_Message,Get_Chat_Notifs",
      },
      needWID: true,
    );

    if (data.isRequestSucces()) {
      String? nombreNoti;
      try {
        nombreNoti = data.getFirstElementFromDataList()["MSG_COUNT"];
      } catch (e) {}

      print("nombre notifi chat : $nombreNoti");
      return nombreNoti;
    } else {
      print("nombre notifi chat : 0");
      return null;
    }
  }

  Future<bool> send_NT_IDF({required String NT_IDF}) async {
    print("NT_IDF : ${NT_IDF}");
    ResponseModel data = await PortailSalarieApi(context).post(
      data: {
        "OKey": "Mobile_Application,Notification,Received_Notification",
        "NT_IDF": NT_IDF,
      },
      needWID: true,
    );
    print("send NT_IDF reposne : ${data.data}");
    if (data.isRequestSucces()) {
      return true;
    } else {
      return true;
    }
  }

  

  Future<bool> verifierExistUrlS19() async {
    bool verifier = false;
    await SharedPreferences.getInstance().then((value) {
      print(
          "siiiiiiiiiiit :${value.getString(GBSystem_System_Strings.kSiteWeb)}");
      print("siiiiiiiiiiit :${value.getString(GBSystem_System_Strings.kS19)}");

      if (value.getString(GBSystem_System_Strings.kSiteWeb) != null &&
          value.getString(GBSystem_System_Strings.kSiteWeb)!.isNotEmpty) {
        verifier = true;
      } else {
        verifier = false;
      }
    });
    return verifier;
  }
  */
//}
