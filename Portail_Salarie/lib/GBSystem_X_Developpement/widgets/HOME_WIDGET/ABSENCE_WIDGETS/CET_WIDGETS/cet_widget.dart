import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_compteur_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_cet_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/CET_WIDGETS/cet_widget_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/TYPE_ABSENCE_DISPLAY_DATA_WIDGET/type_absence_display_data_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';

class CETWidget extends StatelessWidget {
  CETWidget({
    super.key,
    required this.updateLoading,
    required this.updateUI,
    this.isTypeThree = false,
  });
  final Function updateLoading, updateUI;
  final bool isTypeThree;

  @override
  Widget build(BuildContext context) {
    final m = Get.put<CETWidgetController>(CETWidgetController(
      context,
    ));
    print(m.compteurController.getCompteur?.CET_EN_COURS_CP);
    return m.compteurController.getCompteur != null
        ? MainWidget(updateUI: updateUI, updateLoading: updateLoading)
        : FutureBuilder(
            future: GBSystem_AuthService(context).getCompteurCET(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  m.compteurController.setCompteur =
                      snapshot.data!.compteurModel;
                  m.compteurController.setListNombreDesJours =
                      snapshot.data!.listNombreDesJours;

                  return MainWidget(
                    updateUI: updateUI,
                    updateLoading: updateLoading,
                  );
                } else {
                  return EmptyDataWidget();
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 250,
                  child: WaitingWidgets(),
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
    final m = Get.put<CETWidgetController>(CETWidgetController(
      context,
    ));
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => CETDisplayDataWidget(
                  compteurModel: Get.put<GBSystemCompteurController>(
                          GBSystemCompteurController())
                      .getCompteurRx
                      .value,
                ),
              ),
              CalculeCETWidget(
                  updateUI: widget.updateUI,
                  updateLoading: widget.updateLoading,
                  CETModel: GBSystemCETModel(
                    compteurModel: m.compteurController.getCompteur!,
                    listNombreDesJours:
                        m.compteurController.getListNbrJours ?? [],
                  )),
              CustomButtonWithTrailling(
                  verPadding: 8,
                  horPadding: 10,
                  trailling: Icon(
                    CupertinoIcons.pencil_outline,
                    color: Colors.white,
                  ),
                  onTap: () {
                    try {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        m.dialogCompteur(
                            context: context,
                            compteurModel:
                                m.compteurController.getCompteurRx.value!);
                      });
                    } catch (e) {
                      GBSystem_ManageCatchErrors().catchErrors(context,
                          message: e.toString(),
                          method: "showDialogCompteurInfo",
                          page: "cet_widget");
                    }
                  },
                  text: GbsSystemStrings.str_solde_des_absences.tr),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
