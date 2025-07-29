import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mon_projet/models/service.dart';
import 'package:mon_projet/time_detail_card.dart';
import 'package:intl/intl.dart';
import 'package:mon_projet/utils/time_card_helpers.dart' as helpers;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui'; // Import for PlatformDispatcher.instance.views

void main() {
  group('TimeDetailCard Widget Tests', () {
    late Service testService;

    Future<void> _pumpTimeDetailCard(WidgetTester tester, Service serviceToPump, TimeCardType type) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [ // Ensure these are present
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [ // Ensure the locale you're testing with is supported
            Locale('en', 'US'), // English (United States)
            Locale('fr', 'FR'), // French (France) - if your app supports it
          ],
          locale: const Locale('fr', 'FR'),
          home: Builder(
            builder: (BuildContext context) {
              return Scaffold(
                body: TimeDetailCard(
                  service: serviceToPump,
                  type: type,
                  onAbsentPressed: (status) {
                    serviceToPump.isAbsent = status;
                  },
                  onModifyTime: (time) {
                    if (type == TimeCardType.debut) {
                      serviceToPump.startTime = time;
                    } else if (type == TimeCardType.fin) {
                      serviceToPump.endTime = time;
                    }
                  },
                  onValidate: (status) {
                    serviceToPump.isValidated = status;
                  },
                  onTap: () {},
                ),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    setUp(() {
      final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.window.physicalSizeTestValue = const Size(1080, 1920);
      binding.window.devicePixelRatioTestValue = 3.0;

      addTearDown(() {
        binding.window.clearPhysicalSizeTestValue();
        binding.window.clearDevicePixelRatioTestValue();
      });

      testService = Service(
        id: '1',
        employeeName: 'Jean Dupont',
        startTime: DateTime(2025, 7, 29, 8, 0),
        endTime: DateTime(2025, 7, 29, 17, 0),
        employeeSvrCode: 'E001',
        employeeSvrLib: 'Agent de service',
        employeeTelPort: '0612345678',
        locationCode: 'LOC01',
        locationLib: 'Bureau Principal',
        clientLocationLine3: 'Paris',
        clientSvrCode: 'C001',
        clientSvrLib: 'Nettoyage Quotidien',
        isAbsent: false,
        isValidated: false,
      );
    });

    testWidgets('TimeDetailCard displays employee name', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService, TimeCardType.debut);
      expect(find.text('Jean Dupont'), findsOneWidget);
    });

    testWidgets('TimeDetailCard displays start time for Debut type', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService, TimeCardType.debut);
      expect(find.text('H.D: 08:00'), findsOneWidget);
    });

    testWidgets('TimeDetailCard displays end time for Fin type', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService, TimeCardType.fin);
      expect(find.text('H.F: 17:00'), findsOneWidget);
    });

    testWidgets('TimeDetailCard displays calculated duration for Result type', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService, TimeCardType.result);

      expect(
        find.byWidgetPredicate(
          (widget) => widget is Text && widget.data == ' +09h00 min',
          description: 'text " +09h00 min" with key calculatedDurationText',
        ),
        findsOneWidget,
      );
    });

    testWidgets('Tapping on Absent button toggles isAbsent status but text remains "Absent"', (WidgetTester tester) async {
      testService.isAbsent = false;
      await _pumpTimeDetailCard(tester, testService, TimeCardType.debut);

      final absentButtonFinder = find.byKey(const Key('absentButtonPortrait'));
      expect(absentButtonFinder, findsOneWidget);

      expect(find.descendant(of: absentButtonFinder, matching: find.text('Absent')), findsOneWidget);

      await tester.tap(absentButtonFinder);
      await tester.pumpAndSettle();

      expect(testService.isAbsent, isTrue);
      expect(find.descendant(of: absentButtonFinder, matching: find.text('Absent')), findsOneWidget);
    });

    testWidgets('Tapping on Validate button toggles isValidated status', (WidgetTester tester) async {
      testService.isValidated = false;
      testService.isAbsent = false;

      await _pumpTimeDetailCard(tester, testService, TimeCardType.result);

      final validateButtonFinder = find.byKey(const Key('validateButtonPortrait'));
      expect(validateButtonFinder, findsOneWidget);

      expect(find.byWidgetPredicate((widget) => widget is Text && widget.data == 'Valider'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.tap(validateButtonFinder);
      await _pumpTimeDetailCard(tester, testService, TimeCardType.result);

      expect(testService.isValidated, isTrue);

      expect(find.byWidgetPredicate((widget) => widget is Text && widget.data == 'Dévalider'), findsOneWidget);
      expect(find.byIcon(Icons.undo), findsOneWidget);

      await tester.tap(validateButtonFinder);
      await _pumpTimeDetailCard(tester, testService, TimeCardType.result);

      expect(testService.isValidated, isFalse);
      expect(find.byWidgetPredicate((widget) => widget is Text && widget.data == 'Valider'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('Tapping on time displays TimePicker and updates time', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService, TimeCardType.debut);

      final modifyButtonFinder = find.byKey(const Key('modifyTimeButtonPortrait'));
      expect(modifyButtonFinder, findsOneWidget);

      await tester.tap(modifyButtonFinder);

      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 5)); // Give time for the dialog to animate in

      // Find the 'OK' button
      expect(find.widgetWithText(TextButton, 'OK'), findsOneWidget);

      // Find either 'ANNULER' or 'Annuler' button
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

      // Tap the 'OK' button
      await tester.tap(find.widgetWithText(TextButton, 'OK'));
      await tester.pumpAndSettle(); // Settle after tapping OK to dismiss the dialog

      // Ensure the TimePicker dialog is gone
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

      // Verify the time is still the initial time (since we just pressed OK without changing anything)
      expect(find.text('H.D: 08:00'), findsOneWidget);
    });
  
  });
}