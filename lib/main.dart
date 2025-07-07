// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mon_projet/prise_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null); // Initialise les données de formatage de date pour le français
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prise de services automatique',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate, // Délègue les localisations pour les widgets Material Design
        GlobalWidgetsLocalizations.delegate,  // Délègue les localisations pour les widgets génériques
        GlobalCupertinoLocalizations.delegate, // Délègue les localisations pour les widgets de style iOS (si utilisés)
      ],
      supportedLocales: const [
        Locale('fr', 'FR'), // Supporte la locale française
        // Ajoutez d'autres locales si votre application doit supporter d'autres langues
      ],
      locale: const Locale('fr', 'FR'), // Force l'application à démarrer en français
      home: const PriseServiceScreen(),
    );
  }
}
