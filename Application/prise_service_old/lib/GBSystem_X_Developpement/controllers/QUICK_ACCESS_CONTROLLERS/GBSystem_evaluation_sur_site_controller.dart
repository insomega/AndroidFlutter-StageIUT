import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_questionnaire_quick_acces_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_site_quick_access_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_type_questionnaire_quick_access_model.dart';
import 'package:get/get.dart';

class GBSystemEvaluationSurSiteController extends GetxController {
  List<SiteQuickAccesModel>? _allSites;
  List<TypeQuestionnaireModel>? _allTypeQuestionnaire;
  List<QuestionnaireModel>? _allQuestionnaire;
  Rx<SiteQuickAccesModel?> _selectedSite = Rx<SiteQuickAccesModel?>(null);
  Rx<QuestionnaireModel?> _selectedQuestionnaire =
      Rx<QuestionnaireModel?>(null);
  Rx<TypeQuestionnaireModel?> _selectedTypeQuestionnaire =
      Rx<TypeQuestionnaireModel?>(null);
  Rx<String?> _selectedType = Rx<String?>(null);
  Rx<DateTime?> _dateDebut = Rx<DateTime?>(null);
  Rx<DateTime?> _dateFin = Rx<DateTime?>(null);

  Rx<DateTime?> _dateFinCloture = Rx<DateTime?>(null);
  Rx<DateTime?> _dateDebutCloture = Rx<DateTime?>(null);
  set setSelectedType(String? type) {
    _selectedType.value = type;
    update();
  }

  set setDateDebut(DateTime? dateDebut) {
    _dateDebut.value = dateDebut;
    update();
  }

  set setDateFin(DateTime? dateFin) {
    _dateFin.value = dateFin;
    update();
  }

  set setDateFinCloture(DateTime? dateFin) {
    _dateFinCloture.value = dateFin;
    update();
  }

  set setDateDebutCloture(DateTime? dateDebut) {
    _dateDebutCloture.value = dateDebut;
    update();
  }

  set setAllSites(List<SiteQuickAccesModel>? sites) {
    _allSites = sites;
    update();
  }

  set setAllTypeQuestionnaire(List<TypeQuestionnaireModel> typeQuestionnaires) {
    _allTypeQuestionnaire = typeQuestionnaires;
    update();
  }

  set setAllQuestionnaire(List<QuestionnaireModel> questionnaires) {
    _allQuestionnaire = questionnaires;
    update();
  }

  set setSelectedSite(SiteQuickAccesModel? site) {
    _selectedSite.value = site;
    update();
  }

  SiteQuickAccesModel? get getSelectedSite => _selectedSite.value;
  DateTime? get getDateDebut => _dateDebut.value;
  DateTime? get getDateFin => _dateFin.value;
  DateTime? get getDateFinCloture => _dateFinCloture.value;
  DateTime? get getDateDebutCloture => _dateDebutCloture.value;

  set setSelectedQuestionnaire(QuestionnaireModel? questionnaire) {
    _selectedQuestionnaire.value = questionnaire;
    update();
  }

  QuestionnaireModel? get getSelectedQuestionnaire =>
      _selectedQuestionnaire.value;

  set setSelectedTypeQuestionnaire(TypeQuestionnaireModel? typeQuestionnaire) {
    _selectedTypeQuestionnaire.value = typeQuestionnaire;
    update();
  }

  TypeQuestionnaireModel? get getSelectedTypeQuestionnaire =>
      _selectedTypeQuestionnaire.value;

  String? get getSelectedType => _selectedType.value;

  List<SiteQuickAccesModel>? get getAllSites => _allSites;

  List<QuestionnaireModel>? get getAllQuestionnaires => _allQuestionnaire;

  List<TypeQuestionnaireModel>? get getAllTypeQuestionnaires =>
      _allTypeQuestionnaire;
}
