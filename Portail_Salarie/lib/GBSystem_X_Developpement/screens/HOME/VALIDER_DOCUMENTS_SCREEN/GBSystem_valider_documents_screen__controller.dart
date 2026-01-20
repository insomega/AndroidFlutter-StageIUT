import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_nombre_notifications_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_valider_document_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/MAIN_SCREEN/GBSystem_Main_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PDF_PAGE/GBSystem_pdf_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/pdf_service.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

import 'package:portail_salarie/GBSystem_X_Developpement/services/firebase_serivce.dart';

class GBSystemValiderDocumentsScreenController extends GetxController {
  GBSystemValiderDocumentsScreenController({this.context});
  BuildContext? context;
  PageController pageController = PageController();
  RxDouble currentIndex = 0.0.obs;
  PageController pageController2 = PageController();
  RxDouble currentIndex2 = 0.0.obs;
  RxBool pubBool = RxBool(true),
      docBool = RxBool(true),
      priseServiceBool = RxBool(true);

  RxBool isLoading = RxBool(false);
  final validerDocumentsController = Get.put<GBSystemValiderDocumentController>(
      GBSystemValiderDocumentController());
  final GBSystemVacationController vacationController =
      Get.put(GBSystemVacationController());
  final notificationController =
      Get.put<GBSystemNotificationController>(GBSystemNotificationController());

  @override
  void onInit() {
    super.onInit();

    if (validerDocumentsController
            .getCurrentValiderDocument.value?.listPublications ==
        null) {
      pubBool = RxBool(false);
    }
    if (validerDocumentsController
            .getCurrentValiderDocument.value?.listDocuments ==
        null) {
      docBool = RxBool(false);
    }
    if (validerDocumentsController.getCurrentVacation == null) {
      priseServiceBool = RxBool(false);
    }
    pageController.addListener(() {
      currentIndex.value = pageController.page ?? 0.0;
    });
    pageController2.addListener(() {
      currentIndex2.value = pageController2.page ?? 0.0;
    });
  }

  Future pubFunction(String fileName, int index, BuildContext context) async {
    isLoading.value = true;

    await GBSystem_AuthService(context)
        .downloadPublicationPDF(
            publicationModel: validerDocumentsController
                .getCurrentValiderDocument.value!.listPublications![index])
        .then((value) async {
      if (value != null) {
        validerDocumentsController.removePublication(validerDocumentsController
            .getCurrentValiderDocument.value!.listPublications![index]);
////
        if (await verifierNoPDFtoGoHome(context)) {
        } else {
          Uint8List bytes = PDFService()
              .cleanPDFStringAndConvertToUnit8List(stringPDF: value);

          // if (bytes.isNotEmpty) {
          // print("download");
          await PDFService()
              .downloadAndSavePDF(
            fileName,
            bytes,
            context,
            addExtension: true,
          )
              .then((value) {
            isLoading.value = false;
          });
          // } else {
          //   isLoading.value = false;
          // }
        }
      } else {
        isLoading.value = false;
      }
    });
  }

  Future pubFunctionWithDisplay(
      String fileName, int index, BuildContext context) async {
    isLoading.value = true;

    await GBSystem_AuthService(context)
        .downloadPublicationPDF(
            publicationModel: validerDocumentsController
                .getCurrentValiderDocument.value!.listPublications![index])
        .then((value) async {
      if (value != null) {
        validerDocumentsController.removePublication(validerDocumentsController
            .getCurrentValiderDocument.value!.listPublications![index]);

        Uint8List bytes =
            PDFService().cleanPDFStringAndConvertToUnit8List(stringPDF: value);
        await PDFService()
            .downloadAndSavePDF(fileName, bytes, context,
                addExtension: true, autoShare: false)
            .then((value) {
          isLoading.value = false;
        });
        Get.to(
          GBSystemPDFScreen(
            pageName: "${GbsSystemStrings.str_publication.tr}",
            fileName: fileName,
            pdfBytes: bytes,
            addExtensionWhenDownload: true,
          ),
        );
      } else {
        isLoading.value = false;
      }
    });
  }

