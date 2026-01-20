import 'package:bmsoft_ps2/GBSystem_Application/GBSystem_sites_planning_controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_site_planning_model.dart';
import 'package:gbsystem_root/GBSystem_waiting.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:gbsystem_vacation_priseservice/GBSystem_Vacation_Informations_Controller.dart';
import 'package:gbsystem_vacation_priseservice/GBSystem_Vacation_PriseService_Widget.dart';
import 'package:get/get.dart';

class SelectedVacationScreen extends StatefulWidget {
  //  SelectedVacationScreen({super.key, required this.destination});
  SelectedVacationScreen({super.key});

  //final Widget destination;

  @override
  State<SelectedVacationScreen> createState() => _SelectedVacationScreenState();
}

class _SelectedVacationScreenState extends State<SelectedVacationScreen> {
  RxBool isLoading = RxBool(false);
  final GBSystem_Vacation_Informations_Controller vacationController = Get.put(GBSystem_Vacation_Informations_Controller());
  final GBSystemSitesPlanningController sitePlanningController = Get.put(GBSystemSitesPlanningController());

  Future getDataNowWithChanges() async {
    // if (!(vacationController.getFilterLieu) && !(vacationController.getFilterEvenements)) {
    //   await GBSystem_AuthService(context).getAllVacationPlanning(isGetAll: true, evenementList: sitePlanningController.getAllEvenements ?? [], searchText: vacationController.getSearchText, sitePlanningList: sitePlanningController.getAllSites ?? []).then((vacations) async {
    //     vacationController.setAllVacation = vacations;
    //   });
    // } else {
    //   await GBSystem_AuthService(context).getAllVacationPlanning(isGetAll: false, evenementList: vacationController.getFilterEvenements ? vacationController.getAllFiltredEvenements ?? [] : [], searchText: vacationController.getSearchText, sitePlanningList: vacationController.getFilterLieu ? vacationController.getAllFiltredLieu ?? [] : []).then((
    //     vacations,
    //   ) async {
    //     vacationController.setAllVacation = vacations;
    //   });
    // }
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

          await getDataNowWithChanges().then((value) {
            isLoading.value = false;

            // Get.back();
          });
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
                    Get.back();
                    // isLoading.value = true;

                    // await getDataNowWithChanges().then((vacations) async {
                    //   vacationController.setAllVacation = vacations;
                    // });
                    // isLoading.value = false;

                    // Get.back();
                  },
                  child: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
                ),
                backgroundColor: GBSystem_Application_Strings.str_primary_color,
                title: const Text(GBSystem_Application_Strings.str_selected_vacation, style: TextStyle(color: Colors.white)),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GBSystem_Vacation_PriseService_Widget(
                      //
                      isClosePointageAfterExists: true,
                      isUpdatePause: true,
                      isPlanning: true,
                      afficherPrecSuiv: true,
                      afficherOpertaionsBar: true,
                      routeLogin: '',
                    ),
                  ],
                ),
              ),
            ),
            isLoading.value ? Waiting() : Container(),
          ],
        ),
      ),
    );
  }

  Future selectItemSiteFunction(BuildContext context, {required SitePlanningModel selectedSite}) async {
    isLoading.value = true;
    // await GBSystem_AuthService(context).getVacationPlanning(sitePlanningModel: selectedSite).then((vacations) {
    //   vacationController.setAllVacation = vacations;
    //   // if (vacations != null && vacations.isNotEmpty) {
    //   //   vacationController.setCurrentVacationVacation = vacations[0];
    //   // } else {
    //   //   vacationController.setCurrentVacationVacation = null;
    //   // }
    //   // sitePlanningController.setCurrentSite = selectedSite;
    isLoading.value = false;

    //   // Get.back();
    // });
  }
}
