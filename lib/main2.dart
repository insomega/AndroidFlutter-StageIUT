// lib/main.dart

import 'package:flutter/material.dart'; // Importe le package principal de Flutter pour construire l'UI.
import 'package:flutter_localizations/flutter_localizations.dart'; // Importe les délégués de localisation pour les widgets Material et Cupertino.
import 'package:intl/date_symbol_data_local.dart'; // Importe la fonction pour initialiser les données de formatage de date spécifiques à la locale.
import 'package:mon_projet/prise_service.dart'; // Importe l'écran principal de l'application (PriseServiceScreen).

/// Fonction principale d'entrée de l'application Flutter.
///
/// C'est le point de départ de l'exécution de l'application.
/// Elle initialise les bindings de Flutter et les données de formatage de date
/// pour la locale française avant de lancer le widget racine [MyApp].
void main() async {
  /// Assure que les bindings de Flutter sont initialisés avant de lancer l'application.
  /// C'est nécessaire si vous devez faire des opérations asynchrones avant [runApp],
  /// comme l'initialisation des données de localisation.
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialise les données de formatage de date et heure pour la locale française ('fr_FR').
  /// Le second argument `null` signifie qu'il n'y a pas de données spécifiques à charger depuis un fichier JSON.
  await initializeDateFormatting('fr_FR', null);

  /// Lance l'application Flutter en exécutant le widget racine [MyApp].
  runApp(const MyApp());
}

/// `MyApp` est le widget racine de l'application.
///
/// C'est un [StatelessWidget] car l'état global de l'application (le thème, les locales)
/// n'est pas censé changer pendant la durée de vie de ce widget.
class MyApp extends StatelessWidget {
  /// Constructeur de `MyApp`.
  ///
  /// [key] est passé au constructeur du parent [StatelessWidget].
  const MyApp({super.key});

  /// Décrit la partie de l'interface utilisateur représentée par ce widget.
  ///
  /// Construit le [MaterialApp] qui définit le titre de l'application,
  /// le thème visuel, les délégués de localisation, les locales supportées,
  /// et l'écran d'accueil ([PriseServiceScreen]).
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// Le titre de l'application affiché dans le gestionnaire de tâches du système d'exploitation.
      title: 'Prise de services automatique',
      /// Défini à `false` pour masquer le bandeau "DEBUG" en haut à droite de l'application
      /// lorsqu'elle est exécutée en mode débogage.
      debugShowCheckedModeBanner: false,

      /// Définition du thème visuel de l'application.
      theme: ThemeData(
        /// 1. Définir la couleur principale directement (méthode plus ancienne mais toujours fonctionnelle).
        /// Cette propriété est souvent remplacée par `colorScheme.primary` dans les thèmes modernes.
        primaryColor: const Color.fromARGB(255, 17, 89, 197), // Une nuance de bleu-violet.

        /// 2. Définir le [ColorScheme] (méthode recommandée et plus complète pour la gestion des couleurs).
        /// Un `ColorScheme` est un ensemble cohérent de couleurs utilisées dans l'application,
        /// basées sur une couleur "graine".
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 17, 89, 197), // La couleur de base à partir de laquelle le schéma est généré.
          primary: const Color.fromARGB(255, 17, 89, 197), // Couleur principale : utilisée pour les éléments proéminents (AppBar, boutons primaires).
          onPrimary: Colors.white, // Couleur du texte/icône qui contraste avec `primary`.
          secondary: const Color.fromARGB(255, 27, 82, 107), // Couleur secondaire : utilisée pour les accents et les éléments moins proéminents.
          onSecondary: Colors.white, // Couleur du texte/icône qui contraste avec `secondary`.
          error: const Color.fromARGB(255, 143, 2, 2), // Couleur pour les indications d'erreur.
          onError: Colors.white, // Couleur du texte/icône qui contraste avec `error`.
          surface: Colors.white, // Couleur des surfaces des composants (cartes, dialogues, menus).
          onSurface: Colors.black87, // Couleur du texte/icône sur les surfaces.
        ),

        /// Personnalisation des thèmes spécifiques à certains widgets :
        /// Thème de la barre d'application ([AppBar]).
        appBarTheme: const AppBarTheme(
          /// La couleur de fond de l'AppBar sera prise de colorScheme.primary par défaut
          /// ou vous pouvez la définir explicitement ici si elle doit être différente.
          /// backgroundColor: const Color.fromARGB(255, 75, 1, 88), // Exemple de définition explicite.
          iconTheme: IconThemeData(color: Colors.white), // Couleur par défaut des icônes dans l'AppBar.
          titleTextStyle: TextStyle( // Style du texte du titre dans l'AppBar.
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        /// Thème des boutons surélevés ([ElevatedButton]).
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 17, 89, 197), // Couleur du texte/icône du bouton.
            backgroundColor: Colors.white, // Couleur de fond du bouton.
            shape: RoundedRectangleBorder( // Forme du bouton avec des bordures arrondies.
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),

        /// Définition du thème de texte par défaut pour l'ensemble de l'application.
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87), // Style pour le texte de grande taille dans le corps.
          bodyMedium: TextStyle(color: Colors.black87), // Style pour le texte de taille moyenne dans le corps.
        ),

        /// Couleur par défaut pour les icônes.
        iconTheme: const IconThemeData(
          color: Colors.blueGrey, // Couleur par défaut pour toutes les icônes si non spécifiée localement.
        ),

        /// Thème des décorations d'entrée (comme les bordures des [TextField]).
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder( // Style de bordure par défaut (non focus).
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.blueGrey), // Couleur par défaut de la bordure.
          ),
          focusedBorder: OutlineInputBorder( // Style de bordure quand le champ est en focus.
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0), // Utilise la couleur primaire du thème.
          ),
          labelStyle: const TextStyle(color: Colors.blueGrey), // Style du texte de l'étiquette (label).
          hintStyle: const TextStyle(color: Colors.grey), // Style du texte d'aide (hint text).
        ),

        /// Couleur pour les séparateurs (comme [VerticalDivider] ou [Divider]).
        dividerColor: const Color.fromARGB(255, 75, 1, 88), // Couleur pour les lignes de séparation.
      ),

      /// Délégués de localisation pour supporter différentes langues et formats.
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate, // Fournit les localisations pour les widgets Material Design (textes des boutons, dates, etc.).
        GlobalWidgetsLocalizations.delegate, // Fournit les localisations pour les widgets génériques (direction du texte, etc.).
        GlobalCupertinoLocalizations.delegate, // Fournit les localisations pour les widgets de style iOS (si utilisés).
      ],

      /// Locales supportées par l'application.
      supportedLocales: const [
        Locale('fr', 'FR'), // Indique que l'application supporte la locale française (France).
      ],

      /// Force l'application à utiliser la locale française par défaut.
      /// Si cette propriété est omise, Flutter essaiera de détecter la locale du système.
      locale: const Locale('fr', 'FR'),

      /// L'écran d'accueil de l'application.
      home: const PriseServiceScreen(),
    );
  }
}