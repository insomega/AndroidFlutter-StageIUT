// lib/prise_service_web.dart


// ignore: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mon_projet/time_detail_card.dart';
import 'package:mon_projet/models/service.dart'; 
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' hide Border; // Importation pour la lecture et l'écriture Excel
import 'dart:typed_data'; // Pour Uint8List
import 'package:mon_projet/utils/date_time_extensions.dart';
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

  // Visibilité des colonnes
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
        // Afficher un SnackBar de succès
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
            // Afficher un SnackBar pour chaque erreur de ligne
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
        ..setAttribute('download', 'export_services.xlsx')
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

  // Méthode pour construire l'AppBar (barre d'application) de l'interface.
  // Elle est responsable de l'affichage du titre, du logo, et des boutons d'action.
  AppBar _buildAppBar(BuildContext context) {
    // Récupère la largeur actuelle de l'écran pour ajuster les éléments de manière réactive.
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      // Définit la hauteur de la barre d'outils de l'AppBar, ajustée de manière réactive.
      toolbarHeight: responsive_utils.responsiveHeight(screenWidth, 80.0),
      // Widget 'leading' pour le début de l'AppBar (généralement le logo ou un bouton de menu).
      leading: Padding(
        // Ajoute un padding réactif autour du logo.
        padding: EdgeInsets.all(responsive_utils.responsivePadding(screenWidth, 8.0)),
        child: Image.asset(
          'assets/logo_app.png', // Chemin de l'image du logo.
          // Ajuste la hauteur et la largeur du logo de manière réactive.
          height: responsive_utils.responsiveIconSize(screenWidth, 40.0),
          width: responsive_utils.responsiveIconSize(screenWidth, 40.0),
        ),
      ),
      // Titre principal de l'AppBar.
      title: Text(
        'Prise de services automatique',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          // Ajuste la taille de la police de manière réactive.
          fontSize: responsive_utils.responsiveFontSize(screenWidth, 20.0),
          // Définit la couleur du texte basée sur le thème actuel.
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      // Centre le titre dans l'AppBar.
      centerTitle: true,
      // Définit la couleur d'arrière-plan de l'AppBar basée sur le thème.
      backgroundColor: Theme.of(context).primaryColor,
      // Définit la couleur du premier plan (texte, icônes) de l'AppBar basée sur le thème.
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      // Liste des actions (boutons) à afficher à la fin de l'AppBar.
      actions: [
        Padding(
          // Ajoute un padding horizontal réactif autour des boutons d'action.
          padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 4.0)),
          // Affiche un bouton différent selon que les données sont déjà chargées (_dataLoaded).
          child: _dataLoaded
              ? ElevatedButton.icon(
                  // Si les données sont chargées, ce bouton permet de "Changer fichier".
                  onPressed: _importServicesFromExcel, // Appel de la méthode pour importer les services.
                  icon: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.primary,
                    size: responsive_utils.responsiveIconSize(screenWidth, 18.0), // Taille de l'icône réactive.
                  ),
                  label: FittedBox(
                    fit: BoxFit.scaleDown, // Ajuste le texte à la taille disponible.
                    child: Text(
                      'Changer fichier',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: responsive_utils.responsiveFontSize(screenWidth, 12.0), // Taille de la police réactive.
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary, // Couleur d'arrière-plan du bouton.
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(screenWidth, 8.0)), // Bordure arrondie réactive.
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive_utils.responsivePadding(screenWidth, 12.0),
                      vertical: responsive_utils.responsivePadding(screenWidth, 8.0),
                    ), // Padding interne réactif.
                    minimumSize: Size(
                      responsive_utils.responsiveWidth(screenWidth, 140.0),
                      responsive_utils.responsiveHeight(screenWidth, 40.0),
                    ), // Taille minimale réactive du bouton.
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Optimise la zone de tap.
                  ),
                )
              : ElevatedButton.icon(
                  // Si les données ne sont PAS chargées, ce bouton invite à "Importer services".
                  onPressed: _importServicesFromExcel, // Appel de la méthode pour importer les services.
                  icon: Icon(
                    Icons.upload_file,
                    color: Theme.of(context).colorScheme.primary,
                    size: responsive_utils.responsiveIconSize(screenWidth, 18.0), // Taille de l'icône réactive.
                  ),
                  label: FittedBox(
                    fit: BoxFit.scaleDown, // Ajuste le texte à la taille disponible.
                    child: Text(
                      'Importer services',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: responsive_utils.responsiveFontSize(screenWidth, 12.0), // Taille de la police réactive.
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary, // Couleur d'arrière-plan du bouton.
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(screenWidth, 8.0)), // Bordure arrondie réactive.
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive_utils.responsivePadding(screenWidth, 12.0),
                      vertical: responsive_utils.responsivePadding(screenWidth, 8.0),
                    ), // Padding interne réactif.
                    minimumSize: Size(
                      responsive_utils.responsiveWidth(screenWidth, 140.0),
                      responsive_utils.responsiveHeight(screenWidth, 40.0),
                    ), // Taille minimale réactive du bouton.
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Optimise la zone de tap.
                  ),
                ),
        ),
        Padding(
          // Ajoute un padding horizontal réactif autour du bouton "Exporter services".
          padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 4.0)),
          child: ElevatedButton.icon(
            onPressed: _onExportPressed, // Appel de la méthode pour exporter les services.
            icon: Icon(
              Icons.download,
              color: Theme.of(context).colorScheme.primary,
              size: responsive_utils.responsiveIconSize(screenWidth, 18.0), // Taille de l'icône réactive.
            ),
            label: FittedBox(
              fit: BoxFit.scaleDown, // Ajuste le texte à la taille disponible.
              child: Text(
                'Exporter services',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: responsive_utils.responsiveFontSize(screenWidth, 12.0), // Taille de la police réactive.
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onPrimary, // Couleur d'arrière-plan du bouton.
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(screenWidth, 8.0)), // Bordure arrondie réactive.
              ),
              padding: EdgeInsets.symmetric(
                horizontal: responsive_utils.responsivePadding(screenWidth, 12.0),
                vertical: responsive_utils.responsivePadding(screenWidth, 8.0),
              ), // Padding interne réactif.
              minimumSize: Size(
                responsive_utils.responsiveWidth(screenWidth, 140.0),
                responsive_utils.responsiveHeight(screenWidth, 40.0),
              ), // Taille minimale réactive du bouton.
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Optimise la zone de tap.
            ),
          ),
        ),
        // Ajoute un espace horizontal réactif à la fin des actions.
        SizedBox(width: responsive_utils.responsivePadding(screenWidth, 8.0)),
      ],
    );
  }

  // Méthode pour construire le sélecteur de date, incluant les boutons D, F, R pour la visibilité des colonnes.
  Widget _buildDateRangeSelector() {
    // Récupère la largeur actuelle de l'écran pour ajuster les éléments de manière réactive.
    final screenWidth = MediaQuery.of(context).size.width;

    // Fonction d'aide interne pour construire les boutons de basculement de colonne (D, F, R).
    Widget buildColumnToggleButton(String label, bool isVisible, ValueChanged<bool> onChanged) {
      return Padding(
        // Ajoute un padding horizontal réactif autour de chaque bouton de colonne.
        padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 2.0)),
        child: InkWell(
          onTap: () => onChanged(!isVisible), // Inverse l'état de visibilité lors du tap.
          borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(screenWidth, 8.0)), // Bordure arrondie réactive.
          child: Container(
            // Définit la largeur et la hauteur du bouton de manière réactive.
            width: responsive_utils.responsiveWidth(screenWidth, 70.0),
            height: responsive_utils.responsiveHeight(screenWidth, 35.0),
            decoration: BoxDecoration(
              // Change la couleur du bouton en fonction de son état de visibilité.
              color: isVisible ? Theme.of(context).primaryColor : Colors.grey[400],
              borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(screenWidth, 8.0)), // Bordure arrondie réactive.
              // Ajoute une ombre si le bouton est visible (actif).
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
                  // Affiche une icône d'œil ouvert ou fermé selon la visibilité.
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                  size: responsive_utils.responsiveIconSize(screenWidth, 16.0), // Taille de l'icône réactive.
                ),
                SizedBox(width: responsive_utils.responsivePadding(screenWidth, 2.0)), // Espace entre l'icône et le texte.
                Text(
                  label, // Texte du bouton (D, F, R).
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: responsive_utils.responsiveFontSize(screenWidth, 10.0), // Taille de la police réactive.
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis, // Gère le dépassement de texte.
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Contenu principal des contrôles de date, incluant les boutons de navigation (précédent/suivant)
    // et les sélecteurs de date de début et de fin.
    Widget dateControls = Row(
      mainAxisSize: MainAxisSize.min, // La ligne prend juste l'espace nécessaire.
      children: [
        // Bouton pour reculer d'un mois les dates de début et de fin.
        IconButton(
          icon: Icon(Icons.arrow_back_ios, size: responsive_utils.responsiveIconSize(screenWidth, 16.0)),
          onPressed: () {
            setState(() {
              _changeDateByMonth(_startDate, -1, (newDate) => _startDate = newDate);
              _changeDateByMonth(_endDate, -1, (newDate) => _endDate = newDate);
            });
          },
          visualDensity: VisualDensity.compact, // Rend le bouton plus compact.
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        // Appelle la méthode d'aide pour construire le contrôle de la date de début.
        _buildDateControl(_startDate, (newDate) => setState(() => _startDate = newDate)),
        SizedBox(width: responsive_utils.responsivePadding(screenWidth, 4.0)), // Espace.
        // Séparateur visuel entre les deux sélecteurs de date.
        Container(
          width: responsive_utils.responsivePadding(screenWidth, 1.5),
          height: responsive_utils.responsiveHeight(screenWidth, 20.0),
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: responsive_utils.responsivePadding(screenWidth, 4.0)), // Espace.
        // Appelle la méthode d'aide pour construire le contrôle de la date de fin.
        _buildDateControl(_endDate, (newDate) => setState(() => _endDate = newDate)),
        // Bouton pour avancer d'un mois les dates de début et de fin.
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, size: responsive_utils.responsiveIconSize(screenWidth, 16.0)),
          onPressed: () {
            setState(() {
              _changeDateByMonth(_startDate, 1, (newDate) => _startDate = newDate);
              _changeDateByMonth(_endDate, 1, (newDate) => _endDate = newDate);
            });
          },
          visualDensity: VisualDensity.compact, // Rend le bouton plus compact.
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );

    // Les boutons D, F, R pour activer/désactiver la visibilité des colonnes "Début", "Fin", "Résultat".
    Widget columnToggleButtons = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Bouton pour basculer la visibilité de la colonne 'Début'.
        buildColumnToggleButton('D', _showDebutColumn, (newStatus) {
          setState(() {
            _showDebutColumn = newStatus;
          });
        }),
        // Bouton pour basculer la visibilité de la colonne 'Fin'.
        buildColumnToggleButton('F', _showFinColumn, (newStatus) {
          setState(() {
            _showFinColumn = newStatus;
          });
        }),
        // Bouton pour basculer la visibilité de la colonne 'Résultat'.
        buildColumnToggleButton('R', _showResultColumn, (newStatus) {
          setState(() {
            _showResultColumn = newStatus;
          });
        }),
      ],
    );

    return Container(
      // Padding réactif pour le conteneur du sélecteur de date.
      padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 16.0), vertical: responsive_utils.responsivePadding(screenWidth, 8.0)),
      color: Colors.grey[100], // Couleur d'arrière-plan claire.
      child: Row(
        children: [
          dateControls, // Affiche les contrôles de date.
          const Spacer(), // Prend tout l'espace disponible pour pousser les éléments suivants à droite.
          // Affiche la date et l'heure actuelles formatées en français.
          Text(
            DateFormat('EEEE dd MMMM HH:mm:ss', 'fr_FR').format(_currentDisplayDate),
            style: TextStyle(
              fontSize: responsive_utils.responsiveFontSize(screenWidth, 11.0), // Taille de la police réactive.
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary, // Couleur basée sur le thème.
            ),
            overflow: TextOverflow.ellipsis, // Gère le dépassement de texte.
          ),
          SizedBox(width: responsive_utils.responsivePadding(screenWidth, 10.0)), // Espace.
          columnToggleButtons, // Affiche les boutons D, F, R.
        ],
      ),
    );
  }

  // Méthode d'aide pour construire un contrôle individuel de date (boutons +/- et zone de sélection).
  Widget _buildDateControl(DateTime date, ValueChanged<DateTime> onDateChanged) {
    // Récupère la largeur actuelle de l'écran pour ajuster les éléments de manière réactive.
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisSize: MainAxisSize.min, // La ligne prend juste l'espace nécessaire.
      children: [
        // Bouton pour décrémenter la date d'un jour.
        IconButton(
          icon: Icon(Icons.remove, size: responsive_utils.responsiveIconSize(screenWidth, 18.0)),
          onPressed: () => _changeDateByDay(date, -1, onDateChanged), // Appelle la méthode pour changer la date.
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        SizedBox(width: responsive_utils.responsivePadding(screenWidth, 4.0)), // Espace.
        // Zone tappable pour ouvrir le sélecteur de date.
        GestureDetector(
          onTap: () => _selectDate(context, date, onDateChanged), // Appelle la méthode pour sélectionner une date.
          child: Container(
            // Padding réactif à l'intérieur de la zone de date.
            padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 10.0), vertical: responsive_utils.responsivePadding(screenWidth, 5.0)),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor, width: 1.5), // Bordure colorée basée sur le thème.
              borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(screenWidth, 8.0)), // Bordure arrondie réactive.
              color: Colors.white, // Fond blanc.
            ),
            child: Text(
              DateFormat('dd/MM/yyyy').format(date), // Affiche la date formatée.
              style: TextStyle(
                  fontSize: responsive_utils.responsiveFontSize(screenWidth, 14.0), // Taille de la police réactive.
                  fontWeight: FontWeight.bold,
                  color: Colors.black87
              ),
            ),
          ),
        ),
        SizedBox(width: responsive_utils.responsivePadding(screenWidth, 4.0)), // Espace.
        // Bouton pour incrémenter la date d'un jour.
        IconButton(
          icon: Icon(Icons.add, size: responsive_utils.responsiveIconSize(screenWidth, 18.0)),
          onPressed: () => _changeDateByDay(date, 1, onDateChanged), // Appelle la méthode pour changer la date.
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  // Méthode pour construire la barre de recherche des employés.
  Widget _buildSearchBar() {
    // Récupère la largeur actuelle de l'écran pour ajuster les éléments de manière réactive.
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      // Ajoute un padding symétrique réactif autour de la barre de recherche.
      padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 16.0), vertical: responsive_utils.responsivePadding(screenWidth, 8.0)),
      child: TextField(
        controller: _searchController, // Contrôleur pour gérer le texte de recherche.
        decoration: InputDecoration(
          labelText: 'Rechercher par nom d\'employé', // Libellé flottant.
          hintText: 'Entrez le nom de l\'employé...', // Texte d'indication.
          prefixIcon: Icon(Icons.search, size: responsive_utils.responsiveIconSize(screenWidth, 20.0)), // Icône de recherche.
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(screenWidth, 8.0)), // Bordure arrondie réactive.
          ),
          // Padding interne réactif pour le champ de texte.
          contentPadding: EdgeInsets.symmetric(vertical: responsive_utils.responsivePadding(screenWidth, 10.0), horizontal: responsive_utils.responsivePadding(screenWidth, 15.0)),
        ),
        style: TextStyle(fontSize: responsive_utils.responsiveFontSize(screenWidth, 14.0)), // Taille de la police réactive.
      ),
    );
  }

  // Méthode pour construire les en-têtes de colonne (Début, Fin, Résultat).
  // Les en-têtes sont affichés de manière conditionnelle en fonction de l'état des variables _showXColumn.
  Widget _buildColumnHeaders() {
    // Récupère la largeur actuelle de l'écran pour ajuster les éléments de manière réactive.
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      // Ajoute un padding symétrique réactif autour des en-têtes.
      padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 16.0), vertical: responsive_utils.responsivePadding(screenWidth, 8.0)),
      child: Row(
        children: [
          // En-tête de la colonne "Début", affiché si _showDebutColumn est vrai.
          if (_showDebutColumn)
            Expanded(
              flex: 2, // Prend 2 parts d'espace disponible.
              child: Center(
                child: Text(
                  'Début',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive_utils.responsiveFontSize(screenWidth, 16.0), // Taille de la police réactive.
                    color: Theme.of(context).colorScheme.primary, // Couleur basée sur le thème.
                  ),
                ),
              ),
            ),
          // En-tête de la colonne "Fin", affiché si _showFinColumn est vrai.
          if (_showFinColumn)
            Expanded(
              flex: 2, // Prend 2 parts d'espace disponible.
              child: Center(
                child: Text(
                  'Fin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive_utils.responsiveFontSize(screenWidth, 16.0), // Taille de la police réactive.
                    color: Theme.of(context).colorScheme.primary, // Couleur basée sur le thème.
                  ),
                ),
              ),
            ),
          // En-tête de la colonne "Résultat", affiché si _showResultColumn est vrai.
          if (_showResultColumn)
            Expanded(
              flex: 1, // Prend 1 part d'espace disponible (plus petite car le contenu est souvent plus court).
              child: Center(
                child: Text(
                  'Résultat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive_utils.responsiveFontSize(screenWidth, 16.0), // Taille de la police réactive.
                    color: Colors.green.shade700, // Couleur verte spécifique pour le résultat.
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Méthode pour construire une liste de services, formant une colonne (Début, Fin, ou Résultat).
  Widget _buildServiceColumn(List<Service> services, ScrollController controller, TimeCardType type) {
    // Récupère la largeur actuelle de l'écran pour ajuster les éléments de manière réactive.
    final screenWidth = MediaQuery.of(context).size.width;

    // Condition pour afficher ou masquer la colonne entière.
    // Si le type de colonne correspond à une colonne masquée (selon _showXColumn), retourne un SizedBox.shrink() pour ne rien afficher.
    if ((type == TimeCardType.debut && !_showDebutColumn) ||
        (type == TimeCardType.fin && !_showFinColumn) ||
        (type == TimeCardType.result && !_showResultColumn)) {
      return const SizedBox.shrink(); // Ne rend rien si la colonne doit être masquée.
    }

    return Expanded(
      // La colonne "Résultat" prend moins d'espace que les colonnes "Début" et "Fin".
      flex: type == TimeCardType.result ? 1 : 2,
      child: ListView.builder(
        controller: controller, // Contrôleur de défilement pour synchroniser le défilement des colonnes.
        padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(screenWidth, 8.0)), // Padding réactif pour la liste.
        itemCount: services.length, // Nombre total d'éléments dans la liste.
        itemBuilder: (context, index) {
          final service = services[index]; // Récupère le service actuel.
          return TimeDetailCard(
            service: service, // Passe l'objet service à la carte de détail.
            type: type, // Passe le type de carte (début, fin, résultat).
            onAbsentPressed: (newStatus) {
              _handleAbsentToggle(service.id, newStatus); // Gère le basculement de l'état "absent".
            },
            onModifyTime: (currentTime) {
              _handleModifyTime(service.id, currentTime, type); // Gère la modification de l'heure.
            },
            onValidate: (newStatus) {
              _handleValidate(service.id, newStatus); // Gère la validation du service.
            },
            onTap: () {
              _scrollToService(service); // Fait défiler les autres colonnes pour correspondre à cette carte.
            },
          );
        },
      ),
    );
  }

  // Méthode pour construire le pied de page de l'application.
  Widget _buildFooter() {
    // Récupère la largeur actuelle de l'écran pour ajuster les éléments de manière réactive.
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      // Ajoute un padding symétrique réactif autour du pied de page.
      padding: EdgeInsets.symmetric(
        horizontal: responsive_utils.responsivePadding(screenWidth, 8.0),
        vertical: responsive_utils.responsivePadding(screenWidth, 8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centre le contenu horizontalement.
        children: [
          Flexible(
            child: Text(
              // Affiche le copyright et la date/heure actuelle formatée en français.
              "© BMSoft 2025, tous droits réservés    ${DateFormat('dd/MM/yyyy HH:mm:ss', 'fr_FR').format(_currentDisplayDate)}",
              style: TextStyle(
                fontSize: responsive_utils.responsiveFontSize(screenWidth, 12.0), // Taille de la police réactive.
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary, // Couleur basée sur le thème.
              ),
              overflow: TextOverflow.visible, // Permet au texte de déborder si nécessaire.
            ),
          ),
        ],
      ),
    );
  }

  @override
  // Méthode principale pour construire l'interface utilisateur de ce widget.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context), // Utilise la méthode _buildAppBar pour la barre supérieure.
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildDateRangeSelector(), // Affiche le sélecteur de plage de dates.
              _buildSearchBar(), // Affiche la barre de recherche.
              _buildColumnHeaders(), // Affiche les en-têtes de colonne (Début, Fin, Résultat).
              // Conditionnel : Si aucune donnée n'est chargée, affiche un message d'instruction.
              if (!_dataLoaded) ...[
                const Spacer(), // Prend de l'espace pour centrer le message verticalement.
                Text(
                  "Veuillez importer un fichier Excel pour commencer",
                  style: TextStyle(
                    fontSize: responsive_utils.responsiveFontSize(MediaQuery.of(context).size.width, 20.0), // Taille de la police réactive.
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.error, // Couleur d'erreur du thème.
                  ),
                  textAlign: TextAlign.center, // Centre le texte.
                ),
                const Spacer(), // Prend de l'espace pour centrer le message verticalement.
              ],
              // Partie principale de la disposition, contenant les colonnes de services.
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Aligne les colonnes en haut.
                  children: [
                    // Affiche la colonne des services de début filtrés et triés.
                    _buildServiceColumn(_filteredAndSortedDebutServices, _debutScrollController, TimeCardType.debut),
                    // Affiche la colonne des services de fin filtrés et triés.
                    _buildServiceColumn(_filteredAndSortedFinServices, _finScrollController, TimeCardType.fin),
                    // Affiche la colonne des services de résultat filtrés et triés.
                    _buildServiceColumn(_filteredAndSortedResultServices, _resultatScrollController, TimeCardType.result),
                  ],
                ),
              ),
              _buildFooter(), // Affiche le pied de page de l'application.
            ],
          ),
        ],
      ),
    );
  }
}