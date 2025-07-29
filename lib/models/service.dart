// lib/models/service.dart

import 'package:flutter/material.dart'; // Importe Flutter pour `debugPrint`.
import 'package:intl/intl.dart'; // Importe `intl` pour le formatage des dates.
import 'package:excel/excel.dart'; // Importation nécessaire pour les types `CellValue` du package Excel.

// Représente un service avec toutes ses informations détaillées,
// incluant l'employé, les heures, la localisation et le statut.
class Service {
  final String id; // ID du service (correspond à VAC_IDF dans les données).
  final String employeeName; // Nom de l'employé (correspond à USR_LIB).
  final String employeeSvrCode; // Code de service de l'employé (SVR_CODE).
  final String employeeSvrLib; // Libellé de service de l'employé (SVR_LIB).
  final String employeeTelPort; // Numéro de téléphone portable de l'employé (SVR_TELPOR).

  late final DateTime startTime; // Heure de début du service (VAC_START_HOUR).
  DateTime endTime; // Heure de fin du service (VAC_END_HOUR), peut être modifiée.
  bool isAbsent; // Indique si l'employé est absent pour ce service.
  bool isValidated; // Indique si le service a été validé.

  // Informations de localisation/client, communes aux deux types de cartes.
  final String locationCode; // Code du lieu (LIE_CODE).
  final String locationLib; // Libellé du lieu (LIE_LIB).
  final String clientLocationLine3; // Texte statique "client BM-CL01".

  // Informations spécifiques au client pour la carte "Fin".
  final String clientSvrCode; // Code de service du client (SVR_CODE).
  final String clientSvrLib; // Libellé de service du client (SVR_LIB).

  // Constructeur de la classe `Service`.
  Service({
    required this.id,
    required this.employeeName,
    required this.employeeSvrCode,
    required this.employeeSvrLib,
    required this.employeeTelPort,
    required this.startTime,
    required this.endTime,
    this.isAbsent = false, // Valeur par défaut : non absent.
    this.isValidated = false, // Valeur par défaut : non validé.
    required this.locationCode,
    required this.locationLib,
    required this.clientLocationLine3,
    required this.clientSvrCode,
    required this.clientSvrLib,
  });

  // Getter pour obtenir la durée du service formatée en heures et minutes.
  String get duration {
    final Duration diff = endTime.difference(startTime); // Calcule la différence entre l'heure de fin et de début.
    final int hours = diff.inHours; // Nombre total d'heures.
    final int minutes = diff.inMinutes.remainder(60); // Minutes restantes après avoir soustrait les heures.
    return '${hours}h ${minutes}min'; // Retourne la durée formatée.
  }

  // Getter pour obtenir la durée du service en heures sous forme décimale.
  double get durationInHours {
    final Duration diff = endTime.difference(startTime); // Calcule la différence.
    return diff.inMinutes / 60.0; // Convertit les minutes totales en heures décimales.
  }

  // Méthode d'aide statique pour extraire la valeur réelle d'un `CellValue` ou d'un autre type.
  // Si l'objet est un `CellValue`, il est converti en `String`. Sinon, il est retourné tel quel.
  static dynamic _extractCellValue(dynamic valueObject) {
    if (valueObject == null) {
      return null; // Retourne null si l'objet est null.
    }
    if (valueObject is CellValue) {
      return valueObject.toString(); // Convertit CellValue en String.
    }
    return valueObject; // Retourne l'objet tel quel si ce n'est pas un CellValue.
  }

