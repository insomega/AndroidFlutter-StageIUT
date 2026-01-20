import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_valider_document_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_response_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_valider_document_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_document_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_publication_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_vacation_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/AUTH/login_screen/GBSystem_login_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/ERROR/SSO_ERROR/GBSystem_error_sso_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/MAIN_SCREEN/GBSystem_main_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/VALIDER_DOCUMENTS_SCREEN/GBSysetm_valider_documents_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/api.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PortailSalarieApi {
  PortailSalarieApi(this.context);
  BuildContext context;

  Future<void> intigrateWID({required Map<String, String> data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _Wid = prefs.getString(GbsSystemServerStrings.kToken);
    if (_Wid != null) {
      data["Wid"] = _Wid;
    } else {
      data["Wid"] = "";
    }
  }

  Future<String?> getWID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _Wid = prefs.getString(GbsSystemServerStrings.kToken);
    return _Wid;
  }

  Future<ResponseModel> post(
      {required Map<String, String> data, required bool needWID}) async {
    //add WID to JSON data (if need it)
    if (needWID) {
      await intigrateWID(data: data);
    }
    print("----------------------------");
    print(data);
    print("----------------------------");

    //send request to server
    ResponseModel responseServer = await Api(context).post(
      data: data,
    );
    print(responseServer.data);
    if (responseServer.isRequestSucces()) {
      return responseServer;

      //case 1 : Valider vos documents
    } else if (responseServer.validerDocumentsCase()) {
      List<PublicationModel>? listPublications = [];
      List<DocumentModel>? listDocuments = [];
      List<VacationModel>? listVacations = [];

      listPublications =
          responseServer.getElementFromDataList(elementName: "publa") != null
              ? PublicationModel.convertDynamictoList(
                  responseServer.getElementFromDataList(elementName: "publa"))
              : [];
      print(responseServer.getElementFromDataList(elementName: "doc_ent"));
      listDocuments =
          responseServer.getElementFromDataList(elementName: "doc_ent") != null
              ? DocumentModel.convertDynamictoList(
                  responseServer.getElementFromDataList(elementName: "doc_ent"))
              : [];

      print(responseServer.getElementFromDataList(
          elementName: "Planning_Vacations"));
      listVacations = responseServer.getElementFromDataList(
                  elementName: "Planning_Vacations") !=
              null
          ? VacationModel.convertDynamictoListVacations(responseServer
              .getElementFromDataList(elementName: "Planning_Vacations"))
          : [];

      String? wid = await getWID();
      print("wid : $wid");
      ///// second act
      await Api(context).post(
        data: {
          "OKey": "CACB4E292F3F44319D411C16184883A3",
          "act_id": "75408E921C6C490A97CC0C63C755136D",
          "Wid": wid!,
        },
      ).then(
        (dataServer) {
          GBSystemValiderDocumentsModel? validerDocs;
          if (dataServer.isRequestSucces()) {
            List<PublicationModel>? listPublications =
                dataServer.getElementFromDataList(elementName: "publa") != null
                    ? PublicationModel.convertDynamictoList(
                        dataServer.getElementFromDataList(elementName: "publa"))
                    : [];

            List<DocumentModel>? listDocuments = dataServer
                        .getElementFromDataList(elementName: "doc_ent") !=
                    null
                ? DocumentModel.convertDynamictoList(
                    dataServer.getElementFromDataList(elementName: "doc_ent"))
                : [];

            List<VacationModel>? listVacations = dataServer
                        .getElementFromDataList(
                            elementName: "Planning_Vacations") !=
                    null
                ? VacationModel.convertDynamictoListVacations(dataServer
                    .getElementFromDataList(elementName: "Planning_Vacations"))
                : [];

            validerDocs = GBSystemValiderDocumentsModel(
                listVacations: listVacations,
                listDocuments: listDocuments,
                listPublications: listPublications);
          } else {
            validerDocs = null;
          }

          if (validerDocs != null) {
            print(validerDocs);
            if (validerDocs.listVacations != null &&
                validerDocs.listVacations!.isNotEmpty) {
              final validerDocumentsController =
                  Get.put<GBSystemValiderDocumentController>(
                      GBSystemValiderDocumentController());
              validerDocumentsController.setCurrentVacationVacation =
                  validerDocs.listVacations!.first;
            }
          }
        },
      );
      // await GBSystem_AuthService(context)
      //     .getValiderDocuments()
      //     .then((validerDocs) async {
      //   if (validerDocs != null) {
      //     print(validerDocs);
      //     if (validerDocs.listVacations != null &&
      //         validerDocs.listVacations!.isNotEmpty) {
      //       final validerDocumentsController =
      //           Get.put<GBSystemValiderDocumentController>(
      //               GBSystemValiderDocumentController());
      //       validerDocumentsController.setCurrentVacationVacation =
      //           validerDocs.listVacations!.first;
      //     }
      //   }
      // });

      final validerDocumentsController =
          Get.put<GBSystemValiderDocumentController>(
              GBSystemValiderDocumentController());

      if (listVacations.isNotEmpty) {
        validerDocumentsController.setCurrentVacationVacation =
            listVacations.first;
      }
      validerDocumentsController.setCurrentValiderDocument =
          GBSystemValiderDocumentsModel(
              listVacations: listVacations,
              listDocuments: listDocuments,
              listPublications: listPublications);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.off(GBSystemValiderDocumentsScreen());
      });

      return responseServer;
    }
    //case 2 : Session expire
    else if (responseServer.sessionExpirerCase()) {
      final mainScreenController =
          Get.put<GBSystemMainScreenController>(GBSystemMainScreenController());
      mainScreenController.currentIndex.value = 0;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool? isSSO = preferences.getBool(GbsSystemServerStrings.kSSO);
      if (isSSO ?? false) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.off(ErrorSSOPage());
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.off(GBSystemLoginScreen());
        });
      }

      return responseServer;
    } else {
      return responseServer;
    }
  }
}
