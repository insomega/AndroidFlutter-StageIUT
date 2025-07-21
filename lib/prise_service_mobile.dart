// lib/prise_service_mobile.dart (Updated with Excel import functionality)

// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io'; // Pour File
import 'package:path_provider/path_provider.dart'; // Pour getExternalStorageDirectory, etc.
import 'package:open_filex/open_filex.dart'; // Pour ouvrir le fichier après l'exportation // Target of URI doesn't exist: 'package:open_filex/open_filex.dart'.
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mon_projet/time_detail_card.dart'; // Assurez-vous que ce fichier existe
import 'package:mon_projet/models/service.dart'; // Assurez-vous que ce fichier existe
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' hide Border; // Importation pour la lecture et l'écriture Excel
import 'dart:typed_data'; // Pour Uint8List
import 'package:mon_projet/utils/date_time_extensions.dart';

class PriseServiceScreen extends StatefulWidget {
  const PriseServiceScreen({super.key});

  @override
  State<PriseServiceScreen> createState() => _PriseServiceScreenState();
}

class _PriseServiceScreenState extends State<PriseServiceScreen> {
  DateTime _currentDisplayDate = DateTime.now();
  DateTime _startDate = DateTime(2025, 7, 1); // Date de début de période par défaut
  DateTime _endDate = DateTime(2025, 7, 31); // Date de fin de période par défaut

  Timer? _timer;

  final ScrollController _debutScrollController = ScrollController();
  final ScrollController _finScrollController = ScrollController();
  final ScrollController _resultatScrollController = ScrollController();

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = ''; // La chaîne de recherche actuelle

  List<Service> _services = []; // Liste des services chargés
  bool _dataLoaded = false; // Indicateur si les données ont été chargées

  double _totalWorkedHours = 0.0; // Heures totales travaillées
  double _remainingHours = 0.0; // Heures restantes (prévues - travaillées)
  double _totalScheduledHours = 0.0; // Heures totales prévues

