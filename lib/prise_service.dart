// lib/prise_service.dart (Updated with auto-refresh every minute)

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mon_projet/time_detail_card.dart';
import 'package:mon_projet/models/service.dart';
import 'dart:async'; // <--- NOUVELLE IMPORTATION pour utiliser Timer

class PriseServiceScreen extends StatefulWidget {
  const PriseServiceScreen({super.key});

  @override
  State<PriseServiceScreen> createState() => _PriseServiceScreenState();
}

class _PriseServiceScreenState extends State<PriseServiceScreen> {
  DateTime _currentDisplayDate = DateTime.now();
  DateTime _startDate = DateTime(2025, 7, 1);
  DateTime _endDate = DateTime(2025, 7, 31);

  Timer? _timer; // <--- Déclaration du Timer

  // Liste de services factices
  final List<Service> _services = [
    Service(
      id: '0001',
      employeeName: 'PIERRICK ERIC',
      employeeDetails: 'SVR_NOM 86710 TEXT',
      employeeContact: '0662057140',
      startTime: DateTime(2025, 7, 3, 7, 0), // Passé
      endTime: DateTime(2025, 7, 3, 8, 47),
      clientInfo: 'OBM-SECUL1',
      clientName: 'Client Sécurité BMSoft n°1',
      clientLocationLine1: 'OBM-SECUL1',
      clientLocationLine2: '0Lieu de prestation',
      clientLocationLine3: 'client BM-CL01',
    ),
    Service(
      id: '0002',
      employeeName: 'MELCHIORRE GERALD',
      employeeDetails: '0002030406',
      employeeContact: '0602030406',
      startTime: DateTime(2025, 7, 4, 10, 0), // Futur (exemple)
      endTime: DateTime(2025, 7, 4, 11, 47),
      clientInfo: 'OBM-SECUL1',
      clientName: 'Client Sécurité BMSoft n°1',
      clientLocationLine1: 'OBM-SECUL1',
      clientLocationLine2: '0Lieu de prestation',
      clientLocationLine3: 'client BM-CL01',
    ),
    Service(
      id: '0003',
      employeeName: 'BM-SAL04',
      employeeDetails: 'BONBON Délicieux',
      employeeContact: '0605040302',
      startTime: DateTime(2025, 7, 3, 20, 0), // Passé
      endTime: DateTime(2025, 7, 3, 21, 47),
      clientInfo: 'OBM-SECUL1',
      clientName: 'Client Sécurité BMSoft n°1',
      clientLocationLine1: 'OBM-SECUL1',
      clientLocationLine2: '0Lieu de prestation',
      clientLocationLine3: 'client BM-CL01',
    ),
    Service(
      id: '0004',
      employeeName: 'PIERRICK ERIC',
      employeeDetails: 'SVR_NOM 86710 TEXT',
      employeeContact: '0662057140',
      startTime: DateTime(2025, 7, 3, 13, 0), // Juste après l'heure actuelle si elle est 12h21
      endTime: DateTime(2025, 7, 3, 14, 47),
      clientInfo: 'OBM-SECUL1',
      clientName: 'Client Sécurité BMSoft n°1',
      clientLocationLine1: 'OBM-SECUL1',
      clientLocationLine2: '0Lieu de prestation',
      clientLocationLine3: 'client BM-CL01',
    ),
    Service(
      id: '0005',
      employeeName: 'ANNA DUPONT',
      employeeDetails: 'SERVICE MATIN',
      employeeContact: '0712345678',
      startTime: DateTime(2025, 7, 3, 9, 30), // Passé
      endTime: DateTime(2025, 7, 3, 10, 30),
      clientInfo: 'XYZ-COMP',
      clientName: 'Compagnie XYZ',
      clientLocationLine1: 'XYZ-COMP',
      clientLocationLine2: 'Bureau principal',
      clientLocationLine3: 'Ville Lumière',
    ),
    Service(
      id: '0006',
      employeeName: 'MARC LEGRAND',
      employeeDetails: 'PROJET SOIR',
      employeeContact: '0698765432',
      startTime: DateTime(2025, 7, 5, 18, 0), // Futur (exemple)
      endTime: DateTime(2025, 7, 5, 20, 0),
      clientInfo: 'ABC-INC',
      clientName: 'ABC Corporation',
      clientLocationLine1: 'ABC-INC',
      clientLocationLine2: 'Site de production',
      clientLocationLine3: 'Zone Industrielle',
    ),
  ];

