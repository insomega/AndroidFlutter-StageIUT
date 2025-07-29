// test/responsive_utils_web_test.dart
// ignore_for_file: unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:mon_projet/utils/responsive_utils_web.dart' as web_responsive;

// Constants from lib/utils/responsive_utils_web.dart for accurate testing
const double _baseWebWidth = 1200.0;
const double _minScaleFactor = 0.5;

void main() {
  group('WebResponsiveUtils', () {
    // --- Test cases for _getResponsiveValue (implicitly tested via public functions) ---

    test('should return baseValue when screenWidth is zero', () {
      expect(web_responsive.responsivePadding(0.0, 10.0), 10.0);
      expect(web_responsive.responsiveFontSize(0.0, 20.0), 20.0);
    });

    test('should return baseValue when screenWidth is negative', () {
      expect(web_responsive.responsivePadding(-100.0, 10.0), 10.0);
      expect(web_responsive.responsiveFontSize(-50.0, 20.0), 20.0);
    });

    // --- Test cases for responsivePadding ---
    test('responsivePadding should return base value for base web width', () {
      double screenWidth = _baseWebWidth;
      double basePadding = 10.0;
      expect(web_responsive.responsivePadding(screenWidth, basePadding), closeTo(10.0, 0.0001));
    });

    test('responsivePadding should scale down proportionally (above min factor)', () {
      double screenWidth = 900.0; // 75% of base
      double basePadding = 20.0;
      double expectedPadding = 20.0 * (900.0 / _baseWebWidth); // 15.0
      expect(web_responsive.responsivePadding(screenWidth, basePadding), closeTo(15.0, 0.0001));
    });

    test('responsivePadding should cap at minScaleFactor for very small screens', () {
      double screenWidth = 300.0; // Below 600.0 (1200 * 0.5)
      double basePadding = 40.0;
      double expectedPadding = 40.0 * _minScaleFactor; // 20.0
      expect(web_responsive.responsivePadding(screenWidth, basePadding), closeTo(20.0, 0.0001));
    });

    test('responsivePadding should scale up proportionally', () {
      double screenWidth = 1500.0; // 125% of base
      double basePadding = 8.0;
      double expectedPadding = 8.0 * (1500.0 / _baseWebWidth); // 10.0
      expect(web_responsive.responsivePadding(screenWidth, basePadding), closeTo(10.0, 0.0001));
    });

    // --- Test cases for responsiveFontSize ---
    test('responsiveFontSize should return base value for base web width', () {
      double screenWidth = _baseWebWidth;
      double baseFontSize = 16.0;
      expect(web_responsive.responsiveFontSize(screenWidth, baseFontSize), closeTo(16.0, 0.0001));
    });

    test('responsiveFontSize should scale down proportionally (above min factor)', () {
      double screenWidth = 720.0; // 60% of base
      double baseFontSize = 25.0;
      double expectedFontSize = 25.0 * (720.0 / _baseWebWidth); // 15.0
      expect(web_responsive.responsiveFontSize(screenWidth, baseFontSize), closeTo(15.0, 0.0001));
    });

    test('responsiveFontSize should cap at minScaleFactor for very small screens', () {
      double screenWidth = 500.0; // Below 600.0 (1200 * 0.5)
      double baseFontSize = 30.0;
      double expectedFontSize = 30.0 * _minScaleFactor; // 15.0
      expect(web_responsive.responsiveFontSize(screenWidth, baseFontSize), closeTo(15.0, 0.0001));
    });

    // --- Add similar tests for responsiveIconSize, responsiveWidth, responsiveHeight ---
    test('responsiveIconSize should scale correctly', () {
      double screenWidth = 960.0;
      double baseIconSize = 24.0;
      double expectedIconSize = baseIconSize * (960.0 / _baseWebWidth);
      expect(web_responsive.responsiveIconSize(screenWidth, baseIconSize), closeTo(19.2, 0.0001));
    });

    test('responsiveWidth should scale correctly', () {
      double screenWidth = 1800.0; // Above base width
      double baseWidth = 200.0;
      double expectedWidth = baseWidth * (1800.0 / _baseWebWidth); // 300.0
      expect(web_responsive.responsiveWidth(screenWidth, baseWidth), closeTo(300.0, 0.0001));
    });

    test('responsiveHeight should scale correctly', () {
      double screenWidth = 400.0; // Very small, should hit min factor
      double baseHeight = 100.0;
      double expectedHeight = baseHeight * _minScaleFactor; // 50.0
      expect(web_responsive.responsiveHeight(screenWidth, baseHeight), closeTo(50.0, 0.0001));
    });
  
  
  });
}