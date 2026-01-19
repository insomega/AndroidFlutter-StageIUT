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
      theme: ThemeData(useMaterial3: true, primaryColor: Colors.blue[900]),
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
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
  String _currentViewId = 'menu';

  @override
  Widget build(BuildContext context) {
    // Gestion du bouton "Retour" physique sur Android
    return WillPopScope(
      onWillPop: () async {
        if (_currentViewId != 'menu') {
          setState(() => _currentViewId = 'menu');
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: _currentViewId == 'menu'
              ? DynamicMenu(
                  jsonPath: 'assets/menu_config.json',
                  onItemSelected: (id) => setState(() => _currentViewId = id),
                )
              : Stack(
                  children: [
                    AppRouter.getPage(_currentViewId),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: FloatingActionButton.small(
                        onPressed: () => setState(() => _currentViewId = 'menu'),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}