  // Méthode factory pour créer une instance de `Service` à partir d'une `Map` de données (souvent issue d'une ligne Excel).
  factory Service.fromExcelRow(Map<String, dynamic> data) {
    /// Helper interne pour parser les valeurs de date provenant d'Excel, gérant différents formats (String, numérique).
    DateTime parseExcelDateValue(dynamic rawValue, String fieldName) {
      if (rawValue == null) {
        debugPrint('Avertissement: La date pour $fieldName est vide ou nulle. Utilisation de DateTime.now().');
        return DateTime.now(); // Retourne l'heure actuelle si la valeur est nulle.
      }

      final dynamic actualValue = _extractCellValue(rawValue); // Extrait la valeur réelle.

      if (actualValue is String) {
        try {
          return DateTime.parse(actualValue); // Tente de parser en format ISO 8601.
        } catch (_) {
          try {
            final format = DateFormat("dd/MM/yyyy HH:mm");
            return format.parse(actualValue); // Tente de parser en format "dd/MM/yyyy HH:mm".
          } catch (e) {
            debugPrint('Erreur de parsing de date pour $fieldName (String): "$actualValue" - $e. Utilisation de DateTime.now().');
            return DateTime.now(); // Retourne l'heure actuelle en cas d'échec de parsing.
          }
        }
      } else if (actualValue is num) {
        try {
          // Convertit les dates numériques d'Excel (basées sur le 1er janvier 1900).
          final DateTime excelEpoch = DateTime(1899, 12, 30); // Date de référence Excel pour le jour 0.
          final Duration duration = Duration(
              days: actualValue.toInt(),
              milliseconds: ((actualValue - actualValue.toInt()) * 24 * 60 * 60 * 1000).toInt());
          return excelEpoch.add(duration);
        } catch (e) {
          debugPrint('Erreur de conversion de date numérique pour $fieldName (num): "$actualValue" - $e. Utilisation de DateTime.now().');
          return DateTime.now(); // Retourne l'heure actuelle en cas d'échec de conversion.
        }
      }

      debugPrint('Avertissement: Type de données inattendu et non géré pour $fieldName: ${actualValue.runtimeType} ($actualValue). Utilisation de DateTime.now().');
      return DateTime.now(); // Retourne l'heure actuelle pour les types non gérés.
    }

    // Crée une nouvelle instance de `Service` en extrayant et parsant les données de la map.
    return Service(
      id: _extractCellValue(data['VAC_IDF'])?.toString() ?? '',
      employeeName: _extractCellValue(data['USR_LIB'])?.toString() ?? '', // Correction du champ d'extraction
      employeeSvrCode: _extractCellValue(data['SVR_CODE'])?.toString() ?? '',
      employeeSvrLib: _extractCellValue(data['SVR_LIB'])?.toString() ?? '',
      employeeTelPort: _extractCellValue(data['SVR_TELPOR'])?.toString() ?? '',
      startTime: parseExcelDateValue(data['VAC_START_HOUR'], 'VAC_START_HOUR'),
      endTime: parseExcelDateValue(data['VAC_END_HOUR'], 'VAC_END_HOUR'),
      locationCode: _extractCellValue(data['LIE_CODE'])?.toString() ?? '',
      locationLib: _extractCellValue(data['LIE_LIB'])?.toString() ?? '',
      clientLocationLine3: 'client BM-CL01', // Valeur statique.
      clientSvrCode: _extractCellValue(data['CLI_SVR_CODE'])?.toString() ?? '', // Assurez-vous d'avoir le bon champ pour le client
      clientSvrLib: _extractCellValue(data['CLI_SVR_LIB'])?.toString() ?? '', // Assurez-vous d'avoir le bon champ pour le client
      isAbsent: false, // Initialisation par défaut.
      isValidated: false, // Initialisation par défaut.
    );
  }

  // Méthode `copyWith` pour créer une nouvelle instance de `Service` avec des propriétés modifiées.
  // Permet une mise à jour facile et immuable de l'objet `Service`.
  Service copyWith({
    String? id,
    String? employeeName,
    String? employeeSvrCode,
    String? employeeSvrLib,
    String? employeeTelPort,
    DateTime? startTime,
    DateTime? endTime,
    bool? isAbsent,
    bool? isValidated,
    String? locationCode,
    String? locationLib,
    String? clientLocationLine3,
    String? clientSvrCode,
    String? clientSvrLib,
  }) {
    return Service(
      id: id ?? this.id, // Utilise la nouvelle valeur si fournie, sinon la valeur actuelle.
      employeeName: employeeName ?? this.employeeName,
      employeeSvrCode: employeeSvrCode ?? this.employeeSvrCode,
      employeeSvrLib: employeeSvrLib ?? this.employeeSvrLib,
      employeeTelPort: employeeTelPort ?? this.employeeTelPort,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isAbsent: isAbsent ?? this.isAbsent,
      isValidated: isValidated ?? this.isValidated,
      locationCode: locationCode ?? this.locationCode,
      locationLib: locationLib ?? this.locationLib,
      clientLocationLine3: clientLocationLine3 ?? this.clientLocationLine3,
      clientSvrCode: clientSvrCode ?? this.clientSvrCode,
      clientSvrLib: clientSvrLib ?? this.clientSvrLib,
    );
  }
}