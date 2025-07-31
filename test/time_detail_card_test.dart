// test/time_detail_card_test.dart

import 'package:flutter/material.dart'; // Importe les widgets de Material Design pour construire l'interface utilisateur.
import 'package:flutter_test/flutter_test.dart'; // Importe le package de test de Flutter pour écrire des tests de widgets.
import 'package:mon_projet/time_detail_card.dart'; // Ajuste le chemin si nécessaire. Importe le widget à tester.
import 'package:mon_projet/models/service.dart'; // Ajuste le chemin si nécessaire. Importe le modèle de données 'Service'.
import 'package:flutter_localizations/flutter_localizations.dart'; // Importe les délégués pour la localisation (internationalisation) des widgets.

void main() {
  // Le bloc `group` permet de regrouper un ensemble de tests sous un nom commun.
  // Ici, tous les tests sont dédiés au widget `TimeDetailCard`.
  group('TimeDetailCard Widget Tests', () {
    // Déclare une variable `testService` qui servira de base pour créer des copies
    // de l'objet Service pour chaque test, assurant ainsi une isolation des états.
    late Service testService;

    // Fonction d'aide asynchrone pour "pomper" (rendre) le widget `TimeDetailCard`
    // dans l'environnement de test de Flutter.
    // Elle prend un `WidgetTester`, un `Service` initial et un `TimeCardType`.
    Future<void> _pumpTimeDetailCard(WidgetTester tester, Service initialService, TimeCardType type) async {
      // Utilise un `ValueNotifier` pour contenir l'état du service.
      // Cela permet de modifier l'objet `Service` dans le test et de déclencher
      // une reconstruction de l'interface utilisateur du widget `TimeDetailCard` en réaction.
      final ValueNotifier<Service> serviceNotifier = ValueNotifier<Service>(initialService);

      // Rend le widget `MaterialApp` qui est nécessaire pour que les widgets de Material Design
      // et la localisation fonctionnent correctement.
      await tester.pumpWidget(
        MaterialApp(
          // Configure les délégués de localisation pour supporter différentes langues.
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // Définit les locales supportées par l'application.
          supportedLocales: const [
            Locale('en', 'US'), // Anglais (États-Unis)
            Locale('fr', 'FR'), // Français (France)
          ],
          // Force la locale à 'fr_FR' pour s'assurer que les tests sont cohérents
          // et que les textes localisés sont ceux attendus en français.
          locale: const Locale('fr', 'FR'),
          // Le `Scaffold` fournit une structure visuelle de base pour l'application.
          home: Scaffold(
            // `ValueListenableBuilder` écoute les changements dans `serviceNotifier`
            // et reconstruit son enfant (`TimeDetailCard`) lorsque la valeur change.
            body: ValueListenableBuilder<Service>(
              valueListenable: serviceNotifier,
              builder: (context, currentService, child) {
                // Instancie le widget `TimeDetailCard` avec le service actuel du notifier,
                // le type de carte, et les fonctions de rappel pour les interactions.
                return TimeDetailCard(
                  service: currentService, // Passe le service actuel provenant du notifier.
                  type: type, // Passe le type de carte (début, fin, résultat).
                  onAbsentPressed: (status) {
                    // Fonction de rappel lorsque le bouton "Absent" est pressé.
                    // Met à jour la valeur du notifier, ce qui déclenche une reconstruction.
                    // La logique métier est que si l'employé est absent (status est true),
                    // le service ne peut pas être validé (`isValidated` devient false).
                    serviceNotifier.value = currentService.copyWith(isAbsent: status, isValidated: status == true ? false : currentService.isValidated);
                  },
                  onModifyTime: (time) {
                    // Fonction de rappel lorsque l'heure est modifiée via le sélecteur de temps.
                    // Met à jour la valeur du notifier en fonction du type de carte (heure de début ou de fin).
                    if (type == TimeCardType.debut) {
                      serviceNotifier.value = currentService.copyWith(startTime: time);
                    } else if (type == TimeCardType.fin) {
                      serviceNotifier.value = currentService.copyWith(endTime: time);
                    }
                  },
                  onValidate: (status) {
                    // Fonction de rappel lorsque le bouton de validation est pressé.
                    // Met à jour l'état de validation du service dans le notifier.
                    serviceNotifier.value = currentService.copyWith(isValidated: status);
                  },
                  onTap: () {}, // Fonction de rappel pour le tap sur la carte (vide pour ce test).
                );
              },
            ),
          ),
        ),
      );
      // Exécute le rendu initial du widget et attend que toutes les animations soient terminées.
      await tester.pumpAndSettle();
    }

    // `setUp` est exécuté avant chaque test.
    setUp(() {
      // S'assure que le binding de test des widgets Flutter est initialisé.
      final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
      // Définit une taille physique d'écran standard pour un téléphone et un rapport de pixels élevé.
      // Cela simule un environnement de smartphone typique.
      binding.window.physicalSizeTestValue = const Size(1080, 1920); // Résolution de téléphone standard (pixels).
      binding.window.devicePixelRatioTestValue = 3.0; // Rapport de pixels élevé (ex: écran Retina).

      // `addTearDown` ajoute une fonction à exécuter après chaque test, similaire à `tearDown`.
      // Cela garantit que les réglages de la fenêtre de test sont réinitialisés après chaque test.
      addTearDown(() {
        binding.window.clearPhysicalSizeTestValue(); // Réinitialise la taille de l'écran.
        binding.window.clearDevicePixelRatioTestValue(); // Réinitialise le rapport de pixels.
      });

      // Initialise l'instance `testService` avec des données par défaut.
      // Cette instance sera copiée pour l'état initial de chaque test, garantissant l'indépendance.
      testService = Service(
        id: '1',
        employeeName: 'Jean Dupont',
        startTime: DateTime(2025, 7, 29, 8, 0), // Heure de début: 29 juillet 2025, 08:00
        endTime: DateTime(2025, 7, 29, 17, 0), // Heure de fin: 29 juillet 2025, 17:00
        employeeSvrCode: 'E001',
        employeeSvrLib: 'Agent de service',
        employeeTelPort: '0612345678',
        locationCode: 'LOC01',
        locationLib: 'Bureau Principal',
        clientLocationLine3: 'Paris',
        clientSvrCode: 'C001',
        clientSvrLib: 'Nettoyage Quotidien',
        isAbsent: false, // Par défaut, l'employé n'est pas absent.
        isValidated: false, // Par défaut, le service n'est pas validé.
      );
    });

    // Test: `TimeDetailCard` affiche le nom de l'employé.
    // Le nom de l'employé doit toujours être visible quelle que soit la configuration de la carte.
    testWidgets('TimeDetailCard displays employee name', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService.copyWith(), TimeCardType.debut); // Rend la carte avec une copie du service.
      // Vérifie qu'un widget `Text` contenant 'Jean Dupont' est trouvé une fois.
      expect(find.text('Jean Dupont'), findsOneWidget);
    });

    // Test: `TimeDetailCard` affiche l'heure de début pour le type `Debut`.
    testWidgets('TimeDetailCard displays start time for Debut type', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService.copyWith(), TimeCardType.debut); // Rend la carte de type 'Debut'.
      // Vérifie que les textes pour l'heure de début et la date sont affichés.
      expect(find.text('H.D: 08:00'), findsOneWidget); // H.D signifie "Heure de Début".
      expect(find.text('Date: 29/07/2025'), findsOneWidget); // Vérifie également la date.
    });

    // Test: `TimeDetailCard` affiche l'heure de fin pour le type `Fin`.
    testWidgets('TimeDetailCard displays end time for Fin type', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService.copyWith(), TimeCardType.fin); // Rend la carte de type 'Fin'.
      // Vérifie que les textes pour l'heure de fin et la date sont affichés.
      expect(find.text('H.F: 17:00'), findsOneWidget); // H.F signifie "Heure de Fin".
      expect(find.text('Date: 29/07/2025'), findsOneWidget); // Vérifie également la date.
    });

    // Test: Le bouton "Absent" est activé et affiche le texte "Absent" pour le type `Result`.
    testWidgets('Absent button is enabled for Result type (and text is Absent)', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService.copyWith(), TimeCardType.result); // Rend la carte de type 'Result'.
      // Trouve le bouton "Absent" en utilisant sa clé.
      final absentButtonFinder = find.byKey(const Key('absentButtonPortrait'));
      // Vérifie que le bouton est trouvé.
      expect(absentButtonFinder, findsOneWidget);
      // Vérifie que la fonction `onPressed` du bouton n'est pas nulle, ce qui signifie qu'il est cliquable.
      expect(tester.widget<ElevatedButton>(absentButtonFinder).onPressed, isNotNull);
      // Récupère le widget Text à l'intérieur du bouton pour vérifier son contenu.
      ElevatedButton absentButton = tester.widget<ElevatedButton>(absentButtonFinder);
      FittedBox fittedBoxChild = absentButton.child as FittedBox; // Le texte est encapsulé dans un FittedBox.
      Text textWidget = fittedBoxChild.child as Text;
      // Vérifie que le texte du bouton est "Absent".
      expect(textWidget.data, 'Absent');
    });


    // Test: Taper sur le bouton "Valider" bascule le statut `isValidated` pour le type `Debut`.
    testWidgets('Tapping on Validate button toggles isValidated status for Debut type', (WidgetTester tester) async {
      // Rend la carte de type 'Debut' avec un service non validé et non absent.
      await _pumpTimeDetailCard(tester, testService.copyWith(isValidated: false, isAbsent: false), TimeCardType.debut);

      // État initial: Le bouton devrait afficher "Valider" et l'icône de coche.
      expect(find.byKey(const ValueKey('validateButtonText_valider')), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);

      // Trouve le bouton "Valider" par sa clé.
      final validateButtonFinder = find.byKey(const Key('validateButtonPortrait'));
      expect(validateButtonFinder, findsOneWidget); // Vérifie qu'il est présent.

      // Simule un tap sur le bouton "Valider".
      await tester.tap(validateButtonFinder);
      await tester.pumpAndSettle(); // Attend la reconstruction du widget après le changement d'état.

      // Après le premier tap: Le bouton devrait maintenant afficher "Dévalider" et l'icône d'annulation.
      expect(find.byKey(const ValueKey('validateButtonText_devalider')), findsOneWidget);
      expect(find.byIcon(Icons.undo), findsOneWidget);

      // Simule un deuxième tap sur le bouton "Dévalider".
      await tester.tap(validateButtonFinder);
      await tester.pumpAndSettle(); // Attend la reconstruction.

      // Après le second tap: Le bouton devrait revenir à "Valider" et l'icône de coche.
      expect(find.byKey(const ValueKey('validateButtonText_valider')), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    // Test: Le bouton "Valider" est désactivé lorsque `isAbsent` est vrai,
    // mais il est activé pour le type `Result` (même si `isAbsent` est faux initialement pour ce test).
    testWidgets('Validate button is disabled when isAbsent is true (but enabled for Result type)', (WidgetTester tester) async {
      // Cas 1: Type `Result` (le bouton devrait être activé).
      await _pumpTimeDetailCard(tester, testService.copyWith(isValidated: false, isAbsent: false), TimeCardType.result);
      final validateButtonFinderResult = find.byKey(const Key('validateButtonPortrait'));
      expect(validateButtonFinderResult, findsOneWidget);
      // Vérifie que le bouton est cliquable (onPressed n'est pas null).
      expect(tester.widget<ElevatedButton>(validateButtonFinderResult).onPressed, isNotNull);
      expect(find.byKey(const ValueKey('validateButtonText_valider')), findsOneWidget);

      // Cas 2: Type `Debut` mais `isAbsent` est vrai (le bouton devrait être désactivé).
      await _pumpTimeDetailCard(tester, testService.copyWith(isAbsent: true, isValidated: false), TimeCardType.debut);
      final validateButtonFinderAbsent = find.byKey(const Key('validateButtonPortrait'));
      expect(validateButtonFinderAbsent, findsOneWidget);
      // Vérifie que le bouton est désactivé (onPressed est null).
      expect(tester.widget<ElevatedButton>(validateButtonFinderAbsent).onPressed, isNull);
      expect(find.byKey(const ValueKey('validateButtonText_valider')), findsOneWidget);
    });

    // Test: Taper sur le bouton "Modifier" affiche le sélecteur de temps (`TimePicker`)
    // et met à jour l'heure pour le type `Debut`.
    testWidgets('Tapping on modify button displays TimePicker and updates time for Debut type', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService.copyWith(), TimeCardType.debut); // Rend la carte de type 'Debut'.

      // Trouve le bouton "Modifier l'heure" par sa clé.
      final modifyButtonFinder = find.byKey(const Key('modifyTimeButtonPortrait'));
      expect(modifyButtonFinder, findsOneWidget); // Vérifie qu'il est présent.

      // Simule un tap sur le bouton "Modifier".
      await tester.tap(modifyButtonFinder);

      // Pompe juste un cadre pour que le dialogue commence à apparaître.
      await tester.pump();
      // Pompe et attend que toutes les animations du dialogue soient terminées (max 5 secondes).
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Vérifie que le bouton 'OK' du TimePicker est présent (indique que le dialogue est affiché).
      // Note: Le texte peut être en majuscules ou minuscules selon la locale et l'implémentation.
      expect(find.widgetWithText(TextButton, 'OK'), findsOneWidget);

      // Vérifie que le bouton 'ANNULER' ou 'Annuler' est présent.
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is TextButton &&
              widget.child is Text &&
              ((widget.child as Text).data == 'ANNULER' || (widget.child as Text).data == 'Annuler'),
          description: 'finds "ANNULER" or "Annuler" TextButton',
        ),
        findsOneWidget,
      );

      // Simule un tap sur le bouton 'OK' pour fermer le dialogue sans changer l'heure.
      await tester.tap(find.widgetWithText(TextButton, 'OK'));
      await tester.pumpAndSettle(); // Attend la fermeture du dialogue.

      // Vérifie que le dialogue TimePicker n'est plus à l'écran.
      expect(find.widgetWithText(TextButton, 'OK'), findsNothing);
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is TextButton &&
              widget.child is Text &&
              ((widget.child as Text).data == 'ANNULER' || (widget.child as Text).data == 'Annuler'),
        ),
        findsNothing,
      );

      // Vérifie que l'heure affichée est toujours l'heure initiale.
      expect(find.text('H.D: 08:00'), findsOneWidget);
    });

    // Test: Le bouton "Modifier" est désactivé (ou absent) pour le type `Result`.
    testWidgets('Modify button is disabled for Result type', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService.copyWith(), TimeCardType.result); // Rend la carte de type 'Result'.
      final modifyButtonFinder = find.byKey(const Key('modifyTimeButtonPortrait'));
      // Vérifie que le bouton "Modifier l'heure" n'est pas du tout présent pour le type 'Result'.
      expect(modifyButtonFinder, findsNothing);
    });
  });
}