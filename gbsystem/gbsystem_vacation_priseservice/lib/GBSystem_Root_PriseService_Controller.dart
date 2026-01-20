import 'package:gbsystem_root/GBSystem_site_planning_model.dart';
import 'package:gbsystem_root/GBSystem_vacation_model.dart';
import 'package:get/get.dart';

import 'GBSystem_Vacation_Informations_Controller.dart';

import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';
import 'package:gbsystem_root/GBSystem_Root_Controller.dart';
import 'package:gbsystem_root/GBSystem_response_model.dart';
import 'package:gbsystem_root/GBSystem_snack_bar.dart';

import 'package:gbsystem_root/GBSystem_position_with_error_model.dart';

import 'package:gbsystem_root/GBSystem_location_service.dart';
//import 'package:gbsystem_root/GBSystem_Storage_Service.dart';
//import 'package:gbsystem_root/GBSystem_NetworkController.dart';

//import '../../../Application_Model_NG/lib/GBSystem_Application/Routes/GBSystem_Application_Routes.dart';
class GBSystem_Root_PriseService_Controller extends GBSystem_Root_Controller {
  //GBSystem_Vacation_Model? currentVacation;
  final GBSystem_Vacation_Informations_Controller Vacation_Informations_Controller = Get.put(GBSystem_Vacation_Informations_Controller());
  //Future<GBSystem_Vacation_Model?> pointageEntrerSorie({
  Future<ResponseModel?> pointageEntrerSorie({
    required String Sens,
    //required GBSystem_Vacation_Model vacation,
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
    PositionWithErrorModel currentPosition = await LocationService().determinePositionWithErrorsPointage();

    Map<String, String> myMap = {
      "OKey": GBSystem_System_Strings.str_server_okey,
      "ACT_ID": "A17131199E234B73A417A42D8502447E",
      "VAC_IDF": Vacation_Informations_Controller.selectedVacationsIdf, // vacation.VAC_IDF,
      "PNTGS_SENS": Sens, //"1",= entrée 2 = sortie
      "LATITUDE": currentPosition.position?.latitude.toString().replaceAll(".", ",") ?? "",
      "LONGITUDE": currentPosition.position?.longitude.toString().replaceAll(".", ",") ?? "",
      "ERR_NFC": ERR_NFC ?? "",
      "NFC": NFC ?? "",
      "QRCODE": QRCODE ?? "",
      "ERR_QRCODE": ERR_QRCODE ?? "",
      "ERR_GPS": currentPosition.position == null ? "impossible d'accéder à la localisation" : "",
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
      myMap.addAll({"SYSSTR_CODE": (isUserIgnoreQR ?? false) ? "PS_08" : "", "VACPNTGSE_MSG": messageErrQR ?? "", "VACPNTGSE_CODE": (isUserIgnoreQR ?? false) ? "1" : "", "VACPNTGSE_TYPE": 'QRCODE'});
    }

    ResponseModel responseServer = await Execute_Server_post(data: myMap);

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
    // //       }
    // Vacation_Informations_Controller.applyServerResponse(responseServer);

    if (responseServer.isRequestSucces()) {
      //   GBSystem_Vacation_Model? myVacation = GBSystem_Vacation_Model.fromResponse(responseServer);

      //   return myVacation;
      return responseServer;
    } else {
      return null;
    }
  }

  Future<void> _executePointageOperation({
    required Future<ResponseModel?> Function() operation, //
    required String successMessage,
    required bool desconnectAfterSuccess,
  }) async {
    isLoading.value = true;
    //currentVacation = Vacation_Informations_Controller.currentVacation;

    try {
      final result = await operation();

      if (result != null) {
        _handlePointageSuccess(result, successMessage);
        if (desconnectAfterSuccess) await performLogout();
      } else {
        await _handlePointageFailure();
      }
    } catch (e) {
      GBSystem_Add_LogEvent(message: e.toString(), method: '_executePointageOperation', page: "GBSystem_Vacation_PriseService_Controller");
    } finally {
      isLoading.value = false;
    }
  }

  void _handlePointageSuccess(ResponseModel serverResponse, String successMessage) {
    Vacation_Informations_Controller.applyServerResponse(serverResponse);
    // if (vacation.PNTGS_START_HOUR_IN != null) {
    //   Vacation_Informations_Controller.setVacationEntrer = vacation.PNTGS_START_HOUR_IN!;
    // }
    // if (vacation.PNTGS_START_HOUR_OUT != null) {
    //   Vacation_Informations_Controller.setVacationSortie = vacation.PNTGS_START_HOUR_OUT!;
    // }

    // //Vacation_Informations_Controller.currentVacation = vacation;
    // Vacation_Informations_Controller.currentVacation?.updateFrom(vacation);

    showSuccesDialog(successMessage);
  }

  Future<void> _handlePointageFailure() async {
    showErrorDialog(GBSystem_Application_Strings.str_vacation_non_pointer.tr);
  }

  Future<void> entrerFunction(bool desconnectAfterSuccess) async {
    await _executePointageOperation(
      operation: () => pointageEntrerSorie(Sens: GBSystem_System_Strings.str_pointage_entrer_sens),
      successMessage: GBSystem_Application_Strings.str_pointage_entrer_succes,
      desconnectAfterSuccess: desconnectAfterSuccess,
    );
  }

  Future<void> sortieFunction(bool desconnectAfterSuccess) async {
    await _executePointageOperation(
      operation: () => pointageEntrerSorie(Sens: GBSystem_System_Strings.str_pointage_sortie_sens),
      successMessage: GBSystem_Application_Strings.str_pointage_sortie_succes,
      desconnectAfterSuccess: desconnectAfterSuccess,
    );
  }

  Future<void> _executeVacationOperation({required Future<GBSystem_Vacation_Model?> Function() operation, required Function(GBSystem_Vacation_Model) successAction, required String errorMessage}) async {
    isLoading.value = true;
    //currentVacation = Vacation_Informations_Controller.currentVacation;

    try {
      final value = await operation();

      if (value != null) {
        successAction(value);
        Vacation_Informations_Controller.currentVacation = value;
      } else {
        showWarningDialog(errorMessage);
      }
    } catch (e) {
      GBSystem_Add_LogEvent(message: e.toString(), method: '_executeVacationOperation', page: "GBSystem_Vacation_PriseService_Controller");
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<GBSystem_Vacation_Model>?> getAllVacationPlanning({
    required List<SitePlanningModel> sitePlanningList, //
    required List<SitePlanningModel> evenementList,
    required String? searchText,
    bool isGetAll = false,
  }) async {
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
    };
    if (isGetAll) {
      myMap.addAll({"VacsLieOrEvt": "1"});
    }
    print(" maaaaap $myMap");

    ResponseModel data = await Execute_Server_post(data: myMap);
    //Get.log("-----------*************----------data server vac : ${data.data}");
    Vacation_Informations_Controller.setAllVacation = GBSystem_Vacation_Model.fromResponse_List(data);
    return Vacation_Informations_Controller.allVacations;
  }

  Future<void> precedentFunction() async {
    await _executeVacationOperation(
      operation: () => getInfoVacationPrecedent(VAC_IDF: Vacation_Informations_Controller.currentVacation!.VAC_IDF),
      successAction: (value) {
        Vacation_Informations_Controller.setVacationToLeft = value;
        Vacation_Informations_Controller.currentVacation = value;
      },
      errorMessage: GBSystem_Application_Strings.str_aucune_vacation_prec,
    );
  }

  Future<void> suivantFunction() async {
    await _executeVacationOperation(
      operation: () => getInfoVacationSuivant(VAC_IDF: Vacation_Informations_Controller.currentVacation?.VAC_IDF),
      successAction: (value) {
        Vacation_Informations_Controller.setVacationToRight = value;
        Vacation_Informations_Controller.currentVacation = value;
      },
      errorMessage: GBSystem_Application_Strings.str_aucune_vacation_suiv,
    );
  }

  Future<GBSystem_Vacation_Model?> getInfoVacationPrecedent({String? VAC_IDF}) async {
    ResponseModel data = await Execute_Server_post(
      data: {
        "OKey": GBSystem_System_Strings.str_server_okey, //
        "VAC_LOAD_ETAT": "-1",
        "VAC_IDF": VAC_IDF ?? "",
        "ACT_ID": "B563858EFCEA4379B4A583910CA5B728",
      },
    );
    if (data.isRequestSucces()) {
      GBSystem_Vacation_Model? vacationModel = GBSystem_Vacation_Model.fromResponse(data);
      return vacationModel;
    } else {
      return null;
    }
  }

  Future<GBSystem_Vacation_Model?> getInfoVacationSuivant({String? VAC_IDF}) async {
    ResponseModel data = await Execute_Server_post(
      data: {
        "OKey": GBSystem_System_Strings.str_server_okey, //
        "VAC_LOAD_ETAT": "1",
        "VAC_IDF": VAC_IDF ?? "378315",
        "ACT_ID": "B563858EFCEA4379B4A583910CA5B728",
      },
    );
    if (data.isRequestSucces()) {
      GBSystem_Vacation_Model? vacationModel = GBSystem_Vacation_Model.fromResponse(data);

      return vacationModel;
    } else {
      return null;
    }
  }
}
