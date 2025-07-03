// lib/models/service.dart

class Service {
  final String id;
  final String employeeName;
  final String employeeDetails;
  final String employeeContact;
  final DateTime startTime;
  DateTime endTime;
  bool isAbsent;
  bool isValidated;
  final String clientInfo;
  final String clientName;
  final String clientLocationLine1;
  final String clientLocationLine2;
  final String clientLocationLine3;

  Service({
    required this.id,
    required this.employeeName,
    required this.employeeDetails,
    required this.employeeContact,
    required this.startTime,
    required this.endTime,
    this.isAbsent = false,
    this.isValidated = false,
    required this.clientInfo,
    required this.clientName,
    required this.clientLocationLine1,
    required this.clientLocationLine2,
    required this.clientLocationLine3,
  });

  Service copyWith({
    String? id,
    String? employeeName,
    String? employeeDetails,
    String? employeeContact,
    DateTime? startTime,
    DateTime? endTime,
    bool? isAbsent,
    bool? isValidated,
    String? clientInfo,
    String? clientName,
    String? clientLocationLine1,
    String? clientLocationLine2,
    String? clientLocationLine3,
  }) {
    return Service(
      id: id ?? this.id,
      employeeName: employeeName ?? this.employeeName,
      employeeDetails: employeeDetails ?? this.employeeDetails,
      employeeContact: employeeContact ?? this.employeeContact,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isAbsent: isAbsent ?? this.isAbsent,
      isValidated: isValidated ?? this.isValidated,
      clientInfo: clientInfo ?? this.clientInfo,
      clientName: clientName ?? this.clientName,
      clientLocationLine1: clientLocationLine1 ?? this.clientLocationLine1,
      clientLocationLine2: clientLocationLine2 ?? this.clientLocationLine2,
      clientLocationLine3: clientLocationLine3 ?? this.clientLocationLine3,
    );
  }
}
