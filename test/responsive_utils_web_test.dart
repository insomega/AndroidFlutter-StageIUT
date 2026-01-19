/// test/responsive_utils_web_test.dart
library;

// ignore_for_file: unused_local_variable

import 'package:flutter_test/flutter_test.dart'; // Importe le framework de test de Flutter, essentiel pour écrire des tests unitaires et de widgets.
import '../stageS4/lib/utils/responsive_utils_web.dart' as web_responsive; // Importe les fonctions utilitaires pour la responsivité web.

/// Constantes importées ou définies localement pour refléter celles du fichier
/// de production. Ces valeurs sont cruciales pour garantir que les tests
/// utilisent les mêmes points de référence que le code de production pour des résultats précis.
const double _baseWebWidth = 1200.0; // Largeur d'écran de base utilisée pour les calculs de proportionnalité.
const double _minScaleFactor = 0.5; // Facteur de réduction minimal : les valeurs ne doivent pas descendre en dessous de 50% de leur valeur de base.

/// Point d'entrée principal pour l'exécution de tous les tests de responsivité web.
void main() {
  /// Le bloc `group` permet de regrouper des tests associés sous un même nom.
  /// Ici, tous les tests concernent les utilitaires de responsivité pour le web,
  /// assurant que les éléments de l'interface utilisateur s'adaptent correctement
  /// aux différentes largeurs d'écran.
  group('WebResponsiveUtils', () {
    // --- Cas de test pour `_getResponsiveValue` (testé implicitement via les fonctions publiques) ---
    /// Ces tests vérifient le comportement des fonctions responsives lorsque la largeur d'écran est non valide.
    /// Étant donné que `_getResponsiveValue` est une fonction privée, elle est testée indirectement
    /// par l'intermédiaire des fonctions publiques qui l'appellent, garantissant ainsi leur robustesse.

    /// Teste que les fonctions responsives retournent la [baseValue]
    /// lorsque la [screenWidth] est nulle.
    test('devrait retourner baseValue lorsque screenWidth est zéro', () {
      // Vérifie que responsivePadding retourne la valeur de base si screenWidth est 0.0.
      expect(web_responsive.responsivePadding(0.0, 10.0), 10.0);
      // Vérifie que responsiveFontSize retourne la valeur de base si screenWidth est 0.0.
      expect(web_responsive.responsiveFontSize(0.0, 20.0), 20.0);
    });

    /// Teste que les fonctions responsives retournent la [baseValue]
    /// lorsque la [screenWidth] est négative.
    test('devrait retourner baseValue lorsque screenWidth est négatif', () {
      // Vérifie que responsivePadding retourne la valeur de base si screenWidth est négatif.
      expect(web_responsive.responsivePadding(-100.0, 10.0), 10.0);
      // Vérifie que responsiveFontSize retourne la valeur de base si screenWidth est négatif.
      expect(web_responsive.responsiveFontSize(-50.0, 20.0), 20.0);
    });

    // --- Cas de test pour `responsivePadding` ---
    /// Teste que [web_responsive.responsivePadding] retourne la valeur de base
    /// lorsque la largeur de l'écran correspond à la largeur web de base.
    test('responsivePadding devrait retourner la valeur de base pour la largeur web de base', () {
      double screenWidth = _baseWebWidth; // Largeur d'écran égale à la largeur de référence.
      double basePadding = 10.0; // Valeur d'espacement de base.
      // On s'attend à ce que l'espacement responsive soit égal à l'espacement de base.
      expect(web_responsive.responsivePadding(screenWidth, basePadding), closeTo(10.0, 0.0001));
    });

    /// Teste que [web_responsive.responsivePadding] réduit proportionnellement
    /// l'espacement si la largeur de l'écran est inférieure à la référence,
    /// tout en restant au-dessus du facteur de mise à l'échelle minimal.
    test('responsivePadding devrait réduire proportionnellement (au-dessus du facteur min)', () {
      double screenWidth = 900.0; // Largeur d'écran correspondant à 75% de la largeur de base.
      double basePadding = 20.0; // Valeur d'espacement de base.
      // Calcul de l'espacement attendu : 20.0 * (900.0 / 1200.0) = 15.0.
      double expectedPadding = 20.0 * (900.0 / _baseWebWidth);
      // On s'attend à ce que l'espacement soit réduit proportionnellement.
      expect(web_responsive.responsivePadding(screenWidth, basePadding), closeTo(15.0, 0.0001));
    });

    /// Teste que [web_responsive.responsivePadding] ne descend pas
    /// en dessous de la valeur calculée par [_minScaleFactor] même pour des écrans très petits.
    test('responsivePadding devrait être plafonné au facteur minScaleFactor pour les très petits écrans', () {
      double screenWidth = 300.0; // Largeur d'écran très petite, bien en dessous de (_baseWebWidth * _minScaleFactor) = 600.0.
      double basePadding = 40.0; // Valeur d'espacement de base.
      // Calcul de l'espacement attendu : 40.0 * 0.5 (facteur minimal) = 20.0.
      double expectedPadding = 40.0 * _minScaleFactor;
      // On s'attend à ce que l'espacement soit plafonné à la valeur minimale calculée.
      expect(web_responsive.responsivePadding(screenWidth, basePadding), closeTo(20.0, 0.0001));
    });

    /// Teste que [web_responsive.responsivePadding] augmente proportionnellement
    /// l'espacement si la largeur de l'écran est supérieure à la référence.
    test('responsivePadding devrait augmenter proportionnellement', () {
      double screenWidth = 1500.0; // Largeur d'écran supérieure à la largeur de base (125%).
      double basePadding = 8.0; // Valeur d'espacement de base.
      // Calcul de l'espacement attendu : 8.0 * (1500.0 / 1200.0) = 10.0.
      double expectedPadding = 8.0 * (1500.0 / _baseWebWidth);
      // On s'attend à ce que l'espacement soit augmenté proportionnellement.
      expect(web_responsive.responsivePadding(screenWidth, basePadding), closeTo(10.0, 0.0001));
    });

    // --- Cas de test pour `responsiveFontSize` ---
    /// Teste que [web_responsive.responsiveFontSize] retourne la valeur de base
    /// lorsque la largeur de l'écran correspond à la largeur web de base.
    test('responsiveFontSize devrait retourner la valeur de base pour la largeur web de base', () {
      double screenWidth = _baseWebWidth; // Largeur d'écran égale à la largeur de référence.
      double baseFontSize = 16.0; // Taille de police de base.
      // On s'attend à ce que la taille de police responsive soit égale à la taille de base.
      expect(web_responsive.responsiveFontSize(screenWidth, baseFontSize), closeTo(16.0, 0.0001));
    });

    /// Teste que [web_responsive.responsiveFontSize] réduit proportionnellement
    /// la taille de police si la largeur de l'écran est inférieure à la référence,
    /// tout en restant au-dessus du facteur de mise à l'échelle minimal.
    test('responsiveFontSize devrait réduire proportionnellement (au-dessus du facteur min)', () {
      double screenWidth = 720.0; // Largeur d'écran correspondant à 60% de la largeur de base.
      double baseFontSize = 25.0; // Taille de police de base.
      // Calcul de la taille de police attendue : 25.0 * (720.0 / 1200.0) = 15.0.
      double expectedFontSize = 25.0 * (720.0 / _baseWebWidth);
      // On s'attend à ce que la taille de police soit réduite proportionnellement.
      expect(web_responsive.responsiveFontSize(screenWidth, baseFontSize), closeTo(15.0, 0.0001));
    });

    /// Teste que [web_responsive.responsiveFontSize] ne descend pas
    /// en dessous de la valeur calculée par [_minScaleFactor] même pour des écrans très petits.
    test('responsiveFontSize devrait être plafonnée au facteur minScaleFactor pour les très petits écrans', () {
      double screenWidth = 500.0; // Largeur d'écran très petite, en dessous de (_baseWebWidth * _minScaleFactor) = 600.0.
      double baseFontSize = 30.0; // Taille de police de base.
      // Calcul de la taille de police attendue : 30.0 * 0.5 (facteur minimal) = 15.0.
      double expectedFontSize = 30.0 * _minScaleFactor;
      // On s'attend à ce que la taille de police soit plafonnée à la valeur minimale calculée.
      expect(web_responsive.responsiveFontSize(screenWidth, baseFontSize), closeTo(15.0, 0.0001));
    });

    // --- Ajout de tests similaires pour `responsiveIconSize`, `responsiveWidth`, `responsiveHeight` ---
    /// Teste que [web_responsive.responsiveIconSize] s'adapte correctement
    /// en fonction de la largeur de l'écran.
    test('responsiveIconSize devrait s\'adapter correctement', () {
      double screenWidth = 960.0; // Largeur d'écran.
      double baseIconSize = 24.0; // Taille d'icône de base.
      // Calcul de la taille d'icône attendue : 24.0 * (960.0 / 1200.0) = 19.2.
      double expectedIconSize = baseIconSize * (960.0 / _baseWebWidth);
      // On s'attend à ce que la taille de l'icône s'adapte correctement.
      expect(web_responsive.responsiveIconSize(screenWidth, baseIconSize), closeTo(19.2, 0.0001));
    });

    /// Teste que [web_responsive.responsiveWidth] s'adapte correctement
    /// en fonction de la largeur de l'écran, y compris pour des augmentations.
    test('responsiveWidth devrait s\'adapter correctement', () {
      double screenWidth = 1800.0; // Largeur d'écran supérieure à la largeur de base.
      double baseWidth = 200.0; // Largeur de base.
      // Calcul de la largeur attendue : 200.0 * (1800.0 / 1200.0) = 300.0.
      double expectedWidth = baseWidth * (1800.0 / _baseWebWidth);
      // On s'attend à ce que la largeur s'adapte correctement.
      expect(web_responsive.responsiveWidth(screenWidth, baseWidth), closeTo(300.0, 0.0001));
    });

    /// Teste que [web_responsive.responsiveHeight] s'adapte correctement
    /// en fonction de la largeur de l'écran, en étant plafonnée par le facteur minimal.
    test('responsiveHeight devrait s\'adapter correctement', () {
      double screenWidth = 400.0; // Largeur d'écran très petite, devrait atteindre le facteur minimal.
      double baseHeight = 100.0; // Hauteur de base.
      // Calcul de la hauteur attendue : 100.0 * 0.5 (facteur minimal) = 50.0.
      double expectedHeight = baseHeight * _minScaleFactor;
      // On s'attend à ce que la hauteur s'adapte correctement en étant plafonnée par le facteur minimal.
      expect(web_responsive.responsiveHeight(screenWidth, baseHeight), closeTo(50.0, 0.0001));
    });
  });
}