import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_preferences_model.dart';

class GBSystemPreferencesController extends GetxController {
  List<PreferencesModel>? _allPreferences;
  PreferencesModel? _currentPrefrence;

  set setPreference(PreferencesModel preferencesModel) {
    _allPreferences?.add(preferencesModel);
    update();
  }

  set setCurrentPreference(PreferencesModel? preferencesModel) {
    _currentPrefrence = preferencesModel;
    update();
  }

  set setPreferenceToLeft(PreferencesModel preference) {
    _allPreferences?.insert(0, preference);
    update();
  }

  set setPreferenceToRight(PreferencesModel Preference) {
    _allPreferences?.insert(_allPreferences!.length, Preference);
    update();
  }

  set setAllPrefernce(List<PreferencesModel>? Prefernces) {
    _allPreferences = Prefernces;
    update();
  }

  List<PreferencesModel>? get getAllPreferences => _allPreferences;
  PreferencesModel? get getCurrentPreference => _currentPrefrence;
}
