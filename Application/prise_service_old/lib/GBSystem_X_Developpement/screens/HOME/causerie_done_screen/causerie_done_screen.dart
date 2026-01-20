import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_site_quick_access_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/causerie_done_screen/causerie_done_screen_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/formulaire_couserie_screen.dart/formulaire_couserie_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/causerie_done_widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class CauserieDoneScreen extends StatefulWidget {
  const CauserieDoneScreen(
      {super.key,
      required this.dateDebut,
      required this.dateFin,
      required this.site});
  final DateTime? dateDebut, dateFin;
  final SiteQuickAccesModel? site;

  @override
  State<CauserieDoneScreen> createState() => _CauserieDoneScreenState();
}

class _CauserieDoneScreenState extends State<CauserieDoneScreen> {
  @override
  Widget build(BuildContext context) {
    final CauserieDoneScreenController m =
        Get.put(CauserieDoneScreenController(context));
    print("dsdsds-------dsd");
    return Obx(
      () => Stack(
        children: [
          Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 4.0,
                shadowColor: Colors.grey.withOpacity(0.5),
                toolbarHeight: 80,
                backgroundColor: GbsSystemServerStrings.str_primary_color,
                title: const Text(
                  GbsSystemStrings.str_causerie_terminer,
                  style: TextStyle(color: Colors.white),
                ),
                leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.white,
                    )),
              ),
              body: FutureBuilder(
                future: GBSystem_AuthService(context).getAllCauserieTerminer(
                    dateDebut: m.evaluationSurSiteController.getDateDebut,
                    dateFin: m.evaluationSurSiteController.getDateFin,
                    site: m.evaluationSurSiteController.getSelectedSite),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: CauserieDoneWidget(
                                onViewTap: () async {
                                  if (m.evaluationSurSiteController
                                          .getSelectedQuestionnaire !=
                                      null) {
                                    await m
                                        .getCauserieDataView(
                                            causerieModel:
                                                snapshot.data![index])
                                        .then(
                                      (value) {
                                        Get.to(FormulaireCouserieScreen(
                                          causerieModel: snapshot.data![index],
                                          visitMode: true,
                                        ));
                                      },
                                    );
                                  } else {
                                    showErrorDialog(
                                        context,
                                        GbsSystemStrings
                                            .str_choisi_questionnaire);
                                  }
                                },
                                onDeleteTap: () async {
                                  showWarningSnackBar(
                                    context,
                                    GbsSystemStrings.str_supprission_question,
                                    () async {
                                      try {
                                        m.isLoading.value = true;

                                        await GBSystem_AuthService(context)
                                            .deleteCauserie(
                                                causerieModel:
                                                    snapshot.data![index])
                                            .then(
                                          (value) {
                                            m.isLoading.value = false;

                                            if (value) {
                                              setState(() {});
                                              showSuccesDialog(
                                                  context,
                                                  GbsSystemStrings
                                                      .str_operation_effectuee);
                                            }
                                          },
                                        );
                                      } catch (e) {
                                        m.isLoading.value = false;
                                        GBSystem_ManageCatchErrors()
                                            .catchErrors(
                                          context,
                                          message: e.toString(),
                                          method: "deleteCauserie",
                                          page: "causerie_done_screen",
                                        );
                                      }
                                    },
                                  );
                                },
                                causerieModel: snapshot.data![index]),
                          );
                        },
                      );
                    } else {
                      return EmptyDataWidget(
                        heightLottie:
                            GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.8),
                      );
                    }
                  } else {
                    return Waiting();
                  }
                },
              )),
          m.isLoading.value ? Waiting() : Container()
        ],
      ),
    );
  }
}
