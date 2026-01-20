import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class GBSystem_Storage_Service {
  // Instance unique
  static final GBSystem_Storage_Service _instance = GBSystem_Storage_Service._internal();
  factory GBSystem_Storage_Service() => _instance;

  GBSystem_Storage_Service._internal();

  final GetStorage _storage = GetStorage();

  // 🔐 Clés privées
  static const String _keyEmail = 'user_email';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _kS19 = "s19";
  static const String _kSiteWeb = "siteWeb";
  static const String _kEntrepriseName = "CodeEntreprise";
  static const String _kCookies = "Cookies";
  static const String _kBaseUrlStandard = "BaseUrlStandard";
  static const String _kWid = "Wid";
  static const String _kLocal = "Local";

  static const String _kIsFirstTime = "IsFirstTime";
  // ✅ Fonctions publiques nommées

  /// Sauvegarde l’état de connexion
  Future<void> setLoggedIn(bool value) async => _storage.write(_keyIsLoggedIn, true);
  bool isLoggedIn() => _storage.read<bool>(_keyIsLoggedIn) ?? false;

  /// Sauvegarde l’IsFirstTime
  Future<void> saveIsFirstTime() async => _storage.write(_kIsFirstTime, true);
  bool getIsFirstTime() => _storage.read<bool>(_kIsFirstTime) ?? false;
  Future<void> clearIsFirstTime() async => _storage.remove(_kIsFirstTime);

  /// Sauvegarde l’e-mail
  Future<void> saveEmail(String email) async => _storage.write(_keyEmail, email);
  String getEmail() => _storage.read<String>(_keyEmail) ?? '';
  Future<void> clearEmail() async => _storage.remove(_keyEmail);

  /// Sauvegarde _kS19
  Future<void> saveS19(String s19) async => _storage.write(_kS19, s19);
  String? getS19() => _storage.read<String>(_kS19);
  Future<void> clearS19() async => _storage.remove(_kS19);

  /// Sauvegarde kSiteWeb
  Future<void> saveSiteWeb(String siteWeb) async => _storage.write(_kSiteWeb, siteWeb);
  String? getsiteWeb() => _storage.read<String>(_kSiteWeb);
  Future<void> clearsiteWeb() async => _storage.remove(_kSiteWeb);

  /// Sauvegarde kLocal
  Future<void> saveLocal(String alocal) async => _storage.write(_kLocal, alocal);
  // String? getLocal() => _storage.read<String>(_kLocal);
  String? getLocal() {
    return _storage.read<String>(_kLocal) ?? Get.locale?.languageCode;
  }

  Future<void> clearLocal() async => _storage.remove(_kLocal);

  /// Sauvegarde _kEntrepriseName
  Future<void> saveEntrepriseName(String entrepriseName) async {
    entrepriseName.trim().isEmpty ? await _storage.remove(_kEntrepriseName) : _storage.write(_kEntrepriseName, entrepriseName);
  }

  String? getEntrepriseName() => _storage.read<String>(_kEntrepriseName);
  Future<void> clearEntrepriseName() async => _storage.remove(_kEntrepriseName);

  /// Sauvegarde _kCookies
  Future<void> saveCookies(String cookies) async => _storage.write(_kCookies, cookies);
  String? getCookies() => _storage.read<String>(_kCookies);
  Future<void> clearCookies() async => _storage.remove(_kCookies);

  /// Sauvegarde _kBaseUrlStandard
  Future<void> saveBaseUrlStandard(String baseUrlStandard) async => _storage.write(_kBaseUrlStandard, baseUrlStandard);
  String? getBaseUrlStandard() => _storage.read<String>(_kBaseUrlStandard);
  Future<void> clearBaseUrlStandard() async => _storage.remove(_kBaseUrlStandard);

  /// Sauvegarde _kWid
  Future<void> saveWid(String Wid) async => _storage.write(_kWid, Wid);
  String? getWid() => _storage.read<String>(_kWid);
  Future<void> clearWid() async => _storage.remove(_kWid);

  /// Efface toutes les données utilisateur
  Future<void> clearSessionData() async {
    await _storage.remove(_keyEmail);
    await _storage.remove(_kWid);
    await _storage.remove(_kCookies);
  }

  bool hasSessionData() {
    final wid = getWid();
    final cookies = getCookies();
    print("--------****-------------wid : $wid  cookies=$cookies  ");

    return wid != null && wid.isNotEmpty && cookies != null && cookies.isNotEmpty;
  }

  /// Efface toutes les données utilisateur
  Future<void> clearUserData() async {
    await _storage.remove(_keyEmail);
    await _storage.remove(_keyIsLoggedIn);
  }

  getUserPermissions() {}
}
