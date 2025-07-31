// lib/utils/responsive_utils_web.dart

// Largeur de référence pour le design web. Ajustez cette valeur en fonction
// de la résolution de base de votre design sur le web.
const double _baseWebWidth = 1200.0;

// Facteur de mise à l'échelle minimal pour empêcher les éléments de devenir trop petits.
// Par exemple, ne pas réduire en dessous de 50% de la valeur de base.
const double _minScaleFactor = 0.5;

// Fonction d'aide privée (préfixée par un underscore) pour calculer une valeur responsive.
// Cette fonction prend la largeur actuelle de l'écran (screenWidth) et une valeur de base
// (par exemple, un espacement de base, une taille de police de base).
double _getResponsiveValue(double screenWidth, double baseValue) {
  // Gère le cas où la largeur de l'écran pourrait être zéro ou négative,
  // en retournant dans ce cas la valeur de base pour éviter des erreurs ou des tailles incorrectes.
  if (screenWidth <= 0) {
    return baseValue;
  }
  // Calcule une valeur mise à l'échelle basée sur la largeur de référence.
  // La valeur est proportionnelle à la largeur de l'écran par rapport à la largeur de référence.
  double scaledValue = (baseValue / _baseWebWidth) * screenWidth;

  // S'assure que la valeur mise à l'échelle ne descend pas en dessous d'un seuil minimal.
  // Si la valeur calculée est inférieure à (baseValue * _minScaleFactor),
  // alors la valeur minimale est utilisée. Sinon, la valeur mise à l'échelle est conservée.
  // Ce seuil peut être personnalisé plus spécifiquement pour chaque fonction publique si nécessaire.
  return scaledValue > (baseValue * _minScaleFactor) ? scaledValue : (baseValue * _minScaleFactor);
}

// --- Fonctions publiques de responsivité ---

// Calcule un espacement (padding) responsive.
// Prend la largeur de l'écran et un espacement de base, et retourne un espacement ajusté.
double responsivePadding(double screenWidth, double basePadding) {
  return _getResponsiveValue(screenWidth, basePadding);
}

// Calcule une taille de police (font size) responsive.
// Prend la largeur de l'écran et une taille de police de base, et retourne une taille de police ajustée.
double responsiveFontSize(double screenWidth, double baseFontSize) {
  return _getResponsiveValue(screenWidth, baseFontSize);
}

// Calcule une taille d'icône (icon size) responsive.
// Prend la largeur de l'écran et une taille d'icône de base, et retourne une taille d'icône ajustée.
double responsiveIconSize(double screenWidth, double baseIconSize) {
  return _getResponsiveValue(screenWidth, baseIconSize);
}

// Calcule une largeur (width) responsive.
// Prend la largeur de l'écran et une largeur de base, et retourne une largeur ajustée.
double responsiveWidth(double screenWidth, double baseWidth) {
  return _getResponsiveValue(screenWidth, baseWidth);
}

// Calcule une hauteur (height) responsive.
// Prend la largeur de l'écran et une hauteur de base, et retourne une hauteur ajustée.
double responsiveHeight(double screenWidth, double baseHeight) {
  return _getResponsiveValue(screenWidth, baseHeight);
}