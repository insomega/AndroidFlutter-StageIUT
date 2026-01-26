import 'package:flutter/widgets.dart';

class BMSoftIcons {
  static const String _fontFamily = 'FontBMSoft';
  static const String _package = 'gbsystem_menu'; // Ajoute ceci

  BMSoftIcons._();

  // Ajoute fontPackage: _package à TOUTES tes icônes
  static const IconData logo = IconData(0xe074, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData entite = IconData(0x0039, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData planning = IconData(0xe0ab, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData ventilation = IconData(0x002d, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData dispo = IconData(0xe0ac, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData exclure = IconData(0xe09f, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData planning_clients = IconData(0xe159, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData absence = IconData(0xe0af, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData indispo = IconData(0xe0ad, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData indispo_recurrente = IconData(0xe135, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData box_cet = IconData(0xe0be, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData info_salarie = IconData(0xe03b, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData carte_professionnelle = IconData(0xe18f, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData tenues = IconData(0xe922, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData messagerie = IconData(0xe932, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData option = IconData(0xe101, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData documents = IconData(0xe10d, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData dossier_embauche = IconData(0xe019, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData documents_entreprise = IconData(0xe126, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData facturation = IconData(0xe183, fontFamily: _fontFamily, fontPackage: _package);
  static const IconData placeholder = IconData(0xe800, fontFamily: _fontFamily, fontPackage: _package);

  /// Récupère l'icône en fonction de la clé "icon" du JSON
  static IconData fromKey(String? key) {
    switch (key) {
      case 'bmi-entite': return entite;
      case 'bmi-bm-planning': return planning;
      case 'bmi-bm-ventilation': return ventilation;
      case 'bmi-liste-salaries-disponibles': return dispo;
      case 'bmi-exclure': return exclure;
      case 'bmi-planning-clients': return planning_clients;
      case 'bmi-bm-absence': return absence;
      case 'bmi-indisponibilites': return indispo;
      case 'bmi-bm-indisponible': return indispo_recurrente;
      case 'bmi-box': return box_cet;
      case 'bmi-info-salarie': return info_salarie;
      case 'bmi-carte-professionnelle': return carte_professionnelle;
      case 'bmi-tenues': return tenues;
      case 'bmi-bm-messagerie': return messagerie;
      case 'bmi-bm-option': return option;
      case 'bmi-documents': return documents;
      case 'bmi-dossier-embauche': return dossier_embauche;
      case 'bmi-documents-entreprises': return documents_entreprise;
      case 'bmi-facturation': return facturation;
      default: return placeholder;
    }
  }
}