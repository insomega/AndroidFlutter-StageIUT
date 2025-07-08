// lib/prise_service.dart (Updated with Excel import functionality)

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mon_projet/time_detail_card.dart';
import 'package:mon_projet/models/service.dart';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' hide Border; // NOUVEAU: Importation pour la lecture Excel
import 'dart:typed_data'; // Pour Uint8List

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
  DateTime _startDate = DateTime(2025, 7, 1); // Date de début de période
  DateTime _endDate = DateTime(2025, 7, 31); // Date de fin de période

  Timer? _timer;

  final ScrollController _debutScrollController = ScrollController();
  final ScrollController _finScrollController = ScrollController();
  final ScrollController _resultatScrollController = ScrollController();

  List<Service> _services = [];

  @override
  void initState() {
    super.initState();
    _updateCurrentTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCurrentTime();
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

  Future<void> _importServicesFromExcel() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'], // Autorise uniquement les fichiers .xlsx
        allowMultiple: false,
      );

      if (result != null && result.files.single.bytes != null) {
        final Uint8List bytes = result.files.single.bytes!;
        final Excel excel = Excel.decodeBytes(bytes);

        // Supposons que les données sont dans la première feuille
        final String? sheetName = excel.tables.keys.first;
        if (sheetName == null) {
          debugPrint('Aucune feuille trouvée dans le fichier Excel.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erreur: Aucune feuille trouvée dans le fichier Excel.')),
          );
          return;
        }

        final sheet = excel.tables[sheetName];
        if (sheet == null || sheet.rows.isEmpty) {
          debugPrint('La feuille Excel est vide.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Le fichier Excel est vide ou la feuille sélectionnée est vide.')),
          );
          return;
        }

        List<String> headers = [];
        // Récupérer les en-têtes de la première ligne
        if (sheet.rows.isNotEmpty) {
          headers = sheet.rows[0].map((cell) => cell?.value?.toString() ?? '').toList();
        }

        List<Service> importedServices = [];

        // Parcourir les lignes de données (à partir de la deuxième ligne)
        for (int i = 1; i < sheet.rows.length; i++) {
          final row = sheet.rows[i];
          Map<String, dynamic> rowData = {};
          for (int j = 0; j < headers.length; j++) {
            if (j < row.length) {
              // C'est la ligne correcte à utiliser pour passer la CellValue à Service.fromExcelRow
              // Votre _parseExcelDateValue saura maintenant gérer directement cette CellValue.
              rowData[headers[j]] = row[j]?.value;
            }
          }
          try {
            importedServices.add(Service.fromExcelRow(rowData));
          } catch (e) {
            debugPrint('Erreur lors de la création du service à partir de la ligne Excel ${i + 1}: $rowData - $e');
          }
        }

        setState(() {
          _services = importedServices;
          debugPrint('Importation de ${importedServices.length} services depuis Excel réussie.');
        });
      } else {
        // Message plus clair si l'utilisateur annule ou si le fichier est vide
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aucun fichier sélectionné ou le fichier est vide.')),
        );
        debugPrint('Aucun fichier sélectionné ou fichier vide.');
      }
    } catch (e) {
      debugPrint('Erreur lors de l\'importation du fichier Excel: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'importation du fichier Excel: $e')),
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
            onPressed: _importServicesFromExcel, // NOUVEAU: Bouton pour importer le CSV
            child: const Text('Importer Vacations', style: TextStyle(color: Colors.white)),
          ),
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
