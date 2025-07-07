// lib/prise_service.dart (Updated with independent sorting and precise scrolling)

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mon_projet/time_detail_card.dart';
import 'package:mon_projet/models/service.dart';
import 'dart:async';

extension DateTimeExtension on DateTime {
  DateTime startOfDay() {
    return DateTime(year, month, day, 0, 0, 0);
  }

  DateTime endOfDay() {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }
}

class PriseServiceScreen extends StatefulWidget {
  const PriseServiceScreen({super.key});

  @override
  State<PriseServiceScreen> createState() => _PriseServiceScreenState();
}

class _PriseServiceScreenState extends State<PriseServiceScreen> {
  DateTime _currentDisplayDate = DateTime.now();
  DateTime _startDate = DateTime(2025, 7, 1);
  DateTime _endDate = DateTime(2025, 7, 31);

  Timer? _timer;

  final ScrollController _debutScrollController = ScrollController();
  final ScrollController _finScrollController = ScrollController();
  final ScrollController _resultatScrollController = ScrollController();

  DateTime _parseDateTime(String dateTimeString) {
    final format = DateFormat("dd/MM/yyyy HH:mm");
    return format.parse(dateTimeString);
  }

  List<Service> _services = [];

  @override
  void initState() {
    super.initState();
    _populateServices();
    _updateCurrentTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCurrentTime();
    });
  }

  void _populateServices() {
    setState(() {
      _services = [
        Service(
          id: '422419',
          employeeName: 'PIERRICK ERIC',
          employeeSvrCode: 'BM-SAL04',
          employeeSvrLib: 'SVR_NOM 86710 TEXT',
          employeeTelPort: '0662057140',
          startTime: _parseDateTime('06/07/2025 07:00'),
          endTime: _parseDateTime('08/07/2025 08:47'), // Changé pour une heure de fin future
          locationCode: '0BM-SECU1',
          locationLib: '0Lieu de prestatio client BM-CL01',
          clientLocationLine3: 'client BM-CL01',
          clientSvrCode: 'BM-SAL04',
          clientSvrLib: 'BONBON Délicieux',
          isAbsent: false,
          isValidated: false,
        ),
        Service(
          id: '422847',
          employeeName: 'MELCHIORRE GERALD',
          employeeSvrCode: '142320',
          employeeSvrLib: '0002030406',
          employeeTelPort: '0602030406',
          startTime: _parseDateTime('06/08/2025 20:00'),
          endTime: _parseDateTime('07/08/2025 08:00'), // Heure de fin passée
          locationCode: '0BM-SECU1',
          locationLib: '0Lieu de prestatio client BM-CL01',
          clientLocationLine3: 'client BM-CL01',
          clientSvrCode: '142320',
          clientSvrLib: 'MELCHIORRE GERALD',
          isAbsent: false,
          isValidated: false,
        ),
        Service(
          id: '424862',
          employeeName: 'BM-SAL04',
          employeeSvrCode: 'PIERRICK',
          employeeSvrLib: 'BONBON Délicieux',
          employeeTelPort: '0605040302',
          startTime: DateTime(2025, 7, 8, 20, 0), // Heure de début future
          endTime: DateTime(2025, 7, 8, 21, 47), // Heure de fin future
          locationCode: '0BM-SECU1',
          locationLib: '0Lieu de prestatio client BM-CL01',
          clientLocationLine3: 'client BM-CL01',
          clientSvrCode: 'PIERRICK',
          clientSvrLib: 'SVR_NOM 86710 TEXT ERIC',
          isAbsent: false,
          isValidated: false,
        ),
        Service(
          id: '424865',
          employeeName: 'BMSOFT 05 Salarié',
          employeeSvrCode: '1',
          employeeSvrLib: '673644897',
          employeeTelPort: '0673644897',
          startTime: _parseDateTime('06/07/2025 10:00'),
          endTime: DateTime(2025, 7, 7, 17, 30), // Heure de fin future (pour test)
          locationCode: '0BM-SECU1',
          locationLib: '0Lieu de prestatio client BM-CL01',
          clientLocationLine3: 'client BM-CL01',
          clientSvrCode: '1',
          clientSvrLib: 'BMSOFT 05 Salarié',
          isAbsent: false,
          isValidated: false,
        ),
        // NOUVELLES VACATIONS POUR TEST
        Service(
          id: '425001',
          employeeName: 'JULIE MARTIN',
          employeeSvrCode: 'EMP001',
          employeeSvrLib: 'ASSISTANT',
          employeeTelPort: '0711223344',
          startTime: DateTime(2025, 7, 8, 15, 0), // Futur proche
          endTime: DateTime(2025, 7, 8, 16, 30),
          locationCode: 'LOC-ABC',
          locationLib: 'Bureau Central',
          clientLocationLine3: 'client ABC-Corp',
          clientSvrCode: 'CLIENT-ABC',
          clientSvrLib: 'ABC Corporation',
          isAbsent: false,
          isValidated: false,
        ),
        Service(
          id: '425002',
          employeeName: 'DAVID DUBOIS',
          employeeSvrCode: 'EMP002',
          employeeSvrLib: 'TECHNICIEN',
          employeeTelPort: '0755667788',
          startTime: DateTime(2025, 7, 6, 9, 0), // Passé
          endTime: DateTime(2025, 7, 6, 10, 0),
          locationCode: 'LOC-XYZ',
          locationLib: 'Site Production',
          clientLocationLine3: 'client XYZ-Prod',
          clientSvrCode: 'CLIENT-XYZ',
          clientSvrLib: 'XYZ Industries',
          isAbsent: false,
          isValidated: false,
        ),
        Service(
          id: '425003',
          employeeName: 'SOPHIE LEBLANC',
          employeeSvrCode: 'EMP003',
          employeeSvrLib: 'CONSULTANT',
          employeeTelPort: '0799887766',
          startTime: DateTime(2025, 7, 10, 8, 0), // Futur lointain
          endTime: DateTime(2025, 7, 10, 17, 0),
          locationCode: 'LOC-DEF',
          locationLib: 'Siège Social',
          clientLocationLine3: 'client DEF-Group',
          clientSvrCode: 'CLIENT-DEF',
          clientSvrLib: 'DEF Group',
          isAbsent: false,
          isValidated: false,
        ),
        Service(
          id: '425004',
          employeeName: 'THOMAS PETIT',
          employeeSvrCode: 'EMP004',
          employeeSvrLib: 'DEVELOPPEUR',
          employeeTelPort: '0744332211',
          startTime: DateTime(2025, 7, 7, 11, 0), // Passé, mais avec fin future
          endTime: DateTime(2025, 7, 7, 18, 0), // Fin future
          locationCode: 'LOC-GHI',
          locationLib: 'Centre de Recherche',
          clientLocationLine3: 'client GHI-Tech',
          clientSvrCode: 'CLIENT-GHI',
          clientSvrLib: 'GHI Technologies',
          isAbsent: false,
          isValidated: false,
        ),
      ];
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _debutScrollController.dispose();
    _finScrollController.dispose();
    _resultatScrollController.dispose();
    super.dispose();
  }

  void _updateCurrentTime() {
    setState(() {
      _currentDisplayDate = DateTime.now();
    });
  }

  // --- Fonctions de navigation de date ---
  void _changeDateByDay(DateTime dateToChange, int daysToAdd, Function(DateTime) updateState) {
    setState(() {
      updateState(dateToChange.add(Duration(days: daysToAdd)));
    });
  }

  void _changeDateByMonth(DateTime dateToChange, int monthsToAdd, Function(DateTime) updateState) {
    setState(() {
      updateState(DateTime(
        dateToChange.year,
        dateToChange.month + monthsToAdd,
        dateToChange.day,
      ));
    });
  }

  Future<void> _selectDate(BuildContext context, DateTime initialDate, Function(DateTime) updateState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000), // Date de début possible
      lastDate: DateTime(2030),  // Date de fin possible
      helpText: 'Sélectionner une date',
      cancelText: 'Annuler',
      confirmText: 'Confirmer',
      locale: const Locale('fr', 'FR'), // Force le sélecteur de date en français
    );
    if (picked != null && picked != initialDate) {
      setState(() {
        updateState(picked);
      });
    }
  }

  List<Service> get _filteredAndSortedDebutServices {
    final now = DateTime.now();
    final filteredList = _services.where((service) {
      return service.startTime.isBefore(_endDate.endOfDay()) && service.endTime.isAfter(_startDate.startOfDay());
    }).toList();

    filteredList.sort((a, b) {
      final Duration durationA = a.startTime.difference(now);
      final Duration durationB = b.startTime.difference(now);
      return durationB.compareTo(durationA); // Tri décroissant des durées
    });
    return filteredList;
  }

  List<Service> get _filteredAndSortedFinServices {
    final now = DateTime.now();
    final filteredList = _services.where((service) {
      // Utilise le même critère de filtrage pour que les deux colonnes affichent le même ensemble de services
      return service.endTime.isBefore(_endDate.endOfDay()) && service.endTime.isAfter(_startDate.startOfDay());
    }).toList();

    filteredList.sort((a, b) {
      final Duration durationA = a.endTime.difference(now); // Tri basé sur l'heure de fin
      final Duration durationB = b.endTime.difference(now);
      return durationB.compareTo(durationA); // Tri décroissant des durées
    });
    return filteredList;
  }

  void _handleAbsentToggle(String serviceId, bool newAbsentStatus) {
    setState(() {
      final serviceIndex = _services.indexWhere((s) => s.id == serviceId);
      if (serviceIndex != -1) {
        // Si l'état devient absent, la validation est automatiquement retirée
        if (newAbsentStatus == true) {
          _services[serviceIndex] = _services[serviceIndex].copyWith(isAbsent: newAbsentStatus, isValidated: false);
          debugPrint('Service ${serviceId} - Absent: ${newAbsentStatus}, Validation retirée.');
        } else {
          // Si l'état devient présent, on met juste à jour isAbsent
          _services[serviceIndex] = _services[serviceIndex].copyWith(isAbsent: newAbsentStatus);
          debugPrint('Service ${serviceId} - Absent: ${newAbsentStatus}');
        }
      }
    });
  }

  void _handleValidate(String serviceId, bool newValidateStatus) {
    setState(() {
      final serviceIndex = _services.indexWhere((s) => s.id == serviceId);
      if (serviceIndex != -1) {
        _services[serviceIndex] = _services[serviceIndex].copyWith(isValidated: newValidateStatus);
        debugPrint('Service ${serviceId} - Validated: ${newValidateStatus}');
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

  void _scrollToService(Service serviceToScrollTo) {
    const double itemHeight = 200.0; // Hauteur estimée d'une carte

    // Trouver l'index du service dans la liste filtrée et triée de la colonne Début
    final int debutIndex = _filteredAndSortedDebutServices.indexWhere((s) => s.id == serviceToScrollTo.id);
    if (debutIndex != -1) {
      _debutScrollController.animateTo(
        debutIndex * itemHeight,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    // Trouver l'index du service dans la liste filtrée et triée de la colonne Fin
    final int finIndex = _filteredAndSortedFinServices.indexWhere((s) => s.id == serviceToScrollTo.id);
    if (finIndex != -1) {
      _finScrollController.animateTo(
        finIndex * itemHeight,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    // Le défilement de la colonne Résultat suit l'ordre de la colonne Début
    if (debutIndex != -1) {
      _resultatScrollController.animateTo(
        debutIndex * itemHeight,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo_app.png',
            height: 40,
            width: 40,
          ),
        ),
        title: const Text(
          'Prise de services automatique',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Colors.grey[100],
            child: Row(
              children: [
                // Bouton flèche gauche (mois précédent)
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 18),
                  onPressed: () {
                    _changeDateByMonth(_startDate, -1, (newDate) => _startDate = newDate);
                    _changeDateByMonth(_endDate, -1, (newDate) => _endDate = newDate);
                  },
                  visualDensity: VisualDensity.compact,
                ),
                // Bouton "-" pour jour précédent (startDate)
                IconButton(
                  icon: const Icon(Icons.remove, size: 18),
                  onPressed: () {
                    _changeDateByDay(_startDate, -1, (newDate) => _startDate = newDate);
                  },
                  visualDensity: VisualDensity.compact,
                ),
                // Affichage et modification de la date de début
                GestureDetector(
                  onTap: () => _selectDate(context, _startDate, (newDate) => _startDate = newDate),
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(_startDate),
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                // Bouton "+" pour jour suivant (startDate)
                IconButton(
                  icon: const Icon(Icons.add, size: 18),
                  onPressed: () {
                    _changeDateByDay(_startDate, 1, (newDate) => _startDate = newDate);
                  },
                  visualDensity: VisualDensity.compact,
                ),
                
                const SizedBox(width: 8), // Espace entre les deux dates
                Text(
                  '|',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8), // Espace entre les deux dates

                // Bouton "-" pour jour précédent (endDate)
                IconButton(
                  icon: const Icon(Icons.remove, size: 18),
                  onPressed: () {
                    _changeDateByDay(_endDate, -1, (newDate) => _endDate = newDate);
                  },
                  visualDensity: VisualDensity.compact,
                ),
                // Affichage et modification de la date de fin
                GestureDetector(
                  onTap: () => _selectDate(context, _endDate, (newDate) => _endDate = newDate),
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(_endDate),
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                // Bouton "+" pour jour suivant (endDate)
                IconButton(
                  icon: const Icon(Icons.add, size: 18),
                  onPressed: () {
                    _changeDateByDay(_endDate, 1, (newDate) => _endDate = newDate);
                  },
                  visualDensity: VisualDensity.compact,
                ),
                // Bouton flèche droite (mois suivant)
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  onPressed: () {
                    _changeDateByMonth(_startDate, 1, (newDate) => _startDate = newDate);
                    _changeDateByMonth(_endDate, 1, (newDate) => _endDate = newDate);
                  },
                  visualDensity: VisualDensity.compact,
                ),

                const Spacer(), // Pousse l'heure actuelle à droite

                // Affichage de la date et heure actuelles
                Text(
                  DateFormat('EEEE dd MMMM HH:mm:ss', 'fr_FR').format(_currentDisplayDate),
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.blueGrey),
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
                    controller: _debutScrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    itemCount: _filteredAndSortedDebutServices.length,
                    itemBuilder: (context, index) {
                      final service = _filteredAndSortedDebutServices[index];
                      return TimeDetailCard(
                        service: service,
                        type: TimeCardType.debut,
                        onAbsentPressed: (newStatus) {
                          _handleAbsentToggle(service.id, newStatus);
                        },
                        onModifyTime: (currentTime) {
                          _handleModifyTime(service.id, currentTime, TimeCardType.debut);
                        },
                        onValidate: (newStatus) {
                          _handleValidate(service.id, newStatus);
                        },
                        onTap: () {
                           _scrollToService(service);
                        }
                      );
                    },
                  ),
                ),
                // Colonne "Fin"
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    controller: _finScrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    itemCount: _filteredAndSortedFinServices.length,
                    itemBuilder: (context, index) {
                      final service = _filteredAndSortedFinServices[index];
                      return TimeDetailCard(
                        service: service,
                        type: TimeCardType.fin,
                        onModifyTime: (currentTime) {
                          _handleModifyTime(service.id, currentTime, TimeCardType.fin);
                        },
                        onValidate: (newStatus) {
                          _handleValidate(service.id, newStatus);
                        },
                        onAbsentPressed:  (newStatus) {
                          _handleAbsentToggle(service.id, newStatus);
                        },
                        onTap: () {
                           _scrollToService(service);
                        }
                      );
                    },
                  ),
                ),
                // Colonne "Résultat"
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    controller: _resultatScrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    itemCount: _filteredAndSortedDebutServices.length,
                    itemBuilder: (context, index) {
                      final service = _filteredAndSortedDebutServices[index];
                      return TimeDetailCard(
                        service: service,
                        type: TimeCardType.result,
                        onAbsentPressed: (newStatus) {
                          _handleAbsentToggle(service.id, newStatus);
                        },
                        onValidate: (newStatus) {
                          _handleValidate(service.id, newStatus);
                        },
                        onModifyTime: (currentTime) {
                          _handleModifyTime(service.id, currentTime, TimeCardType.debut);
                        },
                        onTap: () => _scrollToService(service),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Container(
          //         padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          //         decoration: BoxDecoration(
          //           color: Colors.blueAccent,
          //           borderRadius: BorderRadius.circular(8.0),
          //         ),
          //         child: const Text('Juillet 2025', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          //       ),
          //       const SizedBox(width: 10),
          //       Container(
          //         padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          //         decoration: BoxDecoration(
          //           color: Colors.redAccent,
          //           borderRadius: BorderRadius.circular(8.0),
          //         ),
          //         child: const Text('36H', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          //       ),
          //       const SizedBox(width: 10),
          //       Container(
          //         padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          //         decoration: BoxDecoration(
          //           color: Colors.orangeAccent,
          //           borderRadius: BorderRadius.circular(8.0),
          //         ),
          //         child: const Text('96H', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          //       ),
          //     ],
          //   ),
          // ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // Groupe de contrôles de pagination (< 1 >)
                Row(
                  mainAxisSize: MainAxisSize.min,
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

                const Spacer(),

                Text(
                  "© BMSoft 2025, tous droits réservés   ${DateFormat('dd/MM/yyyy HH:mm:ss', 'fr_FR').format(_currentDisplayDate)}",
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 3, 53, 190)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
