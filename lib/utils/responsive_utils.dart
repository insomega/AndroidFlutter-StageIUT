// lib/utils/responsive_utils.dart
import 'package:flutter/material.dart';
import 'dart:math';

// Constantes pour le redimensionnement adaptatif
const double kReferenceScreenWidth = 1000.0; // Largeur d'écran de référence pour les calculs de taille (ex: largeur d'un Pixel 3a)
const double kMinFontSize = 10.0; // Taille de police minimale absolue (pour lisibilité extrême)
const double kMinIconSize = 12.0; // Taille d'icône minimale absolue
const double kMinPadding = 2.0; // Padding minimal absolu

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