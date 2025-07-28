// lib/prise_service_web.dart

// ignore_for_file: deprecated_member_use, use_build_context_synchronously

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mon_projet/time_detail_card.dart'; // Assurez-vous que ce fichier existe
import 'package:mon_projet/models/service.dart'; // Assurez-vous que ce fichier existe
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' hide Border; // Importation pour la lecture et l'écriture Excel
import 'dart:typed_data'; // Pour Uint8List
import 'package:mon_projet/utils/date_time_extensions.dart'; // Assurez-vous que ce chemin est correct
import 'package:mon_projet/utils/responsive_utils_web.dart' as responsive_utils;


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

  // Visibilité des colonnes (ajouté)
  bool _showDebutColumn = true;
  bool _showFinColumn = true;
  bool _showResultColumn = true;


  @override
  void initState() {
    super.initState();
    _updateCurrentTime(); // Met à jour l'heure affichée
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCurrentTime(); // Met à jour l'heure toutes les secondes
    });

    _searchController.addListener(_onSearchChanged); // Écoute les changements dans la barre de recherche
    Intl.defaultLocale = 'fr_FR'; // Assure la locale française pour les dates

    _syncScrollControllers(); // Initialise la synchronisation des scroll controllers
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
      });
    }
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

  // Getter pour les services filtrés et triés pour la colonne "Résultat" (ajusté)
  List<Service> get _filteredAndSortedResultServices {
    // Pour l'instant, la colonne "Résultat" affiche les mêmes services que "Début".
    // Vous pouvez ajuster cette logique si "Résultat" doit être différent.
    return _filteredAndSortedDebutServices;
  }


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

  // Fonction pour exporter les services vers un fichier Excel
  Future<void> exportToExcel(List<Service> services, BuildContext context) async {
    if (services.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aucune donnée à exporter.')),
      );
      return;
    }

    try {
      final excel = Excel.createExcel();
      final sheet = excel['Services'];

      // En-têtes
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

      final bytes = excel.save();
      if (bytes == null) throw Exception('Erreur lors de la génération Excel');

      final blob = html.Blob([Uint8List.fromList(bytes)]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      // ignore: unused_local_variable
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'export_services.xlsx') // Nom de fichier clair
        ..click();
      html.Url.revokeObjectUrl(url);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Export Web réussi.'), backgroundColor: Colors.green),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur export Web : $e')),
      );
    }
  }

  void _onExportPressed() {
    exportToExcel(_services, context);
  }

  // Méthode pour synchroniser les contrôleurs de défilement (ajoutée/restaurée)
  void _syncScrollControllers() {
    // Empêcher la récursion en retirant et ajoutant les listeners
    void sync(ScrollController source, List<ScrollController> targets) {
      if (!source.hasClients) return;
      for (var target in targets) {
        if (target.hasClients && target.offset != source.offset) {
          target.jumpTo(source.offset);
        }
      }
    }

    _debutScrollController.addListener(() => sync(_debutScrollController, [_finScrollController, _resultatScrollController]));
    _finScrollController.addListener(() => sync(_finScrollController, [_debutScrollController, _resultatScrollController]));
    _resultatScrollController.addListener(() => sync(_resultatScrollController, [_debutScrollController, _finScrollController]));
  }

  // Méthode pour construire l'AppBar
  AppBar _buildAppBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      toolbarHeight: responsive_utils.responsiveHeight(screenWidth, 80.0), // Hauteur responsive The function 'responsiveHeight' isn't defined.
      leading: Padding(
        padding: EdgeInsets.all(responsive_utils.responsivePadding(screenWidth, 8.0)),
        child: Image.asset(
          'assets/logo_app.png',
          height: responsive_utils.responsiveIconSize(screenWidth, 40.0),
          width: responsive_utils.responsiveIconSize(screenWidth, 40.0),
        ),
      ),
      title: Text(
        'Prise de services automatique',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: responsive_utils.responsiveFontSize(screenWidth, 20.0),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 4.0)),
          child: _dataLoaded
              ? ElevatedButton.icon(
                  onPressed: _importServicesFromExcel,
                  icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.primary, size: responsive_utils.responsiveIconSize(screenWidth, 18.0)),
                  label: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('Changer fichier', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: responsive_utils.responsiveFontSize(screenWidth, 12.0))),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(screenWidth, 8.0)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 12.0), vertical: responsive_utils.responsivePadding(screenWidth, 8.0)),
                    minimumSize: Size(responsive_utils.responsiveWidth(screenWidth, 140.0), responsive_utils.responsiveHeight(screenWidth, 40.0)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                )
              : ElevatedButton.icon(
                  onPressed: _importServicesFromExcel,
                  icon: Icon(Icons.upload_file, color: Theme.of(context).colorScheme.primary, size: responsive_utils.responsiveIconSize(screenWidth, 18.0)),
                  label: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('Importer services', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: responsive_utils.responsiveFontSize(screenWidth, 12.0))),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(screenWidth, 8.0)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 12.0), vertical: responsive_utils.responsivePadding(screenWidth, 8.0)),
                    minimumSize: Size(responsive_utils.responsiveWidth(screenWidth, 140.0), responsive_utils.responsiveHeight(screenWidth, 40.0)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 4.0)),
          child: ElevatedButton.icon(
            onPressed: _onExportPressed,
            icon: Icon(Icons.download, color: Theme.of(context).colorScheme.primary, size: responsive_utils.responsiveIconSize(screenWidth, 18.0)),
            label: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text('Exporter services', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: responsive_utils.responsiveFontSize(screenWidth, 12.0))),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(screenWidth, 8.0)),
              ),
              padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 12.0), vertical: responsive_utils.responsivePadding(screenWidth, 8.0)),
              minimumSize: Size(responsive_utils.responsiveWidth(screenWidth, 140.0), responsive_utils.responsiveHeight(screenWidth, 40.0)),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
        SizedBox(width: responsive_utils.responsivePadding(screenWidth, 8.0)),
      ],
    );
  }

  // Méthode pour construire le sélecteur de date (maintenant avec les boutons D,F,R)
  Widget _buildDateRangeSelector() {
    final screenWidth = MediaQuery.of(context).size.width;

    // Fonction d'aide interne pour les boutons de colonne (D, F, R)
    Widget buildColumnToggleButton(String label, bool isVisible, ValueChanged<bool> onChanged) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 2.0)),
        child: InkWell(
          onTap: () => onChanged(!isVisible),
          borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(screenWidth, 8.0)),
          child: Container(
            width: responsive_utils.responsiveWidth(screenWidth, 70.0),
            height: responsive_utils.responsiveHeight(screenWidth, 35.0),
            decoration: BoxDecoration(
              color: isVisible ? Theme.of(context).primaryColor : Colors.grey[400],
              borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(screenWidth, 8.0)),
              boxShadow: isVisible ? [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ] : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                  size: responsive_utils.responsiveIconSize(screenWidth, 16.0),
                ),
                SizedBox(width: responsive_utils.responsivePadding(screenWidth, 2.0)),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: responsive_utils.responsiveFontSize(screenWidth, 10.0),
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Contenu des contrôles de date (boutons de navigation et sélecteurs de date)
    Widget dateControls = Row(
      mainAxisSize: MainAxisSize.min, // Utiliser min pour ne prendre que l'espace nécessaire
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios, size: responsive_utils.responsiveIconSize(screenWidth, 16.0)),
          onPressed: () {
            setState(() {
              _changeDateByMonth(_startDate, -1, (newDate) => _startDate = newDate);
              _changeDateByMonth(_endDate, -1, (newDate) => _endDate = newDate);
            });
          },
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        _buildDateControl(_startDate, (newDate) => setState(() => _startDate = newDate)),
        SizedBox(width: responsive_utils.responsivePadding(screenWidth, 4.0)),
        Container(
          width: responsive_utils.responsivePadding(screenWidth, 1.5),
          height: responsive_utils.responsiveHeight(screenWidth, 20.0),
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: responsive_utils.responsivePadding(screenWidth, 4.0)),
        _buildDateControl(_endDate, (newDate) => setState(() => _endDate = newDate)),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, size: responsive_utils.responsiveIconSize(screenWidth, 16.0)),
          onPressed: () {
            setState(() {
              _changeDateByMonth(_startDate, 1, (newDate) => _startDate = newDate);
              _changeDateByMonth(_endDate, 1, (newDate) => _endDate = newDate);
            });
          },
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );

    // Les boutons D,F,R (pour activer/désactiver les colonnes Début, Fin, Résultat)
    Widget columnToggleButtons = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildColumnToggleButton('D', _showDebutColumn, (newStatus) {
          setState(() {
            _showDebutColumn = newStatus;
          });
        }),
        buildColumnToggleButton('F', _showFinColumn, (newStatus) {
          setState(() {
            _showFinColumn = newStatus;
          });
        }),
        buildColumnToggleButton('R', _showResultColumn, (newStatus) {
          setState(() {
            _showResultColumn = newStatus;
          });
        }),
      ],
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 16.0), vertical: responsive_utils.responsivePadding(screenWidth, 8.0)),
      color: Colors.grey[100],
      child: Row(
        children: [
          dateControls, // Les contrôles de date
          const Spacer(), // Pousse le texte de la date et les boutons à droite
          Text(
            DateFormat('EEEE dd MMMM HH:mm:ss', 'fr_FR').format(_currentDisplayDate),
            style: TextStyle(
              fontSize: responsive_utils.responsiveFontSize(screenWidth, 11.0),
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(width: responsive_utils.responsivePadding(screenWidth, 10.0)),
          columnToggleButtons, // Les boutons D,F,R
        ],
      ),
    );
  }

  // Méthode d'aide pour les contrôles individuels de date (boutons +/- et sélecteur de date)
  Widget _buildDateControl(DateTime date, ValueChanged<DateTime> onDateChanged) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove, size: responsive_utils.responsiveIconSize(screenWidth, 18.0)),
          onPressed: () => _changeDateByDay(date, -1, onDateChanged),
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        SizedBox(width: responsive_utils.responsivePadding(screenWidth, 4.0)),
        GestureDetector(
          onTap: () => _selectDate(context, date, onDateChanged),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 10.0), vertical: responsive_utils.responsivePadding(screenWidth, 5.0)),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor, width: 1.5),
              borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(screenWidth, 8.0)),
              color: Colors.white,
            ),
            child: Text(
              DateFormat('dd/MM/yyyy').format(date),
              style: TextStyle(fontSize: responsive_utils.responsiveFontSize(screenWidth, 14.0), fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
        ),
        SizedBox(width: responsive_utils.responsivePadding(screenWidth, 4.0)),
        IconButton(
          icon: Icon(Icons.add, size: responsive_utils.responsiveIconSize(screenWidth, 18.0)),
          onPressed: () => _changeDateByDay(date, 1, onDateChanged),
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  // Méthode pour construire la barre de recherche
  Widget _buildSearchBar() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 16.0), vertical: responsive_utils.responsivePadding(screenWidth, 8.0)),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: 'Rechercher par nom d\'employé',
          hintText: 'Entrez le nom de l\'employé...',
          prefixIcon: Icon(Icons.search, size: responsive_utils.responsiveIconSize(screenWidth, 20.0)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(screenWidth, 8.0)),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: responsive_utils.responsivePadding(screenWidth, 10.0), horizontal: responsive_utils.responsivePadding(screenWidth, 15.0)),
        ),
        style: TextStyle(fontSize: responsive_utils.responsiveFontSize(screenWidth, 14.0)),
      ),
    );
  }

  // Méthode pour construire les en-têtes de colonne (maintenant conditionnels)
  Widget _buildColumnHeaders() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 16.0), vertical: responsive_utils.responsivePadding(screenWidth, 8.0)),
      child: Row(
        children: [
          if (_showDebutColumn)
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  'Début',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive_utils.responsiveFontSize(screenWidth, 16.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          if (_showFinColumn)
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  'Fin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive_utils.responsiveFontSize(screenWidth, 16.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          if (_showResultColumn)
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'Résultat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive_utils.responsiveFontSize(screenWidth, 16.0),
                    color: Colors.green.shade700,
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
    final screenWidth = MediaQuery.of(context).size.width;

    // Condition pour afficher ou masquer la colonne
    if ((type == TimeCardType.debut && !_showDebutColumn) ||
        (type == TimeCardType.fin && !_showFinColumn) ||
        (type == TimeCardType.result && !_showResultColumn)) {
      return const SizedBox.shrink(); // Ne rien afficher si la colonne est masquée
    }

    return Expanded(
      flex: type == TimeCardType.result ? 1 : 2,
      child: ListView.builder(
        controller: controller,
        padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 8.0)),
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
              _handleModifyTime(service.id, currentTime, type);
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsive_utils.responsivePadding(screenWidth, 8.0),
        vertical: responsive_utils.responsivePadding(screenWidth, 8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              "© BMSoft 2025, tous droits réservés    ${DateFormat('dd/MM/yyyy HH:mm:ss', 'fr_FR').format(_currentDisplayDate)}",
              style: TextStyle(
                fontSize: responsive_utils.responsiveFontSize(screenWidth, 12.0),
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary,
              ),
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildDateRangeSelector(),
              _buildSearchBar(),
              _buildColumnHeaders(),
              if (!_dataLoaded) ...[
                const Spacer(),
                Text(
                  "Veuillez importer un fichier Excel pour commencer",
                  style: TextStyle(
                    fontSize: responsive_utils.responsiveFontSize(MediaQuery.of(context).size.width, 20.0),
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.error,
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
                    _buildServiceColumn(_filteredAndSortedResultServices, _resultatScrollController, TimeCardType.result),
                  ],
                ),
              ),
              _buildFooter(),
            ],
          ),
        ],
      ),
    );
  }
}