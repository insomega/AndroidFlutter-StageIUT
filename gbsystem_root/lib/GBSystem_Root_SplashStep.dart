// abstract class GBSystem_Root_SplashStep {
//   String get SplashStep_label;

//   Future<void> execute();
// }
abstract class GBSystem_Root_SplashStep {
  String get SplashStep_label;

  /// Renvoie `true` si on stoppe l’exécution après cette étape (ex: redirection).
  Future<bool> execute();
}
