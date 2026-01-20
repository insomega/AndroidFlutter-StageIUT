import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PDF_PAGE/GBSystem_pdf_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/pdf_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/DOCUMENT_WIDGETS/DOCUMENT_ENTREPRISE_WIDGETS/document_entreprise_main_widget_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/DOCUMENT_WIDGETS/document_entreprise_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class DocumentEntrepriseMainWidget extends StatelessWidget {
  DocumentEntrepriseMainWidget({
    super.key,
    required this.updateLoading,
    required this.updateUI,
  });
  final Function updateLoading, updateUI;

  @override
  Widget build(BuildContext context) {
    final m = Get.put<DocumentEntrepriseMainWidgetController>(
        DocumentEntrepriseMainWidgetController(
      context,
    ));
    return m.documentEntrepriseController.getAllDocumentEntreprises != null
        ? MainWidget(updateUI: updateUI, updateLoading: updateLoading)
        : FutureBuilder(
            future: GBSystem_AuthService(context).getListDocumentEntreprise(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  m.documentEntrepriseController.setAllDocumentEntreprise =
                      snapshot.data;
                  m.documentEntrepriseController.setCurrentDocumentEntreprise =
                      snapshot.data?.first;
                  return MainWidget(
                    updateUI: updateUI,
                    updateLoading: updateLoading,
                  );
                } else {
                  return EmptyDataWidget();
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    height: 250,
                    child: WaitingWidgets(),
                  ),
                );
              } else {
                return EmptyDataWidget();
              }
            },
          );
  }
}

class MainWidget extends StatefulWidget {
  MainWidget({
    super.key,
    required this.updateLoading,
    required this.updateUI,
  });
  final Function updateLoading, updateUI;

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    final m = Get.put<DocumentEntrepriseMainWidgetController>(
        DocumentEntrepriseMainWidgetController(
      context,
    ));
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 30,
          child: Row(
            // scrollDirection: Axis.horizontal,
            children: [
              Obx(() => InkWell(
                    onTap: () async {
                      try {
                        m.selectedIndex.value = -1;
                        m.selectedType.value = "null";
                        widget.updateLoading(true);

                        await GBSystem_AuthService(context)
                            .getListDocumentEntreprise()
                            .then((value) {
                          widget.updateLoading(false);

                          if (value != null) {
                            // print("result : $value");
                            m.documentEntrepriseController
                                .setAllDocumentEntreprise = value;
                          }
                        });
                      } catch (e) {
                        widget.updateLoading(false);
                        GBSystem_ManageCatchErrors().catchErrors(context,
                            message: e.toString(),
                            method: "getListDocumentEntreprise",
                            page: "document_entreprise_main_widget");
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: m.selectedIndex.value == null ||
                                m.selectedIndex.value == -1
                            ? GbsSystemStrings.str_primary_color
                            : Colors.grey.shade400.withOpacity(0.7),
                      ),
                      child: Center(
                        child: GBSystem_TextHelper().smallText(
                            textColor: Colors.white,
                            text: GbsSystemStrings.str_tous.tr),
                      ),
                    ),
                  )),
              Expanded(
                child: FutureBuilder(
                  future: GBSystem_AuthService(context).getListFiltreType(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      m.typeFiltreController.setAllTypeFiltre = snapshot.data;
                      print('length : ${snapshot.data?.length}');
                      return SizedBox(
                        height: 30,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: (m.typeFiltreController.getAllTypeFiltres
                                  ?.length ??
                              0),
                          itemBuilder: (context, index) {
                            return Obx(() => InkWell(
                                  onTap: () async {
                                    try {
                                      m.selectedType.value = m
                                          .typeFiltreController
                                          .getAllTypeFiltres![index]
                                          .TYPDOC_LIB;
                                      m.selectedIndex.value = index;
                                      widget.updateLoading(true);
                                      await GBSystem_AuthService(context)
                                          .getListDocumentEntreprise(
                                              filtre: m
                                                          .typeFiltreController
                                                          .getAllTypeFiltres![
                                                              index]
                                                          .TYPDOC_IDF ==
                                                      ""
                                                  ? null
                                                  : int.parse(m
                                                      .typeFiltreController
                                                      .getAllTypeFiltres![index]
                                                      .TYPDOC_IDF))
                                          .then((value) {
                                        widget.updateLoading(false);

                                        if (value != null) {
                                          // print("result : $value");
                                          m.documentEntrepriseController
                                              .setAllDocumentEntreprise = value;
                                        }
                                      });
                                    } catch (e) {
                                      widget.updateLoading(false);
                                      GBSystem_ManageCatchErrors().catchErrors(
                                          context,
                                          message: e.toString(),
                                          method: "getListDocumentEntreprise 2",
                                          page:
                                              "document_entreprise_main_widget");
                                    }
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 7),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: m.selectedType.value ==
                                              m
                                                  .typeFiltreController
                                                  .getAllTypeFiltres![index]
                                                  .TYPDOC_LIB
                                          ? GbsSystemStrings.str_primary_color
                                          : Colors.grey.shade400
                                              .withOpacity(0.7),
                                    ),
                                    child: Center(
                                      child: GBSystem_TextHelper().smallText(
                                          textColor: Colors.white,
                                          text: m
                                              .typeFiltreController
                                              .getAllTypeFiltres![index]
                                              .TYPDOC_LIB),
                                    ),
                                  ),
                                ));
                          },
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Container(
                        height: 50,
                        child: WaitingWidgets(),
                      );
                    } else {
                      return EmptyDataWidget();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: m.documentEntrepriseController
                          .getAllDocumentEntreprisesRx.value?.length ??
                      0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: DocumentEntrepriseWidget(
                        onTelechargerTap: () async {
                          try {
                            widget.updateLoading(true);
                            await GBSystem_AuthService(context)
                                .downloadDocumentEntreprisePDF(
                                    documentModel: m
                                        .documentEntrepriseController
                                        .getAllDocumentEntreprises![index])
                                .then((value) async {
                              widget.updateLoading(false);
                              print(value);
                              if (value != null) {
                                widget.updateUI();

                                Uint8List bytes = PDFService()
                                    .cleanPDFStringAndConvertToUnit8List(
                                        stringPDF: value);
                                await PDFService().downloadAndSavePDF(
                                    "planningPDF", bytes, context,
                                    addExtension: false, autoShare: false);

                                Get.to(GBSystemPDFScreen(
                                  pageName:
                                      "${GbsSystemStrings.str_document.tr}",
                                  fileName: m
                                      .documentEntrepriseController
                                      .getAllDocumentEntreprises![index]
                                      .DOCAN_CODE,
                                  pdfBytes: bytes,
                                ));
                              }
                            });
                          } catch (e) {
                            widget.updateLoading(false);
                            GBSystem_ManageCatchErrors().catchErrors(context,
                                message: e.toString(),
                                method: "downloadDocumentEntreprisePDF",
                                page: "document_entreprise_main_widget");
                          }
                        },
                        docEntreprise: m.documentEntrepriseController
                            .getAllDocumentEntreprises![index],
                      ),
                    );
                  },
                ),
              )),
        ),
      ],
    );
  }
}
