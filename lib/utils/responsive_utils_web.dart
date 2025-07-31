// lib/utils/responsive_utils_web.dart

/// Largeur de référence pour le design web.
///
/// Ajustez cette valeur en fonction de la résolution de base de votre design
/// sur le web pour que les éléments soient proportionnels.
const double _baseWebWidth = 1200.0;

/// Facteur de mise à l'échelle minimal pour empêcher les éléments de devenir trop petits.
///
/// Par exemple, cette constante assure que les éléments ne seront pas réduits
/// en dessous de 50% de leur valeur de base, garantissant ainsi une lisibilité minimale.
const double _minScaleFactor = 0.5;

/// Fonction d'aide privée pour calculer une valeur responsive.
///
/// Cette fonction prend la largeur actuelle de l'écran ([screenWidth]) et une valeur de base
/// ([baseValue], par exemple, un espacement, une taille de police, etc.).
/// Elle calcule une valeur mise à l'échelle proportionnellement à la largeur de l'écran
/// par rapport à [_baseWebWidth], tout en s'assurant que la valeur ne descend pas en dessous
/// d'un seuil minimal défini par [_minScaleFactor].
///
/// [screenWidth]: La largeur actuelle de l'écran en pixels.
/// [baseValue]: La valeur de base à mettre à l'échelle (ex: padding, taille de police).
///
/// Retourne la valeur responsive ajustée.
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

/// Calcule un espacement (padding) responsive.
///
/// Prend la [screenWidth] (largeur actuelle de l'écran) et un [basePadding] (espacement de base),
/// et retourne un espacement ajusté proportionnellement à la taille de l'écran,
/// avec une taille minimale assurée par [_minScaleFactor].
///
/// [screenWidth]: La largeur actuelle de l'écran.
/// [basePadding]: L'espacement de base défini pour le design de référence.
///
/// Retourne la valeur de padding responsive.
double responsivePadding(double screenWidth, double basePadding) {
  return _getResponsiveValue(screenWidth, basePadding);
}

/// Calcule une taille de police (font size) responsive.
///
/// Prend la [screenWidth] (largeur actuelle de l'écran) et une [baseFontSize] (taille de police de base),
/// et retourne une taille de police ajustée proportionnellement,
/// avec une taille minimale assurée par [_minScaleFactor].
///
/// [screenWidth]: La largeur actuelle de l'écran.
/// [baseFontSize]: La taille de police de base définie pour le design de référence.
///
/// Retourne la taille de police responsive.
double responsiveFontSize(double screenWidth, double baseFontSize) {
  return _getResponsiveValue(screenWidth, baseFontSize);
}

/// Calcule une taille d'icône (icon size) responsive.
///
/// Prend la [screenWidth] (largeur actuelle de l'écran) et une [baseIconSize] (taille d'icône de base),
/// et retourne une taille d'icône ajustée proportionnellement,
/// avec une taille minimale assurée par [_minScaleFactor].
///
/// [screenWidth]: La largeur actuelle de l'écran.
/// [baseIconSize]: La taille d'icône de base définie pour le design de référence.
///
/// Retourne la taille d'icône responsive.
double responsiveIconSize(double screenWidth, double baseIconSize) {
  return _getResponsiveValue(screenWidth, baseIconSize);
}

/// Calcule une largeur (width) responsive.
///
/// Prend la [screenWidth] (largeur actuelle de l'écran) et une [baseWidth] (largeur de base),
/// et retourne une largeur ajustée proportionnellement,
/// avec une taille minimale assurée par [_minScaleFactor].
///
/// [screenWidth]: La largeur actuelle de l'écran.
/// [baseWidth]: La largeur de base définie pour le design de référence.
///
/// Retourne la largeur responsive.
double responsiveWidth(double screenWidth, double baseWidth) {
  return _getResponsiveValue(screenWidth, baseWidth);
}

/// Calcule une hauteur (height) responsive.
///
/// Prend la [screenWidth] (largeur actuelle de l'écran) et une [baseHeight] (hauteur de base),
/// et retourne une hauteur ajustée proportionnellement,
/// avec une taille minimale assurée par [_minScaleFactor].
///
/// [screenWidth]: La largeur actuelle de l'écran.
/// [baseHeight]: La hauteur de base définie pour le design de référence.
///
/// Retourne la hauteur responsive.
double responsiveHeight(double screenWidth, double baseHeight) {
  return _getResponsiveValue(screenWidth, baseHeight);
}