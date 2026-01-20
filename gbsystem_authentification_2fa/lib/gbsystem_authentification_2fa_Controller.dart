import 'package:get/get.dart';

//import 'dart:convert';
import 'package:gbsystem_root/GBSystem_Root_Controller.dart';

class GBSystem_AuthenticatorController extends GBSystem_Root_Controller {
  // URL de ton API (à adapter selon ton backend)
  // final String baseUrl = "https://api.tonserveur.com/authenticator";

  // Valeurs reçues du serveur
  var secret = "".obs;
  var otpUrl = "".obs;

  /// Récupère le secret et l’URL OTP depuis ton serveur
  Future<void> fetchSetupData(String userId) async {
    // final response = await http.get(Uri.parse("$baseUrl/setup?userId=$userId"));
    // if (response.statusCode == 200) {
    //   final data = jsonDecode(response.body);
    //   secret.value = data["secret"];
    //   otpUrl.value = data["otpUrl"];
    // } else {
    //   throw Exception("Impossible de charger les données du setup");
    // }
  }

  /// Vérifie le code OTP saisi côté serveur
  Future<bool> verifyCode(String code) async {
    return true;
    // final response = await http.post(Uri.parse("$baseUrl/verify"), headers: {"Content-Type": "application/json"}, body: jsonEncode({"userId": userId, "code": code}));
    // if (response.statusCode == 200) {
    //   final data = jsonDecode(response.body);
    //   return data["valid"] == true;
    // } else {
    //   throw Exception("Erreur de vérification côté serveur");
    // }
  }
}
// import 'package:get/get.dart';
// import 'package:gbsystem_root/GBSystem_Root_Controller.dart';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class TwoFAController extends GBSystem_Root_Controller {
//   final ApiService api;
//   TwoFAController(this.api);

//   var otpauthUri = ''.obs;
//   final storage = FlutterSecureStorage();

//   Future<void> setup2FA() async {
//     final res = await api.post('/api/2fa/setup', {});
//     // res expected: { secret: "...", otpauth_uri: "otpauth://..." }
//     otpauthUri.value = res['otpauth_uri'] ?? '';
//   }

//   Future<Map> verifySetup(String code) async {
//     final res = await api.post('/api/2fa/verify-setup', {'code': code});
//     // res returns backup_codes list
//     return res;
//   }

//   Future<Map> verifyLogin(String tempToken, String code) async {
//     final res = await api.post('/api/2fa/verify-login', {'code': code}, token: tempToken);
//     return res;
//   }
// }
