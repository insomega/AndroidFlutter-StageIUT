// test/responsive_utils_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mon_projet/utils/responsive_utils_web.dart' as responsive_utils;

void main() {
  group('ResponsiveUtils', () { // Groupe de tests pour ResponsiveUtils

    test('responsivePadding should scale correctly for a typical web width', () {
      // Largeur d'écran simulée
      double screenWidth = 1200.0;
      // Valeur de padding de base
      double basePadding = 10.0;
      // La valeur attendue (si 1200 est la largeur de base, ça devrait être 10.0)
      double expectedPadding = 10.0;

      expect(responsive_utils.responsivePadding(screenWidth, basePadding), expectedPadding);
    });

    test('responsiveFontSize should scale down for smaller screens', () {
      double screenWidth = 600.0;
      double baseFontSize = 20.0;
      // Calculez manuellement la valeur attendue pour 600px si votre base est 1200px et facteur 0.8
      // Ex: (600 / 1200) * 20.0 = 0.5 * 20.0 = 10.0. Mais si vous avez une logique de minimum, ajustez.
      // Il est crucial de connaître la logique exacte de votre responsive_utils.
      double expectedFontSize = 10.0; // À ajuster selon votre implémentation réelle

      expect(responsive_utils.responsiveFontSize(screenWidth, baseFontSize), expectedFontSize);
    });

    // Ajoutez d'autres tests pour responsiveHeight, responsiveWidth, responsiveIconSize, etc.
  });
}