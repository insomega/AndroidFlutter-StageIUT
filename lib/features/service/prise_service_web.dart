// lib/prise_service_web.dart

// ignore: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../components/time_detail_card.dart';
import '../../core/service.dart';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' hide Border;
import 'dart:typed_data';
import '../../utils/date_time_extensions.dart';
import '../../utils/responsive_utils_web.dart' as responsive_utils;

/// Écran principal pour la gestion et l'affichage des services.
///
/// Cet écran permet aux utilisateurs d'importer des données de service depuis
/// un fichier Excel, de filtrer et de trier ces services par plage de dates
/// et par recherche textuelle, de modifier des services individuels, et d'exporter
/// les données modifiées vers un nouveau fichier Excel.
class PriseServiceScreen extends StatefulWidget {
  /// Crée un [PriseServiceScreen].
  const PriseServiceScreen({super.key});

  @override
  State<PriseServiceScreen> createState() => _PriseServiceScreenState();
}

/// L'état mutable pour [PriseServiceScreen].
class _PriseServiceScreenState extends State<PriseServiceScreen> {
  /// La date et l'heure actuelles affichées, mise à jour chaque seconde.
  DateTime _currentDisplayDate = DateTime.now();

  /// La date de début de la période de filtrage des services.
  DateTime _startDate = DateTime(2025, 7, 1);

  /// La date de fin de la période de filtrage des services.
  DateTime _endDate = DateTime(2025, 7, 31);

  /// Le minuteur utilisé pour rafraîchir l'heure affichée.
  Timer? _timer;

  /// Contrôleur de défilement pour la colonne des services de début.
  final ScrollController _debutScrollController = ScrollController();

  /// Contrôleur de défilement pour la colonne des services de fin.
  final ScrollController _finScrollController = ScrollController();

  /// Contrôleur de défilement pour la colonne des résultats (défilement synchronisé avec la colonne début).
  final ScrollController _resultatScrollController = ScrollController();

  /// Contrôleur de texte pour la barre de recherche.
  final TextEditingController _searchController = TextEditingController();

  /// La chaîne de caractères actuelle utilisée pour filtrer les services.
  String _searchQuery = '';

  /// La liste des services chargés depuis le fichier Excel.
  List<Service> _services = [];

  /// Indique si des données de service ont été chargées.
  bool _dataLoaded = false;

  /// Contrôle la visibilité de la colonne "Début".
  bool _showDebutColumn = true;

  /// Contrôle la visibilité de la colonne "Fin".
  bool _showFinColumn = true;

  /// Contrôle la visibilité de la colonne "Résultat".
  bool _showResultColumn = true;

