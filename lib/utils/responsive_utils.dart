// lib/utils/responsive_utils.dart

import 'package:flutter/material.dart'; // Importe le package Flutter pour utiliser `BuildContext` et `MediaQuery`.
import 'dart:math'; // Importe la bibliothèque `dart:math` pour utiliser la fonction `max`.

// Constantes pour le redimensionnement adaptatif (responsive design).
// Ces valeurs servent de référence pour adapter les éléments de l'interface
// en fonction de la largeur de l'écran de l'appareil.
const double kReferenceScreenWidth = 1000.0; // Largeur d'écran de référence (ex: largeur d'un Pixel 3a) pour les calculs.
const double kMinFontSize = 10.0; // Taille de police minimale absolue pour assurer la lisibilité.
const double kMinIconSize = 12.0; // Taille d'icône minimale absolue.
const double kMinPadding = 2.0; // Valeur de padding minimale absolue.

const double kMaxEffectiveScreenWidth = 1920.0;
const double kMaxScalingFactor = kMaxEffectiveScreenWidth / kReferenceScreenWidth;

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

// Calcule une taille de police adaptée à la largeur de l'écran.
// Retourne une taille proportionnelle à `baseSize`, mais jamais inférieure à `kMinFontSize`.
double responsiveFontSize(BuildContext context, double baseSize) {
  // *** Correction ici: Utilisez _getClampedScalingFactor ***
  final double scaledSize = baseSize * _getClampedScalingFactor(context);
  return max(kMinFontSize, scaledSize);
}

// Calcule une taille d'icône adaptée à la largeur de l'écran.
// Retourne une taille proportionnelle à `baseSize`, mais jamais inférieure à `kMinIconSize`.
double responsiveIconSize(BuildContext context, double baseSize) {
  // *** Correction ici: Utilisez _getClampedScalingFactor ***
  final double scaledSize = baseSize * _getClampedScalingFactor(context);
  return max(kMinIconSize, scaledSize);
}

// Calcule une valeur de padding adaptée à la largeur de l'écran.
// Retourne une valeur proportionnelle à `baseSize`, mais jamais inférieure à `kMinPadding`.
double responsivePadding(BuildContext context, double baseSize) {
  // *** Correction ici: Utilisez _getClampedScalingFactor ***
  final double scaledSize = baseSize * _getClampedScalingFactor(context);
  return max(kMinPadding, scaledSize);
}