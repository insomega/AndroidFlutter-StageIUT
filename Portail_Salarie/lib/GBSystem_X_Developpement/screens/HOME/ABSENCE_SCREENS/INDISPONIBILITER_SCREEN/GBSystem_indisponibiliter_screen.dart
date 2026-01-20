import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/ABSENCE_SCREENS/INDISPONIBILITER_SCREEN/GBSystem_indisponibiliter_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/INDISPONIBILITER_WIDGET_ABSENCE/indisponibiliter_widget_absence.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemIndisponibiliterScreen extends StatefulWidget {
  const GBSystemIndisponibiliterScreen(
      {super.key, this.isCommingFromOut = false});

  final bool isCommingFromOut;
  @override
  State<GBSystemIndisponibiliterScreen> createState() =>
      _GBSystemIndisponibiliterScreenState();
}

class _GBSystemIndisponibiliterScreenState
    extends State<GBSystemIndisponibiliterScreen> {
  final m = Get.put<indisponibiliterScreenController>(
      indisponibiliterScreenController());

  updateLoading(bool myBool) {
    m.isLoading.value = myBool;
  }

  updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: GbsSystemStrings.str_primary_color,
        onPressed: () {
          try {
            m.showDialogAddIndisponibiliter(
                updateUI: updateUI, context: context);
          } catch (e) {
            GBSystem_ManageCatchErrors().catchErrors(context,
                message: e.toString(),
                method: "open dialog",
                page: "GBSystem_indisponibiliter_screen");
          }
        },
        child: Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
      ),
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 4.0,
        shadowColor: GbsSystemStrings.str_primary_color,
        toolbarHeight: 80,
        backgroundColor: GbsSystemStrings.str_primary_color,
        title: Text(
          GbsSystemStrings.str_indisponibiliter_recurrentes.tr,
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
      body: IndisponibiliterAbsenceWidget(
          updateUI: updateUI, updateLoading: updateLoading),
    );
  }
}
