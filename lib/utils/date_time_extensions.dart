// lib/utils/date_time_extensions.dart

/// Extension sur la classe `DateTime` pour ajouter des méthodes utilitaires
/// facilitant la manipulation des dates et heures.
extension DateTimeExtension on DateTime {
  /// Retourne un nouveau [DateTime] représentant le début du jour courant (00:00:00).
  ///
  /// Crée un [DateTime] à 00h00m00s du même jour que l'instance actuelle.
  ///
  /// Exemple:
  /// ```dart
  /// DateTime now = DateTime(2025, 7, 31, 14, 30);
  /// DateTime start = now.startOfDay(); // DateTime(2025, 7, 31, 0, 0, 0)
  /// ```
  DateTime startOfDay() {
    return DateTime(year, month, day, 0, 0, 0); // Crée un DateTime à 00h00m00s du même jour.
  }

  /// Retourne un nouveau [DateTime] représentant la fin du jour courant (23:59:59.999).
  ///
  /// Crée un [DateTime] à 23h59m59s999ms du même jour que l'instance actuelle.
  ///
  /// Exemple:
  /// ```dart
  /// DateTime now = DateTime(2025, 7, 31, 14, 30);
  /// DateTime end = now.endOfDay(); // DateTime(2025, 7, 31, 23, 59, 59, 999)
  /// ```
  DateTime endOfDay() {
    return DateTime(year, month, day, 23, 59, 59, 999); // Crée un DateTime à 23h59m59s999ms du même jour.
  }
}