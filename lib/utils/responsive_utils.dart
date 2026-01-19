// lib/utils/responsive_utils.dart

import 'package:flutter/material.dart'; // Importe le package Flutter pour utiliser `BuildContext` et `MediaQuery`.
import 'dart:math'; // Importe la bibliothèque `dart:math` pour utiliser la fonction `max`.

/// Constantes pour le redimensionnement adaptatif (responsive design).
///
/// Ces valeurs servent de référence pour adapter la taille des éléments de l'interface
/// en fonction de la largeur de l'écran de l'appareil, garantissant ainsi
/// une expérience utilisateur cohérente sur différentes tailles d'écrans.
const double kReferenceScreenWidth = 1000.0; // Largeur d'écran de référence (ex: largeur d'un Pixel 3a) pour les calculs.
const double kMinFontSize = 10.0; // Taille de police minimale absolue pour assurer la lisibilité.
const double kMinIconSize = 12.0; // Taille d'icône minimale absolue.
const double kMinPadding = 2.0; // Valeur de padding minimale absolue.

/// La largeur d'écran maximale effective pour le calcul du facteur de mise à l'échelle.
///
/// Au-delà de cette largeur, les éléments ne seront plus mis à l'échelle pour éviter
/// qu'ils ne deviennent trop grands sur de très grands écrans.
const double kMaxEffectiveScreenWidth = 1920.0;

/// Le facteur de mise à l'échelle maximal, calculé par rapport à [kReferenceScreenWidth].
///
/// Utilisé pour limiter l'agrandissement des éléments sur les écrans très larges.
const double kMaxScalingFactor = kMaxEffectiveScreenWidth / kReferenceScreenWidth;

/// Calcule un facteur de mise à l'échelle ([scalingFactor]) en fonction de la largeur de l'écran.
///
/// Le facteur de mise à l'échelle est basé sur la [kReferenceScreenWidth] et est
/// `clampé` (restreint) entre une valeur minimale (0.5) et une valeur maximale ([kMaxScalingFactor])
/// pour éviter des tailles d'éléments excessivement petites ou grandes.
///
/// [context]: Le [BuildContext] nécessaire pour accéder à la [MediaQuery] et obtenir
///            la largeur actuelle de l'écran.
///
/// Retourne un `double` représentant le facteur de mise à l'échelle ajusté.
double _getClampedScalingFactor(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  // Calcule le facteur de mise à l'échelle brut
  double rawScalingFactor = screenWidth / kReferenceScreenWidth;

  // Clampe le facteur de mise à l'échelle entre une valeur minimale et maximale.
  // Pour la valeur minimale, vous pourriez vouloir qu'elle soit par exemple 0.8
  // pour que les éléments ne deviennent pas minuscules sur de très petits écrans,
  // ou laisser les `kMin*Size` le gérer si la valeur raw est très faible.
  // Utilisons une valeur réaliste comme 0.5 pour éviter une compression excessive,
  // ou vous pouvez même utiliser `kMinFontSize / baseFontSizeReference`
  // si vous avez une taille de base pour tout. Pour l'instant, 0.5 est un bon point de départ.
  return rawScalingFactor.clamp(0.5, kMaxScalingFactor);
}

/// Calcule une taille de police adaptée à la largeur de l'écran.
///
/// Prend en entrée le [BuildContext] pour accéder aux informations de l'écran
/// et une [baseSize] (taille de police souhaitée pour l'écran de référence).
/// Retourne une taille de police proportionnelle à [baseSize],
/// mais jamais inférieure à [kMinFontSize].
///
/// [context]: Le [BuildContext] de l'arbre de widgets.
/// [baseSize]: La taille de police de base pour l'écran de référence.
///
/// Retourne la taille de police responsive.
double responsiveFontSize(BuildContext context, double baseSize) {
  // *** Correction ici: Utilisez _getClampedScalingFactor ***
  final double scaledSize = baseSize * _getClampedScalingFactor(context);
  return max(kMinFontSize, scaledSize);
}

/// Calcule une taille d'icône adaptée à la largeur de l'écran.
///
/// Prend en entrée le [BuildContext] et une [baseSize] (taille d'icône souhaitée pour l'écran de référence).
/// Retourne une taille d'icône proportionnelle à [baseSize],
/// mais jamais inférieure à [kMinIconSize].
///
/// [context]: Le [BuildContext] de l'arbre de widgets.
/// [baseSize]: La taille d'icône de base pour l'écran de référence.
///
/// Retourne la taille d'icône responsive.
double responsiveIconSize(BuildContext context, double baseSize) {
  // *** Correction ici: Utilisez _getClampedScalingFactor ***
  final double scaledSize = baseSize * _getClampedScalingFactor(context);
  return max(kMinIconSize, scaledSize);
}

/// Calcule une valeur de padding adaptée à la largeur de l'écran.
///
/// Prend en entrée le [BuildContext] et une [baseSize] (valeur de padding souhaitée pour l'écran de référence).
/// Retourne une valeur de padding proportionnelle à [baseSize],
/// mais jamais inférieure à [kMinPadding].
///
/// [context]: Le [BuildContext] de l'arbre de widgets.
/// [baseSize]: La valeur de padding de base pour l'écran de référence.
///
/// Retourne la valeur de padding responsive.
double responsivePadding(BuildContext context, double baseSize) {
  // *** Correction ici: Utilisez _getClampedScalingFactor ***
  final double scaledSize = baseSize * _getClampedScalingFactor(context);
  return max(kMinPadding, scaledSize);
}