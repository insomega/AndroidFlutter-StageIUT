import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PLANNING_SCREEN/DISPONIBILITER_PROPOSITION_DE_VACATION_SCREEN/GBSystem_disponibiliter_propositions_vacation_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/PRISE_DE_VACATION_WIDGET_DISPONIBILITER/vacation_prise_de_vacation_disponibiliter_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class DisponibiliterPropositionVacationScreen extends StatefulWidget {
  const DisponibiliterPropositionVacationScreen(
      {super.key, this.isCommingFromOut = false});

  final bool isCommingFromOut;

  @override
  State<DisponibiliterPropositionVacationScreen> createState() =>
      _DisponibiliterPropositionVacationScreenState();
}

class _DisponibiliterPropositionVacationScreenState
    extends State<DisponibiliterPropositionVacationScreen> {
  final m = Get.put<GBSystemDisponibiliterPropositionsVacationScreenController>(
      GBSystemDisponibiliterPropositionsVacationScreenController());

  updateLoading(bool myBool) {
    m.isLoading.value = myBool;
  }

  updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 4.0,
        shadowColor: GbsSystemStrings.str_primary_color,
        toolbarHeight: 80,
        backgroundColor: GbsSystemStrings.str_primary_color,
        title: Text(
          GbsSystemStrings.str_disponibiliter_propositions_de_vacation.tr,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: GbsSystemStrings.str_primary_color,
        onPressed: () {
          m.showDialogAddPriseVacation(updateUI: updateUI, context: context);
        },
        child: Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
      ),
      body: VacationPriseDeVacationDisponibiliterWidget(
          updateUI: updateUI, updateLoading: updateLoading),
    );
  }
}
