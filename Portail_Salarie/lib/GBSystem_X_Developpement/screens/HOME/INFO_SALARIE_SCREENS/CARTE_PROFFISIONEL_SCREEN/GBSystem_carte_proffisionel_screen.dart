import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/INFO_SALARIE_SCREENS/CARTE_PROFFISIONEL_SCREEN/GBSystem_carte_proffisionel_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PDF_PAGE/GBSystem_pdf_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/pdf_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemCarteProffisionelScreen extends StatelessWidget {
  GBSystemCarteProffisionelScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final m = Get.put<GBSystemCarteProffisionelScreenController>(
        GBSystemCarteProffisionelScreenController(
      context,
    ));
    return m.salarieController.getPDFSalarie != null
        ? GBSystemPDFScreen(
            addExtensionWhenDownload: true,
            pageName: "${GbsSystemStrings.str_carte_proffisionel.tr}",
            fileName: "SalarieInformationsPDF",
            isCommingFromOut: true,
            pdfBytes: PDFService().cleanPDFStringAndConvertToUnit8List(
                stringPDF: m.salarieController.getPDFSalarie!),
          )
        : FutureBuilder(
            future: GBSystem_AuthService(context).loadPDFSalarie(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  m.salarieController.setPDFSalarie = snapshot.data!;

                  return GBSystemPDFScreen(
                    addExtensionWhenDownload: true,
                    pageName: "${GbsSystemStrings.str_carte_proffisionel.tr}",
                    fileName: "SalarieInformationsPDF",
                    isCommingFromOut: true,
                    pdfBytes: PDFService().cleanPDFStringAndConvertToUnit8List(
                        stringPDF: m.salarieController.getPDFSalarie!),
                  );
                } else {
                  return EmptyDataWidget();
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 250,
                  child: Center(child: WaitingWidgets()),
                );
              } else {
                return EmptyDataWidget();
              }
            },
          );
  }
}
