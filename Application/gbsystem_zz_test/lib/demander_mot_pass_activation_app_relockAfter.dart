//Tu veux un “App Lock” qui redemande la sécurité native du téléphone (PIN/mot de passe/schéma/biométrie) dès que l’utilisateur revient dans l’app. Voici une implémentation Flutter prête à brancher.


// 1) Dépendance
// # pubspec.yaml
// dependencies:
//   local_auth: ^2.3.0

// 2) Permissions / configurations

// Android (android/app/src/main/AndroidManifest.xml)

// <manifest ...>
//   <uses-permission android:name="android.permission.USE_BIOMETRIC"/>
//   <!-- Optionnel si anciens appareils -->
//   <uses-permission android:name="android.permission.USE_FINGERPRINT"/>
//   <application ...>
//     <!-- rien d'autre à ajouter pour le lock -->
//   </application>
// </manifest>
// iOS (ios/Runner/Info.plist)

// <key>NSFaceIDUsageDescription</key>
// <string>Cette app utilise Face ID pour vous authentifier.</string>


2) Service GetX (AppLockService)
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

class AppLockService extends GetxService with WidgetsBindingObserver {
  final LocalAuthentication _auth = LocalAuthentication();

  DateTime _lastAuth = DateTime.fromMillisecondsSinceEpoch(0);
  bool _authInProgress = false;
  bool _isForeground = true;

  /// délai avant de redemander l’auth
  final Duration relockAfter;

  AppLockService({this.relockAfter = const Duration(seconds: 0)});

  Future<AppLockService> init() async {
    WidgetsBinding.instance.addObserver(this);
    // Authentification initiale au démarrage si tu veux
    await _triggerAuth();
    return this;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _isForeground = true;
      _maybeReauth();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _isForeground = false;
    }
  }

  Future<void> _maybeReauth() async {
    final since = DateTime.now().difference(_lastAuth);
    if (since >= relockAfter) {
      await _triggerAuth();
    }
  }

  Future<void> _triggerAuth() async {
    if (_authInProgress) return;
    _authInProgress = true;

    try {
      final canCheck =
          await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

      if (!canCheck) {
        // Pas de biométrie dispo, mais on pourra utiliser le code PIN/mot de passe
      }

      final didAuth = await _auth.authenticate(
        localizedReason: 'Déverrouiller l’application',
        options: const AuthenticationOptions(
          biometricOnly: false, // accepte code PIN/mot de passe/schéma aussi
          stickyAuth: true,
          useErrorDialogs: true,
          sensitiveTransaction: true,
        ),
      );

      if (didAuth) {
        _lastAuth = DateTime.now();
      } else {
        if (_isForeground) {
          _showLockedDialog();
        }
      }
    } catch (e) {
      if (_isForeground) {
        _showLockedDialog();
      }
    } finally {
      _authInProgress = false;
    }
  }

  void _showLockedDialog() {
    if (Get.context == null) return;
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text('Application verrouillée'),
          content: const Text('Authentifiez-vous pour continuer.'),
          actions: [
            TextButton(
              onPressed: () async {
                Get.back();
                await _triggerAuth();
              },
              child: const Text('Réessayer'),
            ),
            TextButton(
              onPressed: () {
                // Ici tu peux décider : revenir à login ou fermer l’app
                // Get.offAllNamed('/login');
                Get.back();
              },
              child: const Text('Annuler'),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}

3) Initialisation du service

Dans ton main.dart :

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_lock_service.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init GetX service
  await Get.putAsync(() => AppLockService(relockAfter: Duration(seconds: 0)).init());

  runApp(const MyApp());
}

4) Utilisation

Tu n’as rien à ajouter dans les vues : le AppLockService est global et surveille automatiquement le cycle de vie.
Dès que l’app revient en avant-plan après un certain délai (relockAfter), l’écran d’auth s’affiche.

5) Options possibles

Forcer le relock immédiat (ex : bouton "Verrouiller l’app") :

Get.find<AppLockService>().forceLock();


(tu peux ajouter une méthode forceLock() dans le service qui appelle _triggerAuth() directement).

Retour login : si tu veux que l’utilisateur doive se reconnecter à ton backend en cas d’échec, remplace Get.back() dans "Annuler" par Get.offAllNamed('/login').

👉 Veux-tu que je t’adapte ce service en GetX Middleware aussi, pour que certaines routes sensibles soient protégées (ex: /salaire, /parametres) et demandent une réauth même si l’app est déjà déverrouillée ?