// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mon_projet/prise_service.dart'; // Importe PriseServiceScreen
import 'dynamic_menu_pkg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prise de services automatique',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 17, 89, 197),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 17, 89, 197),
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', 'FR'),
      ],
      locale: const Locale('fr', 'FR'),
      // On lance maintenant MyHomePage qui contient la logique du menu
      home: const MyHomePage(), 
    );
  }
}

// Définition de la classe MyHomePage qui manquait dans ton code
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _currentView = 'menu'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentView == 'menu' ? 'Menu Principal' : 'Prise de Service'),
        leading: _currentView != 'menu' 
          ? IconButton(
              icon: const Icon(Icons.arrow_back), 
              onPressed: () => setState(() => _currentView = 'menu'),
            )
          : null,
      ),
      body: _currentView == 'menu'
        ? DynamicMenuPackage(
            jsonPath: 'assets/menu_config.json',
              onDestinationSelected: (id) {
                print("ID cliqué : $id"); // Ajoute ceci pour déboguer dans la console VS Code
                
                if (id == 'prise_service') {
                  setState(() => _currentView = 'prise_service');
                } else if (id == 'home_screen') {
                  // Action pour l'accueil (par exemple, rester sur le menu ou afficher une snackbar)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Vous êtes déjà sur l'accueil")),
                  );
                } else if (id == 'profile_screen') {
                  // Action pour le profil
                  print("Ouvrir le profil");
                }
              },
            )
          // Correction du nom de la classe : PriseServiceScreen (d'après tes fichiers)
          : const PriseServiceScreen(), 
    );
  }
}