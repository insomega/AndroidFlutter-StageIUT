import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/QUICK_ACCESS_CONTROLLERS/GBSystem_signature_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_salarie_photo_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/signature_salarie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/causerie_question_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/signature_causerie_widget.dart';
import 'package:get/get.dart';

class FormulaireCauserieType extends StatefulWidget {
  const FormulaireCauserieType(
      {super.key,
      required this.salaries,
      required this.questions,
      this.isViewMode = false,
      this.causerieModel});

  final List<GBSystemSalarieWithPhotoCauserieModel> salaries;
  final List<QuestionModel> questions;
  final bool isViewMode;
  final CauserieModel? causerieModel;

  @override
  State<FormulaireCauserieType> createState() => _FormulaireCauserieTypeState();
}

class _FormulaireCauserieTypeState extends State<FormulaireCauserieType> {
  void updateUI() {
    setState(() {});
  }

  void updateLoading(bool value) {
    setState(() {
      isLoading.value = value;
    });
  }

  RxBool isLoading = RxBool(false);
  final signatureController =
      Get.put<GBSystemSignatureController>(GBSystemSignatureController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.questions.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CauserieQuestionWidget(
                          onInfoTap: () {
                            if (widget.questions[index].questionWithoutMemoModel
                                        .LIEINSPQU_HELP !=
                                    null &&
                                widget.questions[index].questionWithoutMemoModel
                                    .LIEINSPQU_HELP!.isNotEmpty) {
                              showWarningDialog(context,
                                  "${widget.questions[index].questionWithoutMemoModel.LIEINSPQU_HELP}");
                            }
                          },
                          questionModel: widget.questions[index]),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.salaries.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: new SignatureCauserieWidget(
                              updateLoading: updateLoading,
                              isViewMode: widget.isViewMode,
                              previousSignature: getSignatureSalarie(
                                  salarie: widget.salaries[index]),
                              causerieModel: widget.causerieModel,
                              salarie: widget.salaries[index]),
                        );
                      }),
                ],
              ),
            ),
          ),
          isLoading.value ? Waiting() : Container()
        ],
      ),
    );
  }

  SignatureSalarieModel? getSignatureSalarie({
    required GBSystemSalarieWithPhotoCauserieModel salarie,
  }) {
    SignatureSalarieModel? selectedSignature;

    List<SignatureSalarieModel> allSignature =
        signatureController.getAllSignatureSalaries;

    for (var i = 0; i < allSignature.length; i++) {
      if (allSignature[i].SVR_IDF == salarie.salarieCauserieModel.SVR_IDF) {
        selectedSignature = allSignature[i];
      }
    }

    return selectedSignature;
  }
}
