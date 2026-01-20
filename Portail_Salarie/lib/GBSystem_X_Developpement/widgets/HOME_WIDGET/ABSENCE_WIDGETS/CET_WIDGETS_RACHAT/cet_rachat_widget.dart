import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_compteur_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/APPLICATION_MODELS/GBSystem_cet_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/CET_WIDGETS_RACHAT/cet_rachat_widget_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/TYPE_ABSENCE_DISPLAY_DATA_WIDGET/type_absence_display_data_widget.dart';

class CETRachatWidget extends StatelessWidget {
  CETRachatWidget({
    super.key,
    required this.updateLoading,
    required this.updateUI,
  });
  final Function updateLoading, updateUI;

  @override
  Widget build(BuildContext context) {
    final m = Get.put<CETRachatWidgetController>(CETRachatWidgetController(
      context,
    ));
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
    final m = Get.put<CETRachatWidgetController>(CETRachatWidgetController(
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
              CalculeCETRachatWidget(
                  updateUI: widget.updateUI,
                  updateLoading: widget.updateLoading,
                  CETModel: GBSystemCETModel(
                    compteurModel: m.compteurController.getCompteur!,
                    listNombreDesJours:
                        m.compteurController.getListNbrJours ?? [],
                  )),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
