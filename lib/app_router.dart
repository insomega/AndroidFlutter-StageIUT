import 'package:flutter/material.dart';

class AppRouter {
  // Cette fonction retourne le widget correspondant à l'ID du menu
  static Widget getPage(String id) {
    switch (id) {
      case 'home_link':
        return const Center(child: Text("Bienvenue sur l'Accueil"));
      case 'planninglistquery':
        return const Center(child: Text("Page Planning en construction"));
      case 'bm_messenger':
        return const Center(child: Text("Messagerie interne"));
      default:
        return Center(child: Text("La page '$id' n'est pas encore implémentée."));
    }
  }
}