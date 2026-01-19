// lib/app_router.dart

import 'package:flutter/material.dart';
import 'features/service/prise_service.dart'; // Import du nouveau module

class AppRouter {
  static Widget getPage(String id) {
    switch (id) {
      case 'home_link':
        return const Center(child: Text("Bienvenue sur l'Accueil"));
        
      case 'PlanningVacPrise': // ID du menu_config.json
        return const PriseServiceScreen();
        
      case 'planninglistquery':
        return const Center(child: Text("Page Mon Planning"));
        
      case 'bm_messenger':
        return const Center(child: Text("Messagerie interne"));
        
      default:
        return Center(child: Text("La page '$id' n'est pas encore implémentée."));
    }
  }
}