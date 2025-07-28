// Extension sur la classe `DateTime` pour ajouter des méthodes utilitaires.
extension DateTimeExtension on DateTime {
  // Retourne un nouveau `DateTime` représentant le début du jour courant (00:00:00).
  DateTime startOfDay() {
    return DateTime(year, month, day, 0, 0, 0); // Crée un DateTime à 00h00m00s du même jour.
  }

  // Retourne un nouveau `DateTime` représentant la fin du jour courant (23:59:59.999).
  DateTime endOfDay() {
    return DateTime(year, month, day, 23, 59, 59, 999); // Crée un DateTime à 23h59m59s999ms du même jour.
  }
}