// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'features/dynamic_menu.dart';
import 'app_router.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.blue[900],
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[900]!),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fr', 'FR')],
      home: const MainNavigator(),
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  // On initialise sur 'home_link' pour afficher l'accueil au démarrage
  String _currentViewId = 'home_link';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Si on n'est pas sur l'accueil, le bouton retour ramène à l'accueil
        if (_currentViewId != 'home_link') {
          setState(() => _currentViewId = 'home_link');
          return false;
        }
        return true;
      },
      child: Scaffold(
        // L'AppBar contient automatiquement l'icône pour ouvrir le Drawer
        appBar: AppBar(
          title: const Text("Espace Salarié", 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
          ),
          backgroundColor: Colors.blue[900],
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        
        // Ton menu transformé en tiroir dépliant
        drawer: DynamicMenu(
          jsonPath: 'assets/menu_config.json',
          onItemSelected: (id) {
            setState(() => _currentViewId = id);
          },
        ),
        
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          // Utilise une Key pour que l'AnimatedSwitcher détecte le changement de widget
          child: Container(
            key: ValueKey(_currentViewId),
            child: AppRouter.getPage(_currentViewId),
          ),
        ),
      ),
    );
  }
}