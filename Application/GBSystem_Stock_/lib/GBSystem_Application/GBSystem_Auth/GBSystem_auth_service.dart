import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';
import 'package:gbsystem_root/GBSystem_snack_bar.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

import 'GBSystem_internet_controller.dart';
import 'GBSystem_evaluation_controller.dart';
import 'GBSystem_evaluation_sur_site_controller.dart';
import 'GBSystem_formulaire_controller.dart';
import 'GBSystem_memo_questions_controller.dart';
import 'GBSystem_Root_Params.dart';
import 'GBSystem_manage_catch_errors.dart';

import 'GBSystem_articles_and_dataset_model.dart';
import 'GBSystem_image_with_model.dart';
import 'signature_salarie_model.dart';
import 'GBSystem_agence_model.dart';
import 'GBSystem_agence_salarie_quick_acces_model.dart';
import 'GBSystem_article_affectuier_multiple_gestion_stock_model.dart';
import 'GBSystem_article_gestion_stock_model.dart';
import 'GBSystem_article_ref_model.dart';
import 'GBSystem_article_salarie_gestion_stock_model.dart';
import 'GBSystem_catalogue_model.dart';
import 'GBSystem_causerie_model.dart';
import 'GBSystem_color_model.dart';
import 'GBSystem_enterpot_model.dart';
import 'GBSystem_evaluation_en_cours_model.dart';
import 'GBSystem_fournisseur_model.dart';
import 'GBSystem_image_eval_non_terminer_model.dart';
import 'GBSystem_image_model.dart';
import 'GBSystem_image_type_two_model.dart';
import 'GBSystem_memo_question_model.dart';
import 'GBSystem_pause_model.dart';
import 'GBSystem_question_model.dart';
import 'GBSystem_question_type_model.dart';
import 'GBSystem_question_without_memo_model.dart';
import 'GBSystem_questionnaire_quick_acces_model.dart';
import 'GBSystem_response_model.dart';
import 'GBSystem_reponse_cloture_model.dart';
import 'GBSystem_salarie_dataset_gestion_stock_model.dart';
import 'GBSystem_salarie_gestion_stock_model.dart';
import 'GBSystem_salarie_model.dart';
import 'GBSystem_salarie_photo_model.dart';
import 'GBSystem_salarie_planning_model.dart';
import 'GBSystem_reponse_qcm_model.dart';
import 'GBSystem_salarie_quick_acces_model.dart';
import 'GBSystem_site_gestion_stock_model.dart';
import 'GBSystem_site_planning_model.dart';
import 'GBSystem_site_quick_access_model.dart';
import 'GBSystem_taille_model.dart';
import 'GBSystem_type_questionnaire_quick_access_model.dart';
import 'GBSystem_user_model.dart';
import 'GBSystem_vacation_model.dart';
import 'GBSystem_evaluation_model.dart';
import 'GBSystem_vacation_salarie.dart';
import 'GBsystem_salarie_causerie_model.dart';
import 'GBsystem_salarie_formulaire_causerie_model.dart';
import 'data_server_model.dart';
import 'GBSystem_convert_date_service.dart';
import 'GBSystem_local_database_service.dart';
import 'GBSystem_location_service.dart';
import 'api.dart';
// import 'GBSystem_location_service.dart';
import 'app_exceptions_manager_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GBSystem_AuthService {
  String _ActiveUrl = '';
  String? _ActiveS19 = '';
  String? _Wid = '';
  String? _Cookies = '';
  BuildContext context;
  GBSystem_AuthService(this.context);

  Future<void> saveCookies(String newCookies) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(GBSystem_System_Strings.kCookies, newCookies);
  }

  // Future<String?> getS19ByUserNumber() async {
  //   String? s19;
  //   // = GBSystem_System_Strings.kMyS19Standard;
  //   int clientNumber = int.parse(GBSystem_System_Strings.kClientNumber);
  //   String filePath = GBSystem_System_Strings.kJsonApiPath;
  //   try {
  //     String jsonString = await rootBundle.loadString(filePath);
  //     Map<String, dynamic> data = json.decode(jsonString);
  //     List<dynamic> clients = data['clients'];
  //     s19 = clients[clientNumber]["s19"];
  //   } catch (e) {
  //     debugPrint('Error reading JSON file: $e');
  //   }
  //   return s19;
  // }

  // Future<String> getUrlByUserNumber() async {
  //   String url = GBSystem_System_Strings.kMyBaseUrlStandard;
  //   int clientNumber = int.parse(GBSystem_System_Strings.kClientNumber);
  //   String filePath = GBSystem_System_Strings.kJsonApiPath;
  //   try {
  //     String jsonString = await rootBundle.loadString(filePath);
  //     Map<String, dynamic> data = json.decode(jsonString);
  //     List<dynamic> clients = data['clients'];
  //     url = clients[clientNumber]["api"];
  //   } catch (e) {
  //     debugPrint('Error reading JSON file: $e');
  //   }
  //   return url;
  // }

  Future initApiData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _ActiveUrl = prefs.getString(GBSystem_System_Strings.kSiteWeb)!; //://?? GBSystem_Application_Strings.kMyBaseUrlStandard;
    _ActiveS19 = prefs.getString(GBSystem_System_Strings.kS19); // ://?? GBSystem_Application_Strings.kMyS19Standard;
    _Wid = prefs.getString(GBSystem_System_Strings.kToken);
    _Cookies = prefs.getString(GBSystem_System_Strings.kCookies);
  }

  Future<ResponseModel> loginUser({required UserModel userModel}) async {
    await initApiData();
    return ResponseModel(statusCode: 200, status: 'success', data: null, cookies: '');
    // ResponseModel data = await AppManageApi(context)
    //     .post(
    //       url: _ActiveUrl,
    //       data: ActiveApplication_Params.get_ConnexionData(
    //         userModel,
    //         _ActiveS19,
    //         // ,
    //         // null
    //       ),
    //     )
    //     .then((value) async {
    //       print(value.data);

    //       await saveCookies(value.cookies!);
    //       return value;
    //     });

    // return data;
  }

  Future<List<VacationModel>?> getInfoVacation() async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": GBSystem_System_Strings.str_server_okey,
        // GBSystem_System_Strings.str_server_okey,
        "VAC_LOAD_ETAT": "0",
        "VAC_IDF": "378315",
        "ACT_ID": "B563858EFCEA4379B4A583910CA5B728",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );
    print("data server vac : ${data.data}");
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<dynamic>? vacationsDynamic;
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["Planning_Vacations"] != null) {
          vacationsDynamic = data.data["Data"][i]["Planning_Vacations"] as List;
        }
      }

      List<VacationModel> listVacations = [];

      for (var i = 0; i < (vacationsDynamic?.length ?? 0); i++) {
        listVacations.add(VacationModel.fromJson(vacationsDynamic![i]));
      }
      await saveCookies(data.cookies!);

      return listVacations;
    } else {
      return null;
    }
  }

  Future<VacationModel?> getInfoVacationPrecedent({String? VAC_IDF}) async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": GBSystem_System_Strings.str_server_okey, "VAC_LOAD_ETAT": "-1", "VAC_IDF": VAC_IDF ?? "378315", "ACT_ID": "B563858EFCEA4379B4A583910CA5B728", "Wid": _Wid!}, cookies: _Cookies);
    // print(data.data);
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      VacationModel? vacationModel;
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["Planning_Vacations"] != null && data.data["Data"][i]["Planning_Vacations"] is List && (data.data["Data"][i]["Planning_Vacations"] as List).isNotEmpty) {
          vacationModel = VacationModel.fromJson(data.data["Data"][i]["Planning_Vacations"][0]);
        }
      }
      // VacationModel vacationModel = VacationModel.fromJson(
      //   data.data["Data"][0]["Planning_Vacations"][0],
      // );
      await saveCookies(data.cookies!);

      return vacationModel;
    } else {
      return null;
    }
  }

  Future<VacationModel?> getInfoVacationSuivant({String? VAC_IDF}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": GBSystem_System_Strings.str_server_okey, "VAC_LOAD_ETAT": "1", "VAC_IDF": VAC_IDF ?? "378315", "ACT_ID": "B563858EFCEA4379B4A583910CA5B728", "Wid": _Wid!}, cookies: _Cookies);
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      VacationModel? vacationModel;
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["Planning_Vacations"] != null && data.data["Data"][i]["Planning_Vacations"] is List && (data.data["Data"][i]["Planning_Vacations"] as List).isNotEmpty) {
          vacationModel = VacationModel.fromJson(data.data["Data"][i]["Planning_Vacations"][0]);
        }
      }

      // VacationModel vacationModel =
      //     VacationModel.fromJson(data.data["Data"][0]["Planning_Vacations"][0]);
      await saveCookies(data.cookies!);

      return vacationModel;
    } else {
      return null;
    }
  }

  Future<GBSystemSalarieWithPhotoModel?> getInfoSalarie() async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": GBSystem_System_Strings.str_server_okey,
        // GBSystem_System_Strings.str_server_okey,
        "ACT_ID": "44E1F828CA8245DB8FFD4209C0CB275C",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );
    print("data server sal : ${data.data}");

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      SalarieModel salarieModel = SalarieModel.fromJson(data.getFirstElementFromDataList(elementName: "ClientData"));
      String imageSalarie = data.getElementFromDataList(elementName: "BinaryData").toString();
      // List<dynamic> infoSalarieDynamic = data.data["Data"][0]["ClientData"];
      // String imageSalarie = data.data["Data"][1]["BinaryData"].toString();

      // SalarieModel salarieModel = SalarieModel.fromJson(infoSalarieDynamic[0]);
      await SharedPreferences.getInstance().then((value) {
        value.setString(GBSystem_System_Strings.kCookies, data.cookies!);
      });
      await saveCookies(data.cookies!);

      return GBSystemSalarieWithPhotoModel(salarieModel: salarieModel, imageSalarie: imageSalarie);
    } else {
      return null;
    }
  }

  Future<VacationModel?> pointageEntrerSorie({required String Sens, required VacationModel vacation}) async {
    await initApiData();
    final GBSystemInternatController internatController = Get.put(GBSystemInternatController());
    Position? currentPosition = await LocationService().determinePosition();
    Map<String, String> data = {
      "OKey": GBSystem_System_Strings.str_server_okey,
      "ACT_ID": "A17131199E234B73A417A42D8502447E",
      "VAC_IDF": vacation.VAC_IDF,
      "PNTGS_SENS": Sens, //"1",= entrée 2 = sortie
      "LATITUDE": currentPosition?.latitude.toString().replaceAll(".", ",") ?? "",
      "LONGITUDE": currentPosition?.longitude.toString().replaceAll(".", ",") ?? "",
      "PNTGL_CODE": GBSystem_System_Strings.Pointage_LecteurName_BmMob_PS1,
      "Wid": _Wid!,
    };
    // test connexion == non
    await internatController.initConnectivity();
    if (!internatController.isConnected) {
      LocalDatabaseService().saveRequestLocally(url: _ActiveUrl, cookies: _Cookies, data: data);
      return null;
    }
    // test connexion = oui
    else {
      ResponseModel responseServer = await AppManageApi(context).post(url: _ActiveUrl, data: data, cookies: _Cookies);
      print(responseServer.data);
      if ((responseServer.data["Data"] as List).isNotEmpty && (responseServer.data["Errors"] as List).isEmpty) {
        VacationModel myVacation = VacationModel.fromJson(
          responseServer.getFirstElementFromDataList(elementName: "Planning_Vacations"),
          // responseServer.data["Data"][1]["Planning_Vacations"][0]
        );

        await saveCookies(responseServer.cookies!);
        return myVacation;
      } else {
        return null;
      }
    }
  }

  Future<VacationModel?> pointageEntrerSorieMultiple({required String Sens, required List<VacationModel> vacations}) async {
    await initApiData();
    final GBSystemInternatController internatController = Get.put(GBSystemInternatController());
    Position? currentPosition = await LocationService().determinePosition();
    Map<String, String> data = {
      "OKey": GBSystem_System_Strings.str_server_okey,
      "ACT_ID": "A17131199E234B73A417A42D8502447E",
      "VAC_IDFS": vacations.map((e) => e.VAC_IDF).toList().join(","),

      "PNTGS_SENS": Sens, //"1",= entrée 2 = sortie
      "LATITUDE": currentPosition?.latitude.toString().replaceAll(".", ",") ?? "",
      "LONGITUDE": currentPosition?.longitude.toString().replaceAll(".", ",") ?? "",
      "PNTGL_CODE": GBSystem_System_Strings.Pointage_LecteurName_BmMob_PS1,
      "Wid": _Wid!,
    };
    // test connexion == non
    await internatController.initConnectivity();
    if (!internatController.isConnected) {
      LocalDatabaseService().saveRequestLocally(url: _ActiveUrl, cookies: _Cookies, data: data);
      return null;
    }
    // test connexion = oui
    else {
      ResponseModel responseServer = await AppManageApi(context).post(url: _ActiveUrl, data: data, cookies: _Cookies);
      print(responseServer.data);
      if ((responseServer.data["Data"] as List).isNotEmpty && (responseServer.data["Errors"] as List).isEmpty) {
        VacationModel myVacation = VacationModel.fromJson(
          responseServer.getFirstElementFromDataList(elementName: "Planning_Vacations"),
          // responseServer.data["Data"][1]["Planning_Vacations"][0]
        );

        await saveCookies(responseServer.cookies!);
        return myVacation;
      } else {
        return null;
      }
    }
  }

  Future<VacationSalarieModel?> pointageEntrerSorieSalarie({required String Sens, required SalariePlanningModel salarie, required SitePlanningModel site}) async {
    await initApiData();
    final GBSystemInternatController internatController = Get.put(GBSystemInternatController());

    Map<String, String> data = {
      "OKey": "Mobile_Application,Mobile_Application,Server_PriseService",
      "SVR_IDF": salarie.SVR_IDF,
      "LIE_IDF": site.LIE_IDF,
      "SENS": Sens, //"1",= entrée 2 = sortie
      "PSA_HOUR": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
      "Wid": _Wid!,
    };
    // test connexion == non
    await internatController.initConnectivity();
    if (!internatController.isConnected) {
      LocalDatabaseService().saveRequestLocally(url: _ActiveUrl, cookies: _Cookies, data: data);
      return null;
    }
    // test connexion = oui
    else {
      ResponseModel responseServer = await AppManageApi(context).post(url: _ActiveUrl, data: data, cookies: _Cookies);

      if ((responseServer.data["Data"] as List).isNotEmpty && (responseServer.data["Errors"] as List).isEmpty) {
        VacationSalarieModel myVacation = responseServer.getFirstElementFromDataList();

        // VacationSalarieModel myVacation = VacationSalarieModel.fromJson(
        //     responseServer.data["Data"][0]["ClientData"][0]);
        await saveCookies(responseServer.cookies!);
        return myVacation;
      } else {
        return null;
      }
    }
  }

  Future<List<SalariePlanningModel>?> getAllEmployer() async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Server,Serveur_int,Select", "svr_type": "1", "pagination": "0", "row": "0", "FieldsToShow": "4", "USR_LANGUE": "fr", "Wid": _Wid!}, cookies: _Cookies);
    print(data.data);
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<dynamic>? salarieDynamic;
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          salarieDynamic = data.data["Data"][i]["ClientData"] as List;
        }
      }

      List<SalariePlanningModel> listsalarie = [];

      for (var i = 0; i < (salarieDynamic?.length ?? 0); i++) {
        listsalarie.add(SalariePlanningModel.fromJson(salarieDynamic![i]));
      }
      await saveCookies(data.cookies!);
      return listsalarie;
    } else {
      return null;
    }
  }

  Future<List<SitePlanningModel>?> getAllSites() async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,lieu_int,select",
        "title": "Lieu",
        // "title": "LieuEvt",
        "pagination": "0",
        "rows": "0",
        "FieldsToShow": "-1",
        "USR_LANGUE": "fr",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<dynamic>? sitesDynamic;
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          sitesDynamic = data.data["Data"][i]["ClientData"] as List;
        }
      }
      List<SitePlanningModel> listSites = [];

      for (var i = 0; i < (sitesDynamic?.length ?? 0); i++) {
        listSites.add(SitePlanningModel.fromJson(sitesDynamic![i]));
      }
      print(listSites.length);
      await saveCookies(data.cookies!);
      return listSites;
    } else {
      return null;
    }
  }

  Future<List<SitePlanningModel>?> getAllEvenements() async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Lieu,lieu_int,select", "title": "Evenement", "pagination": "0", "rows": "0", "FieldsToShow": "-1", "USR_LANGUE": "fr", "Wid": _Wid!}, cookies: _Cookies);
    print("evenement ${data.data}");
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print("evenement ${data.data}");
      List<dynamic>? sitesDynamic;
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          sitesDynamic = data.data["Data"][i]["ClientData"] as List;
        }
      }
      List<SitePlanningModel> listSites = [];

      for (var i = 0; i < (sitesDynamic?.length ?? 0); i++) {
        listSites.add(SitePlanningModel.fromJson(sitesDynamic![i]));
      }
      print("evenment lenght : ${listSites.length}");
      await saveCookies(data.cookies!);
      return listSites;
    } else {
      return null;
    }
  }

  Future<List<VacationModel>?> getVacationPlanning({required SitePlanningModel sitePlanningModel}) async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "CACB4E292F3F44319D411C16184883A3", "VAC_LOAD_ETAT": "0", "LIE_IDF": sitePlanningModel.LIE_IDF, "TPH_PSA": "1", "ACT_ID": "3F7715F8F7A34CB68C3A94D5F6E8B432", "Wid": _Wid!}, cookies: _Cookies);
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<dynamic>? vacationsDynamic;
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["Planning_Vacations"] != null) {
          vacationsDynamic = data.data["Data"][i]["Planning_Vacations"] as List;
        }
      }

      List<VacationModel> listVacations = [];

      for (var i = 0; i < (vacationsDynamic?.length ?? 0); i++) {
        listVacations.add(VacationModel.fromJson(vacationsDynamic![i]));
      }

      print("nombre ${listVacations.length}");

      await saveCookies(data.cookies!);
      return listVacations;
    } else {
      return null;
    }
  }

  Future<List<VacationModel>?> getAllVacationPlanning({required List<SitePlanningModel> sitePlanningList, required List<SitePlanningModel> evenementList, required String? searchText, bool isGetAll = false}) async {
    await initApiData();
    Map<String, String> myMap = {
      "OKey": "CACB4E292F3F44319D411C16184883A3",
      "VAC_LOAD_ETAT": "0",
      "EVT_IDF": evenementList
          .map((e) {
            print(e.LIE_IDF);
            return e.LIE_IDF;
          })
          .toList()
          .join(","),
      // "search": searchText ?? "",
      "LIE_IDF": sitePlanningList
          .map((e) {
            print(e.LIE_IDF);
            return e.LIE_IDF;
          })
          .toList()
          .join(","),
      "ACT_ID": "3F7715F8F7A34CB68C3A94D5F6E8B432",
      "TPH_PSA": "1",
      "Wid": _Wid!,
    };
    if (isGetAll) {
      myMap.addAll({"VacsLieOrEvt": "1"});
      // "VacsLieOrEvt": "1", // U
    }
    print(" maaaaap $myMap");
    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: myMap,
      // {
      //   "OKey": "CACB4E292F3F44319D411C16184883A3",
      //   "VAC_LOAD_ETAT": "0",
      //   "VacsLieOrEvt": "1", // U
      //   "EVT_IDF": evenementList
      //       .map(
      //         (e) {
      //           print(e.LIE_IDF);
      //           return e.LIE_IDF;
      //         },
      //       )
      //       .toList()
      //       .join(","),
      //   "search": searchText ?? "",
      //   "LIE_IDF": sitePlanningList
      //       .map(
      //         (e) {
      //           print(e.LIE_IDF);
      //           return e.LIE_IDF;
      //         },
      //       )
      //       .toList()
      //       .join(","),
      //   "ACT_ID": "3F7715F8F7A34CB68C3A94D5F6E8B432",
      //   "Wid": _Wid!
      // },
      cookies: _Cookies,
    );
    print("resultat server vac :: ${data.data}");
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<dynamic>? vacationsDynamic;
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["Planning_Vacations"] != null) {
          vacationsDynamic = data.data["Data"][i]["Planning_Vacations"] as List;
        }
      }

      // List<dynamic>? vacationsDynamic =
      //     data.data["Data"][0]["Planning_Vacations"] as List;
      List<VacationModel> listVacations = [];

      for (var i = 0; i < (vacationsDynamic?.length ?? 0); i++) {
        listVacations.add(VacationModel.fromJson(vacationsDynamic![i]));
      }

      await saveCookies(data.cookies!);
      return listVacations;
    } else {
      return null;
    }
  }

  Future<List<TypeQuestionnaireModel>?> getTypeQuestionnaireQuickAccess() async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Lieu,LIEINSQUESTYP,select", "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<TypeQuestionnaireModel> listQuestionnaire = TypeQuestionnaireModel.convertDynamictoListVacations(data.getElementFromDataList());

      // List<TypeQuestionnaireModel> listQuestionnaire =
      //     TypeQuestionnaireModel.convertDynamictoListVacations(
      //         data.data["Data"][0]["ClientData"]);
      await saveCookies(data.cookies!);
      return listQuestionnaire;
    } else {
      return null;
    }
  }

  Future<List<QuestionnaireModel>?> getQuestionnaireQuickAccess() async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Lieu,LIEU_INSPECT_QUESTNRE_Web,select", "FLIEINSTYP_IDF": "1", "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<QuestionnaireModel> listQuestionnaire = QuestionnaireModel.convertDynamictoListQuestions(data.getElementFromDataList());
      // List<QuestionnaireModel> listQuestionnaire =
      //     QuestionnaireModel.convertDynamictoListQuestions(
      //         data.data["Data"][0]["ClientData"]);
      await saveCookies(data.cookies!);
      return listQuestionnaire;
    } else {
      return null;
    }
  }

  Future<List<EvaluationEnCoursModel>?> getListEvaluationEnCours() async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,Load_Liste_evaluations_QA_Web,Load_Liste_evaluations_QA_Web",
        "START_DATE": ConvertDateService().parseDate(date: DateTime.now()),
        "END_DATE": ConvertDateService().parseDate(date: DateTime.now().add(Duration(days: 1))),
        "SYSINSTYP_IDF": "1",
        "type": "0",
        "LIEINSPSVRQU_ACTION_SHORT": "0",
        "LIEINSPSVRQU_ACTION_LONG": "0",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print(data.data);
      List<EvaluationEnCoursModel> listEval = EvaluationEnCoursModel.convertDynamictoListEval(data.getElementFromDataList());
      // List<EvaluationEnCoursModel> listEval =
      //     EvaluationEnCoursModel.convertDynamictoListEval(
      //         data.data["Data"][0]["ClientData"]);
      await saveCookies(data.cookies!);
      print(listEval.length);
      return listEval;
    } else {
      return null;
    }
  }

  /////////
  Future<List<QuestionnaireModel>?> getQuestionnaireDependTypeQuickAccess({required TypeQuestionnaireModel typeQuestionnaire}) async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Lieu,LIEU_INSPECT_QUESTNRE_Web,select", "LIEINSQUESTYP_IDF": typeQuestionnaire.LIEINSQUESTYP_IDF, "LIEINSTYP_IDF": "1", "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<QuestionnaireModel> listQuestionnaire = QuestionnaireModel.convertDynamictoListQuestions(data.getElementFromDataList());
      // List<QuestionnaireModel> listQuestionnaire =
      //     QuestionnaireModel.convertDynamictoListQuestions(
      //         data.data["Data"][0]["ClientData"]);
      await saveCookies(data.cookies!);
      return listQuestionnaire;
    } else {
      return null;
    }
  }

  Future<List<SiteQuickAccesModel>?> getSiteQuickAccess() async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Lieu,lieu_int,select", "title": "Lieu", "pagination": "0", "rows": "0", "FieldsToShow": "1", "USR_LANGUE": "fr", "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<SiteQuickAccesModel> listQuestionnaire = SiteQuickAccesModel.convertDynamictoListSites(data.getElementFromDataList());
      // List<SiteQuickAccesModel> listQuestionnaire =
      //     SiteQuickAccesModel.convertDynamictoListSites(
      //         data.data["Data"][0]["ClientData"]);
      await saveCookies(data.cookies!);
      return listQuestionnaire;
    } else {
      return null;
    }
  }

  Future<List<SiteQuickAccesModel>?> getSiteQuickAccessFiltred({required bool isLibre, required bool isPeriodique, required bool isUtilisateur}) async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,lieu_int,load_list_lieu_a_evaluer",
        "rows": "0",
        "page": "1",
        "sidx": "LIE_LIB",
        "sord": "asc",
        "Prefix": "LIE",
        "title": "Lieu",
        "A_Evaluer": isPeriodique ? "true" : "",
        "with_vac": "true",
        "LIBRE": isLibre ? "true" : "",
        "evalues": isPeriodique ? "true" : "",
        "EVAL_USR": isUtilisateur ? "true" : "",
        "TypeGrid": "treeGrid",
        "Count": "0",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<SiteQuickAccesModel> listQuestionnaire = SiteQuickAccesModel.convertDynamictoListSites(data.getElementFromDataList());
      // List<SiteQuickAccesModel> listQuestionnaire =
      //     SiteQuickAccesModel.convertDynamictoListSites(
      //         data.data["Data"][0]["ClientData"]);
      await saveCookies(data.cookies!);
      return listQuestionnaire;
    } else {
      return null;
    }
  }

  //////
  Future<List<SalarieQuickAccessModel>?> getSalariesQuickAccess({required TypeQuestionnaireModel typeQuestionnaire, required QuestionnaireModel questionnaireModel, SiteQuickAccesModel? siteQuickAccesModel, required String type, String? utilisateur_LIE_IDF}) async {
    await initApiData();

    DateTime firstDateMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime lastDateMonth = DateTime(DateTime.now().year, DateTime.now().month + 1, 1).subtract(Duration(days: 1));

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,eval_load_svr_wrk_lieu,eval_load_svr_wrk_lieu",
        "ITEM_IDF": utilisateur_LIE_IDF ?? siteQuickAccesModel?.LIE_IDF ?? "",
        "ITEM_CODE": questionnaireModel.LIEINSQUESTYP_IDF,
        "START_DATE": utilisateur_LIE_IDF != null ? ConvertDateService().parseDate(date: firstDateMonth) : ConvertDateService().parseDateAndTime(date: DateTime.now()),
        // "0${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}",
        "END_DATE": utilisateur_LIE_IDF != null ? ConvertDateService().parseDate(date: lastDateMonth) : ConvertDateService().parseDateAndTime(date: DateTime.now()),
        // "0${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}",
        "EVAL_LIBRE": type == GBSystem_Application_Strings.str_libre
            ? "true"
            : type == GBSystem_Application_Strings.str_utilisateur
            ? "1"
            : "false",
        // "page": "1",
        // "rows": "0",
        "sidx": "SVR_LIB",
        "sord": "asc",
        // "Count": "0",
        // "FieldsToShow": "-1",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print(data.data);
      List<SalarieQuickAccessModel> listSalaries = SalarieQuickAccessModel.convertDynamictoListSalaries(data.getElementFromDataList());
      // List<SalarieQuickAccessModel> listSalaries =
      //     SalarieQuickAccessModel.convertDynamictoListSalaries(
      //         data.data["Data"][0]["ClientData"]);

      //
      // List<SalarieQuickAccessModel> listSalaries =
      //     SalarieQuickAccessModel.convertDynamictoListSalaries(
      //         data.data["Data"][0]["ClientData"]["rows"]);

      await saveCookies(data.cookies!);

      return listSalaries;
    } else {
      return null;
    }
  }

  Future<List<AgenceSalarieQuickAccesModel>?> getAgencesSalariesQuickAccess({required TypeQuestionnaireModel typeQuestionnaire, required QuestionnaireModel questionnaireModel, SiteQuickAccesModel? siteQuickAccesModel, required String type}) async {
    await initApiData();
    print(siteQuickAccesModel?.LIE_IDF);
    print(questionnaireModel.LIEINSPQSNR_IDF);
    ResponseModel data = await AppManageApi(
      context,
    ).post(url: _ActiveUrl, data: {"OKey": "Lieu,LIEINSPQUSR,select", "LIE_IDF": siteQuickAccesModel?.LIE_IDF ?? "", "LIEINSPQSNR_IDF": questionnaireModel.LIEINSPQSNR_IDF, "EVAL": "1", "ETAT": "2", "page": "1", "rows": "200", "sidx": "LIE_LIB", "sord": "asc", "Count": "0", "FieldsToShow": "-1", "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print(data.data);
      List<AgenceSalarieQuickAccesModel> listAgnces = [];
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          listAgnces = AgenceSalarieQuickAccesModel.convertDynamictoListAgences(data.data["Data"][0]["ClientData"]["rows"]);
        }
      }

      await saveCookies(data.cookies!);

      return listAgnces;
    } else {
      return null;
    }
  }

  Future<List<SalarieQuickAccessModel>?> getSalariesQuickAccessUtilisateur({required TypeQuestionnaireModel typeQuestionnaire, required QuestionnaireModel questionnaireModel, SiteQuickAccesModel? siteQuickAccesModel, required String type}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,LIEINSPQUSR,select",
        "LIE_IDF": siteQuickAccesModel?.LIE_IDF ?? "",
        //"LIEINSPQSNR_IDF": questionnaireModel.LIEINSPQSNR_IDF ?? "12",
        "LIEINSPQSNR_IDF": "13",
        "EVAL": "1",
        "ETAT": "2",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<SalarieQuickAccessModel> listSalaries = SalarieQuickAccessModel.convertDynamictoListSalaries(data.getElementFromDataList());
      // List<SalarieQuickAccessModel> listSalaries =
      //     SalarieQuickAccessModel.convertDynamictoListSalaries(
      //         data.data["Data"][0]["ClientData"]);
      await saveCookies(data.cookies!);
      return listSalaries;
    } else {
      return null;
    }
  }

  Future<String?> getPhotoSalarieQuickAccess({required String SVR_IDF}) async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Server_Photo,System_photo,Get_Default_Photo_From_Web", "PREFIX": "SVR", "ENTITY_IDF_NAME": "SVR_IDF", "ENTITY_IDF_VALUE": SVR_IDF, "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      String image = data.getElementFromDataList(elementName: "BinaryData").toString();
      // String image = data.data["Data"][0]["BinaryData"];
      await saveCookies(data.cookies!);
      return image;
    } else {
      return null;
    }
  }

  Future<String?> getPhotoRoot({required int type, required String idf}) async {
    await initApiData();
    // 1 salarie --> SVR , SVR_IDF
    // 2 agence --> DOS , DOS_IDF
    // 3 client --> CLI , CLI_IDF
    // 4 lieu --> LIE , LIE_IDF
    late String prefix, idf_name;
    // init prefix idf_name
    switch (type) {
      case 1:
        prefix = "SVR";
        idf_name = "SVR_IDF";
        break;

      case 2:
        prefix = "DOS";
        idf_name = "DOS_IDF";
        break;
      case 3:
        prefix = "CLI";
        idf_name = "CLI_IDF";
        break;
      case 4:
        prefix = "LIE";
        idf_name = "LIE_IDF";
        break;
      default:
        prefix = "SVR";
        idf_name = "SVR_IDF";
        break;
    }
    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Server_Photo,System_photo,Get_Default_Photo_From_Web", "PREFIX": prefix, "ENTITY_IDF_NAME": idf_name, "ENTITY_IDF_VALUE": idf, "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      String image = data.getElementFromDataList(elementName: "BinaryData").toString();

      // String image = data.data["Data"][0]["BinaryData"];
      await saveCookies(data.cookies!);
      return image;
    } else {
      return null;
    }
  }

  Future<List<QuestionTypeModel>?> getFormulaireQuestionsTypeDataQuickAccess({
    // required SalarieQuickAccessModel salarie,
    required String SVR_IDF,
    required String LIE_IDF,
    required String CLI_IDF,
    required String LIEINSPQSNR_IDF,
    String? LIEINSPSVR_IDF,
    bool setEvaluation = false,
  }) async {
    Position? currentPosition;
    await initApiData();

    try {
      currentPosition = await LocationService().determinePosition();
    } catch (e) {
      GBSystem_Add_LogEvent(message: e.toString(), method: "getFormulaireQuestionsTypeDataQuickAccess", page: "GBSystem_auth_service");
    }

    // final evaluationController = Get.put<GBSystemEvaluationSurSiteController>(
    //     GBSystemEvaluationSurSiteController());
    final evaluationController = Get.put<EvaluationController>(EvaluationController());
    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,load_lieu_evaluation_for_server,load_lieu_evaluation_for_server",
        "SVR_IDF": SVR_IDF, // salarie.SVR_IDF,
        "LIE_IDF": LIE_IDF, //salarie.LIE_IDF,
        "CLI_IDF": CLI_IDF, // salarie.CLI_IDF,
        "START_DATE": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "END_DATE": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "LIEINSPSVR_IDF": LIEINSPSVR_IDF ?? "",
        "SYSINSTYP_IDF": "1",
        "LIEINSPQSNR_IDF": LIEINSPQSNR_IDF,
        // evaluationController.getSelectedQuestionnaire?.LIEINSPQSNR_IDF ??
        //     "1",
        "USER_IDF": "",
        "LIEINSPSVR_LATITUDE": currentPosition?.latitude.toString().replaceAll(".", ",") ?? "36,077568",
        "LIEINSPSVR_LONGITUDE": currentPosition?.longitude.toString().replaceAll(".", ",") ?? "4,7415296",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print("datataa  :: ${data.data}");
      List<QuestionTypeModel> listQustType = [];

      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          listQustType = QuestionTypeModel.convertDynamictoListQuestionsType(data.data["Data"][i]["ClientData"]);
        }
        if (setEvaluation) {
          if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["EvaluationStat"] != null && (data.data["Data"][i]["EvaluationStat"] as List).isNotEmpty) {
            EvaluationModel evaluationModel = EvaluationModel.fromJson(data.data["Data"][i]["EvaluationStat"][0]);
            evaluationController.setCuurentEvaluationView = evaluationModel;
          }
        }
      }
      await saveCookies(data.cookies!);
      return listQustType;
    } else {
      return null;
    }
  }

  Future<List<QuestionModel>?> getFormulaireQuestionDataQuickAccess({required QuestionTypeModel questionTypeModel}) async {
    await initApiData();
    final evaluationController = Get.put<GBSystemEvaluationSurSiteController>(GBSystemEvaluationSurSiteController());
    final GBSystemMemoQuestionController memoQuestionController = Get.put(GBSystemMemoQuestionController());

    ResponseModel data = await AppManageApi(
      context,
    ).post(url: _ActiveUrl, data: {"OKey": "Lieu,Get_Eval_For_Server_By_Categories,Get_Eval_For_Server_By_Categories", "LIEINSPCAT_IDF": questionTypeModel.LIEINSPCAT_IDF, "LIEINSPSVR_IDF": questionTypeModel.LIEINSPSVR_IDF, "LIEINSPQSNR_IDF": evaluationController.getSelectedQuestionnaire?.LIEINSPQSNR_IDF ?? "1", "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print("data question : ${data.data}");
      List<QuestionModel>? questionnaireModel = [];
      List<QuestionWithoutMemoModel> questionnaireWithoutMemoModel = [];
      List<MemoQuestionModel> listMemo = [];

      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          questionnaireWithoutMemoModel = QuestionWithoutMemoModel.convertDynamictoListQuestionsWithoutMemo(data.data["Data"][i]["ClientData"]);
        }
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["LIEINSQMMO"] != null) {
          listMemo = MemoQuestionModel.convertDynamictoListMemo(data.data["Data"][i]["LIEINSQMMO"]);

          memoQuestionController.addListMemo = listMemo;
          // memoQuestionController.setIsFirstLoad = false;
        }
      }
      print("lissttt memo :${listMemo.length}");
      questionnaireWithoutMemoModel.forEach((element) {
        print("-----------------------");
        print("type affichage note : ${element.LIEINSPQU_NOTATION_TYPE}");
        print("note : ${element.LIEINSPSVRQU_NOTE}");
        print("deferer : ${element.LIEINSPSVRQU_ACTION_LONG}");
        print("immediate : ${element.LIEINSPSVRQU_ACTION_SHORT}");
        print("memo : ${element.LIEINSPSVRQU_MEMO}");
        print("date : ${element.LIEINSPSVRQU_ALONG_DATE}");
        print("-----------------------");

        questionnaireModel.add(QuestionModel(LIEINSQMMO: listMemo, questionWithoutMemoModel: element, nombreImages: 0));
      });
      await saveCookies(data.cookies!);
      return questionnaireModel;
    } else {
      return null;
    }
  }

  Future<List<MemoQuestionModel>?> getListMemo({required QuestionTypeModel questionTypeModel}) async {
    await initApiData();
    final evaluationController = Get.put<GBSystemEvaluationSurSiteController>(GBSystemEvaluationSurSiteController());

    ResponseModel data = await AppManageApi(
      context,
    ).post(url: _ActiveUrl, data: {"OKey": "Lieu,Get_Eval_For_Server_By_Categories,Get_Eval_For_Server_By_Categories", "LIEINSPCAT_IDF": questionTypeModel.LIEINSPCAT_IDF, "LIEINSPSVR_IDF": questionTypeModel.LIEINSPSVR_IDF, "LIEINSPQSNR_IDF": evaluationController.getSelectedQuestionnaire?.LIEINSPQSNR_IDF ?? "3", "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<MemoQuestionModel> listMemo = [];
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["LIEINSQMMO"] != null) {
          listMemo = MemoQuestionModel.convertDynamictoListMemo(data.data["Data"][i]["LIEINSQMMO"]);
        }
      }

      await saveCookies(data.cookies!);
      return listMemo;
    } else {
      return null;
    }
  }

  Future<List<ImageEvaluationNonTerminerModel>?> getListImagesQuestion({required QuestionModel questionModel}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Server_Photo,,Get_Photo_From_Web", "PREFIX": 'LIEINSPSVRQU', "ENTITY_IDF_NAME": "LIEINSPSVRQU_IDF", "ENTITY_IDF_VALUE": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_IDF, "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print(data.data);
      List<ImageEvaluationNonTerminerModel> listMemo = [];
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          listMemo = ImageEvaluationNonTerminerModel.convertDynamictoListImages(data.data["Data"][i]["ClientData"]);
        }
      }

      await saveCookies(data.cookies!);
      return listMemo;
    } else {
      return null;
    }
  }

  Future<ImageTypeTwoWithModel?> getImageDataForEvalNonTerminer({required ImageEvaluationNonTerminerModel image}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Server_Photo,System_photo,Get_Photo_From_Web", "PREFIX": 'LIEINSPSVRQU', "IMAGE_IDF": image.IMAGE_IDF, "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print(data.data);
      String? imageData;
      ImageTypeTwoModel? image;
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["BinaryData"] != null) {
          imageData = data.data["Data"][i]["BinaryData"];
        }
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null && (data.data["Data"][i]["ClientData"] as List).isNotEmpty) {
          image = ImageTypeTwoModel.fromJson((data.data["Data"][i]["ClientData"] as List).first);
        }
      }

      await saveCookies(data.cookies!);
      if (image != null && imageData != null) {
        return ImageTypeTwoWithModel(fileImage: imageData, imageModel: image);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<List<ReponseQCMModel>?> getQCMQuestionReponsesDataQuickAccess({required QuestionModel questionModel}) async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Lieu,Lieu,Get_SVR_Qust_QCM_Resp", "LIEINSPSVRQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_IDF, "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<ReponseQCMModel> reponsesList = ReponseQCMModel.convertDynamictoListReponseQCM(data.getElementFromDataList());
      // List<ReponseQCMModel> reponsesList =
      //     ReponseQCMModel.convertDynamictoListReponseQCM(
      //         data.data["Data"][0]["ClientData"]);
      await saveCookies(data.cookies!);
      return reponsesList;
    } else {
      return null;
    }
  }

  Future<EvaluationModel?> checkQCMQuickAccess({required QuestionModel questionModel, required bool checkBool}) async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,valide_eval_server_sur_lieu,valide_eval_server_sur_lieu",
        "LIEINSPSVRQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_IDF,
        "LIEINSPSVRQU_UIDF": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_UIDF,
        "LIEINSPSVRQU_MEMO": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_MEMO ?? "",
        "LIEINSPSVR_IDF": questionModel.questionWithoutMemoModel.LIEINSPSVR_IDF,
        "LIEINSPQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPQU_IDF,
        "LIEINSPSVRQU_STATUT": checkBool == false ? "0" : "1",
        "LIEINSPSVRQUQCMRESP_IDF": "",
        "SELECTION_STATE": "",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      EvaluationModel evaluationModel = EvaluationModel.fromJson(data.getFirstElementFromDataList());

      // EvaluationModel evaluationModel =
      //     EvaluationModel.fromJson(data.data["Data"][0]["ClientData"][0]);
      await saveCookies(data.cookies!);
      return evaluationModel;
    } else {
      return null;
    }
  }

  Future<String?> getQCM_LIEINSPQU_MAX({required QuestionModel questionModel}) async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Lieu,Lieu,Get_Quest_MAX_Resp", "LIEINSPSVRQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_IDF, "Wid": _Wid!}, cookies: _Cookies);
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      String LIEINSPQU_MAX = data.getFirstElementFromDataList()["LIEINSPQU_MAX"];

      // String LIEINSPQU_MAX =
      //     data.data["Data"][0]["ClientData"][0]["LIEINSPQU_MAX"];
      await saveCookies(data.cookies!);
      return LIEINSPQU_MAX;
    } else {
      return null;
    }
  }

  Future<EvaluationModel?> sendReponseQCMQuickAccess({required QuestionModel questionModel, required ReponseQCMModel reponseQCMModel}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,valide_eval_server_sur_lieu,valide_eval_server_sur_lieu",
        "LIEINSPSVRQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_IDF,
        "LIEINSPSVRQU_UIDF": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_UIDF,
        "LIEINSPSVRQU_MEMO": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_MEMO ?? "",
        "LIEINSPSVR_IDF": questionModel.questionWithoutMemoModel.LIEINSPSVR_IDF,
        "LIEINSPQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPQU_IDF,
        "LIEINSPSVRQU_NOTE": reponseQCMModel.LIEINSPQCMRES_VALUE,
        "LIEINSPSVRQUQCMRESP_IDF": reponseQCMModel.LIEINSPSVRQUQCMRESP_IDF,
        "SELECTION_STATE": reponseQCMModel.SELECTION_STATE,
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      EvaluationModel evaluationModel = EvaluationModel.fromJson(data.getFirstElementFromDataList());

      // EvaluationModel evaluationModel =
      //     EvaluationModel.fromJson(data.data["Data"][0]["ClientData"][0]);
      await saveCookies(data.cookies!);
      return evaluationModel;
    } else {
      return null;
    }
  }

  Future<EvaluationModel?> sendReponseQustionsNonApplicableBool({required QuestionModel questionModel, required bool nonApplicableBool}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,valide_eval_server_sur_lieu,valide_eval_server_sur_lieu",
        "LIEINSPSVRQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_IDF,
        "LIEINSPSVRQU_UIDF": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_UIDF,
        "LIEINSPSVRQU_MEMO": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_MEMO ?? "",
        "LIEINSPSVR_IDF": questionModel.questionWithoutMemoModel.LIEINSPSVR_IDF,
        "LIEINSPQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPQU_IDF,
        "LIEINSPSVRQU_STATUT": nonApplicableBool ? "0" : "1",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      EvaluationModel evaluationModel = EvaluationModel.fromJson(data.getFirstElementFromDataList());

      // EvaluationModel evaluationModel =
      //     EvaluationModel.fromJson(data.data["Data"][0]["ClientData"][0]);
      await saveCookies(data.cookies!);
      return evaluationModel;
    } else {
      return null;
    }
  }

  Future<EvaluationModel?> sendReponseQustionsNote({required QuestionModel questionModel, required int note}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,valide_eval_server_sur_lieu,valide_eval_server_sur_lieu",
        "LIEINSPSVRQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_IDF,
        // "LIEINSPSVRQU_UIDF":
        //     questionModel.questionWithoutMemoModel.LIEINSPSVRQU_UIDF,
        // "LIEINSPSVRQU_MEMO": "",
        // "LIEINSPSVR_IDF":
        //     questionModel.questionWithoutMemoModel.LIEINSPSVR_IDF,
        // "LIEINSPQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPQU_IDF,
        "LIEINSPSVRQU_NOTE": note.toString(),
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      EvaluationModel evaluationModel = EvaluationModel.fromJson(data.getFirstElementFromDataList());
      // EvaluationModel evaluationModel =
      //     EvaluationModel.fromJson(data.data["Data"][0]["ClientData"][0]);
      await saveCookies(data.cookies!);
      return evaluationModel;
    } else {
      return null;
    }
  }

  Future<EvaluationModel?> sendReponseQustionsDiffererBool({required QuestionModel questionModel, required bool defererBool}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,valide_eval_server_sur_lieu,valide_eval_server_sur_lieu",
        "LIEINSPSVRQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_IDF,
        // "LIEINSPSVRQU_UIDF":
        //     questionModel.questionWithoutMemoModel.LIEINSPSVRQU_UIDF,
        // "LIEINSPSVRQU_MEMO":
        //     questionModel.questionWithoutMemoModel.LIEINSPSVRQU_MEMO ?? "",
        // "LIEINSPSVR_IDF":
        //     questionModel.questionWithoutMemoModel.LIEINSPSVR_IDF,
        // "LIEINSPQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPQU_IDF,
        // // "LIEINSPSVRQU_ACTION_LONG":
        // //    "1",
        "LIEINSPSVRQU_ACTION_LONG": defererBool ? "1" : "0",
        // "LIEINSPSVRQU_ACTION_SHORT": defererBool ? "1" : "0",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      EvaluationModel evaluationModel = EvaluationModel.fromJson(data.getFirstElementFromDataList());
      // EvaluationModel evaluationModel =
      //     EvaluationModel.fromJson(data.data["Data"][0]["ClientData"][0]);
      await saveCookies(data.cookies!);
      return evaluationModel;
    } else {
      return null;
    }
  }

  Future<EvaluationModel?> sendReponseQustionsImmediateBool({required QuestionModel questionModel, required bool immdiateBool}) async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,valide_eval_server_sur_lieu,valide_eval_server_sur_lieu",
        "LIEINSPSVRQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_IDF,
        // "LIEINSPSVRQU_UIDF":
        //     questionModel.questionWithoutMemoModel.LIEINSPSVRQU_UIDF,
        // "LIEINSPSVRQU_MEMO":
        //     questionModel.questionWithoutMemoModel.LIEINSPSVRQU_MEMO ?? "",
        // "LIEINSPSVR_IDF":
        //     questionModel.questionWithoutMemoModel.LIEINSPSVR_IDF,
        // "LIEINSPQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPQU_IDF,
        // "LIEINSPSVRQU_ACTION_LONG": immdiateBool ? "1" : "0",
        "LIEINSPSVRQU_ACTION_SHORT": immdiateBool ? "1" : "0",
        // "LIEINSPSVRQU_ACTION_SHORT": "0",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      EvaluationModel evaluationModel = EvaluationModel.fromJson(data.getFirstElementFromDataList());
      // EvaluationModel evaluationModel =
      //     EvaluationModel.fromJson(data.data["Data"][0]["ClientData"][0]);
      await saveCookies(data.cookies!);
      return evaluationModel;
    } else {
      return null;
    }
  }

  Future<EvaluationModel?> sendReponseQustionsCommentaire({required QuestionModel questionModel, required String commentaire}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,valide_eval_server_sur_lieu,valide_eval_server_sur_lieu",
        "LIEINSPSVRQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_IDF,
        // "LIEINSPSVRQU_UIDF":
        //     questionModel.questionWithoutMemoModel.LIEINSPSVRQU_UIDF,
        "LIEINSPSVRQU_MEMO": commentaire,
        // "LIEINSPSVR_IDF":
        //     questionModel.questionWithoutMemoModel.LIEINSPSVR_IDF,
        // "LIEINSPQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPQU_IDF,
        // "LIEINSPSVRQU_ACTION_LONG":
        //     questionModel.questionWithoutMemoModel.LIEINSPSVRQU_ACTION_LONG ??
        //         "1",
        // "LIEINSPSVRQU_ACTION_SHORT": questionModel
        //         .questionWithoutMemoModel.LIEINSPSVRQU_ACTION_SHORT ??
        //     "0",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      EvaluationModel evaluationModel = EvaluationModel.fromJson(data.getFirstElementFromDataList());
      // EvaluationModel evaluationModel =
      //     EvaluationModel.fromJson(data.data["Data"][0]["ClientData"][0]);
      updateEvaluation(evaluationModel);

      await saveCookies(data.cookies!);
      return evaluationModel;
    } else {
      return null;
    }
  }

  Future<EvaluationModel?> sendReponseQustionsDate({required QuestionModel questionModel, required DateTime date}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,valide_eval_server_sur_lieu,valide_eval_server_sur_lieu",
        "LIEINSPSVRQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_IDF,
        // "LIEINSPSVRQU_UIDF":
        //     questionModel.questionWithoutMemoModel.LIEINSPSVRQU_UIDF,
        // "LIEINSPSVR_IDF":
        //     questionModel.questionWithoutMemoModel.LIEINSPSVR_IDF,
        // "LIEINSPQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPQU_IDF,
        "LIEINSPSVRQU_ALONG_DATE": "${date.day}/${date.month}/${date.year}",
        // "LIEINSPSVRQU_ACTION_LONG":
        //     questionModel.questionWithoutMemoModel.LIEINSPSVRQU_ACTION_LONG ??
        //         "1",
        // "LIEINSPSVRQU_ACTION_SHORT": questionModel
        //         .questionWithoutMemoModel.LIEINSPSVRQU_ACTION_SHORT ??
        //     "0",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      EvaluationModel evaluationModel = EvaluationModel.fromJson(data.getFirstElementFromDataList());

      // EvaluationModel evaluationModel =
      //     EvaluationModel.fromJson(data.data["Data"][0]["ClientData"][0]);
      updateEvaluation(evaluationModel);

      await saveCookies(data.cookies!);
      return evaluationModel;
    } else {
      return null;
    }
  }

  Future<List<ImageModel>?> sendReponseImage({required QuestionModel questionModel, required String imageBytes, required String imageType, required String imageVign}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Server_Photo,,insert",
        "PREFIX": "LIEINSPSVRQU",
        "IMAGE_VIGN": imageBytes,
        // imageVign,
        "IMAGE_PHOTO": imageBytes,
        "IMAGE_TYPE": imageType,
        "LIEINSPSVRQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_IDF,
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      // List<dynamic>? sitesDynamic = data.data["Data"][0]["ClientData"] as List;
      // List<SitePlanningModel> listSites = [];

      // for (var i = 0; i < sitesDynamic.length; i++) {
      //   listSites.add(SitePlanningModel.fromJson(sitesDynamic[i]));
      // }

      List<ImageModel> imageList = ImageModel.convertDynamictoListImages(data.getElementFromDataList(elementName: "Reconcile"));

      // List<ImageModel> imageList = ImageModel.convertDynamictoListImages(
      //     data.data["Data"][0]["Reconcile"]);

      print("image adddded : ${data.data["Data"][0]["Reconcile"]}");
      //  image adddded : [{Image_UIDF: {16DFE4E4-1585-441C-A83A-6CB145C583B5}, Image_IDF: 17208, LIEINSPSVRQU_IDF: 159026,
      //   Image_DESCRIPTION: , LAST_UPDT: 09/10/2024 16:53:00.000, USER_IDF: 3689, Image_DEFAULT: , USR_LIB: yaakoub}]
      await saveCookies(data.cookies!);
      return imageList;
    } else {
      return null;
    }
  }

  Future<List<ImageModel>?> sendReponseDeleteImage({required QuestionModel questionModel, required ImageModel imageModel}) async {
    await initApiData();
    print("delete imageeee: idf ${imageModel.Image_IDF} ,USER_IDF ${questionModel.questionWithoutMemoModel.SVR_IDF} ");

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Server_Photo,,delete",
        "IMAGE_IDF": imageModel.Image_IDF,
        "USER_IDF": questionModel.questionWithoutMemoModel.SVR_IDF,
        "LAST_UPDT": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}",
        "PREFIX": "LIEINSPSVRQU",
        "LIEINSPSVRQU_IDF": questionModel.questionWithoutMemoModel.LIEINSPSVRQU_IDF,
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );
    print("dalaaata delete :${data.data}");
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      // List<ImageModel> imageList = ImageModel.convertDynamictoListImages(
      //     data.data["Data"][0]["Reconcile"]);
      List<ImageModel> imageList = ImageModel.convertDynamictoListImages(data.getElementFromDataList(elementName: "Reconcile"));

      await saveCookies(data.cookies!);
      return imageList;
    } else {
      return null;
    }
  }

  Future<String?> sendReponseSignature({required String? LIEINSPSVR_IDF, required String imageBytes, required String? commentaire}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Lieu,Set_Server_Signature_Eval,Set_Server_Signature_Eval", "LIEINSPSVR_IDF": LIEINSPSVR_IDF ?? "12066", "LIEINSPSVR_SIGNATURE": imageBytes, "LIEINSPSVR_MEMO": commentaire ?? "", "Wid": _Wid!}, cookies: _Cookies);
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      String signatureImage = data.getElementFromDataList(elementName: "ServerSignature");

      // String signatureImage = data.data["Data"][0]["ServerSignature"];
      await saveCookies(data.cookies!);
      return signatureImage;
    } else {
      return null;
    }
  }

  Future<GbsystemReponseClotureModel?> sendReponseCloseEvaluation({required String LIEINSPSVR_IDF}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Lieu,CloseEval,CloseEval", "LIEINSPSVR_IDF": LIEINSPSVR_IDF, "Wid": _Wid!}, cookies: _Cookies);
    print('"  "OKey": "Lieu,CloseEval,CloseEval","LIEINSPSVR_IDF": ${LIEINSPSVR_IDF},"Wid": ${_Wid}!"');
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      GbsystemReponseClotureModel? reponseClotureModel;
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null && (data.data["Data"][i]["ClientData"] as List).isNotEmpty) {
          reponseClotureModel = GbsystemReponseClotureModel.fromJson((data.data["Data"][i]["ClientData"] as List).first);
        }
      }
      await saveCookies(data.cookies!);
      return reponseClotureModel;
    } else {
      return null;
    }
  }

  void updateEvaluation(EvaluationModel newEvaluation) {
    final evaluationController = Get.put<EvaluationController>(EvaluationController());
    evaluationController.setCuurentEvaluation = newEvaluation;
  }

  Future<bool> ManageCatchErrorsServer({required String page, required String functionName, required String msg}) async {
    await initApiData();

    ResponseModel responseServer = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "39A5552F5E2B49F8959D3CA7468D2D67", "sender": page, "functionName": functionName, "msg": msg, "LOG_SERVER": "1", "Wid": _Wid ?? ""}, cookies: _Cookies);
    if ((responseServer.data["Data"] as List).isEmpty && (responseServer.data["Errors"] as List).isEmpty) {
      await saveCookies(responseServer.cookies!);

      return true;
    } else {
      return false;
    }
  }

  Future<List<SiteGestionStockModel>?> getAllSiteGestionStock() async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "mobile_application,UserDossier_List,UserDossier_List", "Wid": _Wid!}, cookies: _Cookies);
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print(data.data);
      List<dynamic> siteDynamic = data.getElementFromDataList() as List;

      // List<dynamic> siteDynamic = data.data["Data"][0]["ClientData"] as List;
      List<SiteGestionStockModel> listsite = [];

      for (var i = 0; i < siteDynamic.length; i++) {
        listsite.add(SiteGestionStockModel.fromJson(siteDynamic[i]));
      }
      await saveCookies(data.cookies!);
      return listsite;
    } else {
      return null;
    }
  }

  Future<List<SalarieGestionStockModel>?> getAllSalarieGestionStock({required SiteGestionStockModel site}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "mobile_application,DossierServer_List,DossierServer_List", "ITEM_IDF": site.DOS_IDF ?? "", "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print(data.data);
      List<dynamic> salarieDynamic = data.getElementFromDataList() as List;

      // List<dynamic> salarieDynamic = data.data["Data"][0]["ClientData"] as List;

      List<SalarieGestionStockModel> listsalarie = [];

      for (var i = 0; i < salarieDynamic.length; i++) {
        listsalarie.add(SalarieGestionStockModel.fromJson(salarieDynamic[i]));
      }
      await saveCookies(data.cookies!);
      return listsalarie;
    } else {
      return null;
    }
  }

  Future<List<SalarieGestionStockModel>?> getAllSalarieGestionStockWith_DOS_IDF({required String DOS_IDF}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "mobile_application,DossierServer_List,DossierServer_List", "ITEM_IDF": DOS_IDF, "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print(data.data);
      List<dynamic> salarieDynamic = data.getElementFromDataList() as List;

      // List<dynamic> salarieDynamic = data.data["Data"][0]["ClientData"] as List;

      List<SalarieGestionStockModel> listsalarie = [];

      for (var i = 0; i < salarieDynamic.length; i++) {
        listsalarie.add(SalarieGestionStockModel.fromJson(salarieDynamic[i]));
      }
      await saveCookies(data.cookies!);
      return listsalarie;
    } else {
      return null;
    }
  }

  Future<ArticleAndDataSetModel?> getAllArticlesSalarieGestionStock({required SalarieGestionStockModel salarie, required SiteGestionStockModel site}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "mobile_application,ServerArticle,ServerArticle", "ITEM_IDF": salarie.SVR_IDF, "ITEM_CODE": site.DOS_IDF ?? "", "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      SalarieDataSetGestionStockModel? salarieDataSetModel;
      List<ArticleSalarieGestionStockModel> listArticles = [];

      print(data.data);
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          listArticles = ArticleSalarieGestionStockModel.convertDynamictoListArticlesSalarie(data.data["Data"][i]["ClientData"]);
        }
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ServerInfo_DataSet"] != null) {
          salarieDataSetModel = SalarieDataSetGestionStockModel.fromJson(data.data["Data"][i]["ServerInfo_DataSet"][0]);
        }
      }

      await saveCookies(data.cookies!);
      return ArticleAndDataSetModel(listArticles: listArticles, salarieDataSetModel: salarieDataSetModel!);
    } else {
      return null;
    }
  }

  Future<dynamic> getAllArticlesGestionStock() async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "mobile_application,Select_Entite,ARTREF", "Wid": _Wid!}, cookies: _Cookies);
    print(data.data);
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      // SalarieDataSetGestionStockModel? salarieDataSetModel;
      // List<dynamic> listArticles = [];
      // print(data.data);
      // for (var i = 0; i < (data.data["Data"] as List).length; i++) {
      //   if (data.data["Data"][i] != null &&
      //       data.data["Data"][i] is Map &&
      //       data.data["Data"][i]["ClientData"] != null) {
      //     listArticles = data.data["Data"][i]["ClientData"] as List;
      //   }
      //   if (data.data["Data"][i] != null &&
      //       data.data["Data"][i] is Map &&
      //       data.data["Data"][i]["ServerInfo_DataSet"] != null) {
      //     salarieDataSetModel = SalarieDataSetGestionStockModel.fromJson(
      //         data.data["Data"][i]["ServerInfo_DataSet"][0]);
      //   }
      // }

      await saveCookies(data.cookies!);
      // return ArticleAndDataSetModel(
      //     listArticles: listArticles,
      //     salarieDataSetModel: salarieDataSetModel!);
    } else {
      return null;
    }
  }

  Future<GbsystemArticleGestionStockModel?> affectuerArticleByTag({required SalarieGestionStockModel salarie, required SiteGestionStockModel site, required String tag}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "mobile_application,AffectArticle,AffectArticle", "ITEM_IDF": salarie.SVR_IDF, "ITEM_CODE": site.DOS_IDF ?? "", "ITEM_LIB": tag, "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print(data.data);

      List<GbsystemArticleGestionStockModel> listArticles = [];
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ArticlesRef_Ds"] != null) {
          listArticles = GbsystemArticleGestionStockModel.convertDynamictoListArticles(data.data["Data"][i]["ArticlesRef_Ds"]);
        }
      }

      await saveCookies(data.cookies!);

      if (listArticles.isNotEmpty) {
        return listArticles.first;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<GbsystemArticleRefModel?> getArticleByTag({required String? tagType, required String tag}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "mobile_application,READ_ARTREF_INFO_TAG,READ_ARTREF_INFO_TAG",
        "TAG_CODE": tag,
        // "TAG_TYPE": tagType ?? "3",
        "Wid": _Wid!,
      },
      //TAG_CODE  == >  ARTREF-${ARTREF_IDF]
      //TAG_TYPE   1:NFC,2:QRCode,3:CodeBarre
      cookies: _Cookies,
    );

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print("dataserver art ref : ${data.data}");

      List<GbsystemArticleRefModel> listArticles = [];
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          listArticles = GbsystemArticleRefModel.convertDynamictoListArticles(data.data["Data"][i]["ClientData"]);
        }
      }

      await saveCookies(data.cookies!);

      if (listArticles.isNotEmpty) {
        return listArticles.first;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<List<ArticleSalarieGestionStockModel>?> affectuerArticle({required SalarieGestionStockModel salarie, required SiteGestionStockModel site, required GbsystemArticleGestionStockModel article}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(
      context,
    ).post(url: _ActiveUrl, data: {"OKey": "mobile_application,AffectArticle,AffectArticle", "ITEM_IDF": salarie.SVR_IDF, "ITEM_CODE": site.DOS_IDF ?? "", "ITEM_LIB": article.ARTFOUREF_IDF, "START_DATE": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}", "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print(data.data);

      List<ArticleSalarieGestionStockModel> listArticlesSalarie = [];
      print(data.data);
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          listArticlesSalarie = ArticleSalarieGestionStockModel.convertDynamictoListArticlesSalarie(data.data["Data"][i]["ClientData"]);
        }
      }

      await saveCookies(data.cookies!);
      return listArticlesSalarie;
    } else {
      return null;
    }
  }

  Future<List<ArticleSalarieGestionStockModel>?> retourArticle({required SalarieGestionStockModel salarie, required SiteGestionStockModel site, required ArticleSalarieGestionStockModel article}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "mobile_application,Retour_Stock,Retour_Stock", "ITEM_IDF": salarie.SVR_IDF, "ITEM_CODE": article.ART_IDF, "ITEM_LIB": site.DOS_IDF ?? "", "START_DATE": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}", "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print(data.data);

      List<ArticleSalarieGestionStockModel> listArticlesSalarie = [];
      print(data.data);
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          listArticlesSalarie = ArticleSalarieGestionStockModel.convertDynamictoListArticlesSalarie(data.data["Data"][i]["ClientData"]);
        }
      }

      await saveCookies(data.cookies!);
      return listArticlesSalarie;
    } else {
      return null;
    }
  }

  Future<List<QuestionnaireModel>?> getQuestionnaireCauserie({required DateTime dateDebut}) async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Lieu,LIEU_INSPECT_QUESTNRE_Web,select", "FLIEINSTYP_IDF": "5", "Prefix": "LIEINSPQSNR", "sidx": "LIEINSPQSNR_CODE", "eval_select": "true", "START_DATE": "${dateDebut.day}/${dateDebut.month}/${dateDebut.year}", "Wid": _Wid!}, cookies: _Cookies);
    print(dateDebut);
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print(data.data);
      print("questionnaire length : ${data.data}");
      List<QuestionnaireModel> listQuestionnaire = QuestionnaireModel.convertDynamictoListQuestions(data.getElementFromDataList());
      // List<QuestionnaireModel> listQuestionnaire =
      //     QuestionnaireModel.convertDynamictoListQuestions(
      //         data.data["Data"][0]["ClientData"]);

      await saveCookies(data.cookies!);
      return listQuestionnaire;
    } else {
      return null;
    }
  }

  Future<List<SalarieCuaserieModel>?> getSalariesQuickAccessCauserie({required SiteQuickAccesModel site, required QuestionnaireModel questionnaire}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Lieu,load_servers_for_eval,load_servers_for_eval", "LIE_IDF": site.LIE_IDF, "LIEINSPQSNR_IDF": questionnaire.LIEINSPQSNR_IDF, "page": "1", "rows": "10", "sidx": "SVR_LIB", "sord": "asc", "Count": "0", "FieldsToShow": "-1", "Wid": _Wid!}, cookies: _Cookies);
    print(' "OKey": "Lieu,load_servers_for_eval,load_servers_for_eval","LIE_IDF": ${site.LIE_IDF},"LIEINSPQSNR_IDF": ${questionnaire.LIEINSPQSNR_IDF},"sidx": "SVR_LIB","Wid": _Wid!');
    print("datataa  :: ${data.data}");
    if ((data.data["Data"] as List).isNotEmpty) {
      List<SalarieCuaserieModel> listSalaries = [];

      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["list_salaries"] != null) {
          listSalaries = SalarieCuaserieModel.convertDynamictoListSalariesDataSet(data.data["Data"][i]["list_salaries"]["rows"]);
        }
      }
      await saveCookies(data.cookies!);
      return listSalaries;
    } else {
      return null;
    }
  }

  Future<String?> getPhotoSalarieCauserie({required String salarieCauserieModel_SVR_IDF}) async {
    await initApiData();
    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Server_Photo,System_photo,Get_Default_Photo_From_Web", "PREFIX": "SVR", "ENTITY_IDF_NAME": "SVR_IDF", "ENTITY_IDF_VALUE": salarieCauserieModel_SVR_IDF, "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      String image = data.getElementFromDataList(elementName: "BinaryData");

      // String image = data.data["Data"][0]["BinaryData"];
      await saveCookies(data.cookies!);
      return image;
    } else {
      return null;
    }
  }

  Future<List<QuestionTypeModel>?> getAllQuestionTypeCauserie({required String site_LIE_IDF, required String questionnaire_LIEINSPQSNR_IDF, bool detectLocation = true}) async {
    Position? currentPosition;
    await initApiData();
    if (detectLocation) {
      try {
        currentPosition = await LocationService().determinePosition();
      } catch (e) {
        GBSystem_Add_LogEvent(message: e.toString(), method: "getAllQuestionTypeCauserie", page: "GBSystem_auth_service");
      }
    }

    final evaluationController = Get.put<EvaluationController>(EvaluationController());

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,load_lieu_evaluation_for_server,load_lieu_evaluation_for_server",
        "LIE_IDF": site_LIE_IDF,
        "START_DATE": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "END_DATE": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "LIEINSPSVR_IDF": "",
        "SYSINSTYP_IDF": "5",
        "LIEINSPQSNR_IDF": questionnaire_LIEINSPQSNR_IDF,
        "LIEINSPSVR_LATITUDE": currentPosition?.latitude.toString().replaceAll(".", ",") ?? "0",
        "LIEINSPSVR_LONGITUDE": currentPosition?.longitude.toString().replaceAll(".", ",") ?? "0",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print("datataa  :: ${data.data}");
      print("qst type length : ${data.data}");
      List<QuestionTypeModel> listQustType = [];

      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          listQustType = QuestionTypeModel.convertDynamictoListQuestionsType(data.data["Data"][i]["ClientData"]);
        }
        //change evaluation cordonner
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["EvaluationStat"] != null) {
          EvaluationModel newEval = EvaluationModel.fromJson(data.data["Data"][i]["EvaluationStat"][0]);
          evaluationController.setCuurentEvaluation = newEval;
        }
      }
      await saveCookies(data.cookies!);
      return listQustType;
    } else {
      return null;
    }
  }

  Future<List<QuestionModel>?> getAllQuestionsOfQuestionTypeCauserie({required QuestionnaireModel questionnaire, required QuestionTypeModel questionType}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Lieu,Get_Eval_For_Server_By_Categories,Get_Eval_For_Server_By_Categories", "LIEINSPCAT_IDF": questionType.LIEINSPCAT_IDF, "LIEINSPSVR_IDF": questionType.LIEINSPSVR_IDF, "LIEINSPQSNR_IDF": questionnaire.LIEINSPQSNR_IDF, "Wid": _Wid!}, cookies: _Cookies);
    print("datataa  :: ${data.data}");
    print("qst of qst type length : ${data.data}");
    if ((data.data["Data"] as List).isNotEmpty) {
      List<QuestionModel>? questionnaireModel = [];
      List<QuestionWithoutMemoModel> questionnaireWithoutMemoModel = [];
      List<MemoQuestionModel> listMemo = [];

      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          questionnaireWithoutMemoModel = QuestionWithoutMemoModel.convertDynamictoListQuestionsWithoutMemo(data.data["Data"][i]["ClientData"]);
        }
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["LIEINSQMMO"] != null) {
          listMemo = MemoQuestionModel.convertDynamictoListMemo(data.data["Data"][i]["LIEINSQMMO"]);
        }
      }

      questionnaireWithoutMemoModel.forEach((element) {
        print("-----------------------");
        print("type affichage note : ${element.LIEINSPQU_NOTATION_TYPE}");
        print("note : ${element.LIEINSPSVRQU_NOTE}");
        print("deferer : ${element.LIEINSPSVRQU_ACTION_LONG}");
        print("immediate : ${element.LIEINSPSVRQU_ACTION_SHORT}");
        print("memo : ${element.LIEINSPSVRQU_MEMO}");
        print("date : ${element.LIEINSPSVRQU_ALONG_DATE}");
        print("-----------------------");

        questionnaireModel.add(QuestionModel(LIEINSQMMO: listMemo, questionWithoutMemoModel: element, nombreImages: 0));
      });
      await saveCookies(data.cookies!);
      return questionnaireModel;
    } else {
      return null;
    }
  }

  Future<List<SalarieFormulaireCuaserieModel>?> getListSalariesFormulaireCauserie({required String? site_LIE_IDF, required String? site_CLI_IDF, required QuestionnaireModel questionnaire, required List<SalarieCuaserieModel> salaries, required QuestionTypeModel questionType}) async {
    await initApiData();

    final evaluationController = Get.put<EvaluationController>(EvaluationController());

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,load_lieu_evaluation_for_server,load_lieu_evaluation_for_server",
        "SVR_IDF": salaries.map((e) => e.SVR_IDF).join(","),
        "LIE_IDF": site_LIE_IDF ?? "",
        "CLI_IDF": site_CLI_IDF ?? "",
        "START_DATE": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "END_DATE": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "LIEINSPSVR_IDF": questionType.LIEINSPSVR_IDF,
        "SYSINSTYP_IDF": "5",
        "LIEINSPQSNR_IDF": questionnaire.LIEINSPQSNR_IDF,
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print("datataa  :: ${data.data}");
      List<SalarieFormulaireCuaserieModel> listSalaries = [];

      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["List_servers"] != null) {
          listSalaries = SalarieFormulaireCuaserieModel.convertDynamictoListSalariesFormulaire(data.data["Data"][i]["List_servers"]);
        }
        //change evaluation cordonner
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["EvaluationStat"] != null) {
          EvaluationModel newEval = EvaluationModel.fromJson(data.data["Data"][i]["EvaluationStat"][0]);
          evaluationController.setCuurentEvaluation = newEval;
        }
        //change LIEINSPSVR_IDF in controller
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          final FormulaireController formulaireController = Get.put(FormulaireController());
          formulaireController.set_LIEINSPSVR_IDF = data.data["Data"][i]["ClientData"][0]["LIEINSPSVR_IDF"];
        }
      }
      await saveCookies(data.cookies!);
      return listSalaries;
    } else {
      return null;
    }
  }

  Future<String?> sendReponseSignatureCauserie({required String? LIEINSPSVR_IDF, required String imageBytes, required SalarieCuaserieModel salarie, required QuestionTypeModel questionType, required String? commentaire}) async {
    await initApiData();

    print("LIEINSPSVR_IDF $LIEINSPSVR_IDF");

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Lieu,Set_Server_Signature_Eval,Set_Server_Signature_Eval", "LIEINSPSVR_IDF": LIEINSPSVR_IDF ?? "", "SVR_IDF": salarie.SVR_IDF, "LIEINSPSVR_SIGNATURE": imageBytes, "LIEINSPSVR_MEMO": commentaire ?? "", "Wid": _Wid!}, cookies: _Cookies);
    print(data.data);
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      String? signatureImage;
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ServerSignature_list"] != null) {
          signatureImage = data.data["Data"][i]["ServerSignature_list"];
        }
      }

      await saveCookies(data.cookies!);
      return signatureImage;
    } else {
      return null;
    }
  }

  Future<List<CauserieModel>?> getAllCauserieTerminer({SiteQuickAccesModel? site, DateTime? dateDebut, DateTime? dateFin}) async {
    await initApiData();
    late DateTime selectedDebut, selectedFin;
    DateTime firstDateMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime lastDateMonth = DateTime(DateTime.now().year, DateTime.now().month + 1, 1).subtract(Duration(days: 1));

    selectedDebut = dateDebut ?? firstDateMonth;
    selectedFin = dateFin ?? lastDateMonth;

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,load_Evaluation_From_Lieu,load_Evaluation_From_Lieu",
        "ITEM_IDF": site?.LIE_IDF ?? "",
        "ITEM_LIB": '5',
        "ITEM_CODE": "1",
        "START_DATE": "${selectedDebut.day}/${selectedDebut.month}/${selectedDebut.year}",
        "END_DATE": "${selectedFin.day}/${selectedFin.month}/${selectedFin.year}",
        "sidx": "SVR_LIB",
        "FieldsToShow": "-1",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print("datataa  :: ${data.data}");
      List<CauserieModel> listCauserie = [];
      listCauserie = CauserieModel.convertDynamictoListCauserie(data.getElementFromDataList());
      // listCauserie = CauserieModel.convertDynamictoListCauserie(
      //     data.data["Data"][0]["ClientData"]);

      // for (var i = 0; i < (data.data["Data"] as List).length; i++) {
      //   if (data.data["Data"][i] != null &&
      //       data.data["Data"][i] is Map &&
      //       data.data["Data"][i]["ClientData"] != null) {
      //     listCauserie = CauserieModel.convertDynamictoListCauserie(
      //         data.data["Data"][i]["ClientData"]["rows"]);
      //   }
      // }
      await saveCookies(data.cookies!);
      return listCauserie;
    } else {
      return null;
    }
  }

  Future<bool> deleteCauserie({required CauserieModel causerieModel}) async {
    await initApiData();
    ResponseModel data = await AppManageApi(
      context,
    ).post(url: _ActiveUrl, data: {"OKey": "Lieu,LIEINSPSVR,delete", "USER_IDF": causerieModel.USER_IDF, "LAST_UPDT": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}", "LIEINSPSVR_IDF": causerieModel.LIEINSPSVR_IDF, "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isEmpty && (data.data["Errors"] as List).isEmpty) {
      await saveCookies(data.cookies!);
      return true;
    } else {
      return false;
    }
  }

  Future<List<SalarieFormulaireCuaserieModel>?> getAllSalariesCauserieFormulaire({required CauserieModel causerieModel}) async {
    await initApiData();
    final evaluationController = Get.put<EvaluationController>(EvaluationController());

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Lieu,load_lieu_evaluation_for_server,load_lieu_evaluation_for_server",
        "SVR_IDF": causerieModel.SVR_IDF ?? "",
        "LIE_IDF": causerieModel.LIE_IDF,
        "CLI_IDF": causerieModel.CLI_IDF ?? "",
        "START_DATE": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "END_DATE": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "LIEINSPSVR_IDF": causerieModel.LIEINSPSVR_IDF,
        "SYSINSTYP_IDF": "5",
        "LIEINSPQSNR_IDF": causerieModel.LIEINSPQSNR_IDF,
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print("datataa  :: ${data.data}");

      List<SalarieFormulaireCuaserieModel> listQustType = [];

      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["List_servers"] != null) {
          print(data.data["Data"][i]["List_servers"]);
          listQustType = SalarieFormulaireCuaserieModel.convertDynamictoListSalariesFormulaire(data.data["Data"][i]["List_servers"]);
        }
        //change evaluation cordonner
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["EvaluationStat"] != null) {
          EvaluationModel newEval = EvaluationModel.fromJson(data.data["Data"][i]["EvaluationStat"][0]);
          evaluationController.setCuurentEvaluation = newEval;
        }
      }
      print("qst type length : ${listQustType.length}");
      await saveCookies(data.cookies!);
      return listQustType;
    } else {
      return null;
    }
  }

  Future<String?> getSignatureResponsableCauserie({required CauserieModel causerieModel}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Lieu,Get_Server_Signature_Eval,Get_Server_Signature_Eval", "LIEINSPSVR_IDF": causerieModel.LIEINSPSVR_IDF, "Wid": _Wid!}, cookies: _Cookies);
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      String? signature = data.getElementFromDataList(elementName: "ServerSignature");

      // String? signature = data.data["Data"][0]["ServerSignature"];
      await saveCookies(data.cookies!);
      return signature;
    } else {
      return null;
    }
  }

  Future<SignatureSalarieModel?> getSignatureSalarieCauserie({required CauserieModel causerieModel, required String salarie_SVR_IDF}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Lieu,Get_Server_Signature_Eval,Get_Server_Signature_Eval", "LIEINSPSVR_IDF": causerieModel.LIEINSPSVR_IDF, "SVR_IDF": salarie_SVR_IDF, "Wid": _Wid!}, cookies: _Cookies);
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      String? signatureString;
      String? comment;

      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ServerSignature_list"] != null) {
          signatureString = data.data["Data"][i]["ServerSignature_list"];
        }
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["serveur_memo"] != null) {
          comment = data.data["Data"][i]["serveur_memo"][0]["LIEINSPSVRL_MEMO"];
        }
      }

      await saveCookies(data.cookies!);
      print("---------------- signsalarie ---------------");

      print(signatureString);
      print(comment);
      print("---------------- signsalarie ---------------");

      return SignatureSalarieModel(SVR_IDF: salarie_SVR_IDF, signatureData: signatureString, comment: comment);
    } else {
      return null;
    }
  }

  Future<List<GbsystemCatalogueModel>?> getAllCatalogueArticle({required GbsystemArticleRefModel articleRef}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "ArticleRef_Manager,charge_Catalog_Fouri,charge_Catalog_Fouri", "ITEM_LIB": "0", "ARTREF_IDF": articleRef.ARTREF_IDF, "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<GbsystemCatalogueModel> listCatalogues = [];

      print(data.data);
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ARTCAT"] != null) {
          listCatalogues = GbsystemCatalogueModel.convertDynamictoListCatalogue(data.data["Data"][i]["ARTCAT"]);
        }
      }

      await saveCookies(data.cookies!);
      return listCatalogues;
    } else {
      return null;
    }
  }

  Future<List<GbsystemFournisseurModel>?> getAllFournisseur() async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Parameters,fournisseur_int,select", "nd": "1725354923783", "sidx": "FOU_CODE", "sord": "asc", "Prefix": "FOU", "Count": "0", "rows": "0", "page": "1", "_search": "false", "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<GbsystemFournisseurModel> listFournisseur = [];

      print(data.data);
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          listFournisseur = GbsystemFournisseurModel.convertDynamictoListFournisseur(data.data["Data"][i]["ClientData"]);
        }
      }

      await saveCookies(data.cookies!);
      return listFournisseur;
    } else {
      return null;
    }
  }

  Future<List<GbsystemColorModel>?> getAllColors() async {
    await initApiData();

    ResponseModel data = await AppManageApi(
      context,
    ).post(url: _ActiveUrl, data: {"OKey": "Parameters,color,select", "nd": "1725354930362", "sidx": "CLR_CODE", "sord": "asc", "Prefix": "CLR", "filter": "CLR_CAT='AH'", "ConvertColor": "CLR_CODE", "rows": "20", "Count": "0", "FieldsToShow": "1", "page": "1", "_search": "false", "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<GbsystemColorModel> listColors = [];

      print(data.data);
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          listColors = GbsystemColorModel.convertDynamictoListColor(data.data["Data"][i]["ClientData"]["rows"]);
        }
      }

      await saveCookies(data.cookies!);
      return listColors;
    } else {
      return null;
    }
  }

  Future<List<GbsystemTailleModel>?> getAllTailles({required GbsystemArticleRefModel article}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "ArticleRef_Manager,charge_Catalog_Fouri,Server_Taille", "ITEM_IDF": article.ARTCAT_IDF, "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<GbsystemTailleModel> listColors = [];

      print(data.data);
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          listColors = GbsystemTailleModel.convertDynamictoListTailles(data.data["Data"][i]["ClientData"]);
        }
      }

      await saveCookies(data.cookies!);
      return listColors;
    } else {
      return null;
    }
  }

  Future<List<GbsystemCatalogueModel>?> AddArticleRefToCatalogue({
    required GbsystemArticleRefModel article, //
    required GbsystemFournisseurModel fournisseur,
    required DateTime? dateDebut,
    required DateTime? dateFin,
    required String? prix,
    required GbsystemColorModel? color,
    required List<GbsystemTailleModel>? listTailles,
  }) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "ArticleRef_Manager,charge_Catalog_Fouri,Genere_Catalog_Fouri_NEW",
        // "ARTFOUREF_IDF": "",
        // "ARTFOUREF_UIDF": "",
        "CLR_IDF": color?.CLR_IDF ?? "",
        "FOU_IDF": fournisseur.FOU_IDF,
        "TPOI_IDFS": listTailles?.map((taille) => taille.TPOI_IDF).join(",").toString() ?? "",
        "ARTFOUREF_TYPE": "0",
        "ARTREF_IDF": article.ARTREF_IDF,
        "ARTFOUREF_PRIX": prix ?? "",
        "ARTFOUREF_START_DATE": dateDebut != null ? ConvertDateService().parseDateAndTime(date: dateDebut) : "",
        "ARTFOUREF_END_DATE": dateFin != null ? ConvertDateService().parseDateAndTime(date: dateFin) : "",
        "LAST_UPDT": ConvertDateService().parseDateAndTime(date: DateTime.now()),
        "USER_IDF": article.USER_IDF ?? "",
        // "FOU_IDF_Main": fournisseur.FOU_IDF,
        // "ARTREF_IDF_Main": "",
        // "START_DATE_Main": "",
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<GbsystemCatalogueModel> listColors = [];

      print("add catalogue adata : ${data.data}");

      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["Reconcile"] != null) {
          listColors = GbsystemCatalogueModel.convertDynamictoListCatalogue(data.data["Data"][i]["Reconcile"]);
        }
      }

      await saveCookies(data.cookies!);

      return listColors;
    } else {
      return null;
    }
  }

  Future<bool> deleteCatalogue({required GbsystemCatalogueModel catalogue}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "ArticleRef_Manager,charge_Catalog_Fouri,Delete_Ligne_Catalog", "ARTFOUREF_IDF": catalogue.ARTFOUREF_IDF, "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      await saveCookies(data.cookies!);

      return true;
    } else {
      return false;
    }
  }

  Future<List<GbsystemEnterpotModel>?> getAllEnterpot() async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Parameters,ENTR_WithFilter,select", "nd": "1725454999973", "sidx": "ENTR_CODE", "sord": "asc", "Prefix": "ENTR", "rows": "20", "Count": "0", "page": "1", "_search": "false", "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<GbsystemEnterpotModel> listEnterpot = [];

      print(data.data);
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          listEnterpot = GbsystemEnterpotModel.convertDynamictoListEnterpot(data.data["Data"][i]["ClientData"]["rows"]);
        }
      }

      await saveCookies(data.cookies!);
      return listEnterpot;
    } else {
      return null;
    }
  }

  Future<bool> AddCatalogueAuStock({required GbsystemCatalogueModel catalogue, required GbsystemEnterpotModel enterpot, required DateTime? dateDebut, required DateTime? dateFin, required String qte}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "ArticleRef_Manager,article,INSERT",
        "ARTFOUREF_IDF": catalogue.ARTFOUREF_IDF,
        "ART_START_DATE": dateDebut != null ? ConvertDateService().parseDate(date: dateDebut) : "",
        "ART_END_DATE": dateFin != null ? ConvertDateService().parseDate(date: dateFin) : "",
        "ENTR_IDF": enterpot.ENTR_IDF,
        "ART_QTE_STOCK": qte,
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );

    print("data add catalogue : ${data.data} ");
    if ((data.data["Data"] as List).isEmpty && (data.data["Errors"] as List).isEmpty) {
      await saveCookies(data.cookies!);

      return true;
    } else {
      return false;
    }
  }

  Future<GbsystemCatalogueModel?> updateCatalogue({required GbsystemCatalogueModel catalogue, required DateTime dateDebut, required DateTime? dateFin, required String prix, required GbsystemColorModel? color}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "ArticleRef_Manager,charge_Catalog_Fouri,Update_Ligne_Catalog",
        "ARTFOUREF_IDF": catalogue.ARTFOUREF_IDF,
        "ARTFOUREF_UIDF": catalogue.ARTFOUREF_UIDF,
        "ARTFOUREF_TYPE": "0",
        "ARTREF_IDF": catalogue.ARTREF_IDF,
        "TPOI_IDF": catalogue.TPOI_IDF,
        "FOU_IDF": catalogue.FOU_IDF,
        "ARTFOUREF_START_DATE": ConvertDateService().parseDateAndTime(date: dateDebut),
        "ARTFOUREF_END_DATE": dateFin != null ? ConvertDateService().parseDateAndTime(date: dateFin) : "",
        "ARTFOUREF_PRIX": prix,
        "CLR_IDF": color?.CLR_IDF ?? catalogue.CLR_IDF,
        "USER_IDF": catalogue.USER_IDF,
        "LAST_UPDT": ConvertDateService().parseDateAndTime(date: DateTime.now()),
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      GbsystemCatalogueModel? catalogueModel;

      print("update catalogue adata : ${data.data}");

      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["Reconcile"] != null) {
          catalogueModel = GbsystemCatalogueModel.fromJson(data.data["Data"][i]["Reconcile"][0]);
        }
      }

      await saveCookies(data.cookies!);

      return catalogueModel;
    } else {
      return null;
    }
  }

  Future<List<GbsystemArticleRefModel>?> getAllArticlesRef() async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "Mobile_Application,ARTREF,Select_Entite", "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<GbsystemArticleRefModel> listArtRef = [];

      print("all art ref :: ${data.data}");
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          listArtRef = GbsystemArticleRefModel.convertDynamictoListArticles(data.data["Data"][i]["ClientData"]);
        }
      }

      await saveCookies(data.cookies!);
      return listArtRef;
    } else {
      return null;
    }
  }

  Future<List<GbsystemAgenceModel>?> getAllAgences({required String email, required String password}) async {
    await initApiData();
    print(_ActiveUrl);
    print(_Cookies);

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "system_user,system_user,sysuser_dossier",
        "_search": "false",
        "nd": "1733306430883",
        "rows": "200",
        "page": "1",
        "sidx": "DOS_CODE",
        "sord": "asc",
        "Prefix": "DOS",
        "USR_CODE": email,
        "USR_PASS": password,
        //boubaker 30/01/2025
        //"CNX_APPLICATION": 'bmplanning-qcs',
        "CNX_APPLICATION": GBSystem_System_Strings.bmPlanning_PriseService,
        "CNX_TYPE": 'planner',
        "Count": '0',
        "FieldsToShow": '1',
        "Wid": "0",
        // "Wid": _Wid!
      },
      cookies: _Cookies,
    );
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      print(data.data);
      List<dynamic>? agenceDynamic;
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          agenceDynamic = data.data["Data"][i]["ClientData"] as List;
        }
      }
      // List<dynamic> agenceDynamic = data.data["Data"][0]["ClientData"] as List;
      List<GbsystemAgenceModel> listAgences = [];

      for (var i = 0; i < (agenceDynamic?.length ?? 0); i++) {
        listAgences.add(GbsystemAgenceModel.fromJson(agenceDynamic![i]));
      }
      await saveCookies(data.cookies!);
      return listAgences;
    } else {
      return null;
    }
  }

  Future<List<GbsystemArticleGestionStockModel>?> getAllArticlesNonAffectuer() async {
    await initApiData();

    ResponseModel data = await AppManageApi(context).post(url: _ActiveUrl, data: {"OKey": "ArticleRef_Manager,Charger_Articles_NonAffectes_Salarie,Charger_Articles_NonAffectes_Salarie", "ITEM_STOCK_TYPE": "0", "Wid": _Wid!}, cookies: _Cookies);

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<GbsystemArticleGestionStockModel> listArtRef = [];

      print("all art ref :: ${data.data}");
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["ClientData"] != null) {
          listArtRef = GbsystemArticleGestionStockModel.convertDynamictoListArticles(data.data["Data"][i]["ClientData"]);
        }
      }

      await saveCookies(data.cookies!);
      return listArtRef;
    } else {
      return null;
    }
  }

  // Future<bool> affectuerArticleToSalaries(
  //     {required List<SalarieGestionStockModel> listSalariesSelectionner,
  //     required GbsystemArticleGestionStockModel articleNonAffectuer}) async {
  //   await initApiData();

  //   ResponseModel data = await AppManageApi(context).post(
  //       url: _ActiveUrl,
  //       data: {
  //         "OKey":
  //             "ArticleRef_Manager,Visualiser_Articles_Ref_Affectes,Visualiser_Articles_Ref_Affectes",
  //         "ITEM_IDF": articleNonAffectuer.ARTCAT_IDF,
  //         "ITEM_CODE": listSalariesSelectionner
  //             .map((taille) => taille.SVR_IDF)
  //             .join(",")
  //             .toString(),
  //         "ITEM_STOCK_TYPE": "0",
  //         "Wid": _Wid!
  //       },
  //       cookies: _Cookies);
  //   print(data.data);
  //   if ((data.data["Data"] as List).isNotEmpty &&
  //       (data.data["Errors"] as List).isEmpty) {
  //     List<GbsystemArticleGestionStockModel> listArtRef = [];

  //     print("all affectier to salaries :: ${data.data}");
  //     for (var i = 0; i < (data.data["Data"] as List).length; i++) {
  //       if (data.data["Data"][i] != null &&
  //           data.data["Data"][i] is Map &&
  //           data.data["Data"][i]["ClientData"] != null) {
  //         listArtRef =
  //             GbsystemArticleGestionStockModel.convertDynamictoListArticles(
  //                 data.data["Data"][i]["ClientData"]);
  //       }
  //     }

  //     await saveCookies(data.cookies!);
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  Future<List<ArticleAffectuierMultipleGestionStockModel>?> affectuerArticleToSalaries({required List<SalarieGestionStockModel> listSalariesSelectionner, required GbsystemArticleGestionStockModel articleNonAffectuer}) async {
    await initApiData();

    ResponseModel data = await AppManageApi(
      context,
    ).post(url: _ActiveUrl, data: {"OKey": "ArticleRef_Manager,Insert_Server_Article,Insert_Server_Article", "ARTFOUREF_IDF": articleNonAffectuer.ARTFOUREF_IDF, "ENTR_IDF": articleNonAffectuer.ENTR_IDF, "STOCK_TYPE": "0", "SVR_IDF": listSalariesSelectionner.map((taille) => taille.SVR_IDF).join(",").toString(), "Wid": _Wid!}, cookies: _Cookies);
    print(data.data);
    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      List<ArticleAffectuierMultipleGestionStockModel> listArtRef = [];

      print("all affectier to salaries :: ${data.data}");
      for (var i = 0; i < (data.data["Data"] as List).length; i++) {
        if (data.data["Data"][i] != null && data.data["Data"][i] is Map && data.data["Data"][i]["Reconcile"] != null) {
          listArtRef = ArticleAffectuierMultipleGestionStockModel.convertDynamictoListArticlesSalarie(data.data["Data"][i]["Reconcile"]);
        }
      }
      print(listArtRef);
      await saveCookies(data.cookies!);
      return listArtRef;
    } else {
      return null;
    }
  }

  Future<PauseModel?> updatePauseVacation({required VacationModel vacation, required TimeOfDay debutPause, required TimeOfDay finPause}) async {
    await initApiData();
    DateTime debutPauseDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, debutPause.hour, debutPause.minute);

    DateTime finPauseDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, finPause.hour, finPause.minute);

    int durationSeconds = finPauseDate.difference(debutPauseDate).inSeconds;
    bool isDefferentJour = debutPauseDate.compareTo(finPauseDate) == 1;
    // /////////////////////////////////////
    bool isDefferentJourVacation = false;

    if (vacation.VAC_START_HOUR != null && vacation.VAC_END_HOUR != null) {
      isDefferentJourVacation = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, vacation.VAC_START_HOUR!.hour, vacation.VAC_START_HOUR!.minute).compareTo(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, vacation.VAC_END_HOUR!.hour, vacation.VAC_END_HOUR!.minute)) == 1;
    }

    ResponseModel data = await AppManageApi(context).post(
      url: _ActiveUrl,
      data: {
        "OKey": "Shift_CalendarPlanning_NG,,Update_Vacs_Evenement",
        "actionTH": "0",
        "action": "5",
        "VAC_IDF": vacation.VAC_IDF,
        "EVT_IDF": vacation.EVT_IDF ?? '',
        "JOB_IDF": vacation.JOB_IDF ?? "",
        'J_PLUS': isDefferentJourVacation ? "1" : "0",
        "JB_PLUS": isDefferentJour ? "1" : "0",
        "VAC_DURATION": vacation.VAC_DURATION_SECONDS ?? "",
        "JOB_FILTER_CKBX": "0",
        "VACS_TO_UPDATE": "",
        "VAC_START_HOUR": vacation.VAC_START_HOUR != null ? ConvertDateService().parseDateAndTimeWithoutSec(date: vacation.VAC_START_HOUR!) : "",
        "VAC_END_HOUR": vacation.VAC_END_HOUR != null ? ConvertDateService().parseDateAndTimeWithoutSec(date: vacation.VAC_END_HOUR!) : "",
        "VAC_BREAK": durationSeconds.toString(),
        "VAC_BREAKSTART_HOUR": ConvertDateService().parseDateAndTimeWithoutSec(date: debutPauseDate),
        "VAC_BREAKEND_HOUR": ConvertDateService().parseDateAndTimeWithoutSec(date: isDefferentJour ? finPauseDate.add(Duration(days: 1)) : finPauseDate),
        "Wid": _Wid!,
      },
      cookies: _Cookies,
    );

    for (var i = 0; i < (data.data["Data"] as List).length; i++) {
      if (data.data["Data"][i] != null && data.data["Data"][i] is Map && (data.data["Data"][i] as Map).containsKey("SHIFT_CAL_MSG") && data.data["Data"][i]["SHIFT_CAL_MSG"] is List && (data.data["Data"][i]["SHIFT_CAL_MSG"] as List).isNotEmpty) {
        showErrorDialog("${data.data["Data"][i]["SHIFT_CAL_MSG"][0]["MESSAGES"]}");
      }
    }
    // showErrorDialog(
    //     context, "${data.data["Data"][1]["SHIFT_CAL_MSG"][0]["MESSAGES"]}");

    if ((data.data["Data"] as List).isNotEmpty && (data.data["Errors"] as List).isEmpty) {
      await saveCookies(data.cookies!);

      String VAC_BREAKSTART_HOUR = data.getFirstElementFromDataList()["VAC_BREAKSTART_HOUR"];
      String VAC_BREAKEND_HOUR = data.getFirstElementFromDataList()["VAC_BREAKEND_HOUR"];
      String VAC_DURATION = data.getFirstElementFromDataList()["VAC_DURATION_STR"];
      String VAC_BREAK = data.getFirstElementFromDataList()["VAC_BREAK_STR"];
      // print(data.data["Data"][0]["ClientData"][0]["VAC_BREAKSTART_HOUR"]);
      // print(data.data["Data"][0]["ClientData"][0]["VAC_BREAKEND_HOUR"]);
      // print(data.data["Data"][0]["ClientData"][0]["VAC_DURATION"]);

      return PauseModel(VAC_BREAK: VAC_BREAK, VAC_DURATION: VAC_DURATION, VAC_BREAKSTART_HOUR: VAC_BREAKSTART_HOUR, VAC_BREAKEND_HOUR: VAC_BREAKEND_HOUR);
    } else {
      return null;
    }
  }

  Future<DataServerModel?> getSiteS19Client({required String clientName}) async {
    print("used url to get entreprise : https://192.168.1.120/BMServerR.dll/BMDP81679E6763294DE3827D7D93EEE89436A?d-page=D1BAA8F26A9E418093FB0CDA98846062&SYSMENT_CODE=$clientName&SYSMENT_APPNAME=${ActiveApplication_Params.get_Application_Name_Entreprise()}");
    ResponseModel responseServer = await Api(context).get(
      //boubaker 13/05/2025 For Build APK #PS1 #PS2 Update this
      url:
          // Activation pour poste developpeur
          //    "https://192.168.1.120/BMServerR.dll/BMDP81679E6763294DE3827D7D93EEE89436A?d-page=D1BAA8F26A9E418093FB0CDA98846062&SYSMENT_CODE=$clientName&SYSMENT_APPNAME=${ActiveApplication_Params.get_Application_Name_Entreprise()}",
          // Activation pour recette hasna
          "https://192.168.1.30:8010/BMServerR.dll/BMDP81679E6763294DE3827D7D93EEE89436A?d-page=D1BAA8F26A9E418093FB0CDA98846062&SYSMENT_CODE=$clientName&SYSMENT_APPNAME=${ActiveApplication_Params.get_Application_Name_Entreprise()}",
      //Activation pour Paris production
      // "https://www.bmplanning.com/BMServerR.dll/BMDP81679E6763294DE3827D7D93EEE89436A?d-page=D1BAA8F26A9E418093FB0CDA98846062&SYSMENT_CODE=$clientName&SYSMENT_APPNAME=${ActiveApplication_Params.get_Application_Name_Entreprise()}",
    );
    print(responseServer.data);
    if (responseServer.isRequestSucces()) {
      if ((responseServer.getElementFromDataList() as List).isNotEmpty) {
        DataServerModel dataServerModel = DataServerModel.fromJson(responseServer.getFirstElementFromDataList());
        return dataServerModel;
      }
      //@
    } else {
      return null;
    }
    return null;
  }

  Future<bool> verifierExistUrlS19() async {
    bool verifier = false;
    await SharedPreferences.getInstance().then((value) {
      print("siiiiiiiiiiit :${value.getString(GBSystem_System_Strings.kSiteWeb)}");
      print("siiiiiiiiiiit :${value.getString(GBSystem_System_Strings.kS19)}");

      if (value.getString(GBSystem_System_Strings.kSiteWeb) != null && value.getString(GBSystem_System_Strings.kSiteWeb)!.isNotEmpty) {
        verifier = true;
      } else {
        verifier = false;
      }
    });
    return verifier;
  }
}
