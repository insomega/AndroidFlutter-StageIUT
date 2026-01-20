import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/DOCUMENTS_SCREENS/DOCUMENT_DE_ENTREPRISE_SCREEN/GBSystem_document_de_entreprise_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/DOCUMENT_WIDGETS/DOCUMENT_ENTREPRISE_WIDGETS/document_entreprise_main_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemDocumentDeEntrepriseScreen extends StatefulWidget {
  const GBSystemDocumentDeEntrepriseScreen(
      {super.key, this.isCommingFromOut = false});

  final bool isCommingFromOut;
  @override
  State<GBSystemDocumentDeEntrepriseScreen> createState() =>
      _GBSystemDocumentDeEntrepriseScreenState();
}

class _GBSystemDocumentDeEntrepriseScreenState
    extends State<GBSystemDocumentDeEntrepriseScreen> {
  final m = Get.put<GBSystemDocumentDeEntrepriseScreenController>(
      GBSystemDocumentDeEntrepriseScreenController());

  updateLoading(bool myBool) {
    m.isLoading.value = myBool;
  }

  updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            Scaffold(
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                centerTitle: true,
                elevation: 4.0,
                shadowColor: GbsSystemStrings.str_primary_color,
                toolbarHeight: 80,
                backgroundColor: GbsSystemStrings.str_primary_color,
                title: Text(
                  GbsSystemStrings.str_documents_de_lentreprise.tr,
                  style: TextStyle(color: Colors.white),
                ),
                leading: widget.isCommingFromOut
                    ? InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          CupertinoIcons.arrow_left,
                          color: Colors.white,
                        ),
                      )
                    : Container(),
              ),
              body: DocumentEntrepriseMainWidget(
                  updateUI: updateUI, updateLoading: updateLoading),
            ),
            m.isLoading.value ? Waiting() : Container()
          ],
        ));
  }
}
