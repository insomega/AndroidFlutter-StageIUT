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

// Calcule une taille de police adaptée à la largeur de l'écran.
// Retourne une taille proportionnelle à `baseSize`, mais jamais inférieure à `kMinFontSize`.
double responsiveFontSize(BuildContext context, double baseSize) {
  final screenWidth = MediaQuery.of(context).size.width; // Récupère la largeur actuelle de l'écran.
  return max(kMinFontSize, baseSize * (screenWidth / kReferenceScreenWidth)); // Calcule la taille responsive.
}

// Calcule une taille d'icône adaptée à la largeur de l'écran.
// Retourne une taille proportionnelle à `baseSize`, mais jamais inférieure à `kMinIconSize`.
double responsiveIconSize(BuildContext context, double baseSize) {
  final screenWidth = MediaQuery.of(context).size.width; // Récupère la largeur actuelle de l'écran.
  return max(kMinIconSize, baseSize * (screenWidth / kReferenceScreenWidth)); // Calcule la taille responsive.
}

// Calcule une valeur de padding adaptée à la largeur de l'écran.
// Retourne une valeur proportionnelle à `baseSize`, mais jamais inférieure à `kMinPadding`.
double responsivePadding(BuildContext context, double baseSize) {
  final screenWidth = MediaQuery.of(context).size.width; // Récupère la largeur actuelle de l'écran.
  return max(kMinPadding, baseSize * (screenWidth / kReferenceScreenWidth)); // Calcule le padding responsive.
}