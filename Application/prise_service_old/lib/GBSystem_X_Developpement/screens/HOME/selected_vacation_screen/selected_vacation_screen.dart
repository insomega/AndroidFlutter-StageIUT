import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/PLANNING_CONTROLLERS/GBSystem_sites_planning_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/controllers/SALARIES_CONTROLLERS/GBSystem_vacation_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_site_planning_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_vacation_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_WIDGET/GBSystem_user_entrer_sortie.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class SelectedVacationScreen extends StatefulWidget {
  SelectedVacationScreen({
    super.key,
    required this.destination,
  });

  final Widget destination;

  @override
  State<SelectedVacationScreen> createState() => _SelectedVacationScreenState();
}

class _SelectedVacationScreenState extends State<SelectedVacationScreen> {
  RxBool isLoading = RxBool(false);
  final GBSystemVacationController vacationController =
      Get.put(GBSystemVacationController());
  final GBSystemSitesPlanningController sitePlanningController =
      Get.put(GBSystemSitesPlanningController());

  Future getDataNowWithChanges() async {
    if (!(vacationController.getFilterLieu) &&
        !(vacationController.getFilterEvenements)) {
      await GBSystem_AuthService(context)
          .getAllVacationPlanning(
              isGetAll: true,
              evenementList: sitePlanningController.getAllEvenements ?? [],
              searchText: vacationController.getSearchText,
              sitePlanningList: sitePlanningController.getAllSites ?? [])
          .then((vacations) async {
        vacationController.setAllVacation = vacations;
      });
    } else {
      await GBSystem_AuthService(context)
          .getAllVacationPlanning(
              isGetAll: false,
              evenementList: vacationController.getFilterEvenements
                  ? vacationController.getAllFiltredEvenements ?? []
                  : [],
              searchText: vacationController.getSearchText,
              sitePlanningList: vacationController.getFilterLieu
                  ? vacationController.getAllFiltredLieu ?? []
                  : [])
          .then((vacations) async {
        vacationController.setAllVacation = vacations;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: true,
        // canPop: true,
        onPopInvoked: (didPop) async {
          // charger new data
          isLoading.value = true;

          await getDataNowWithChanges().then(
            (value) {
              isLoading.value = false;

              // Get.back();
            },
          );
        },
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                elevation: 4.0,
                centerTitle: true,
                shadowColor: Colors.grey.withOpacity(0.5),
                toolbarHeight: 70,
                leading: InkWell(
                    onTap: () async {
                      // if (sitePlanningController.getCurrentSite != null) {
                      //   await selectItemSiteFunction(context,
                      //       selectedSite:
                      //           sitePlanningController.getCurrentSite!);

                      //   // Get.back();
                      //   Get.offAll(widget.destination);
                      // } else {
                      //   // Get.back();
                      //   // Get.back();
                      //   Get.offAll(widget.destination);
                      // }
                      // charger new data
                      isLoading.value = true;

                      await getDataNowWithChanges().then((vacations) async {
                        vacationController.setAllVacation = vacations;
                      });
                      isLoading.value = false;

                      Get.back();
                    },
                    child: const Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.white,
                    )),
                backgroundColor: GbsSystemServerStrings.str_primary_color,
                title: const Text(
                  GbsSystemStrings.str_selected_vacation,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UserEnterSortie(
                      isClosePointageAfterExists: true,
                      isUpdatePause: true,
                      isPlanning: true,
                      afficherPrecSuiv: true,
                      afficherOpertaionsBar: true,
                    ),
                  ],
                ),
              ),
            ),
            isLoading.value ? Waiting() : Container()
          ],
        ),
      ),
    );
  }

  Future selectItemSiteFunction(BuildContext context,
      {required SitePlanningModel selectedSite}) async {
    isLoading.value = true;
    await GBSystem_AuthService(context)
        .getVacationPlanning(sitePlanningModel: selectedSite)
        .then((vacations) {
      vacationController.setAllVacation = vacations;
      // if (vacations != null && vacations.isNotEmpty) {
      //   vacationController.setCurrentVacationVacation = vacations[0];
      // } else {
      //   vacationController.setCurrentVacationVacation = null;
      // }
      // sitePlanningController.setCurrentSite = selectedSite;
      isLoading.value = false;

      // Get.back();
    });
  }
}
