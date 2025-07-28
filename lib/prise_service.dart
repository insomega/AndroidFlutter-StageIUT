// lib/prise_service.dart

// Export conditionnel : ce fichier exporte 'prise_service_web.dart' par défaut.
// Cependant, si l'application est compilée pour une plateforme qui supporte 'dart.library.io' (comme le mobile ou le desktop),
// alors 'prise_service_mobile.dart' sera exporté à la place.
// Cela permet d'avoir des implémentations différentes de l'écran 'PriseService'
// en fonction de l'environnement d'exécution (web vs mobile/desktop).
export 'prise_service_web.dart' if (dart.library.io) 'prise_service_mobile.dart';