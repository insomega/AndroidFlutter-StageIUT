//import 'dart:io';

//import 'package:flutter/material.dart';
//import 'package:get/get.dart';
//import 'package:gbsystem_root/GBSystem_Storage_Service.dart';
//import 'package:local_auth/local_auth.dart';

// import 'package:bmsoft_ps2/GBSystem_Application/GBSystem_FilterBottomSheet.dart';
// import 'package:flutter/material.dart';
// import 'package:gbsystem_serveur/GBSystem_Serveur_Info_Model.dart';

import 'package:gbsystem_root/GBSystem_Root_MainView_Controller.dart';
//import 'package:gbsystem_root/GBSystem_Vacation_Informations_Controller.dart';
//import 'package:gbsystem_root/GBSystem_salarie_controller.dart';

//import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
//import 'package:gbsystem_root/GBSystem_response_model.dart';
//import 'package:gbsystem_root/GBSystem_System_Strings.dart';
//import '../GBSystem_Serveur/GBSystem_salarie_photo_model.dart';
//import 'package:gbsystem_root/GBSystem_vacation_model.dart';
//import 'Routes/GBSystem_Application_Routes.dart';

class GBSystem_MainForm_PS2_Controller extends GBSystem_Root_MainForm_Controller {
  // GBSystem_Serveur_Info_Model? salarie;
  // String? imageSalarie;
  // GBSystem_Vacation_Model? vacation, vacationPrec, vacationSuiv;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  @override
  void onClose() {
    //_subscription?.cancel();
    super.onClose();
  }

  // Future<void> _initializeData_For_First_VAcation() async {
  //   try {} catch (e) {
  //     GBSystem_Add_LogEvent(message: e.toString(), method: "_initializeData_For_First_VAcation", page: "GBSystem_MainForm_PS2_Controller");
  //   }
  // }

  Future<void> _initializeData() async {
    try {
      isLoading.value = true;
      //Get.log('start----------------------------------------_initializeData');

      //await _initializeData_For_Connected_Server();
      // await _initializeData_For_First_VAcation();
      //Get.log('centre----------------------------------------_initializeData');
    } catch (e) {
      GBSystem_Add_LogEvent(message: e.toString(), method: "_initializeData", page: "GBSystem_MainForm_PS2_Controller");
    } finally {
      //Get.log('end----------------------------------------_initializeData');
      isLoading.value = false;
    }
  }

  // void do_showfilter(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
  //     builder: (context) => FilterBottomSheet(),
  //   );
  // }
}
