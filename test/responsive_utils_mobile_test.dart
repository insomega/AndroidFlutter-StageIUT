/// test/responsive_utils_mobile_test.dart
library;

// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart'; // Importe les composants Material Design de Flutter.
import 'package:flutter_test/flutter_test.dart'; // Importe le package de test de Flutter pour écrire des tests de widgets.
import 'package:mon_projet/utils/responsive_utils.dart' as mobile_responsive; // Importe le fichier des utilitaires responsives. On le renomme `mobile_responsive` pour éviter les conflits de noms et améliorer la clarté dans les tests.

/// Constantes importées ou reflétant celles définies dans `lib/utils/responsive_utils.dart`
/// pour garantir que les tests sont basés sur les mêmes valeurs de référence.
const double kReferenceScreenWidth = 1000.0; // Largeur d'écran de référence pour les calculs responsives.
const double kMinFontSize = 10.0; // Taille de police minimale autorisée.
const double kMinIconSize = 12.0; // Taille d'icône minimale autorisée.
const double kMinPadding = 2.0; // Espacement (padding) minimal autorisé.

/// Fonction principale pour définir et exécuter les tests.
void main() {
  /// Regroupe un ensemble de tests sous la catégorie 'MobileResponsiveUtils'.
  group('MobileResponsiveUtils', () {
    /// Fonction d'aide privée pour "pomper" (rendre) un widget avec une largeur d'écran spécifique.
    /// Cela simule différentes tailles d'écran pour tester la réactivité des utilitaires.
    ///
    /// [tester] L'instance [WidgetTester] fournie par `flutter_test` pour interagir avec les widgets.
    /// [screenWidth] La largeur d'écran simulée pour le test.
    ///
    /// Retourne un [Future<void>] qui se complète une fois le widget rendu et stabilisé.
    Future<void> pumpTestWidget(WidgetTester tester, double screenWidth) async {
      // S'assure que le binding de test des widgets Flutter est initialisé.
      final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
      // Définit la taille physique de l'écran virtuel pour le test.
      // La hauteur (800.0) est arbitraire car seule la largeur est pertinente pour ces utilitaires.
      binding.window.physicalSizeTestValue = Size(screenWidth, 800.0);
      // Définit le rapport de pixels de l'appareil à 1.0 pour des calculs simples.
      binding.window.devicePixelRatioTestValue = 1.0;

      // Rend un widget MaterialApp minimal.
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              return Scaffold(
                body: Container(),
              );
            },
          ),
        ),
      );
      // Attend que toutes les animations et les cadres soient rendus stables.
      await tester.pumpAndSettle();
    }

    /// `tearDown` est exécuté après chaque test.
    /// Il réinitialise les paramètres de l'écran virtuel pour garantir
    /// que chaque test s'exécute dans un environnement propre et prévisible.
    tearDown(() {
      final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
      // Réinitialise la taille physique de l'écran et le rapport de pixels à leurs valeurs par défaut
      // pour éviter que les réglages d'un test n'affectent les suivants.
      binding.window.clearPhysicalSizeTestValue();
      binding.window.clearDevicePixelRatioTestValue();
    });

    // --- Cas de test pour `responsiveFontSize` ---
    /// Teste que [mobile_responsive.responsiveFontSize] retourne la valeur de base
    /// lorsque la largeur de l'écran correspond à la largeur de référence.
    testWidgets('responsiveFontSize devrait retourner la valeur de base pour la largeur d\'écran de référence', (WidgetTester tester) async {
      // Simule un écran à la largeur de référence.
      await pumpTestWidget(tester, kReferenceScreenWidth);
      // Récupère le BuildContext à partir d'un élément rendu (le Container vide).
      final BuildContext context = tester.element(find.byType(Container));

      double baseFontSize = 20.0;
      // Vérifie que la taille de police renvoyée est approximativement égale à la taille de base.
      expect(mobile_responsive.responsiveFontSize(context, baseFontSize), closeTo(20.0, 0.0001));
    });

    /// Teste que [mobile_responsive.responsiveFontSize] réduit proportionnellement
    /// la taille de police si la largeur de l'écran est inférieure à la référence,
    /// tout en restant au-dessus de la taille minimale.
    testWidgets('responsiveFontSize devrait réduire proportionnellement (au-dessus du minimum)', (WidgetTester tester) async {
      double screenWidth = 750.0; // 75% de la largeur de référence.
      await pumpTestWidget(tester, screenWidth);
      final BuildContext context = tester.element(find.byType(Container));

      double baseFontSize = 20.0;
      double expectedFontSize = 20.0 * (750.0 / kReferenceScreenWidth); // Le calcul attendu est 15.0.
      // Vérifie que la taille de police est réduite proportionnellement.
      expect(mobile_responsive.responsiveFontSize(context, baseFontSize), closeTo(15.0, 0.0001));
    });

    /// Teste que [mobile_responsive.responsiveFontSize] ne descend pas
    /// en dessous de [kMinFontSize] même pour des écrans très petits.
    testWidgets('responsiveFontSize devrait être plafonnée à kMinFontSize pour les très petits écrans', (WidgetTester tester) async {
      double screenWidth = 400.0; // Le résultat calculé serait 20.0 * (400/1000) = 8.0, mais le minimum est 10.0.
      await pumpTestWidget(tester, screenWidth);
      final BuildContext context = tester.element(find.byType(Container));

      double baseFontSize = 20.0;
      // Vérifie que la taille de police ne descend pas en dessous du minimum défini.
      expect(mobile_responsive.responsiveFontSize(context, baseFontSize), closeTo(kMinFontSize, 0.0001));
    });

    /// Teste que [mobile_responsive.responsiveFontSize] augmente proportionnellement
    /// la taille de police si la largeur de l'écran est supérieure à la référence.
    testWidgets('responsiveFontSize devrait augmenter proportionnellement', (WidgetTester tester) async {
      double screenWidth = 1200.0; // 120% de la largeur de référence.
      await pumpTestWidget(tester, screenWidth);
      final BuildContext context = tester.element(find.byType(Container));

      double baseFontSize = 15.0;
      double expectedFontSize = 15.0 * (1200.0 / kReferenceScreenWidth); // Le calcul attendu est 18.0.
      // Vérifie que la taille de police est augmentée proportionnellement.
      expect(mobile_responsive.responsiveFontSize(context, baseFontSize), closeTo(18.0, 0.0001));
    });

    // --- Cas de test pour `responsiveIconSize` ---
    /// Teste que [mobile_responsive.responsiveIconSize] retourne la valeur de base
    /// lorsque la largeur de l'écran correspond à la largeur de référence.
    testWidgets('responsiveIconSize devrait retourner la valeur de base pour la largeur d\'écran de référence', (WidgetTester tester) async {
      await pumpTestWidget(tester, kReferenceScreenWidth);
      final BuildContext context = tester.element(find.byType(Container));

      double baseIconSize = 24.0;
      // Vérifie que la taille d'icône est égale à la valeur de base à la largeur de référence.
      expect(mobile_responsive.responsiveIconSize(context, baseIconSize), closeTo(24.0, 0.0001));
    });

    /// Teste que [mobile_responsive.responsiveIconSize] ne descend pas
    /// en dessous de [kMinIconSize] même pour des écrans très petits.
    testWidgets('responsiveIconSize devrait être plafonnée à kMinIconSize pour les très petits écrans', (WidgetTester tester) async {
      double screenWidth = 400.0; // Le résultat calculé serait 24.0 * (400/1000) = 9.6, mais le minimum est 12.0.
      await pumpTestWidget(tester, screenWidth);
      final BuildContext context = tester.element(find.byType(Container));

      double baseIconSize = 24.0;
      // Vérifie que la taille d'icône ne descend pas en dessous du minimum défini.
      expect(mobile_responsive.responsiveIconSize(context, baseIconSize), closeTo(kMinIconSize, 0.0001));
    });

    // --- Cas de test pour `responsivePadding` ---
    /// Teste que [mobile_responsive.responsivePadding] retourne la valeur de base
    /// lorsque la largeur de l'écran correspond à la largeur de référence.
    testWidgets('responsivePadding devrait retourner la valeur de base pour la largeur d\'écran de référence', (WidgetTester tester) async {
      await pumpTestWidget(tester, kReferenceScreenWidth);
      final BuildContext context = tester.element(find.byType(Container));

      double basePadding = 16.0;
      // Vérifie que l'espacement est égal à la valeur de base à la largeur de référence.
      expect(mobile_responsive.responsivePadding(context, basePadding), closeTo(16.0, 0.0001));
    });

    /// Teste que [mobile_responsive.responsivePadding] est plafonné à une valeur maximale
    /// de réduction (ici, 8.0 pour un padding de base de 16.0) sur de très petits écrans,
    /// en raison d'un facteur de mise à l'échelle minimal.
    testWidgets('responsivePadding devrait être plafonné à 8.0 pour un padding de base de 16.0 sur de très petits écrans', (WidgetTester tester) async {
      double screenWidth = 100.0; // Le résultat calculé serait 16.0 * (100/1000) = 1.6.
      // Cependant, le facteur de mise à l'échelle est plafonné à 0.5 (défini implicitement ou explicitement dans responsive_utils.dart),
      // donc 16.0 * 0.5 = 8.0.
      await pumpTestWidget(tester, screenWidth);
      final BuildContext context = tester.element(find.byType(Container));

      double basePadding = 16.0;
      // La valeur attendue est 8.0 car 16.0 * 0.5 (facteur de plafonnement) = 8.0.
      expect(mobile_responsive.responsivePadding(context, basePadding), closeTo(8.0, 0.0001));
    });

    /// Teste que [mobile_responsive.responsivePadding] ne descend pas
    /// en dessous de [kMinPadding] pour de très petites tailles de base sur de petits écrans.
    testWidgets('responsivePadding devrait être plafonné à kMinPadding pour de très petites tailles de base sur de petits écrans', (WidgetTester tester) async {
      double screenWidth = 100.0; // Le facteur de mise à l'échelle sera plafonné à 0.5.
      await pumpTestWidget(tester, screenWidth);
      final BuildContext context = tester.element(find.byType(Container));

      double basePadding = 3.0; // 3.0 * 0.5 = 1.5, ce qui est inférieur à `kMinPadding` (2.0).
      // Vérifie que l'espacement est plafonné à `kMinPadding` (2.0).
      expect(mobile_responsive.responsivePadding(context, basePadding), closeTo(kMinPadding, 0.0001)); // Attendu 2.0.
    });
  });
}