// test/responsive_utils_mobile_test.dart
// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mon_projet/utils/responsive_utils.dart' as mobile_responsive; // Renamed alias for clarity

// Constants from lib/utils/responsive_utils.dart for accurate testing
const double kReferenceScreenWidth = 1000.0;
const double kMinFontSize = 10.0;
const double kMinIconSize = 12.0;
const double kMinPadding = 2.0;

void main() {
  group('MobileResponsiveUtils', () {
    // Helper to pump a widget with a specific screen width
    Future<void> _pumpTestWidget(WidgetTester tester, double screenWidth) async {
      final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.window.physicalSizeTestValue = Size(screenWidth, 800.0); // Set width, arbitrary height
      binding.window.devicePixelRatioTestValue = 1.0; // Set pixel ratio

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              // We need a widget to grab the BuildContext from
              return Scaffold(
                body: Container(),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle(); // Settle any animations
    }

    // Reset window size after each test
    tearDown(() {
      final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.window.clearPhysicalSizeTestValue();
      binding.window.clearDevicePixelRatioTestValue();
    });

    // --- Test cases for responsiveFontSize ---
    testWidgets('responsiveFontSize should return base value for reference screen width', (WidgetTester tester) async {
      await _pumpTestWidget(tester, kReferenceScreenWidth);
      final BuildContext context = tester.element(find.byType(Container));

      double baseFontSize = 20.0;
      expect(mobile_responsive.responsiveFontSize(context, baseFontSize), closeTo(20.0, 0.0001));
    });

    testWidgets('responsiveFontSize should scale down proportionally (above minimum)', (WidgetTester tester) async {
      double screenWidth = 750.0; // 75% of reference
      await _pumpTestWidget(tester, screenWidth);
      final BuildContext context = tester.element(find.byType(Container));

      double baseFontSize = 20.0;
      double expectedFontSize = 20.0 * (750.0 / kReferenceScreenWidth); // 15.0
      expect(mobile_responsive.responsiveFontSize(context, baseFontSize), closeTo(15.0, 0.0001));
    });

    testWidgets('responsiveFontSize should cap at kMinFontSize for very small screens', (WidgetTester tester) async {
      double screenWidth = 400.0; // Result would be 20.0 * (400/1000) = 8.0, but min is 10.0
      await _pumpTestWidget(tester, screenWidth);
      final BuildContext context = tester.element(find.byType(Container));

      double baseFontSize = 20.0;
      expect(mobile_responsive.responsiveFontSize(context, baseFontSize), closeTo(kMinFontSize, 0.0001));
    });

    testWidgets('responsiveFontSize should scale up proportionally', (WidgetTester tester) async {
      double screenWidth = 1200.0; // 120% of reference
      await _pumpTestWidget(tester, screenWidth);
      final BuildContext context = tester.element(find.byType(Container));

      double baseFontSize = 15.0;
      double expectedFontSize = 15.0 * (1200.0 / kReferenceScreenWidth); // 18.0
      expect(mobile_responsive.responsiveFontSize(context, baseFontSize), closeTo(18.0, 0.0001));
    });

    // --- Test cases for responsiveIconSize ---
    testWidgets('responsiveIconSize should return base value for reference screen width', (WidgetTester tester) async {
      await _pumpTestWidget(tester, kReferenceScreenWidth);
      final BuildContext context = tester.element(find.byType(Container));

      double baseIconSize = 24.0;
      expect(mobile_responsive.responsiveIconSize(context, baseIconSize), closeTo(24.0, 0.0001));
    });

    testWidgets('responsiveIconSize should cap at kMinIconSize for very small screens', (WidgetTester tester) async {
      double screenWidth = 400.0; // Result would be 24.0 * (400/1000) = 9.6, but min is 12.0
      await _pumpTestWidget(tester, screenWidth);
      final BuildContext context = tester.element(find.byType(Container));

      double baseIconSize = 24.0;
      expect(mobile_responsive.responsiveIconSize(context, baseIconSize), closeTo(kMinIconSize, 0.0001));
    });

    // --- Test cases for responsivePadding ---
    testWidgets('responsivePadding should return base value for reference screen width', (WidgetTester tester) async {
      await _pumpTestWidget(tester, kReferenceScreenWidth);
      final BuildContext context = tester.element(find.byType(Container));

      double basePadding = 16.0;
      expect(mobile_responsive.responsivePadding(context, basePadding), closeTo(16.0, 0.0001));
    });

    testWidgets('responsivePadding should cap at kMinPadding for very small screens', (WidgetTester tester) async {
      double screenWidth = 100.0; // Result would be 16.0 * (100/1000) = 1.6, but min is 2.0
      await _pumpTestWidget(tester, screenWidth);
      final BuildContext context = tester.element(find.byType(Container));

      double basePadding = 16.0;
      expect(mobile_responsive.responsivePadding(context, basePadding), closeTo(kMinPadding, 0.0001));
    });
  
  
  });
}