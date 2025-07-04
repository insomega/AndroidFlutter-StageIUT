// lib/models/service.dart

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
