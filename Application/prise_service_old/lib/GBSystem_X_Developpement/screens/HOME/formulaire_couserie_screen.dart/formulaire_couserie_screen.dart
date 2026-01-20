import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/formulaire_couserie_screen.dart/formulaire_couserie_screen_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/signature_page/GBSystem_signature_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/APP_BAR/app_bar_couserie.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/tab_bar.dart';
import 'package:get/get.dart';

class FormulaireCouserieScreen extends StatefulWidget {
  const FormulaireCouserieScreen(
      {super.key, this.visitMode = false, required this.causerieModel});

  final bool visitMode;
  final CauserieModel? causerieModel;
  @override
  State<FormulaireCouserieScreen> createState() =>
      _FormulaireCouserieScreenState();
}

class _FormulaireCouserieScreenState extends State<FormulaireCouserieScreen> {
  void updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final FormulaireCouserieScreenController m = Get.put(
        FormulaireCouserieScreenController(context,
            causerieModel: widget.causerieModel, isViewMode: widget.visitMode));

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        m.evaluationSurSiteController.setDateFinCloture = null;
      },
      child: Scaffold(
        appBar: GBSystemAppBarQuickAccess2(
            isViewMode: widget.visitMode,
            causerieModel: widget.causerieModel,
            onSignatureTap: () {
              Get.to(GBSystemSignatureScreen(
                evaluationEnCoursModel_LIEINSPSVR_IDF: null,
                causerieModel: widget.causerieModel,
                updateUI: updateUI,
                viewMode: widget.visitMode,
              ));
            },
            onChargerTap: () async {
              try {
                widget.visitMode
                    ? await m.chargerDataView(
                        causerieModel: widget.causerieModel!)
                    : await m.chargerData();
                updateUI();
              } catch (e) {
                m.isLoading.value = false;

                GBSystem_ManageCatchErrors().catchErrors(
                  context,
                  message: e.toString(),
                  method: "chargerData",
                  page: "formulaire_couserie_screen",
                );
              }
            },
            listSalarie:
                m.salarieCauserieWithImageController.getAllSalaries ?? []),
        body: Column(
          children: [
            TabBarWidget(
              evaluationEnCoursModel_LIEINSPSVR_IDF: null,
              pageController: m.pageController,
              items: m.items,
              current: m.current,
              scrollController: m.scrollController,
            ),
            Expanded(
              child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: m.pageController,
                  children: m.listPagesFormulaires),
            )
          ],
        ),
      ),
    );
  }
}