  Future docFunction(String fileName, int index, BuildContext context) async {
    isLoading.value = true;

    await GBSystem_AuthService(context)
        .downloadDocumentPDF(
            documentModel: validerDocumentsController
                .getCurrentValiderDocument.value!.listDocuments![index])
        .then((value) async {
      if (value != null) {
        validerDocumentsController.removeDocument(validerDocumentsController
            .getCurrentValiderDocument.value!.listDocuments![index]);
        /////
        if (await verifierNoPDFtoGoHome(context)) {
        } else {
          print("pdf string : $value");
          Uint8List bytes = PDFService()
              .cleanPDFStringAndConvertToUnit8List(stringPDF: value);
          print("pdf string cleaned : $bytes");

          await PDFService()
              .downloadAndSavePDF(
            fileName,
            bytes,
            context,
            addExtension: true,
          )
              .then((value) {
            isLoading.value = false;
          });
        }
      } else {
        isLoading.value = false;
      }
    });
  }

  Future docFunctionWithDisplay(
      String fileName, int index, BuildContext context) async {
    isLoading.value = true;

    await GBSystem_AuthService(context)
        .downloadDocumentPDF(
            documentModel: validerDocumentsController
                .getCurrentValiderDocument.value!.listDocuments![index])
        .then((value) async {
      if (value != null) {
        validerDocumentsController.removeDocument(validerDocumentsController
            .getCurrentValiderDocument.value!.listDocuments![index]);
        /////
        // if (await verifierNoPDFtoGoHome(context)) {
        // } else {
        Uint8List bytes =
            PDFService().cleanPDFStringAndConvertToUnit8List(stringPDF: value);

        await PDFService()
            .downloadAndSavePDF(fileName, bytes, context,
                addExtension: true, autoShare: false)
            .then((value) {
          isLoading.value = false;
        });
        Get.to(
          GBSystemPDFScreen(
            pageName: "${GbsSystemStrings.str_document.tr}",
            fileName: fileName,
            pdfBytes: bytes,
            addExtensionWhenDownload: true,
          ),
        );
        // }
      } else {
        isLoading.value = false;
      }
    });
  }

  Future<bool> verifierNoPDFtoGoHome(BuildContext context) async {
    if ((validerDocumentsController
                    .getCurrentValiderDocument.value?.listDocuments ==
                null ||
            validerDocumentsController
                .getCurrentValiderDocument.value!.listDocuments!.isEmpty) &&
        (validerDocumentsController
                    .getCurrentValiderDocument.value?.listPublications ==
                null ||
            validerDocumentsController
                .getCurrentValiderDocument.value!.listPublications!.isEmpty) &&
        (validerDocumentsController.getCurrentVacation == null)) {
      isLoading.value = true;
      await downloadHomeData(context).then((value) {
        isLoading.value = false;
      });
      return true;
    } else {
      return false;
    }
  }

  Future downloadHomeData(BuildContext context) async {
    await GBSystem_AuthService(context)
        .getInfoSalarie()
        .then((infoSalarie) async {
      if (infoSalarie != null) {
        final GBSystemSalarieController salarieController =
            Get.put(GBSystemSalarieController());

        salarieController.setSalarie = infoSalarie;
        //boubaker 14/04/2025
await FirebaseSerivce(context).subscribeTopicsAndDisubscribeOld();
      }
    });

    await GBSystem_AuthService(context)
        .getVacationsHome()
        .then((vacationsHome) async {
      if (vacationsHome != null && vacationsHome.isNotEmpty) {
        vacationController.setAllVacation = vacationsHome;
        vacationController.setCurrentVacationVacation = vacationsHome.first;
      }
    });
    await GBSystem_AuthService(context)
        .getNombreNotiChat()
        .then((nbrNoti) async {
      if (nbrNoti != null) {
        notificationController.setNbrNoti = nbrNoti;
      }
    });
    await GBSystem_AuthService(context)
        .getNombreVacationProposer()
        .then((nbrVac) async {
      if (nbrVac != null) {
        vacationController.setNumberVacationsProposer = nbrVac;
      }
    });

    await GBSystem_AuthService(context)
        .getNombreVacationProposer()
        .then((nbrVac) async {
      if (nbrVac != null) {
        final GBSystemVacationController vacationController =
            Get.put(GBSystemVacationController());

        vacationController.setNumberVacationsProposer = nbrVac;

        Get.to(GBSystemMainScreen());
      }
    });
  }

  Future onPointageTap(BuildContext context1) async {
    validerDocumentsController.setCurrentVacationVacation = null;
    await verifierNoPDFtoGoHome(context1);
    update();
  }
}
