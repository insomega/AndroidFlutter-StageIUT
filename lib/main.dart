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
      debugShowCheckedModeBanner: false, // Cache le bandeau "DEBUG"
      theme: ThemeData(
        // 1. Définir la couleur principale directement (méthode plus ancienne mais toujours fonctionnelle)
        primaryColor: const Color.fromARGB(255, 17, 89, 197), // Un violet foncé

        // 2. Définir le ColorScheme (méthode recommandée et plus complète)
        // C'est ici que vous définissez un ensemble cohérent de couleurs.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 17, 89, 197), // Couleur de base pour générer le schéma
          primary: const Color.fromARGB(255, 17, 89, 197),    // Couleur principale (utilisée pour l'AppBar, boutons, etc.)
          onPrimary: Colors.white,                          // Couleur du texte/icône sur la couleur primaire
          secondary: const Color.fromARGB(255, 27, 82, 107), // Couleur secondaire (pour les accents, par exemple)
          onSecondary: Colors.white,                        // Couleur du texte/icône sur la couleur secondaire
          error: const Color.fromARGB(255, 143, 2, 2),      // Couleur pour les messages d'erreur
          onError: Colors.white,                            // Couleur du texte/icône sur la couleur d'erreur
          //background: Colors.white,                         // Couleur de fond générale de l'application
          //onBackground: Colors.black87,                     // Couleur du texte/icône sur le fond
          surface: Colors.white,                            // Couleur des surfaces (cartes, dialogues)
          onSurface: Colors.black87,                        // Couleur du texte/icône sur les surfaces
        ),

        // Vous pouvez également personnaliser d'autres aspects du thème ici :
        appBarTheme: const AppBarTheme(
          // La couleur de fond de l'AppBar sera prise de colorScheme.primary par défaut
          // ou vous pouvez la définir explicitement ici si elle doit être différente.
          // backgroundColor: const Color.fromARGB(255, 75, 1, 88),
          iconTheme: IconThemeData(color: Colors.white), // Couleur des icônes dans l'AppBar
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 17, 89, 197), // Couleur du texte/icône du bouton
            backgroundColor: Colors.white, // Couleur de fond du bouton
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),

        // Définir la couleur du texte par défaut pour l'ensemble de l'application
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black87),
          // Ajoutez d'autres styles de texte si nécessaire
        ),

        // Couleur pour les icônes par défaut
        iconTheme: const IconThemeData(
          color: Colors.blueGrey, // Couleur par défaut pour les icônes si non spécifiée ailleurs
        ),

        // Couleur pour les bordures de l'OutlineInputBorder (comme dans le TextField)
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.blueGrey), // Couleur par défaut de la bordure
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0), // Bordure quand le champ est focus
          ),
          labelStyle: const TextStyle(color: Colors.blueGrey), // Couleur du label
          hintStyle: const TextStyle(color: Colors.grey), // Couleur du hint text
        ),

        // Couleur pour les séparateurs (comme le VerticalDivider)
        dividerColor: const Color.fromARGB(255, 75, 1, 88),
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
