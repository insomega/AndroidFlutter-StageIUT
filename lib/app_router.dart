// lib/app_router.dart

import 'package:flutter/material.dart';
import 'package:mon_projet/features/home_screen.dart';
import 'features/service/prise_service.dart';

class AppRouter {
  static Widget getPage(String id) {
    switch (id) {
      // Gestion des différents alias de l'accueil
      case 'home_link':
      case 'home_QA':
      case '':
        return const HomeScreen();
        
      case 'bmserver_Planning_VacPriseNG': 
        return const PriseServiceScreen();
        
      default:
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.warning_amber_rounded, size: 50, color: Colors.orange),
                const SizedBox(height: 10),
                Text("Page non implémentée\nID reçu : $id", textAlign: TextAlign.center),
              ],
            ),
          ),
        );
    }
  }
}