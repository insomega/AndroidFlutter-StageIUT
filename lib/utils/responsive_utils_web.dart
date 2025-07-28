// lib/utils/responsive_utils_web.dart

// Reference width for web design, adjust this based on your design's base resolution
const double _baseWebWidth = 1200.0;

// Minimum scaling factor to prevent elements from becoming too small
const double _minScaleFactor = 0.5; // e.g., don't scale down below 50% of the base value

// Private helper function to calculate the responsive value
// This function takes the current screenWidth and a baseValue (e.g., base padding, base font size)
double _getResponsiveValue(double screenWidth, double baseValue) {
  if (screenWidth <= 0) { // Handle case where screenWidth might be zero or negative
    return baseValue;
  }
  // Calculate a scaled value based on the reference width
  double scaledValue = (baseValue / _baseWebWidth) * screenWidth;

  // Ensure the scaled value does not go below a minimum threshold
  // You can customize the minimums more specifically for each function if needed.
  return scaledValue > (baseValue * _minScaleFactor) ? scaledValue : (baseValue * _minScaleFactor);
}

// --- Public Responsive Functions ---

// Calculates responsive padding
double responsivePadding(double screenWidth, double basePadding) {
  return _getResponsiveValue(screenWidth, basePadding);
}

// Calculates responsive font size
double responsiveFontSize(double screenWidth, double baseFontSize) {
  return _getResponsiveValue(screenWidth, baseFontSize);
}

// Calculates responsive icon size
double responsiveIconSize(double screenWidth, double baseIconSize) {
  return _getResponsiveValue(screenWidth, baseIconSize);
}

// Calculates responsive width
double responsiveWidth(double screenWidth, double baseWidth) {
  return _getResponsiveValue(screenWidth, baseWidth);
}

// Calculates responsive height
double responsiveHeight(double screenWidth, double baseHeight) {
  return _getResponsiveValue(screenWidth, baseHeight);
}