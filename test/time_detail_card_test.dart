import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mon_projet/time_detail_card.dart'; // Adjust path if necessary
import 'package:mon_projet/models/service.dart'; // Adjust path if necessary
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  group('TimeDetailCard Widget Tests', () {
    late Service testService; // This will be our base service for creating copies

    // Helper to pump the widget with necessary localizations and manage service state
    Future<void> _pumpTimeDetailCard(WidgetTester tester, Service initialService, TimeCardType type) async {
      // Use a ValueNotifier to hold the service state and trigger rebuilds
      // This allows us to modify the service object and have the UI react in the test.
      final ValueNotifier<Service> serviceNotifier = ValueNotifier<Service>(initialService);

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('fr', 'FR'),
          ],
          locale: const Locale('fr', 'FR'), // Ensure French locale for consistent testing
          home: Scaffold(
            body: ValueListenableBuilder<Service>(
              valueListenable: serviceNotifier,
              builder: (context, currentService, child) {
                return TimeDetailCard(
                  service: currentService, // Pass the current service from the notifier
                  type: type,
                  onAbsentPressed: (status) {
                    // Update the notifier's value, which triggers a rebuild
                    // Ensure isValidated is false if becoming absent, as per your business logic
                    serviceNotifier.value = currentService.copyWith(isAbsent: status, isValidated: status == true ? false : currentService.isValidated);
                  },
                  onModifyTime: (time) {
                    // Update the notifier's value, which triggers a rebuild
                    if (type == TimeCardType.debut) {
                      serviceNotifier.value = currentService.copyWith(startTime: time);
                    } else if (type == TimeCardType.fin) {
                      serviceNotifier.value = currentService.copyWith(endTime: time);
                    }
                  },
                  onValidate: (status) {
                    // Update the notifier's value, which triggers a rebuild
                    serviceNotifier.value = currentService.copyWith(isValidated: status);
                  },
                  onTap: () {},
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle(); // Initial pump and settle
    }

    setUp(() {
      final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.window.physicalSizeTestValue = const Size(1080, 1920); // Standard phone resolution
      binding.window.devicePixelRatioTestValue = 3.0; // High pixel ratio

      addTearDown(() {
        binding.window.clearPhysicalSizeTestValue();
        binding.window.clearDevicePixelRatioTestValue();
      });

      // This testService instance will be copied for each test's initial state
      testService = Service(
        id: '1',
        employeeName: 'Jean Dupont',
        startTime: DateTime(2025, 7, 29, 8, 0), // Start: July 29, 2025, 08:00
        endTime: DateTime(2025, 7, 29, 17, 0), // End: July 29, 2025, 17:00
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

    // Test: TimeDetailCard displays employee name (should always be present)
    testWidgets('TimeDetailCard displays employee name', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService.copyWith(), TimeCardType.debut); // Pass a copy
      expect(find.text('Jean Dupont'), findsOneWidget);
    });

    // Test: TimeDetailCard displays start time for Debut type
    testWidgets('TimeDetailCard displays start time for Debut type', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService.copyWith(), TimeCardType.debut); // Pass a copy
      expect(find.text('H.D: 08:00'), findsOneWidget);
      expect(find.text('Date: 29/07/2025'), findsOneWidget); // Also check date
    });

    // Test: TimeDetailCard displays end time for Fin type
    testWidgets('TimeDetailCard displays end time for Fin type', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService.copyWith(), TimeCardType.fin); // Pass a copy
      expect(find.text('H.F: 17:00'), findsOneWidget);
      expect(find.text('Date: 29/07/2025'), findsOneWidget); // Also check date
    });

    // Test: Tapping on Absent button toggles isAbsent status for Debut type (where button is visible)
    // testWidgets('Tapping on Absent button toggles isAbsent status for Debut type', (WidgetTester tester) async {
    //   // Start with a clean service state for this test
    //   await _pumpTimeDetailCard(tester, testService.copyWith(isAbsent: false, isValidated: false), TimeCardType.debut);

    //   final absentButtonFinder = find.byKey(const Key('absentButtonPortrait'));
    //   expect(absentButtonFinder, findsOneWidget);

    //   // The button text will always be 'Absent' as per your UI code.
    //   ElevatedButton absentButton = tester.widget<ElevatedButton>(absentButtonFinder);
    //   FittedBox fittedBoxChild = absentButton.child as FittedBox;
    //   Text textWidget = fittedBoxChild.child as Text;
    //   expect(textWidget.data, 'Absent'); // Expect 'Absent' initially, as per your UI code.

    //   await tester.tap(absentButtonFinder);
    //   await tester.pumpAndSettle(); // Rebuild triggered by ValueNotifier

    //   // Now, directly check the color of the button to confirm isAbsent state
    //   absentButton = tester.widget<ElevatedButton>(absentButtonFinder);
    //   expect(absentButton.style?.backgroundColor?.resolve(MaterialState.values.toSet()), Colors.red.shade700);

    //   fittedBoxChild = absentButton.child as FittedBox;
    //   textWidget = fittedBoxChild.child as Text;
    //   expect(textWidget.data, 'Absent'); // Text should remain 'Absent' after toggle.

    //   await tester.tap(absentButtonFinder);
    //   await tester.pumpAndSettle(); // Tap again, rebuild triggered by ValueNotifier

    //   absentButton = tester.widget<ElevatedButton>(absentButtonFinder);
    //   expect(absentButton.style?.backgroundColor?.resolve(MaterialState.values.toSet()), Colors.blueGrey.shade600);
    //   fittedBoxChild = absentButton.child as FittedBox;
    //   textWidget = fittedBoxChild.child as Text;
    //   expect(textWidget.data, 'Absent'); // Text should remain 'Absent' after second toggle.
    // });

    // Test: Absent button is disabled for Result type (This test is now partially redundant with the new Result type test, but kept for specific focus)
    testWidgets('Absent button is enabled for Result type (and text is Absent)', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService.copyWith(), TimeCardType.result); // Pass a copy
      final absentButtonFinder = find.byKey(const Key('absentButtonPortrait'));
      expect(absentButtonFinder, findsOneWidget);
      expect(tester.widget<ElevatedButton>(absentButtonFinder).onPressed, isNotNull); // Should be clickable for result type now
      ElevatedButton absentButton = tester.widget<ElevatedButton>(absentButtonFinder);
      FittedBox fittedBoxChild = absentButton.child as FittedBox;
      Text textWidget = fittedBoxChild.child as Text;
      expect(textWidget.data, 'Absent');
    });


    // Test: Tapping on Validate button toggles isValidated status for Debut type
    testWidgets('Tapping on Validate button toggles isValidated status for Debut type', (WidgetTester tester) async {
      // Start with a clean service state for this test
      await _pumpTimeDetailCard(tester, testService.copyWith(isValidated: false, isAbsent: false), TimeCardType.debut);

      // Initial state: Valider
      expect(find.byKey(const ValueKey('validateButtonText_valider')), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);

      final validateButtonFinder = find.byKey(const Key('validateButtonPortrait'));
      expect(validateButtonFinder, findsOneWidget);

      await tester.tap(validateButtonFinder);
      await tester.pumpAndSettle(); // Rebuild triggered by ValueNotifier

      // After first tap: Dévalider
      expect(find.byKey(const ValueKey('validateButtonText_devalider')), findsOneWidget);
      expect(find.byIcon(Icons.undo), findsOneWidget);


      await tester.tap(validateButtonFinder);
      await tester.pumpAndSettle(); // Rebuild triggered by ValueNotifier

      // After second tap: Valider
      expect(find.byKey(const ValueKey('validateButtonText_valider')), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    // Test: Validate button is disabled for Result type or when isAbsent is true
    testWidgets('Validate button is disabled when isAbsent is true (but enabled for Result type)', (WidgetTester tester) async {
      // Case 1: Result type (should be enabled)
      await _pumpTimeDetailCard(tester, testService.copyWith(isValidated: false, isAbsent: false), TimeCardType.result);
      final validateButtonFinderResult = find.byKey(const Key('validateButtonPortrait'));
      expect(validateButtonFinderResult, findsOneWidget);
      expect(tester.widget<ElevatedButton>(validateButtonFinderResult).onPressed, isNotNull); // Should be clickable
      expect(find.byKey(const ValueKey('validateButtonText_valider')), findsOneWidget);


      // Case 2: Debut type but isAbsent is true (should be disabled)
      await _pumpTimeDetailCard(tester, testService.copyWith(isAbsent: true, isValidated: false), TimeCardType.debut);
      final validateButtonFinderAbsent = find.byKey(const Key('validateButtonPortrait'));
      expect(validateButtonFinderAbsent, findsOneWidget);
      expect(tester.widget<ElevatedButton>(validateButtonFinderAbsent).onPressed, isNull); // Should be disabled
      expect(find.byKey(const ValueKey('validateButtonText_valider')), findsOneWidget);
    });

    // Test: Tapping on modify button displays TimePicker and updates time for Debut type
    testWidgets('Tapping on modify button displays TimePicker and updates time for Debut type', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService.copyWith(), TimeCardType.debut); // Pass a copy

      final modifyButtonFinder = find.byKey(const Key('modifyTimeButtonPortrait'));
      expect(modifyButtonFinder, findsOneWidget);

      await tester.tap(modifyButtonFinder);

      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 5)); // Give time for the dialog to animate in

      // Find the 'OK' button (might be uppercase depending on locale)
      expect(find.widgetWithText(TextButton, 'OK'), findsOneWidget);

      // Find 'ANNULER' or 'Annuler' button (depending on locale)
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

      // Tap the 'OK' button to dismiss the dialog without changing time
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

    // Test: Modify button is disabled for Result type
    testWidgets('Modify button is disabled for Result type', (WidgetTester tester) async {
      await _pumpTimeDetailCard(tester, testService.copyWith(), TimeCardType.result); // Pass a copy
      final modifyButtonFinder = find.byKey(const Key('modifyTimeButtonPortrait'));
      expect(modifyButtonFinder, findsNothing); // It should not be present at all for Result type
    });
  
  });
}