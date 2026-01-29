// lib/app_router.dart

import 'package:flutter/material.dart';
import 'package:gbsystem_menu/features/home_screen.dart';
import 'package:bmsoft_ps2/GBSystem_Application/GBSystem_Vacation_List_PS2_Wigget.dart';

class GBSystem_AppRouter {
  static Widget getPage(String pageId) {
    // pageId est déjà nettoyé par MenuModel.pageId (ex: "bmserver_Planning_VacPriseNG")

    switch (pageId) {
      case 'home_link':
      case 'home_QA':
      case 'home':
        return const GBSystem_HomeScreen();

      case 'bmserver_Planning_VacPriseNG': 
        return const GBSystem_Vacation_List_PS2_Wigget();
        
      case 'bmserver_svr_planning':
        return const Center(child: Text("Mon Planning"));

      case 'bmserver_Server_info':
        return const Center(child: Text("Mes Informations"));

      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.help_outline, size: 80, color: Colors.blueGrey),
              const SizedBox(height: 20),
              Text("Page non trouvée", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("ID recherché : $pageId"),
            ],
          ),
        );
    }
  }
}