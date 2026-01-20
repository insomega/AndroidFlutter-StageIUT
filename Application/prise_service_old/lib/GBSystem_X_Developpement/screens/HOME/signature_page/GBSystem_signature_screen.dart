import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/signature_page/GBSystem_signature_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/GBSystem_signature_widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class GBSystemSignatureScreen extends StatefulWidget {
  GBSystemSignatureScreen({
    super.key,
    required this.updateUI,
    this.viewMode = false,
    required this.causerieModel,
    required this.evaluationEnCoursModel_LIEINSPSVR_IDF,
  });
  final Function updateUI;
  final bool viewMode;
  final CauserieModel? causerieModel;
  final String? evaluationEnCoursModel_LIEINSPSVR_IDF;
  @override
  State<GBSystemSignatureScreen> createState() =>
      _GBSystemSignatureScreenState();
}

class _GBSystemSignatureScreenState extends State<GBSystemSignatureScreen> {
  @override
  Widget build(BuildContext context) {
    final m = Get.put<GBSystemSignaturePageController>(
        GBSystemSignaturePageController(context,
            causerieModel: widget.causerieModel, viewMode: widget.viewMode));

    return Obx(() => Stack(
          children: [
            WillPopScope(
              onWillPop: () async {
                widget.updateUI();
                return true;
              },
              child: Scaffold(
                appBar: AppBar(
                  elevation: 4.0,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  toolbarHeight: 80,
                  backgroundColor: GbsSystemServerStrings.str_primary_color,
                  title: const Text(
                    GbsSystemStrings.str_signatur,
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: InkWell(
                    onTap: () {
                      widget.updateUI();
                      Get.back();
                    },
                    child: const Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.white,
                    ),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SingleChildScrollView(
                    child: SignatureWidget(
                      paddingContent: true,
                      causerieModel: widget.causerieModel,
                      viewMode: widget.viewMode,
                      updateUI: widget.updateUI,
                      onBackTap: () {
                        widget.updateUI();
                        Get.back();
                      },
                      controllerCommentaires: m.controller,
                      uploadSignature: (String? signature) async {
                        if (widget.evaluationEnCoursModel_LIEINSPSVR_IDF !=
                            null) {
                          await m.uploadSignature(signature,
                              widget.evaluationEnCoursModel_LIEINSPSVR_IDF!);
                        } else {
                          // causerie
                          await m.uploadSignature(signature, null);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            m.isLoading.value ? Waiting() : Container()
          ],
        ));
  }
}
