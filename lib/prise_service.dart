/// lib/prise_service.dart
library;

/// Export conditionnel : ce fichier exporte 'prise_service_web.dart' par défaut.
///
/// Si l'application est compilée pour une plateforme qui supporte 'dart.library.io'
/// (comme le mobile ou le desktop via Flutter), alors 'prise_service_mobile.dart'
/// sera exporté à la place.
///
/// Cela permet d'avoir des implémentations différentes de l'écran 'PriseService'
/// en fonction de l'environnement d'exécution (web vs mobile/desktop) tout en
/// maintenant une seule interface publique.
export 'prise_service_web.dart' if (dart.library.io) 'prise_service_mobile.dart';