  // Initialisation du Timer lors de la création de l'état du widget
  @override
  void initState() {
    super.initState();
    // Met à jour l'heure affichée immédiatement
    _updateCurrentTime();
    // Démarre un timer périodique qui se déclenche toutes les minutes
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateCurrentTime();
    });
  }

  // Annulation du Timer lorsque le widget est retiré de l'arbre (pour éviter les fuites de mémoire)
  @override
  void dispose() {
    _timer?.cancel(); // Annule le timer s'il est actif
    super.dispose();
  }

  // Fonction pour mettre à jour l'heure actuelle et forcer le rafraîchissement de l'UI
  void _updateCurrentTime() {
    setState(() {
      _currentDisplayDate = DateTime.now(); // Met à jour la date/heure affichée
      // Le getter _sortedServices se réévalue automatiquement car il dépend de DateTime.now()
      // Cela entraînera le rafraîchissement des TimeDetailCards et de leurs durées.
    });
  }

  // Propriété calculée pour obtenir la liste des services triés
  List<Service> get _sortedServices {
    final now = DateTime.now();
    final List<Service> sortedList = List.from(_services);

    sortedList.sort((a, b) {
      final Duration durationA = a.startTime.difference(now);
      final Duration durationB = b.startTime.difference(now);
      return durationA.compareTo(durationB);
    });
    return sortedList;
  }

  void _handleAbsentToggle(String serviceId, bool newAbsentStatus) {
    setState(() {
      final serviceIndex = _services.indexWhere((s) => s.id == serviceId);
      if (serviceIndex != -1) {
        _services[serviceIndex] = _services[serviceIndex].copyWith(isAbsent: newAbsentStatus);
        debugPrint('Service ${serviceId} - Absent: ${newAbsentStatus}');
      }
    });
  }

  void _handleValidate(String serviceId) {
    setState(() {
      final serviceIndex = _services.indexWhere((s) => s.id == serviceId);
      if (serviceIndex != -1) {
        _services[serviceIndex] = _services[serviceIndex].copyWith(isValidated: true);
        debugPrint('Service ${serviceId} - Validated');
      }
    });
  }

  Future<void> _handleModifyTime(String serviceId, DateTime currentTime, TimeCardType type) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(currentTime),
      helpText: 'Sélectionner l\'heure',
      cancelText: 'Annuler',
      confirmText: 'Confirmer',
    );

    if (newTime != null) {
      setState(() {
        final serviceIndex = _services.indexWhere((s) => s.id == serviceId);
        if (serviceIndex != -1) {
          final Service currentService = _services[serviceIndex];
          final DateTime updatedDateTime = DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            newTime.hour,
            newTime.minute,
          );

          if (type == TimeCardType.debut) {
            _services[serviceIndex] = currentService.copyWith(startTime: updatedDateTime);
            debugPrint('Service ${serviceId} - Nouvelle heure de début: ${DateFormat('HH:mm').format(updatedDateTime)}');
          } else {
            _services[serviceIndex] = currentService.copyWith(endTime: updatedDateTime);
            debugPrint('Service ${serviceId} - Nouvelle heure de fin: ${DateFormat('HH:mm').format(updatedDateTime)}');
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prise de services automatique'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              debugPrint('Bouton "Changer" pressé');
            },
            child: const Text('Changer', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () {}),
                Text(
                  '${DateFormat('dd/MM/yyyy').format(_startDate)} - ${DateFormat('dd/MM/yyyy').format(_endDate)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: () {}),
                // L'heure ici sera mise à jour chaque minute
                Text(
                  DateFormat('EEEE dd MMMM HH:mm', 'fr_FR').format(_currentDisplayDate),
                  style: const TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Center(child: Text('Début', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                ),
                const Expanded(
                  flex: 2,
                  child: Center(child: Text('Fin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                ),
                const Expanded(
                  flex: 1,
                  child: Center(child: Text('Résultat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Colonne "Début"
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    itemCount: _sortedServices.length,
                    itemBuilder: (context, index) {
                      final service = _sortedServices[index];
                      return TimeDetailCard(
                        service: service,
                        type: TimeCardType.debut,
                        onAbsentPressed: (newStatus) {
                          _handleAbsentToggle(service.id, newStatus);
                        },
                        onModifyTime: (currentTime) {
                          _handleModifyTime(service.id, currentTime, TimeCardType.debut);
                        },
                        onValidate: null, // Bouton "Valider" désactivé pour les cartes "Début"
                      );
                    },
                  ),
                ),
                // Colonne "Fin"
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    itemCount: _sortedServices.length,
                    itemBuilder: (context, index) {
                      final service = _sortedServices[index];
                      return TimeDetailCard(
                        service: service,
                        type: TimeCardType.fin,
                        onModifyTime: (currentTime) {
                          _handleModifyTime(service.id, currentTime, TimeCardType.fin);
                        },
                        onValidate: () {
                          _handleValidate(service.id);
                        },
                        onAbsentPressed: null, // Bouton "Présent/Absent" désactivé pour les cartes "Fin"
                      );
                    },
                  ),
                ),
                // Colonne "Résultat"
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    itemCount: _sortedServices.length,
                    itemBuilder: (context, index) {
                      final service = _sortedServices[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Colors.grey.shade200, width: 1.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Service ${service.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Text(
                                service.isValidated ? 'Validé' : 'En attente',
                                style: TextStyle(
                                  color: service.isValidated ? Colors.green : Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text('Juillet 2025', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text('36H', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text('96H', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () {}),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text('1', style: TextStyle(color: Colors.blue)),
                ),
                IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