  @override
  void initState() {
    super.initState();
    _updateCurrentTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCurrentTime();
    });

    _searchController.addListener(_onSearchChanged);
    Intl.defaultLocale = 'fr_FR';

    _syncScrollControllers();
  }

  /// Met à jour la chaîne de recherche et déclenche un rafraîchissement de l'interface utilisateur.
  ///
  /// Cette méthode est un écouteur pour le [TextEditingController] de la barre de recherche.
  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _debutScrollController.dispose();
    _finScrollController.dispose();
    _resultatScrollController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  /// Met à jour l'heure actuelle affichée dans l'interface utilisateur.
  ///
  /// Cette méthode est appelée périodiquement par un [Timer] pour maintenir
  /// l'affichage de l'heure à jour.
  void _updateCurrentTime() {
    setState(() {
      _currentDisplayDate = DateTime.now();
    });
  }

  /// Modifie la date spécifiée ([dateToChange]) d'un certain nombre de jours.
  ///
  /// Après la modification, un rafraîchissement des services est déclenché.
  ///
  /// [dateToChange] La date à modifier (soit `_startDate` soit `_endDate`).
  /// [daysToAdd] Le nombre de jours à ajouter ou soustraire.
  /// [updateState] Une fonction de rappel pour mettre à jour la date dans l'état du widget.
  void _changeDateByDay(DateTime dateToChange, int daysToAdd, Function(DateTime) updateState) {
    setState(() {
      updateState(dateToChange.add(Duration(days: daysToAdd)));
      _filterAndSortServices();
    });
  }

  /// Modifie la date spécifiée ([dateToChange]) d'un certain nombre de mois.
  ///
  /// Après la modification, un rafraîchissement des services est déclenché.
  ///
  /// [dateToChange] La date à modifier (soit `_startDate` soit `_endDate`).
  /// [monthsToAdd] Le nombre de mois à ajouter ou soustraire.
  /// [updateState] Une fonction de rappel pour mettre à jour la date dans l'état du widget.
  void _changeDateByMonth(DateTime dateToChange, int monthsToAdd, Function(DateTime) updateState) {
    setState(() {
      updateState(DateTime(
        dateToChange.year,
        dateToChange.month + monthsToAdd,
        dateToChange.day,
      ));
      _filterAndSortServices();
    });
  }

  /// Ouvre un sélecteur de date pour permettre à l'utilisateur de choisir une date spécifique.
  ///
  /// Après la sélection, la date est mise à jour et les services sont rafraîchis.
  ///
  /// [context] Le BuildContext de l'application.
  /// [initialDate] La date initialement affichée dans le sélecteur.
  /// [updateState] Une fonction de rappel pour mettre à jour la date dans l'état du widget.
  Future<void> _selectDate(BuildContext context, DateTime initialDate, Function(DateTime) updateState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      helpText: 'Sélectionner une date',
      cancelText: 'Annuler',
      confirmText: 'Confirmer',
      locale: const Locale('fr', 'FR'),
    );
    if (picked != null && picked != initialDate) {
      setState(() {
        updateState(picked);
        _filterAndSortServices();
      });
    }
  }

  /// Déclenche le filtrage et le tri des services en forçant un rafraîchissement de l'UI.
  ///
  /// Cette méthode appelle `setState` pour que les getters des listes de services filtrées
  /// et triées soient recalculés.
  void _filterAndSortServices() {
    setState(() {
      // Le simple fait de déclencher setState() fera que les getters seront recalculés.
    });
  }

  /// Retourne la liste des services filtrés par plage de dates et par la chaîne de recherche,
  /// puis triés par heure de début.
  List<Service> get _filteredAndSortedDebutServices {
    final filteredList = _services.where((service) {
      bool isInDateRange = service.startTime.isBefore(_endDate.endOfDay()) && service.startTime.isAfter(_startDate.startOfDay());
      bool matchesSearch = _searchQuery.isEmpty ||
          service.employeeName.toLowerCase().contains(_searchQuery.toLowerCase());
      return isInDateRange && matchesSearch;
    }).toList();

    filteredList.sort((a, b) => a.startTime.compareTo(b.startTime));
    return filteredList;
  }

  /// Retourne la liste des services filtrés par plage de dates et par la chaîne de recherche,
  /// puis triés par heure de fin.
  List<Service> get _filteredAndSortedFinServices {
    final filteredList = _services.where((service) {
      bool isInDateRange = service.endTime.isBefore(_endDate.endOfDay()) && service.endTime.isAfter(_startDate.startOfDay());
      bool matchesSearch = _searchQuery.isEmpty ||
          service.employeeName.toLowerCase().contains(_searchQuery.toLowerCase());
      return isInDateRange && matchesSearch;
    }).toList();

    filteredList.sort((a, b) => a.endTime.compareTo(b.endTime));
    return filteredList;
  }

  /// Retourne la liste des services filtrés et triés pour la colonne "Résultat".
  ///
  /// Actuellement, elle utilise la même logique de filtrage et de tri que la colonne "Début".
  List<Service> get _filteredAndSortedResultServices {
    return _filteredAndSortedDebutServices;
  }

  /// Gère le basculement de l'état "Absent" pour un service donné.
  ///
  /// Si un service devient "absent", sa validation est automatiquement retirée.
  ///
  /// [serviceId] L'identifiant unique du service à modifier.
  /// [newAbsentStatus] Le nouvel état d'absence (true si absent, false si présent).
  void _handleAbsentToggle(String serviceId, bool newAbsentStatus) {
    setState(() {
      final serviceIndex = _services.indexWhere((s) => s.id == serviceId);
      if (serviceIndex != -1) {
        if (newAbsentStatus == true) {
          _services[serviceIndex] = _services[serviceIndex].copyWith(isAbsent: newAbsentStatus, isValidated: false);
          debugPrint('Service $serviceId - Absent: $newAbsentStatus, Validation retirée.');
        } else {
          _services[serviceIndex] = _services[serviceIndex].copyWith(isAbsent: newAbsentStatus);
          debugPrint('Service $serviceId - Absent: $newAbsentStatus');
        }
      }
    });
  }

  /// Gère le basculement de l'état "Validé" pour un service donné.
  ///
  /// [serviceId] L'identifiant unique du service à modifier.
  /// [newValidateStatus] Le nouvel état de validation (true si validé, false si non validé).
  void _handleValidate(String serviceId, bool newValidateStatus) {
    setState(() {
      final serviceIndex = _services.indexWhere((s) => s.id == serviceId);
      if (serviceIndex != -1) {
        _services[serviceIndex] = _services[serviceIndex].copyWith(isValidated: newValidateStatus);
        debugPrint('Service $serviceId - Validated: $newValidateStatus');
      }
    });
  }

  /// Gère la modification de l'heure de début ou de fin d'un service spécifique.
  ///
  /// Cette méthode ouvre d'abord un sélecteur de date, puis un sélecteur d'heure.
  /// Elle effectue des validations pour s'assurer que l'heure de début reste antérieure
  /// à l'heure de fin et vice-versa.
  ///
  /// [serviceId] L'identifiant unique du service à modifier.
  /// [currentTime] L'heure actuelle (début ou fin) du service à modifier.
  /// [type] Le type de carte temporelle (début ou fin) pour déterminer quelle heure est modifiée.
  Future<void> _handleModifyTime(String serviceId, DateTime currentTime, TimeCardType type) async {
    // Étape 1: Sélectionner la date
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: currentTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      helpText: 'Sélectionner la date',
      cancelText: 'Annuler',
      confirmText: 'Confirmer',
      locale: const Locale('fr', 'FR'),
    );

    if (newDate == null) {
      return; // L'utilisateur a annulé la sélection de la date
    }

    // Étape 2: Sélectionner l'heure
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(currentTime),
      helpText: 'Sélectionner l\'heure',
      cancelText: 'Annuler',
      confirmText: 'Confirmer',
    );

    if (newTime != null) {
      final serviceIndex = _services.indexWhere((s) => s.id == serviceId);
      if (serviceIndex == -1) {
        debugPrint('Erreur: Service non trouvé avec l\'ID $serviceId');
        return;
      }

      final Service currentService = _services[serviceIndex];

      final DateTime updatedDateTime = DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
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
        if (updatedDateTime.isAfter(currentService.endTime) || updatedDateTime.isAtSameMomentAs(currentService.endTime)) {
          canUpdate = false;
          errorMessage = 'L\'heure de début (${DateFormat('dd/MM HH:mm').format(updatedDateTime)}) ne peut pas être après ou égale à l\'heure de fin actuelle (${DateFormat('dd/MM HH:mm').format(currentService.endTime)}).';
        }
      } else { // type == TimeCardType.fin
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Heure ${type == TimeCardType.debut ? "de début" : "de fin"} mise à jour avec succès.'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      } else {
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

  /// Fait défiler les différentes colonnes de services pour afficher le service spécifié.
  ///
  /// Cette méthode calcule la position de défilement pour les contrôleurs
  /// des colonnes "Début", "Fin" et "Résultat" et anime le défilement.
  ///
  /// [serviceToScrollTo] Le service vers lequel faire défiler.
  void _scrollToService(Service serviceToScrollTo) {
    const double itemHeight = 200.0;

    final int debutIndex = _filteredAndSortedDebutServices.indexWhere((s) => s.id == serviceToScrollTo.id);
    if (debutIndex != -1) {
      _debutScrollController.animateTo(
        debutIndex * itemHeight,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    final int finIndex = _filteredAndSortedFinServices.indexWhere((s) => s.id == serviceToScrollTo.id);
    if (finIndex != -1) {
      _finScrollController.animateTo(
        finIndex * itemHeight,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    if (debutIndex != -1) {
      _resultatScrollController.animateTo(
        debutIndex * itemHeight,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Importe les données de service depuis un fichier Excel sélectionné par l'utilisateur.
  ///
  /// Cette fonction utilise `file_picker` pour permettre à l'utilisateur de choisir un fichier `.xlsx`.
  /// Les données sont lues, converties en objets [Service], et mises à jour dans l'état de l'application.
  /// Des messages d'erreur sont affichés si le fichier est vide ou si la lecture échoue.
  Future<void> _importServicesFromExcel() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
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
        if (sheet.rows.isNotEmpty) {
          headers = sheet.rows[0].map((cell) => cell?.value?.toString() ?? '').toList();
        }

        List<Service> importedServices = [];

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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur à la ligne ${i + 1}: $e')),
            );
          }
        }

        setState(() {
          _services = importedServices;
          _dataLoaded = true;
          debugPrint('Importation de ${importedServices.length} services depuis Excel réussie.');
          _filterAndSortServices();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Importation de ${importedServices.length} services depuis Excel réussie.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
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

  /// Exporte la liste des services fournis vers un fichier Excel téléchargeable.
  ///
  /// Cette fonction crée un nouveau fichier `.xlsx` avec les en-têtes et les données
  /// des services, puis déclenche le téléchargement via le navigateur web.
  ///
  /// [services] La liste des [Service] à exporter.
  /// [context] Le BuildContext pour afficher des messages (SnackBar).
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

      // En-têtes des colonnes Excel
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

      // Remplir les lignes avec les données des services
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

      // Créer un objet Blob et un URL pour le téléchargement sur le web
      final blob = html.Blob([Uint8List.fromList(bytes)]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Déclencher le téléchargement via un élément <a> simulé
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

  /// Appelle la fonction d'exportation Excel avec la liste des services actuels.
  void _onExportPressed() {
    exportToExcel(_services, context);
  }

  /// Synchronise les contrôleurs de défilement des différentes colonnes.
  ///
  /// Cette méthode assure que le défilement dans une colonne entraîne le défilement
  /// synchronisé des autres colonnes, offrant une expérience utilisateur cohérente.
  void _syncScrollControllers() {
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



  /// Méthode pour construire l'AppBar (barre d'application) de l'interface.
  ///
  /// Elle est responsable de l'affichage du titre, du logo, et des boutons d'action
  /// pour l'importation et l'exportation des services. Les éléments sont ajustés
  /// de manière réactive en fonction de la largeur de l'écran.
  ///
  /// [context] Le BuildContext de l'application.
  ///
  /// Retourne un widget [AppBar] configuré.
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
          '../../assets/logo_app.png', // Chemin de l'image du logo.
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

  /// Méthode pour construire le sélecteur de date de début et de fin,
  /// incluant les boutons de navigation mensuelle et les bascules de visibilité des colonnes (D, F, R).
  ///
  /// Elle intègre des contrôles pour la sélection des dates et des boutons pour
  /// afficher/masquer les colonnes "Début", "Fin" et "Résultat". Tous les éléments
  /// sont réactifs à la taille de l'écran.
  ///
  /// Retourne un widget [Widget] représentant le sélecteur de plage de dates.
  Widget _buildDateRangeSelector() {
    // Récupère la largeur actuelle de l'écran pour ajuster les éléments de manière réactive.
    final screenWidth = MediaQuery.of(context).size.width;

    /// Fonction d'aide interne pour construire les boutons de basculement de colonne (D, F, R).
    ///
    /// [label] Le texte affiché sur le bouton (ex: 'D', 'F', 'R').
    /// [isVisible] L'état actuel de visibilité de la colonne correspondante.
    /// [onChanged] La fonction de rappel appelée lorsque l'état de visibilité change.
    ///
    /// Retourne un widget [Widget] représentant le bouton de basculement.
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

  /// Méthode d'aide pour construire un contrôle individuel de date, avec des boutons
  /// d'incrémentation/décrémentation journalière et une zone cliquable pour ouvrir
  /// un sélecteur de date.
  ///
  /// [date] La date actuelle affichée par le contrôle.
  /// [onDateChanged] La fonction de rappel appelée lorsque la date est modifiée.
  ///
  /// Retourne un widget [Widget] représentant le contrôle de date.
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

  /// Méthode pour construire la barre de recherche permettant de filtrer les services
  /// par nom d'employé.
  ///
  /// La barre de recherche est stylisée avec une icône de recherche et un libellé flottant.
  /// La taille et le padding sont réactifs à la largeur de l'écran.
  ///
  /// Retourne un widget [Padding] contenant le champ de texte de recherche.
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

  /// Méthode pour construire les en-têtes de colonne (Début, Fin, Résultat).
  ///
  /// Les en-têtes sont affichés de manière conditionnelle en fonction des variables
  /// `_showDebutColumn`, `_showFinColumn`, et `_showResultColumn`. Ils sont stylisés
  /// et ajustés de manière réactive.
  ///
  /// Retourne un widget [Padding] contenant les en-têtes des colonnes.
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

  /// Méthode pour construire une liste défilante de services, formant une colonne
  /// (Début, Fin, ou Résultat) dans l'interface utilisateur.
  ///
  /// La visibilité de la colonne est contrôlée par les variables d'état (_showDebutColumn, etc.).
  /// Chaque service est affiché comme une [TimeDetailCard], qui gère les interactions
  /// telles que le basculement d'absence, la modification de l'heure et la validation.
  /// Le défilement est synchronisé entre les colonnes.
  ///
  /// [services] La liste des services à afficher dans cette colonne.
  /// [controller] Le [ScrollController] pour cette colonne, permettant la synchronisation du défilement.
  /// [type] Le [TimeCardType] (début, fin, ou résultat) qui détermine le contenu et le comportement des cartes.
  ///
  /// Retourne un widget [Expanded] contenant la colonne de services, ou un [SizedBox.shrink] si la colonne est masquée.
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

  /// Méthode pour construire le pied de page de l'application.
  ///
  /// Le pied de page affiche un copyright et la date/heure actuelle, ajustés
  /// de manière réactive.
  ///
  /// Retourne un widget [Padding] contenant le pied de page.
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
  /// Méthode principale pour construire l'interface utilisateur de ce widget.
  ///
  /// Elle organise l'AppBar, le sélecteur de plage de dates, la barre de recherche,
  /// les en-têtes de colonne, les colonnes de services (Début, Fin, Résultat) et le pied de page.
  /// Un message est affiché si aucune donnée n'est encore chargée.
  ///
  /// [context] Le BuildContext de l'application.
  ///
  /// Retourne un widget [Scaffold] qui contient toute l'interface.
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