// lib/models/service.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:excel/excel.dart'; // Importation nécessaire pour CellValue types

class Service {
  final String id; // Correspond à VAC_IDF
  final String employeeName; // Correspond à USR_LIB (la personne qui a créé/géré le service)
  final String employeeSvrCode; // Correspond à SVR_CODE (pour l'employé)
  final String employeeSvrLib; // Correspond à SVR_LIB (pour l'employé, ex: "SVR_NOM 86710 TEXT ERIC")
  final String employeeTelPort; // Correspond à SVR_TELPOR

  final DateTime startTime; // Correspond à VAC_START_HOUR
  DateTime endTime; // Correspond à VAC_END_HOUR (peut être modifié)
  bool isAbsent;
  bool isValidated;

  // Informations de localisation/client, communes aux deux cartes
  final String locationCode; // Correspond à LIE_CODE
  final String locationLib; // Correspond à LIE_LIB
  final String clientLocationLine3; // Le texte statique "client BM-CL01"

  // Informations spécifiques au client pour la carte "Fin"
  final String clientSvrCode; // SVR_CODE quand il s'agit du client (ex: BM-SAL04, 142320, PIERRICK)
  final String clientSvrLib; // SVR_LIB quand il s'agit du client (ex: BONBON Délicieux, MELCHIORRE GERALD, SVR_NOM 86710 TEXT ERIC)

  Service({
    required this.id,
    required this.employeeName,
    required this.employeeSvrCode,
    required this.employeeSvrLib,
    required this.employeeTelPort,
    required this.startTime,
    required this.endTime,
    this.isAbsent = false,
    this.isValidated = false,
    required this.locationCode,
    required this.locationLib,
    required this.clientLocationLine3,
    required this.clientSvrCode,
    required this.clientSvrLib,
  });

  // Helper pour extraire la valeur réelle d'un CellValue ou d'un autre type.
  // Cette fonction va maintenant toujours retourner une String si c'est un CellValue,
  // et le type original si ce n'est pas un CellValue (ex: déjà String, int, DateTime).
  static dynamic _extractCellValue(dynamic valueObject) {
    if (valueObject == null) {
      return null;
    }
    // Si l'objet est une instance de CellValue (ou l'une de ses sous-classes),
    // nous utilisons sa représentation en chaîne.
    if (valueObject is CellValue) {
      return valueObject.toString();
    }
    // Si ce n'est pas un CellValue (par exemple, c'est déjà un DateTime, String, int, double),
    // nous le retournons tel quel.
    return valueObject;
  }

  // Méthode factory pour créer un Service à partir d'une Map (issue d'une ligne Excel)
  factory Service.fromExcelRow(Map<String, dynamic> data) {
    // Helper pour parser les dates en gérant les différents types de données de Excel.
    DateTime _parseExcelDateValue(dynamic rawValue, String fieldName) {
      if (rawValue == null) {
        debugPrint('Avertissement: La date pour $fieldName est vide ou nulle. Utilisation de DateTime.now().');
        return DateTime.now();
      }

      // Extrait la valeur réelle en utilisant la fonction _extractCellValue.
      // On s'attend maintenant à ce que _extractCellValue retourne une String ou un num.
      final dynamic actualValue = _extractCellValue(rawValue);

      if (actualValue is String) {
        try {
          // Tente d'abord de parser le format ISO 8601 (ex: "2025-07-02T20:00:00.000Z")
          return DateTime.parse(actualValue);
        } catch (_) {
          // Si ISO 8601 échoue, tente le format "dd/MM/yyyy HH:mm"
          try {
            final format = DateFormat("dd/MM/yyyy HH:mm");
            return format.parse(actualValue);
          } catch (e) {
            debugPrint('Erreur de parsing de date pour $fieldName (String): "$actualValue" - $e. Utilisation de DateTime.now().');
            return DateTime.now();
          }
        }
      } else if (actualValue is num) { // Gère les dates numériques d'Excel
        try {
          // Excel base les dates sur le 1er janvier 1900 (jour 1). Ajustement pour la base 0 de Dart.
          final DateTime excelEpoch = DateTime(1899, 12, 30); // Date de référence Excel pour le jour 0
          final Duration duration = Duration(days: actualValue.toInt(), milliseconds: ((actualValue - actualValue.toInt()) * 24 * 60 * 60 * 1000).toInt());
          return excelEpoch.add(duration);
        } catch (e) {
          debugPrint('Erreur de conversion de date numérique pour $fieldName (num): "$actualValue" - $e. Utilisation de DateTime.now().');
          return DateTime.now();
        }
      }
      
      debugPrint('Avertissement: Type de données inattendu et non géré pour $fieldName: ${actualValue.runtimeType} ($actualValue). Utilisation de DateTime.now().');
      return DateTime.now();
    }

    // Utilise _extractCellValue pour toutes les données provenant de l'Excel.
    // Les résultats sont ensuite convertis en String ou passés à la fonction de parsing de date.
    return Service(
      id: _extractCellValue(data['VAC_IDF'])?.toString() ?? '',
      employeeName: _extractCellValue(data['USR_LIB'])?.toString() ?? '',
      employeeSvrCode: _extractCellValue(data['SVR_CODE'])?.toString() ?? '',
      employeeSvrLib: _extractCellValue(data['SVR_LIB'])?.toString() ?? '',
      employeeTelPort: _extractCellValue(data['SVR_TELPOR'])?.toString() ?? '',
      startTime: _parseExcelDateValue(data['VAC_START_HOUR'], 'VAC_START_HOUR'),
      endTime: _parseExcelDateValue(data['VAC_END_HOUR'], 'VAC_END_HOUR'),
      locationCode: _extractCellValue(data['LIE_CODE'])?.toString() ?? '',
      locationLib: _extractCellValue(data['LIE_LIB'])?.toString() ?? '',
      clientLocationLine3: 'client BM-CL01', // Cette valeur semble être statique d'après votre exemple
      clientSvrCode: _extractCellValue(data['SVR_CODE'])?.toString() ?? '',
      clientSvrLib: _extractCellValue(data['SVR_LIB'])?.toString() ?? '',
      isAbsent: false,
      isValidated: false,
    );
  }

  // Méthode copyWith pour la mise à jour des propriétés
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
      id: id ?? this.id,
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