  @override
  void initState() {
    super.initState();
    _updateCurrentTime(); // Met à jour l'heure affichée
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCurrentTime(); // Met à jour l'heure toutes les secondes
    });

    _searchController.addListener(_onSearchChanged); // Écoute les changements dans la barre de recherche
    Intl.defaultLocale = 'fr_FR'; // Assure la locale française pour les dates
    _calculateSummaryData(); // Calcul initial des données de résumé
  }

  // Met à jour la chaîne de recherche et déclenche un rafraîchissement de l'UI
  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Annule le timer pour éviter les fuites de mémoire
    _debutScrollController.dispose();
    _finScrollController.dispose();
    _resultatScrollController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // Met à jour l'heure actuelle affichée
  void _updateCurrentTime() {
    setState(() {
      _currentDisplayDate = DateTime.now();
    });
  }

  // --- Fonctions de navigation de date ---
  // Change la date par jour (pour _startDate ou _endDate)
  void _changeDateByDay(DateTime dateToChange, int daysToAdd, Function(DateTime) updateState) {
    setState(() {
      updateState(dateToChange.add(Duration(days: daysToAdd)));
      _filterAndSortServices(); // Rafraîchit après changement de date
      _calculateSummaryData(); // Recalcule les données de résumé
    });
  }

  // Change la date par mois (pour _startDate ou _endDate)
  void _changeDateByMonth(DateTime dateToChange, int monthsToAdd, Function(DateTime) updateState) {
    setState(() {
      updateState(DateTime(
        dateToChange.year,
        dateToChange.month + monthsToAdd,
        dateToChange.day,
      ));
      _filterAndSortServices(); // Rafraîchit après changement de date
      _calculateSummaryData(); // Recalcule les données de résumé
    });
  }

  // Ouvre un sélecteur de date pour choisir une date spécifique
  Future<void> _selectDate(BuildContext context, DateTime initialDate, Function(DateTime) updateState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000), // Date de début possible
      lastDate: DateTime(2030), // Date de fin possible
      helpText: 'Sélectionner une date',
      cancelText: 'Annuler',
      confirmText: 'Confirmer',
      locale: const Locale('fr', 'FR'), // Force le sélecteur de date en français
    );
    if (picked != null && picked != initialDate) {
      setState(() {
        updateState(picked);
        _filterAndSortServices(); // Rafraîchit après changement de date
        _calculateSummaryData(); // Recalcule les données de résumé
      });
    }
  }

  // Helper pour parser la durée (ex: "1h 30min") en heures totales
  // Cette fonction n'est pas utilisée directement dans le code actuel car
  // le modèle Service gère déjà la conversion de durée.
  
  // double _parseDurationToHours(String durationString) {
  //   double totalHours = 0.0;
  //   final parts = durationString.toLowerCase().split('h');
  //   if (parts.isNotEmpty) {
  //     // Gère la partie heures
  //     final hourPart = parts[0].trim();
  //     try {
  //       totalHours += double.parse(hourPart.replaceAll(',', '.')); // Gère la virgule comme séparateur décimal
  //     } catch (e) {
  //       debugPrint('Error parsing hour part: $hourPart, $e');
  //     
  //     // Gère la partie minutes si disponible
  //     if (parts.length > 1 && parts[1].contains('min')) {
  //       final minPart = parts[1].split('min')[0].trim();
  //       try {
  //         totalHours += int.parse(minPart) / 60.0;
  //       } catch (e) {
  //         debugPrint('Error parsing minute part: $minPart, $e');
  //       }
  //     }
  //   }
  //   return totalHours;
  // }

  // Calcule les données de résumé (total et restant)
  void _calculateSummaryData() {
    double currentTotalWorkedHours = 0.0;
    double currentTotalScheduledHours = 0.0;

    // Itérer sur tous les services pour calculer les heures prévues et travaillées
    for (var service in _services) {
      // Vérifie si le service est dans la plage de dates actuelle
      bool isInDateRange = service.startTime.isAfter(_startDate.startOfDay()) &&
          service.startTime.isBefore(_endDate.endOfDay());

      if (isInDateRange) {
        // Ajoute la durée de tous les services à _totalScheduledHours
        currentTotalScheduledHours += service.durationInHours;

        // Ajoute la durée des services validés et non absents à _totalWorkedHours
        if (service.isValidated && !service.isAbsent) {
          currentTotalWorkedHours += service.durationInHours;
        }
      }
    }

    setState(() {
      _totalWorkedHours = currentTotalWorkedHours;
      _totalScheduledHours = currentTotalScheduledHours;
      _remainingHours = _totalScheduledHours - _totalWorkedHours;
    });
  }

  // Méthode pour déclencher le filtrage et le tri des services
  void _filterAndSortServices() {
    setState(() {
      // Le simple fait de déclencher setState() fera que les getters seront recalculés.
    });
  }

  // Getter pour les services filtrés et triés pour la colonne "Début"
  List<Service> get _filteredAndSortedDebutServices {
    final filteredList = _services.where((service) {
      // Filtre par plage de dates
      bool isInDateRange = service.startTime.isBefore(_endDate.endOfDay()) && service.startTime.isAfter(_startDate.startOfDay());
      // Filtre par nom d'employé (recherche insensible à la casse)
      bool matchesSearch = _searchQuery.isEmpty ||
          service.employeeName.toLowerCase().contains(_searchQuery.toLowerCase());
      return isInDateRange && matchesSearch;
    }).toList();

    filteredList.sort((a, b) => a.startTime.compareTo(b.startTime)); // Tri par heure de début
    return filteredList;
  }

  // Getter pour les services filtrés et triés pour la colonne "Fin"
  List<Service> get _filteredAndSortedFinServices {
    final filteredList = _services.where((service) {
      // Filtre par plage de dates
      bool isInDateRange = service.endTime.isBefore(_endDate.endOfDay()) && service.endTime.isAfter(_startDate.startOfDay());
      // Filtre par nom d'employé
      bool matchesSearch = _searchQuery.isEmpty ||
          service.employeeName.toLowerCase().contains(_searchQuery.toLowerCase());
      return isInDateRange && matchesSearch;
    }).toList();

    filteredList.sort((a, b) => a.endTime.compareTo(b.endTime)); // Tri par heure de fin
    return filteredList;
  }

  // La colonne Résultat affiche les mêmes services que Début, mais avec une carte différente
  // List<Service> get _filteredAndSortedResultatServices {
  //   return List.from(_filteredAndSortedDebutServices);
  // }

  // Gère le basculement de l'état "Absent" d'un service
  void _handleAbsentToggle(String serviceId, bool newAbsentStatus) {
    setState(() {
      final serviceIndex = _services.indexWhere((s) => s.id == serviceId);
      if (serviceIndex != -1) {
        // Si l'état devient absent, la validation est automatiquement retirée
        if (newAbsentStatus == true) {
          _services[serviceIndex] = _services[serviceIndex].copyWith(isAbsent: newAbsentStatus, isValidated: false);
          debugPrint('Service $serviceId - Absent: $newAbsentStatus, Validation retirée.');
        } else {
          // Si l'état devient présent, on met juste à jour isAbsent
          _services[serviceIndex] = _services[serviceIndex].copyWith(isAbsent: newAbsentStatus);
          debugPrint('Service $serviceId - Absent: $newAbsentStatus');
        }
        _calculateSummaryData(); // Recalcule les données de résumé
      }
    });
  }

  // Gère le basculement de l'état "Validé" d'un service
  void _handleValidate(String serviceId, bool newValidateStatus) {
    setState(() {
      final serviceIndex = _services.indexWhere((s) => s.id == serviceId);
      if (serviceIndex != -1) {
        _services[serviceIndex] = _services[serviceIndex].copyWith(isValidated: newValidateStatus);
        debugPrint('Service $serviceId - Validated: $newValidateStatus');
        _calculateSummaryData(); // Recalcule les données de résumé
      }
    });
  }

  // Gère la modification de l'heure de début ou de fin d'un service
  Future<void> _handleModifyTime(String serviceId, DateTime currentTime, TimeCardType type) async {
    // Étape 1: Sélectionner la date
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: currentTime, // Date initiale basée sur l'heure actuelle du service
      firstDate: DateTime(2000), // Date de début possible
      lastDate: DateTime(2030), // Date de fin possible
      helpText: 'Sélectionner la date',
      cancelText: 'Annuler',
      confirmText: 'Confirmer',
      locale: const Locale('fr', 'FR'), // Force le sélecteur de date en français
    );

    if (newDate == null) {
      return; // L'utilisateur a annulé la sélection de la date
    }

    // Étape 2: Sélectionner l'heure
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(currentTime), // Heure initiale basée sur l'heure actuelle du service
      helpText: 'Sélectionner l\'heure',
      cancelText: 'Annuler',
      confirmText: 'Confirmer',
    );

    if (newTime != null) {
      // Trouver le service actuel avant de modifier l'état
      final serviceIndex = _services.indexWhere((s) => s.id == serviceId);
      if (serviceIndex == -1) {
        debugPrint('Erreur: Service non trouvé avec l\'ID $serviceId');
        return; // Sortir si le service n'est pas trouvé
      }

      final Service currentService = _services[serviceIndex];

      // Construire le DateTime complet avec la NOUVELLE date et la NOUVELLE heure
      final DateTime updatedDateTime = DateTime(
        newDate.year, // Utilise l'année de la nouvelle date
        newDate.month, // Utilise le mois de la nouvelle date
        newDate.day, // Utilise le jour de la nouvelle date
        newTime.hour,
        newTime.minute,
      );

      debugPrint('--- Débogage de la validation ---');
      debugPrint('ID du service: $serviceId');
      debugPrint('Type de modification: $type');
      debugPrint('Heure de début actuelle (complète): ${currentService.startTime}');
      debugPrint('Heure de fin actuelle (complète): ${currentService.endTime}');
      debugPrint('Nouvelle heure sélectionnée (complète): $updatedDateTime');
      debugPrint('--- Fin du débogage de la validation ---');

      bool canUpdate = true;
      String? errorMessage;

      if (type == TimeCardType.debut) {
        // Pour une modification de l'heure de DÉBUT :
        // La nouvelle heure de début (updatedDateTime) doit être AVANT l'heure de fin actuelle (currentService.endTime).
        // Si elle est APRÈS ou ÉGALE, c'est une erreur.
        if (updatedDateTime.isAfter(currentService.endTime) || updatedDateTime.isAtSameMomentAs(currentService.endTime)) {
          canUpdate = false;
          errorMessage = 'L\'heure de début (${DateFormat('dd/MM HH:mm').format(updatedDateTime)}) ne peut pas être après ou égale à l\'heure de fin actuelle (${DateFormat('dd/MM HH:mm').format(currentService.endTime)}).';
        }
      } else { // type == TimeCardType.fin
        // Pour une modification de l'heure de FIN :
        // La nouvelle heure de fin (updatedDateTime) doit être APRÈS l'heure de début actuelle (currentService.startTime).
        // Si elle est AVANT ou ÉGALE, c'est une erreur.
        if (updatedDateTime.isBefore(currentService.startTime) || updatedDateTime.isAtSameMomentAs(currentService.startTime)) {
          canUpdate = false;
          errorMessage = 'L\'heure de fin (${DateFormat('dd/MM HH:mm').format(updatedDateTime)}) ne peut pas être avant ou égale à l\'heure de début actuelle (${DateFormat('dd/MM HH:mm').format(currentService.startTime)}).';
        }
      }

      if (canUpdate) {
        setState(() {
          if (type == TimeCardType.debut) {
            _services[serviceIndex] = currentService.copyWith(startTime: updatedDateTime);
            debugPrint('Service $serviceId - Nouvelle heure de début: ${DateFormat('dd/MM HH:mm').format(updatedDateTime)}');
          } else {
            _services[serviceIndex] = currentService.copyWith(endTime: updatedDateTime);
            debugPrint('Service $serviceId - Nouvelle heure de fin: ${DateFormat('dd/MM HH:mm').format(updatedDateTime)}');
          }
          _calculateSummaryData(); // Recalcule les données de résumé
        });
        // Afficher un SnackBar de succès (optionnel, mais bonne pratique)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Heure ${type == TimeCardType.debut ? "de début" : "de fin"} mise à jour avec succès.'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Afficher le message d'erreur si la validation échoue
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage!),
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,
          ),
        );
        debugPrint('Erreur de validation: $errorMessage');
      }
    }
  }

  // Fait défiler les différentes colonnes pour afficher le service spécifié
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

  // Fonction pour importer les services depuis un fichier Excel
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
        final String sheetName = excel.tables.keys.first;

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
              rowData[headers[j]] = row[j]?.value;
            }
          }
          try {
            importedServices.add(Service.fromExcelRow(rowData));
          } catch (e) {
            debugPrint('Erreur lors de la création du service à partir de la ligne Excel ${i + 1}: $rowData - $e');
            // Optionnel: Afficher un SnackBar pour chaque erreur de ligne
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur à la ligne ${i + 1}: $e')),
            );
          }
        }

        setState(() {
          _services = importedServices;
          _dataLoaded = true;
          debugPrint('Importation de ${importedServices.length} services depuis Excel réussie.');
          _filterAndSortServices(); // Applique le filtre initial après le chargement
          _calculateSummaryData(); // Recalcule les données de résumé
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Importation de ${importedServices.length} services depuis Excel réussie.'),
            backgroundColor: Colors.green,
          ),
        );
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
  
  // Fonction pour exporter les services vers un fichier Excel sur mobile
  Future<void> _exportServicesToExcel(List<Service> services) async {
    if (services.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aucune donnée à exporter.')),
      );
      return;
    }

    try {
      final excel = Excel.createExcel();
      final sheet = excel['Services'];

      // En-têtes (même logique que pour le web)
      sheet.appendRow([
        TextCellValue('VAC_IDF'),
        TextCellValue('SVR_LIB'),
        TextCellValue('SVR_CODE'),
        TextCellValue('SVR_LIB (Employé)'),
        TextCellValue('SVR_TELPOR'),
        TextCellValue('VAC_START_HOUR'),
        TextCellValue('VAC_END_HOUR'),
        TextCellValue('LIE_CODE'),
        TextCellValue('LIE_LIB'),
        TextCellValue('CLIENT'),
        TextCellValue('SVR_CODE (Client)'),
        TextCellValue('SVR_LIB (Client)'),
        TextCellValue('Absent'),
        TextCellValue('Validé'),
      ]);

      // Données (même logique que pour le web)
      for (var service in services) {
        sheet.appendRow([
          TextCellValue(service.id),
          TextCellValue(service.employeeSvrLib),
          TextCellValue(service.employeeSvrCode),
          TextCellValue(service.employeeName),
          TextCellValue(service.employeeTelPort),
          TextCellValue(DateFormat('dd/MM/yyyy HH:mm').format(service.startTime)),
          TextCellValue(DateFormat('dd/MM/yyyy HH:mm').format(service.endTime)),
          TextCellValue(service.locationCode),
          TextCellValue(service.locationLib),
          TextCellValue(service.clientLocationLine3),
          TextCellValue(service.clientSvrCode),
          TextCellValue(service.clientSvrLib),
          TextCellValue(service.isAbsent ? 'Oui' : 'Non'),
          TextCellValue(service.isValidated ? 'Oui' : 'Non'),
        ]);
      }
      excel.delete('Sheet1'); // Supprime la feuille par défaut

      final List<int>? bytes = excel.save();
      if (bytes == null) throw Exception('Erreur lors de la génération Excel');

      // Spécifique au mobile : enregistrer le fichier
      final String? directory = (await getExternalStorageDirectory())?.path; // Pour Android
      // Ou getApplicationDocumentsDirectory() pour iOS/Android interne
      if (directory == null) throw Exception('Impossible de trouver le répertoire de stockage.');

      final String fileName = 'services_export_${DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now())}.xlsx';
      final File file = File('$directory/$fileName');
      await file.writeAsBytes(bytes, flush: true);

      // Optionnel : Ouvrir le fichier
      await OpenFilex.open(file.path); // Undefined name 'OpenFilex'.

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Exportation réussie (fichier enregistré).'), backgroundColor: Colors.green),
      );
    } catch (e) {
      debugPrint('Erreur lors de l\'export mobile : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur export mobile : $e')),
      );
    }
  }

  void _onExportPressed() {
    _exportServicesToExcel(_services); // Passez la liste '_services' comme argument.
  }

  // Méthode pour construire l'AppBar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/logo_app.png',
          height: 40,
          width: 40,
        ),
      ),
      title: Text(
        'Prise de services automatique',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: _dataLoaded
              ? ElevatedButton.icon(
                  onPressed: _importServicesFromExcel,
                  icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.primary),
                  label: Text('Changer fichier', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                )
              : ElevatedButton.icon(
                  onPressed: _importServicesFromExcel,
                  icon: Icon(Icons.upload_file, color: Theme.of(context).colorScheme.primary),
                  label: Text('Importer services', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ElevatedButton.icon(
            onPressed: _onExportPressed,
            icon: Icon(Icons.download, color: Theme.of(context).colorScheme.primary),
            label: Text('Exporter services', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ),

        const SizedBox(width: 8),
      ],
    );
  }

  // Méthode pour construire le sélecteur de date
  Widget _buildDateRangeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.grey[100],
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18),
            onPressed: () {
              setState(() {
                _changeDateByMonth(_startDate, -1, (newDate) => _startDate = newDate);
                _changeDateByMonth(_endDate, -1, (newDate) => _endDate = newDate);
              });
            },
            visualDensity: VisualDensity.compact,
          ),
          _buildDateControl(_startDate, (newDate) => setState(() => _startDate = newDate)),
          const SizedBox(width: 8),
          VerticalDivider(
            color: Theme.of(context).colorScheme.primary, // Utilise la couleur du thème
            thickness: 1.5,
            indent: 5,
            endIndent: 5,
            width: 16,
          ),
          const SizedBox(width: 8),
          _buildDateControl(_endDate, (newDate) => setState(() => _endDate = newDate)),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 18),
            onPressed: () {
              setState(() {
                _changeDateByMonth(_startDate, 1, (newDate) => _startDate = newDate);
                _changeDateByMonth(_endDate, 1, (newDate) => _endDate = newDate);
              });
            },
            visualDensity: VisualDensity.compact,
          ),
          const Spacer(),
          Text(
            DateFormat('EEEE dd MMMM HH:mm:ss', 'fr_FR').format(_currentDisplayDate),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary, // Couleur secondaire du thème
            ),
          ),
        ],
      ),
    );
  }

  // Méthode d'aide pour les contrôles individuels de date
  Widget _buildDateControl(DateTime date, ValueChanged<DateTime> onDateChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove, size: 18),
          onPressed: () => _changeDateByDay(date, -1, onDateChanged),
          visualDensity: VisualDensity.compact,
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () => _selectDate(context, date, onDateChanged),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor, width: 1.5),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
            child: Text(
              DateFormat('dd/MM/yyyy').format(date),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
        ),
        const SizedBox(width: 4),
        IconButton(
          icon: const Icon(Icons.add, size: 18),
          onPressed: () => _changeDateByDay(date, 1, onDateChanged),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }

  // Méthode pour construire la barre de recherche
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: 'Rechercher par nom d\'employé',
          hintText: 'Entrez le nom de l\'employé...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        ),
      ),
    );
  }

  // Méthode pour construire les en-têtes de colonne
  Widget _buildColumnHeaders() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Début',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary, // Utilise la couleur du thème
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Fin',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary, // Utilise la couleur du thème
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Résultat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green.shade700, // Une couleur distincte pour le résultat
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour construire une liste de services (colonne)
  Widget _buildServiceColumn(List<Service> services, ScrollController controller, TimeCardType type) {
    return Expanded(
      flex: type == TimeCardType.result ? 1 : 2, // Flexibilité différente pour la colonne Résultat
      child: ListView.builder(
        controller: controller,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return TimeDetailCard(
            service: service,
            type: type,
            onAbsentPressed: (newStatus) {
              _handleAbsentToggle(service.id, newStatus);
            },
            onModifyTime: (currentTime) {
              _handleModifyTime(service.id, currentTime, type); // Passe le type correct
            },
            onValidate: (newStatus) {
              _handleValidate(service.id, newStatus);
            },
            onTap: () {
              _scrollToService(service);
            },
          );
        },
      ),
    );
  }

  // Méthode pour construire le pied de page
  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            "© BMSoft 2025, tous droits réservés   ${DateFormat('dd/MM/yyyy HH:mm:ss', 'fr_FR').format(_currentDisplayDate)}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary, // Utilise la couleur secondaire du thème
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour construire une puce de résumé flottante
  Widget _buildSummaryChip(IconData icon, String label, String value, Color color) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  value,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour construire les widgets flottants de résumé
  Widget _buildSummaryFloatingWidgets() {
    return Positioned(
      bottom: 30, // Ajustez la position verticale si nécessaire
      right: 20, // Ajustez la position horizontale si nécessaire
      child: Row( // Changé de Row à Column pour empiler verticalement
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildSummaryChip(Icons.calendar_today, 'Mois', DateFormat('MMMM', 'fr_FR').format(_startDate), Colors.blueAccent),
          const SizedBox(height: 6),
          _buildSummaryChip(Icons.balance, 'Prévu', '${_totalScheduledHours.toStringAsFixed(1)}H', Colors.purpleAccent), // Nouvelle puce pour les heures prévues
          const SizedBox(height: 6),
          _buildSummaryChip(Icons.access_time, 'Travaillé', '${_totalWorkedHours.toStringAsFixed(1)}H', Colors.redAccent), // Ancien "Total"
          const SizedBox(height: 6),
          _buildSummaryChip(Icons.access_time, 'Restant', '${_remainingHours.toStringAsFixed(1)}H', Colors.orangeAccent),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack( // Utilisez un Stack pour positionner les widgets flottants
        children: <Widget>[
          Column( // Le contenu principal de l'application
            children: <Widget>[
              _buildDateRangeSelector(),
              _buildSearchBar(),
              _buildColumnHeaders(),
              if (!_dataLoaded) ...[
                const Spacer(),
                Text(
                  "Veuillez importer un fichier Excel pour commencer",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.error, // Utilise la couleur d'erreur du thème
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
              ],
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildServiceColumn(_filteredAndSortedDebutServices, _debutScrollController, TimeCardType.debut),
                    _buildServiceColumn(_filteredAndSortedFinServices, _finScrollController, TimeCardType.fin),
                    _buildServiceColumn(_filteredAndSortedDebutServices, _resultatScrollController, TimeCardType.result),
                  ],
                ),
              ),
              _buildFooter(),
            ],
          ),
          _buildSummaryFloatingWidgets(), // Les widgets flottants ajoutés ici
        ],
      ),
    );
  }
}