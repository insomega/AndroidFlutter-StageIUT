// lib/app_router.dart

import 'package:flutter/material.dart';
import 'package:mon_projet/features/home_screen.dart';
import 'features/service/prise_service.dart';

class AppRouter {
  static Widget getPage(String id) {
    switch (id) {
      case 'home_link':
        return const HomeScreen();
        
      case 'PlanningVacPrise': 
        return const PriseServiceScreen();
        
      case 'bmserver_svr_planning': 
        return const Center(child: Text("Page Mon Planning (Extraction HREF)"));
        
      case 'planninglistquery':
        return const Center(child: Text("Page Mon Planning (ID fallback)"));
        
      case 'bm_messenger':
        return const Center(child: Text("Messagerie interne"));
        
      default:
        return Scaffold(
          body: Center(child: Text("ID reçu : $id")),
        );
    }
  }
}