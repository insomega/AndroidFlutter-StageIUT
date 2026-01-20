import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_vacation_state_controller.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class VacationStateWidgetController extends GetxController {

VacationStateWidgetController(this.context);
  BuildContext context;
  Rx<Color?> typeAbsColor =Rx<Color?>(GbsSystemStrings.str_primary_color) ;
  
  final vacationStateController = Get.put<GBSystemVacationStateController>(
      GBSystemVacationStateController());

PageController pageController = PageController(initialPage: 0);
RxInt currentPageIndex = 0.obs;
  

@override
  void onClose() {
  pageController.dispose();
   super.onClose();
  }

@override
  void onInit() {
    if (vacationStateController.getAllVacations.value != null && vacationStateController.getAllVacations.value!.isNotEmpty) {
     final hexColor = vacationStateController.getAllVacations.value!
                      .first.STATE_COLOR
                      .replaceAll(r"#", "")
                      .replaceAll(r"$", "");
                  final color = Color(int.parse(
                    '0xFF$hexColor',
                  ));
                 
    
    
      
      typeAbsColor.value = color;
     
    }
     
   super.onInit();
  }


}