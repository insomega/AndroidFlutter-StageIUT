// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
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

// lib/main.dart

class _MyHomePageState extends State<MyHomePage> {
  // On stocke l'ID de la vue actuelle
  String _currentViewId = 'menu'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // On utilise un simple "if/else" ou un "Switch" pour la modularité
      body: WillPopScope(
        onWillPop: () async {
          if (_currentViewId != 'menu') {
            setState(() => _currentViewId = 'menu');
            return false;
          }
          return true;
        },
        child: _buildCurrentScreen(),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentViewId) {
      case 'menu':
        return DynamicMenuPackage(
          jsonPath: 'assets/menu_config.json',
          onDestinationSelected: (id) {
            setState(() => _currentViewId = id);
          },
        );
      
      // Ajoutez vos modules ici au fur et à mesure
      case 'planninglistquery':
        return const Center(child: Text("Module Planning")); 
        
      case 'bm_messenger':
        return const Center(child: Text("Module Messagerie"));

      default:
        // Si l'ID n'est pas reconnu, on reste sur le menu avec un message
        return DynamicMenuPackage(
          jsonPath: 'assets/menu_config.json',
          onDestinationSelected: (id) => setState(() => _currentViewId = id),
        );
    }
  }
}