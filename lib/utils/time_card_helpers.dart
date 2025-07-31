// lib/time_card_helpers.dart

import 'package:flutter/material.dart'; // Importe le package Flutter pour utiliser `BuildContext` et `MediaQuery`.
import 'dart:math'; // Importe la bibliothèque `dart:math` pour utiliser la fonction `max`.

/// Constantes pour le redimensionnement adaptatif (responsive design) des éléments UI.
///
/// Ces valeurs sont utilisées comme références pour adapter les tailles de police,
/// icônes et padding en fonction de la largeur de l'écran. Elles sont potentiellement
/// copiées depuis un autre fichier pour assurer l'autonomie de ce fichier d'aide
/// dans un contexte spécifique (par exemple, pour des widgets autonomes).
const double kReferenceScreenWidth = 1000.0; // Largeur d'écran de référence en pixels pour le calcul des tailles.
const double kMinFontSize = 8.5; // Taille de police minimale pour éviter qu'elle ne devienne illisible.
const double kMinIconSize = 14.0; // Taille d'icône minimale.
const double kMinPadding = 4.0; // Valeur de padding minimale.

/// Fonction d'aide pour calculer une taille de police responsive.
///
/// Prend en entrée le [BuildContext] pour accéder aux informations de l'écran
/// et une [baseSize] (taille de police souhaitée pour l'écran de référence).
/// Retourne une taille de police adaptée à la largeur actuelle de l'écran,
/// sans jamais être inférieure à [kMinFontSize].
///
/// [context]: Le [BuildContext] de l'arbre de widgets.
/// [baseSize]: La taille de police de base pour l'écran de référence.
///
/// Retourne la taille de police responsive calculée.
double responsiveFontSize(BuildContext context, double baseSize) {
  final screenWidth = MediaQuery.of(context).size.width; // Récupère la largeur actuelle de l'écran.
  // Calcule la nouvelle taille de police en proportion de la largeur de l'écran par rapport à la référence.
  // Utilise `max` pour s'assurer que la taille ne tombe jamais en dessous de [kMinFontSize].
  return max(kMinFontSize, baseSize * (screenWidth / kReferenceScreenWidth));
}

/// Fonction d'aide pour calculer une taille d'icône responsive.
///
/// Prend en entrée le [BuildContext] et une [baseSize] (taille d'icône souhaitée pour l'écran de référence).
/// Retourne une taille d'icône adaptée à la largeur actuelle de l'écran,
/// sans jamais être inférieure à [kMinIconSize].
///
/// [context]: Le [BuildContext] de l'arbre de widgets.
/// [baseSize]: La taille d'icône de base pour l'écran de référence.
///
/// Retourne la taille d'icône responsive calculée.
double responsiveIconSize(BuildContext context, double baseSize) {
  final screenWidth = MediaQuery.of(context).size.width; // Récupère la largeur actuelle de l'écran.
  // Calcule la nouvelle taille d'icône proportionnellement.
  // Utilise `max` pour s'assurer que la taille ne tombe jamais en dessous de [kMinIconSize].
  return max(kMinIconSize, baseSize * (screenWidth / kReferenceScreenWidth));
}

/// Fonction d'aide pour calculer une valeur de padding responsive.
///
/// Prend en entrée le [BuildContext] et une [baseSize] (valeur de padding souhaitée pour l'écran de référence).
/// Retourne une valeur de padding adaptée à la largeur actuelle de l'écran,
/// sans jamais être inférieure à [kMinPadding].
///
/// [context]: Le [BuildContext] de l'arbre de widgets.
/// [baseSize]: La valeur de padding de base pour l'écran de référence.
///
/// Retourne la valeur de padding responsive calculée.
double responsivePadding(BuildContext context, double baseSize) {
  final screenWidth = MediaQuery.of(context).size.width; // Récupère la largeur actuelle de l'écran.
  // Calcule la nouvelle valeur de padding proportionnellement.
  // Utilise `max` pour s'assurer que la valeur ne tombe jamais en dessous de [kMinPadding].
  return max(kMinPadding, baseSize * (screenWidth / kReferenceScreenWidth));
}

/// Fonction utilitaire pour formater une durée en une chaîne de caractères lisible.
///
/// Gère les durées positives et négatives, en ajoutant un signe approprié.
/// Par exemple:
/// - Une durée de 90 minutes sera formatée en "+01h30 min".
/// - Une durée de -30 minutes sera formatée en "-00h30 min".
///
/// [duration]: L'objet [Duration] à formater.
///
/// Retourne une chaîne de caractères ([String]) représentant la durée formatée.
String formatDuration(Duration duration) {
  String sign = ''; // Variable pour stocker le signe (+ ou -).

  // Vérifie si la durée est négative.
  if (duration.isNegative) {
    sign = '-'; // Si négative, le signe est '-'.
    duration = -duration; // Convertit la durée en positive pour le calcul, le signe est déjà géré.
  } else {
    sign = '+'; // Si positive ou nulle, le signe est '+'.
  }

  /// Fonction locale utilitaire pour formater un nombre entier en deux chiffres.
  ///
  /// Ajoute un zéro en préfixe si le nombre est inférieur à 10.
  ///
  /// [n]: Le nombre entier à formater.
  ///
  /// Retourne une chaîne de caractères ([String]) de deux chiffres.
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  // Calcule les heures totales de la durée.
  final String hours = twoDigits(duration.inHours);
  // Calcule les minutes restantes après avoir soustrait les heures complètes.
  final String minutes = twoDigits(duration.inMinutes.remainder(60));

  // Retourne la chaîne de caractères formatée.
  return '$sign${hours}h$minutes min';
}