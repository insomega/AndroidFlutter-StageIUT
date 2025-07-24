// lib/time_card_helpers.dart

import 'package:flutter/material.dart';
import 'dart:math';

// Constantes pour le redimensionnement adaptatif (copie de prise_service_mobile.dart pour autonomie)
const double kReferenceScreenWidth = 1000.0;
const double kMinFontSize = 8.5;
const double kMinIconSize = 14.0;
const double kMinPadding = 4.0;

// Fonctions d'aide pour le redimensionnement
double responsiveFontSize(BuildContext context, double baseSize) {
  final screenWidth = MediaQuery.of(context).size.width;
  return max(kMinFontSize, baseSize * (screenWidth / kReferenceScreenWidth));
}

double responsiveIconSize(BuildContext context, double baseSize) {
  final screenWidth = MediaQuery.of(context).size.width;
  return max(kMinIconSize, baseSize * (screenWidth / kReferenceScreenWidth));
}

double responsivePadding(BuildContext context, double baseSize) {
  final screenWidth = MediaQuery.of(context).size.width;
  return max(kMinPadding, baseSize * (screenWidth / kReferenceScreenWidth));
}

// Fonction utilitaire pour formater la durée (gère les négatifs)
String formatDuration(Duration duration) {
  String sign = '';
  if (duration.isNegative) {
    sign = '-';
    duration = -duration;
  } else {
    sign = '+';
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final String hours = twoDigits(duration.inHours);
  final String minutes = twoDigits(duration.inMinutes.remainder(60));
  return '$sign${hours}h$minutes min';
}
