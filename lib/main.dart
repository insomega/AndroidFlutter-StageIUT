// lib/main.dart

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mon_projet/prise_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Assure que les bindings Flutter sont initialisés
  await initializeDateFormatting('fr_FR', null); // <--- C'est l'appel à la fonction du package intl
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prise de services automatique', // Titre qui apparaît dans le gestionnaire de tâches
      theme: ThemeData(
        // C'est ici que vous définissez le thème général de votre application
        // Par exemple, la couleur principale de votre barre d'application
        primarySwatch: Colors.blue, // La couleur bleue comme couleur principale
        useMaterial3: true, // Utiliser la dernière version de Material Design
      ),
      // Au lieu de MyHomePage, nous allons maintenant afficher votre nouvel écran
      home: const PriseServiceScreen(),
    );
  }
}
