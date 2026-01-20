import 'package:flutter/material.dart';

import 'package:gbsystem_vacation_priseservice/GBSystem_Root_PriseService_Controller.dart';
import 'package:get/get.dart';
import 'package:gbsystem_root/GBSystem_vacation_model.dart';
import 'GBSystem_vacation_informations_Widget.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';
import 'package:gbsystem_root/GBSystem_response_model.dart';

class GBSystem_Vacation_PriseService_Controller extends GBSystem_Root_PriseService_Controller {
  final BuildContext context;
  final bool isUpdatePause;
  final bool isClosePointageAfterExists;
  final String routeLogin;

  GBSystem_Vacation_PriseService_Controller({
    required this.context, //
    required this.isUpdatePause,
    required this.isClosePointageAfterExists,
    required this.routeLogin,
  });

  // Contrôleurs
  //final GBSystemSalarieController salarieController = Get.put(GBSystemSalarieController());
  // final GBSystem_NetworkController internatController = Get.find<GBSystem_NetworkController>();

  // États
  final PageController pageController = PageController(initialPage: 0);
  final RxDouble currentIndex = 0.0.obs;
  final List<GBSystem_Vacation_Informations_Widget> vacationPages = [];

  List<GBSystem_Vacation_Model>? listVacations = [];

  @override
  void onInit() {
    super.onInit();

    _initializeController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<void> _Do_Load_Data() async {
    try {
      ResponseModel data = await Execute_Server_post(
        data: {
          "OKey": GBSystem_System_Strings.str_server_okey, //
          "VAC_LOAD_ETAT": "0",
          "ACT_ID": "B563858EFCEA4379B4A583910CA5B728",
        },
      );
      //Get.log("-----------*************----------data server vac : ${data.data}");
      Vacation_Informations_Controller.setAllVacation = GBSystem_Vacation_Model.fromResponse_List(data);
    } finally {
      //   isLoading.value = false;
    }
  }

  // Future<void> deconnexion() async {
  //   await _performLogout();
  // }

  //=== Méthodes privées =======================================================

  Future<void> _initializeController() async {
    try {
      isLoading.value = true;

      if (Vacation_Informations_Controller.currentVacation == null) {
        await _Do_Load_Data();
      }

      //currentVacation = vacationController.currentVacation;
      _initVacationsPages();
      _setupPageControllerListener();
    } finally {
      isLoading.value = false;
    }
  }

  void _initVacationsPages() {
    vacationPages.add(GBSystem_Vacation_Informations_Widget(isUpdatePause: isUpdatePause));
  }

  void _setupPageControllerListener() {
    pageController.addListener(() {
      currentIndex.value = pageController.page ?? 0;
    });
  }

  // Future<void> _performLogout() async {
  //   //isLoading.value = true;

  //   GBSystem_Storage_Service().clearSessionData();

  //   // final agencesController = Get.put(GBSystemAgenceQuickAccessController());
  //   //agencesController.setLoginAgence = null;

  //   // final preferences = await SharedPreferences.getInstance();
  //   // await preferences.setString(GBSystem_Application_Strings.kToken, "");
  //   // await preferences.setString(GBSystem_Application_Strings.kCookies, "");

  //   //isLoading.value = false;
  //   //Get.offAllNamed(GBSystem_Application_Routes.login);
  //   Get.offAllNamed(routeLogin);
  // }
}
