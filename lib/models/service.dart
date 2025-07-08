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

  // Helper pour extraire la valeur réelle d'un CellValue ou d'un autre type
  static dynamic _extractCellValue(dynamic value) {
    if (value is CellValue) {
      // Utilisez le getter spécifique si disponible
      if (value is DateTimeCellValue) {
        return value.dateTime;
      } else if (value is TextCellValue) {
        return value.text;
      } else if (value is IntCellValue) {
        return value.intValue;
      } else if (value is DoubleCellValue) {
        return value.doubleValue;
      }
      // Fallback pour d'autres types de CellValue si nécessaire
      // Note: Dans les versions récentes de 'excel', les CellValue ont des getters spécifiques.
      // Ce 'value.value' est un fallback pour les cas inattendus ou les versions très anciennes.
      return value.value; 
    }
    return value; // Si ce n'est pas un CellValue, retournez la valeur telle quelle
  }

  // Méthode factory pour créer un Service à partir d'une Map (issue d'une ligne Excel)
  factory Service.fromExcelRow(Map<String, dynamic> data) {
    // Format de date attendu si la date est une chaîne de caractères dans Excel
    final DateFormat format = DateFormat("dd/MM/yyyy HH:mm");

    // Helper pour parser les dates en gérant les différents types de données de Excel
    DateTime _parseExcelDateValue(dynamic cellValueObject, String fieldName) {
      if (cellValueObject == null) {
        debugPrint('Avertissement: La date pour $fieldName est vide ou nulle. Utilisation de DateTime.now().');
        return DateTime.now();
      }

      // Extrait la valeur réelle avant de la traiter
      final dynamic actualValue = _extractCellValue(cellValueObject);

      if (actualValue is DateTime) {
        return actualValue;
      } else if (actualValue is String) {
        try {
          return format.parse(actualValue);
        } catch (e) {
          debugPrint('Erreur de parsing de date pour $fieldName (String): "$actualValue" - $e. Utilisation de DateTime.now().');
          return DateTime.now();
        }
      } else if (actualValue is num) {
        debugPrint('Avertissement: $fieldName est un nombre (${actualValue}). Conversion de date numérique non implémentée. Utilisation de DateTime.now().');
        return DateTime.now();
      }
      
      debugPrint('Avertissement: Type de données inattendu et non géré pour $fieldName: ${actualValue.runtimeType} ($actualValue). Utilisation de DateTime.now().');
      return DateTime.now();
    }

    // Utilise _extractCellValue pour toutes les données provenant de l'Excel
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
      // 'client BM-CL01' semble être une chaîne statique dans votre exemple Excel.
      // Si cette valeur provient d'une colonne Excel, vous devrez la mapper comme les autres.
      clientLocationLine3: 'client BM-CL01', 
      clientSvrCode: _extractCellValue(data['SVR_CODE'])?.toString() ?? '',
      clientSvrLib: _extractCellValue(data['SVR_LIB'])?.toString() ?? '',
      isAbsent: false, // Valeur par défaut
      isValidated: false, // Valeur par défaut
    );
  }

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

extension on CellValue {
   get value => value;
}

extension on DoubleCellValue {
  get doubleValue => doubleValue;
}

extension on IntCellValue {
  get intValue => intValue;
}

extension on TextCellValue {
  String get text => text;
}

extension on DateTimeCellValue {
  DateTime get dateTime => dateTime;
}
