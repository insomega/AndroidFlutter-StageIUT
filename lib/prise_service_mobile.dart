// lib/prise_service_mobile.dart

import 'dart:io'; // Importe la classe File pour les opérations sur les fichiers
import 'package:open_filex/open_filex.dart'; // Permet d'ouvrir un fichier avec l'application par défaut du système
import 'package:flutter/material.dart'; // Importe les composants Material Design de Flutter
import 'package:intl/intl.dart'; // Pour le formatage des dates et heures
import 'package:mon_projet/time_detail_card.dart'; // Importe le widget TimeDetailCard personnalisé
import 'package:mon_projet/models/service.dart'; // Importe le modèle de données Service
import 'dart:async'; // Pour utiliser Timer
import 'package:file_picker/file_picker.dart'; // Pour permettre à l'utilisateur de choisir un fichier
import 'package:excel/excel.dart' hide Border; // Importation de la bibliothèque Excel, en masquant la classe Border pour éviter les conflits avec flutter
import 'dart:typed_data'; // Pour manipuler des listes d'octets (Uint8List)
import 'package:mon_projet/utils/date_time_extensions.dart'; // Importe les extensions personnalisées pour DateTime
import 'package:mon_projet/utils/responsive_utils.dart' as responsive_utils; // Importe les utilitaires de responsive design avec un alias

// Définition du widget PriseServiceScreen, qui est un StatefulWidget car son état peut changer
class PriseServiceScreen extends StatefulWidget {
  const PriseServiceScreen({super.key}); // Constructeur avec une clé optionnelle

  @override
  State<PriseServiceScreen> createState() => _PriseServiceScreenState(); // Crée l'état associé
}

// Classe d'état pour PriseServiceScreen
class _PriseServiceScreenState extends State<PriseServiceScreen> {
  // Variables d'état
  DateTime _currentDisplayDate = DateTime.now(); // Date et heure actuellement affichées (pour le footer)
  DateTime _startDate = DateTime(2025, 7, 1); // Date de début par défaut pour le filtre des services
  DateTime _endDate = DateTime(2025, 7, 31); // Date de fin par défaut pour le filtre des services

  Timer? _timer; // Timer pour mettre à jour l'heure affichée chaque seconde

  // Contrôleurs de défilement pour les ListView des différentes colonnes
  final ScrollController _debutScrollController = ScrollController();
  final ScrollController _finScrollController = ScrollController();
  final ScrollController _resultatScrollController = ScrollController();

  final TextEditingController _searchController = TextEditingController(); // Contrôleur pour le champ de recherche
  String _searchQuery = ''; // La chaîne de caractères saisie dans la barre de recherche

  List<Service> _services = []; // Liste principale de tous les services chargés
  bool _dataLoaded = false; // Indicateur pour savoir si des données ont été chargées depuis un fichier Excel

  // Indicateurs de visibilité pour les colonnes (Début, Fin, Résultat)
  bool _showDebutColumn = true;
  bool _showFinColumn = true;
  bool _showResultColumn = true;

  @override
  void initState() {
    super.initState();
    _updateCurrentTime(); // Initialise l'heure affichée au démarrage
    // Configure un timer pour rafraîchir l'heure affichée toutes les secondes
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCurrentTime();
    });

    // Ajoute un écouteur au contrôleur de recherche pour réagir aux changements de texte
    _searchController.addListener(_onSearchChanged);
    Intl.defaultLocale = 'fr_FR'; // Définit la locale par défaut sur le français pour le formatage des dates
  }

  // Met à jour la chaîne de recherche lorsque le texte change dans le champ, et rafraîchit l'UI
  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Annule le timer pour éviter les fuites de mémoire lorsque le widget est supprimé
    // Libère les contrôleurs de défilement et de texte
    _debutScrollController.dispose();
    _finScrollController.dispose();
    _resultatScrollController.dispose();
    _searchController.removeListener(_onSearchChanged); // Supprime l'écouteur pour éviter les erreurs
    _searchController.dispose();
    super.dispose(); // Appelle la méthode dispose de la classe parente
  }

  // Met à jour l'heure et la date affichées dans le pied de page
  void _updateCurrentTime() {
    setState(() {
      _currentDisplayDate = DateTime.now();
    });
  }

  // --- Fonctions de navigation de date pour les filtres ---

  // Change la date spécifiée (début ou fin) d'un certain nombre de jours
  void _changeDateByDay(DateTime dateToChange, int daysToAdd, Function(DateTime) updateState) {
    setState(() {
      updateState(dateToChange.add(Duration(days: daysToAdd))); // Ajoute/retire des jours
      _filterAndSortServices(); // Rafraîchit l'affichage des services après le changement de date
    });
  }

  // Change la date spécifiée (début ou fin) d'un certain nombre de mois
  void _changeDateByMonth(DateTime dateToChange, int monthsToAdd, Function(DateTime) updateState) {
    setState(() {
      updateState(DateTime(
        dateToChange.year,
        dateToChange.month + monthsToAdd,
        dateToChange.day,
      )); // Modifie l'année/mois en gardant le jour
      _filterAndSortServices(); // Rafraîchit l'affichage des services après le changement de date
    });
  }

  // Ouvre un sélecteur de date pour permettre à l'utilisateur de choisir une date
  Future<void> _selectDate(BuildContext context, DateTime initialDate, Function(DateTime) updateState) async {

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate, // Date par défaut affichée dans le sélecteur
      firstDate: DateTime(2000), // Date la plus ancienne que l'utilisateur peut sélectionner
      lastDate: DateTime(2030), // Date la plus récente que l'utilisateur peut sélectionner
      helpText: 'Sélectionner une date', // Texte d'aide en haut du sélecteur
      cancelText: 'Annuler', // Texte pour le bouton d'annulation
      confirmText: 'Confirmer', // Texte pour le bouton de confirmation
      locale: const Locale('fr', 'FR'), // Force la locale du sélecteur en français
    );
    if (picked != null && picked != initialDate) { // Si une date est sélectionnée et qu'elle est différente de l'initiale
      setState(() {
        updateState(picked); // Met à jour la date (soit _startDate, soit _endDate)
        _filterAndSortServices(); // Rafraîchit l'affichage des services
      });
    }
  }

  // Déclenche le re-calcul des listes de services filtrées et triées
  void _filterAndSortServices() {
    setState(() {
      // Le simple fait d'appeler setState() avec un corps vide suffit à faire
      // que les getters (_filteredAndSortedDebutServices, etc.) soient recalculés.
      // C'est une manière implicite de rafraîchir la UI basée sur des données dérivées.
    });
  }

  // Getter pour obtenir les services filtrés par date et recherche, puis triés par heure de DÉBUT
  List<Service> get _filteredAndSortedDebutServices {
    final filteredList = _services.where((service) {
      // Vérifie si l'heure de début du service est dans la plage de dates sélectionnée
      bool isInDateRange = service.startTime.isBefore(_endDate.endOfDay()) && service.startTime.isAfter(_startDate.startOfDay());
      // Vérifie si le nom de l'employé contient la chaîne de recherche (insensible à la casse)
      bool matchesSearch = _searchQuery.isEmpty ||
          service.employeeName.toLowerCase().contains(_searchQuery.toLowerCase());
      return isInDateRange && matchesSearch; // Retourne true si les deux conditions sont remplies
    }).toList(); // Convertit le résultat en une nouvelle liste

    filteredList.sort((a, b) => a.startTime.compareTo(b.startTime)); // Trie la liste par heure de début croissante
    return filteredList;
  }

  // Getter pour obtenir les services filtrés par date et recherche, puis triés par heure de FIN
  List<Service> get _filteredAndSortedFinServices {
    final filteredList = _services.where((service) {
      // Vérifie si l'heure de fin du service est dans la plage de dates sélectionnée
      bool isInDateRange = service.endTime.isBefore(_endDate.endOfDay()) && service.endTime.isAfter(_startDate.startOfDay());
      // Vérifie si le nom de l'employé contient la chaîne de recherche (insensible à la casse)
      bool matchesSearch = _searchQuery.isEmpty ||
          service.employeeName.toLowerCase().contains(_searchQuery.toLowerCase());
      return isInDateRange && matchesSearch; // Retourne true si les deux conditions sont remplies
    }).toList(); // Convertit le résultat en une nouvelle liste

    filteredList.sort((a, b) => a.endTime.compareTo(b.endTime)); // Trie la liste par heure de fin croissante
    return filteredList;
  }

  // Gère le basculement de l'état "Absent" d'un service donné
  void _handleAbsentToggle(String serviceId, bool newAbsentStatus) {
    setState(() {
      final serviceIndex = _services.indexWhere((s) => s.id == serviceId); // Trouve l'index du service par son ID
      if (serviceIndex != -1) { // Si le service est trouvé
        if (newAbsentStatus == true) {
          // Si le service devient absent, la validation est automatiquement retirée
          _services[serviceIndex] = _services[serviceIndex].copyWith(isAbsent: newAbsentStatus, isValidated: false);
          debugPrint('Service $serviceId - Absent: $newAbsentStatus, Validation retirée.');
        } else {
          // Si le service redevient présent, met simplement à jour l'état "absent"
          _services[serviceIndex] = _services[serviceIndex].copyWith(isAbsent: newAbsentStatus);
          debugPrint('Service $serviceId - Absent: $newAbsentStatus');
        }
      }
    });
  }

  // Gère le basculement de l'état "Validé" d'un service donné
  void _handleValidate(String serviceId, bool newValidateStatus) {
    setState(() {
      final serviceIndex = _services.indexWhere((s) => s.id == serviceId); // Trouve l'index du service
      if (serviceIndex != -1) { // Si le service est trouvé
        // Met à jour l'état "validé" du service
        _services[serviceIndex] = _services[serviceIndex].copyWith(isValidated: newValidateStatus);
        debugPrint('Service $serviceId - Validated: $newValidateStatus');
      }
    });
  }

  // Gère la modification de l'heure de début ou de fin d'un service après sélection par l'utilisateur
  Future<void> _handleModifyTime(String serviceId, DateTime currentTime, TimeCardType type) async {
    // Étape 1: Sélectionner la date via un sélecteur de date
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

    // Étape 2: Sélectionner l'heure via un sélecteur d'heure
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

      // Construire le DateTime complet avec la NOUVELLE date et la NOUVELLE heure sélectionnées
      final DateTime updatedDateTime = DateTime(
        newDate.year, // Utilise l'année de la nouvelle date sélectionnée
        newDate.month, // Utilise le mois de la nouvelle date sélectionnée
        newDate.day, // Utilise le jour de la nouvelle date sélectionnée
        newTime.hour, // Utilise l'heure de la nouvelle heure sélectionnée
        newTime.minute, // Utilise la minute de la nouvelle heure sélectionnée
      );

      // Messages de débogage pour suivre les valeurs
      debugPrint('--- Débogage de la validation ---');
      debugPrint('ID du service: $serviceId');
      debugPrint('Type de modification: $type');
      debugPrint('Heure de début actuelle (complète): ${currentService.startTime}');
      debugPrint('Heure de fin actuelle (complète): ${currentService.endTime}');
      debugPrint('Nouvelle heure sélectionnée (complète): $updatedDateTime');
      debugPrint('--- Fin du débogage de la validation ---');

      bool canUpdate = true; // Indicateur si la mise à jour est valide
      String? errorMessage; // Message d'erreur si la validation échoue

      if (type == TimeCardType.debut) {
        // Pour une modification de l'heure de DÉBUT :
        // La nouvelle heure de début (updatedDateTime) doit être strictement AVANT l'heure de fin actuelle.
        if (updatedDateTime.isAfter(currentService.endTime) || updatedDateTime.isAtSameMomentAs(currentService.endTime)) {
          canUpdate = false;
          errorMessage = 'L\'heure de début (${DateFormat('dd/MM HH:mm').format(updatedDateTime)}) ne peut pas être après ou égale à l\'heure de fin actuelle (${DateFormat('dd/MM HH:mm').format(currentService.endTime)}).';
        }
      } else { // type == TimeCardType.fin
        // Pour une modification de l'heure de FIN :
        // La nouvelle heure de fin (updatedDateTime) doit être strictement APRÈS l'heure de début actuelle.
        if (updatedDateTime.isBefore(currentService.startTime) || updatedDateTime.isAtSameMomentAs(currentService.startTime)) {
          canUpdate = false;
          errorMessage = 'L\'heure de fin (${DateFormat('dd/MM HH:mm').format(updatedDateTime)}) ne peut pas être avant ou égale à l\'heure de début actuelle (${DateFormat('dd/MM HH:mm').format(currentService.startTime)}).';
        }
      }

      if (canUpdate) {
        setState(() {
          // Met à jour le service dans la liste avec la nouvelle heure
          if (type == TimeCardType.debut) {
            _services[serviceIndex] = currentService.copyWith(startTime: updatedDateTime);
            debugPrint('Service $serviceId - Nouvelle heure de début: ${DateFormat('dd/MM HH:mm').format(updatedDateTime)}');
          } else {
            _services[serviceIndex] = currentService.copyWith(endTime: updatedDateTime);
            debugPrint('Service $serviceId - Nouvelle heure de fin: ${DateFormat('dd/MM HH:mm').format(updatedDateTime)}');
          }
        });
        // Affiche un SnackBar de succès
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Heure ${type == TimeCardType.debut ? "de début" : "de fin"} mise à jour avec succès.'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Affiche le message d'erreur si la validation échoue
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage!), // Affiche le message d'erreur spécifique
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,
          ),
        );
        debugPrint('Erreur de validation: $errorMessage');
      }
    }
  }

  // Fait défiler les différentes colonnes de services pour afficher un service spécifique
  void _scrollToService(Service serviceToScrollTo) {
    // Utilisez les listes filtrées qui sont effectivement affichées dans les ListViews
    final List<Service> currentFilteredServices = _filteredAndSortedDebutServices;

    // Hauteur estimée d'une carte de service.
    // C'est une valeur fixe qui peut être imprécise si les cartes ont des hauteurs variables.
    // Pour une précision accrue, il faudrait utiliser un package comme `scrollable_positioned_list`
    // ou calculer dynamiquement la hauteur de l'élément.
    const double itemHeight = 200.0; // Valeur arbitraire, ajustez si nécessaire.

    // Trouve l'index du service dans la liste actuellement filtrée et triée
    final int serviceIndex = currentFilteredServices.indexWhere((s) => s.id == serviceToScrollTo.id);

    if (serviceIndex != -1) { // Si le service est trouvé dans la liste
      // Défilement de la colonne "Début" si elle est visible et que son contrôleur est attaché
      if (_showDebutColumn && _debutScrollController.hasClients) {
        _debutScrollController.animateTo(
          serviceIndex * itemHeight, // Calcule la position de défilement
          duration: const Duration(milliseconds: 500), // Durée de l'animation
          curve: Curves.easeInOut, // Type d'animation
        );
      }

      // Défilement de la colonne "Fin" si elle est visible et que son contrôleur est attaché
      if (_showFinColumn && _finScrollController.hasClients) {
        _finScrollController.animateTo(
          serviceIndex * itemHeight,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }

      // Défilement de la colonne "Résultat" si elle est visible et que son contrôleur est attaché
      if (_showResultColumn && _resultatScrollController.hasClients) {
        _resultatScrollController.animateTo(
          serviceIndex * itemHeight,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  // Fonction pour importer les services à partir d'un fichier Excel sélectionné par l'utilisateur
  Future<void> _importServicesFromExcel() async {
    try {
      // Ouvre une fenêtre de dialogue pour permettre à l'utilisateur de choisir un fichier
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, // Type de fichier personnalisé
        allowedExtensions: ['xlsx'], // N'autorise que les fichiers avec l'extension .xlsx
        allowMultiple: false, // Ne permet pas la sélection multiple de fichiers
      );

      // Messages de débogage pour le résultat du sélecteur de fichiers
      debugPrint(' DEBUG FILE PICKER RESULT ');
      debugPrint('Result: $result');
      if (result != null) {
        debugPrint('Result.files length: ${result.files.length}');
        if (result.files.isNotEmpty) {
          debugPrint('First file path: ${result.files.first.path}');
          debugPrint('First file name: ${result.files.first.name}');
          debugPrint('First file bytes is null: ${result.files.first.bytes == null}');
          debugPrint('First file size: ${result.files.first.size} bytes');
        }
      }
      debugPrint(' END DEBUG ');

      // Vérifie si un fichier a été sélectionné et si son chemin n'est pas nul
      if (result != null && result.files.single.path != null) {
        final String? filePath = result.files.single.path;

        if (filePath == null) {
          debugPrint('Le chemin du fichier sélectionné est nul après la sélection.');
          // Affiche un SnackBar si le chemin est manquant
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Impossible d\'accéder au fichier sélectionné (chemin manquant).')),
          );
          return; // Quitte la fonction
        }

        final File file = File(filePath); // Crée un objet File à partir du chemin
        final Uint8List bytes = await file.readAsBytes(); // Lit le contenu du fichier en tant que liste d'octets

        // Vérifie si le fichier est vide après lecture
        if (bytes.isEmpty) {
          debugPrint('Le fichier sélectionné est vide après lecture des octets.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Le fichier sélectionné est vide.')),
          );
          return; // Quitte la fonction
        }

        // Décode le fichier Excel à partir des octets
        final Excel excel = Excel.decodeBytes(bytes);

        // Supposons que les données se trouvent dans la première feuille du classeur Excel
        final String sheetName = excel.tables.keys.first;

        final sheet = excel.tables[sheetName]; // Accède à la feuille
        if (sheet == null || sheet.rows.isEmpty) { // Vérifie si la feuille est vide
          debugPrint('La feuille Excel est vide.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Le fichier Excel est vide ou la feuille sélectionnée est vide.')),
          );
          return; // Quitte la fonction
        }

        List<String> headers = [];
        // Récupère les en-têtes de colonne de la première ligne de la feuille
        if (sheet.rows.isNotEmpty) {
          headers = sheet.rows[0].map((cell) => cell?.value?.toString() ?? '').toList();
        }

        List<Service> importedServices = []; // Liste pour stocker les services importés

        // Parcourt les lignes de données à partir de la deuxième ligne (en-têtes ignorés)
        for (int i = 1; i < sheet.rows.length; i++) {
          final row = sheet.rows[i];
          Map<String, dynamic> rowData = {};
          // Associe les valeurs de chaque cellule à leur en-tête correspondant
          for (int j = 0; j < headers.length; j++) {
            if (j < row.length) {
              rowData[headers[j]] = row[j]?.value;
            }
          }
          try {
            importedServices.add(Service.fromExcelRow(rowData)); // Crée un objet Service à partir des données de la ligne
          } catch (e) {
            // Gère les erreurs lors de la conversion d'une ligne en Service
            debugPrint('Erreur lors de la création du service à partir de la ligne Excel ${i + 1}: $rowData - $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur à la ligne ${i + 1}: $e')),
            );
          }
        }

        setState(() {
          _services = importedServices; // Met à jour la liste des services de l'état
          _dataLoaded = true; // Indique que les données ont été chargées
          debugPrint('Importation de ${importedServices.length} services depuis Excel réussie.');
          _filterAndSortServices(); // Rafraîchit l'affichage des services
        });

        // Affiche un SnackBar de succès
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Importation de ${importedServices.length} services depuis Excel réussie.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Message si l'utilisateur annule la sélection ou si le fichier est invalide
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aucun fichier sélectionné ou fichier invalide.')),
        );
        debugPrint('Aucun fichier sélectionné ou fichier invalide.');
      }
    } catch (e) {
      // Gère toute autre erreur survenant pendant le processus d'importation
      debugPrint('Erreur lors de l\'importation du fichier Excel: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'importation du fichier Excel: $e')),
      );
    }
  }

  // Fonction pour exporter les services vers un fichier Excel sur l'appareil mobile
  Future<void> _exportServicesToExcel(List<Service> servicesToExport) async {
    if (servicesToExport.isEmpty) {
      // Affiche un message si la liste de services à exporter est vide
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aucune donnée à exporter.')),
      );
      return; // Quitte la fonction
    }

    try {
      final excel = Excel.createExcel(); // Crée un nouveau classeur Excel
      final sheet = excel['Services']; // Crée une nouvelle feuille nommée 'Services'

      // Ajoute la ligne d'en-têtes à la feuille Excel
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

      // Parcourt chaque service de la liste et ajoute ses données à une nouvelle ligne dans Excel
      for (var service in servicesToExport) {
        sheet.appendRow([
          TextCellValue(service.id),
          TextCellValue(service.employeeSvrLib),
          TextCellValue(service.employeeSvrCode),
          TextCellValue(service.employeeName),
          TextCellValue(service.employeeTelPort),
          TextCellValue(DateFormat('dd/MM/yyyy HH:mm').format(service.startTime)), // Formate la date de début
          TextCellValue(DateFormat('dd/MM/yyyy HH:mm').format(service.endTime)), // Formate la date de fin
          TextCellValue(service.locationCode),
          TextCellValue(service.locationLib),
          TextCellValue(service.clientLocationLine3),
          TextCellValue(service.clientSvrCode),
          TextCellValue(service.clientSvrLib),
          TextCellValue(service.isAbsent ? 'Oui' : 'Non'), // Convertit le booléen en texte
          TextCellValue(service.isValidated ? 'Oui' : 'Non'), // Convertit le booléen en texte
        ]);
      }
      excel.delete('Sheet1'); // Supprime la feuille par défaut "Sheet1" si elle existe

      final List<int>? bytes = excel.save(); // Sauvegarde le classeur Excel en tant que liste d'octets
      if (bytes == null) throw Exception('Erreur lors de la génération Excel'); // Lance une exception si la sauvegarde échoue

      // Utilisation de FilePicker pour choisir le répertoire de sauvegarde
      final String? directoryPath = await FilePicker.platform.getDirectoryPath(); // Ouvre une fenêtre de dialogue pour que l'utilisateur choisisse un répertoire
      if (directoryPath == null) {
        // L'utilisateur a annulé la sélection du répertoire
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Exportation annulée par l\'utilisateur.'), backgroundColor: Colors.orange),
        );
        return; // Quitte la fonction
      }

      final String fileName = 'services_export.xlsx'; // Nom du fichier exporté
      final File file = File('$directoryPath/$fileName'); // Crée le chemin complet du fichier
      await file.writeAsBytes(bytes, flush: true); // Écrit les octets du fichier Excel dans le fichier

      // Ouvre le fichier exporté avec l'application par défaut du système
      await OpenFilex.open(file.path);

      // Affiche un SnackBar de succès avec le chemin du fichier
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exportation réussie ! Fichier enregistré à : ${file.path}'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 7), // Affiche le message plus longtemps
        ),
      );
    } catch (e) {
      // Gère toute erreur survenant pendant le processus d'exportation
      debugPrint('Erreur lors de l\'export mobile : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'exportation : $e')),
      );
    }
  }

  // Méthode appelée lorsque le bouton d'exportation est pressé
  void _onExportPressed() {
    _exportServicesToExcel(_services); // Exporte tous les services actuellement chargés
  }



  // Méthode pour construire l'AppBar
  AppBar _buildAppBar(BuildContext context) {
    // Récupère l'orientation actuelle de l'appareil (portrait ou paysage)
    final orientation = MediaQuery.of(context).orientation;

    // Vérifie si l'orientation est portrait
    if (orientation == Orientation.portrait) {
      // Pour l'orientation Portrait
      return AppBar(
        // Définit la hauteur de la barre d'outils de l'AppBar en utilisant une valeur responsive
        toolbarHeight: responsive_utils.responsivePadding(context, 80.0), // Hauteur standard pour le titre et le logo
        // Widget affiché au début de l'AppBar
        leading: Padding(
          padding: EdgeInsets.all(responsive_utils.responsivePadding(context, 4.0)),
          // Affiche l'image du logo de l'application
          child: Image.asset(
            'assets/logo_app.png',
            height: responsive_utils.responsiveIconSize(context, 40.0),
            width: responsive_utils.responsiveIconSize(context, 40.0),
          ),
        ),
        // Titre de l'application affiché au centre de l'AppBar
        title: Text(
          'Prise de services automatique',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: responsive_utils.responsiveFontSize(context, 16.0), // Taille peut rester celle-ci si l'espace est suffisant
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        // Centre le titre de l'AppBar
        centerTitle: true,
        // Couleur de fond de l'AppBar
        backgroundColor: Theme.of(context).primaryColor,
        // Couleur du premier plan (texte, icônes) de l'AppBar
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        // Les actions sont déplacées vers le 'bottom' pour l'orientation portrait
        bottom: PreferredSize(
          // Définit la taille préférée pour le widget 'bottom' de l'AppBar
          preferredSize: Size.fromHeight(responsive_utils.responsivePadding(context, 45.0)), // Hauteur pour les boutons d'action
          child: Container(
            // Couleur de fond pour cette bande inférieure de l'AppBar
            color: Theme.of(context).primaryColor, // Couleur de fond pour cette bande inférieure
            // Rembourrage horizontal et vertical pour le contenu du conteneur
            padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 8.0), vertical: responsive_utils.responsivePadding(context, 4.0)),
            child: Row(
              // Centre les enfants de la Row horizontalement
              mainAxisAlignment: MainAxisAlignment.center, // Centrer les boutons
              children: [
                // Bouton Changer/Importer fichier
                Expanded( // Permet aux boutons de prendre de l'espace disponible
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 2.0)),
                    // Affiche un bouton différent selon si les données sont déjà chargées ou non
                    child: _dataLoaded
                        // Si les données sont chargées, affiche un bouton "Changer fichier"
                        ? ElevatedButton.icon(
                            onPressed: _importServicesFromExcel,
                            icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.primary, size: responsive_utils.responsiveIconSize(context, 16.0)), // Légèrement réduit
                            label: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('Changer fichier', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: responsive_utils.responsiveFontSize(context, 9.0))), // Légèrement réduit
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(context, 6.0)),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 6.0), vertical: responsive_utils.responsivePadding(context, 2.0)), // Padding réduit
                              minimumSize: Size.fromHeight(responsive_utils.responsivePadding(context, 35.0)), // Hauteur suffisante
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          )
                        // Si les données ne sont pas chargées, affiche un bouton "Importer services"
                        : ElevatedButton.icon(
                            onPressed: _importServicesFromExcel,
                            icon: Icon(Icons.upload_file, color: Theme.of(context).colorScheme.primary, size: responsive_utils.responsiveIconSize(context, 16.0)), // Légèrement réduit
                            label: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('Importer services', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: responsive_utils.responsiveFontSize(context, 9.0))), // Légèrement réduit
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(context, 6.0)),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 6.0), vertical: responsive_utils.responsivePadding(context, 2.0)), // Padding réduit
                              minimumSize: Size.fromHeight(responsive_utils.responsivePadding(context, 35.0)),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                  ),
                ),
                SizedBox(width: responsive_utils.responsivePadding(context, 6.0)), // Espacement entre les boutons

                // Bouton Exporter services
                Expanded( // Permet aux boutons de prendre de l'espace disponible
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 2.0)),
                    child: ElevatedButton.icon(
                      onPressed: _onExportPressed,
                      icon: Icon(Icons.download, color: Theme.of(context).colorScheme.primary, size: responsive_utils.responsiveIconSize(context, 16.0)), // Légèrement réduit
                      label: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('Exporter services', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: responsive_utils.responsiveFontSize(context, 9.0))), // Légèrement réduit
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(context, 6.0)),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 6.0), vertical: responsive_utils.responsivePadding(context, 2.0)), // Padding réduit
                        minimumSize: Size.fromHeight(responsive_utils.responsivePadding(context, 35.0)),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // Pour l'orientation Paysage
      return AppBar(
        // Définit la hauteur de la barre d'outils pour l'orientation paysage
        toolbarHeight: responsive_utils.responsivePadding(context, 50.0),
        leading: Padding(
          padding: EdgeInsets.all(responsive_utils.responsivePadding(context, 4.0)),
          child: Image.asset(
            'assets/logo_app.png',
            height: responsive_utils.responsiveIconSize(context, 25.0),
            width: responsive_utils.responsiveIconSize(context, 25.0),
          ),
        ),
        title: Text(
          'Prise de services automatique',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: responsive_utils.responsiveFontSize(context, 16.0),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        // Widgets d'action affichés à droite de l'AppBar
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 2.0)),
            // Affiche un bouton différent selon si les données sont déjà chargées ou non
            child: _dataLoaded
                // Si les données sont chargées, affiche un bouton "Changer fichier"
                ? ElevatedButton.icon(
                    onPressed: _importServicesFromExcel,
                    icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.primary, size: responsive_utils.responsiveIconSize(context, 16.0)), 
                    label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text('Changer fichier', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: responsive_utils.responsiveFontSize(context, 9.0))), 
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(context, 6.0)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 6.0), vertical: responsive_utils.responsivePadding(context, 2.0)), 
                      minimumSize: Size(responsive_utils.responsivePadding(context, 75.0), responsive_utils.responsivePadding(context, 30.0)), 
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  )
                // Si les données ne sont pas chargées, affiche un bouton "Importer services"
                : ElevatedButton.icon(
                    onPressed: _importServicesFromExcel,
                    icon: Icon(Icons.upload_file, color: Theme.of(context).colorScheme.primary, size: responsive_utils.responsiveIconSize(context, 16.0)),
                    label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text('Importer services', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: responsive_utils.responsiveFontSize(context, 9.0))), 
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(context, 6.0)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 6.0), vertical: responsive_utils.responsivePadding(context, 2.0)),
                      minimumSize: Size(responsive_utils.responsivePadding(context, 75.0), responsive_utils.responsivePadding(context, 30.0)), 
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 2.0)),
            child: ElevatedButton.icon(
              onPressed: _onExportPressed,
              icon: Icon(Icons.download, color: Theme.of(context).colorScheme.primary, size: responsive_utils.responsiveIconSize(context, 16.0)),
              label: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('Exporter services', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: responsive_utils.responsiveFontSize(context, 9.0))),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(context, 6.0)),
                ),
                padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 6.0), vertical: responsive_utils.responsivePadding(context, 2.0)),
                minimumSize: Size(responsive_utils.responsivePadding(context, 75.0), responsive_utils.responsivePadding(context, 30.0)),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
          SizedBox(width: responsive_utils.responsivePadding(context, 6.0)),
        ],
      );
    }
  }

  // Méthode pour construire le sélecteur de date (maintenant avec les boutons D,F,R)
  Widget _buildDateRangeSelector() {
    // Récupère l'orientation actuelle de l'appareil
    final orientation = MediaQuery.of(context).orientation;

    // Fonction d'aide interne pour les boutons de colonne (D, F, R)
    Widget buildColumnToggleButton(String label, bool isVisible, ValueChanged<bool> onChanged) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 2.0)), // Espacement entre les boutons
        child: InkWell(
          onTap: () => onChanged(!isVisible), // Inverse la visibilité au tap
          borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(context, 8.0)), // Bordures arrondies
          child: Container(
            width: responsive_utils.responsivePadding(context, 70.0), // Augmenter la largeur pour accueillir icône + texte côte à côte
            height: responsive_utils.responsivePadding(context, 35.0), // Revenir à une hauteur plus standard pour un bouton avec texte à côté
            decoration: BoxDecoration(
              // Change la couleur de fond en fonction de la visibilité
              color: isVisible ? Theme.of(context).primaryColor : Colors.grey[400],
              borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(context, 8.0)),
              // Ajoute une ombre si le bouton est visible
              boxShadow: isVisible ? [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ] : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centrer horizontalement
              crossAxisAlignment: CrossAxisAlignment.center, // Centrer verticalement
              children: [
                // Icône qui change en fonction de la visibilité (oeil ouvert/fermé)
                Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                  size: responsive_utils.responsiveIconSize(context, 16.0), // Taille de l'icône
                ),
                SizedBox(width: responsive_utils.responsivePadding(context, 2.0)), // Espacement horizontal entre l'icône et le texte
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: responsive_utils.responsiveFontSize(context, 10.0), // Taille du texte, peut être légèrement plus grande
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis, // Tronque le texte si trop long
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Bouton pour reculer d'un mois
        IconButton(
          icon: Icon(Icons.arrow_back_ios, size: responsive_utils.responsiveIconSize(context, 16.0)),
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
        // Contrôle de la date de début
        _buildDateControl(_startDate, (newDate) => setState(() => _startDate = newDate)),
        SizedBox(width: responsive_utils.responsivePadding(context, 4.0)),
        // Séparateur vertical
        Container(
          width: responsive_utils.responsivePadding(context, 1.5), // Épaisseur du séparateur vertical
          height: responsive_utils.responsiveFontSize(context, 20.0), // Hauteur du séparateur
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: responsive_utils.responsivePadding(context, 4.0)),
        // Contrôle de la date de fin
        _buildDateControl(_endDate, (newDate) => setState(() => _endDate = newDate)),
        // Bouton pour avancer d'un mois
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, size: responsive_utils.responsiveIconSize(context, 16.0)),
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
      mainAxisSize: MainAxisSize.min, // S'assure que la Row prend juste la taille nécessaire
      children: [
        // Bouton pour la colonne "Début"
        buildColumnToggleButton('D', _showDebutColumn, (newStatus) {
          setState(() {
            _showDebutColumn = newStatus;
          });
        }),
        // Bouton pour la colonne "Fin"
        buildColumnToggleButton('F', _showFinColumn, (newStatus) {
          setState(() {
            _showFinColumn = newStatus;
          });
        }),
        // Bouton pour la colonne "Résultat"
        buildColumnToggleButton('R', _showResultColumn, (newStatus) {
          setState(() {
            _showResultColumn = newStatus;
          });
        }),
      ],
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 10.0), vertical: responsive_utils.responsivePadding(context, 4.0)), // Ajusté pour éviter l'overflow vertical
      color: Colors.grey[100],
      // Affiche la mise en page en fonction de l'orientation
      child: orientation == Orientation.portrait
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                dateControls, // Les contrôles de date seuls
                SizedBox(height: responsive_utils.responsivePadding(context, 8.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligne à gauche/droite
                  children: [
                    Expanded( // Le texte prend l'espace disponible à gauche
                      child: Text(
                        DateFormat('EEEE dd MMMM HH:mm:ss', 'fr_FR').format(_currentDisplayDate),
                        style: TextStyle(
                          fontSize: responsive_utils.responsiveFontSize(context, 11.0),
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        overflow: TextOverflow.ellipsis, // Tronque le texte si trop long
                        maxLines: 1, // Assure que le texte ne prend qu'une seule ligne
                      ),
                    ),
                    columnToggleButtons, // Les boutons D,F,R à droite
                  ],
                ),
              ],
            )
          : Row( // Pour le mode paysage
              children: [
                dateControls, // Les contrôles de date seuls
                const Spacer(), // Pousse le texte de la date et les boutons à droite
                Text( // Le texte de la date actuelle
                  DateFormat('EEEE dd MMMM HH:mm:ss', 'fr_FR').format(_currentDisplayDate),
                  style: TextStyle(
                    fontSize: responsive_utils.responsiveFontSize(context, 11.0),
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: responsive_utils.responsivePadding(context, 10.0)), // Espace entre le texte et les boutons
                columnToggleButtons, // Les boutons D,F,R
              ],
            ),
    );
  }

  // Méthode d'aide pour les contrôles individuels de date (boutons +/- et sélecteur de date)
  Widget _buildDateControl(DateTime date, ValueChanged<DateTime> onDateChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Bouton pour décrémenter le jour
        IconButton(
          icon: Icon(Icons.remove, size: responsive_utils.responsiveIconSize(context, 16.0)),
          onPressed: () => _changeDateByDay(date, -1, onDateChanged),
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        SizedBox(width: responsive_utils.responsivePadding(context, 3.0)),
        // GestureDetector pour ouvrir le sélecteur de date au tap
        GestureDetector(
          onTap: () => _selectDate(context, date, onDateChanged),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 6.0), vertical: responsive_utils.responsivePadding(context, 3.0)),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(context, 5.0)),
              color: Colors.white,
            ),
            child: Text(
              DateFormat('dd/MM/yyyy').format(date),
              style: TextStyle(fontSize: responsive_utils.responsiveFontSize(context, 12.0), fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
        ),
        SizedBox(width: responsive_utils.responsivePadding(context, 3.0)),
        // Bouton pour incrémenter le jour
        IconButton(
          icon: Icon(Icons.add, size: responsive_utils.responsiveIconSize(context, 16.0)),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 9.0), vertical: responsive_utils.responsivePadding(context, 4.0)),
      child: TextField(
        controller: _searchController, // Contrôleur pour le champ de texte
        decoration: InputDecoration(
          labelText: 'Rechercher par nom d\'employé', // Texte du label
          hintText: 'Entrez le nom de l\'employé...', // Texte d'indication
          prefixIcon: Icon(Icons.search, size: responsive_utils.responsiveIconSize(context, 12.0)), // Icône de recherche
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsive_utils.responsivePadding(context, 6.0)),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: responsive_utils.responsivePadding(context, 6.0), horizontal: responsive_utils.responsivePadding(context, 6.0)),
          isDense: true, // Rend le champ de texte plus compact
        ),
        style: TextStyle(fontSize: responsive_utils.responsiveFontSize(context, 10.0)), // Style du texte saisi
      ),
    );
  }

  // Méthode pour construire les en-têtes de colonne (maintenant conditionnels)
  Widget _buildColumnHeaders() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 10.0), vertical: responsive_utils.responsivePadding(context, 6.0)),
      child: Row(
        children: [
          // Affiche l'en-tête "Début" si _showDebutColumn est vrai
          if (_showDebutColumn) // Condition pour la colonne "Début"
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  'Début',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive_utils.responsiveFontSize(context, 14.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          // Affiche l'en-tête "Fin" si _showFinColumn est vrai
          if (_showFinColumn) // Condition pour la colonne "Fin"
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  'Fin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive_utils.responsiveFontSize(context, 14.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          // Affiche l'en-tête "Résultat" si _showResultColumn est vrai
          if (_showResultColumn) // Condition pour la colonne "Résultat"
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'Résultat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive_utils.responsiveFontSize(context, 14.0),
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
    return Expanded(
      // La flexibilité de la colonne varie en fonction du type (résultat ou autre)
      flex: type == TimeCardType.result ? 1 : 2, // Flexibilité différente pour la colonne Résultat
      child: ListView.builder(
        controller: controller, // Contrôleur de défilement pour synchronisation
        padding: EdgeInsets.symmetric(horizontal: responsive_utils.responsivePadding(context, 5.0)),
        itemCount: services.length, // Nombre d'éléments dans la liste
        itemBuilder: (context, index) {
          final service = services[index]; // Récupère le service actuel
          return TimeDetailCard(
            service: service,
            type: type,
            // Rappel lorsque le statut "absent" est modifié
            onAbsentPressed: (newStatus) {
              _handleAbsentToggle(service.id, newStatus);
            },
            // Rappel lorsque l'heure est modifiée
            onModifyTime: (currentTime) {
              _handleModifyTime(service.id, currentTime, type); // Passe le type correct
            },
            // Rappel lorsque le statut "validé" est modifié
            onValidate: (newStatus) {
              _handleValidate(service.id, newStatus);
            },
            // Rappel lorsque la carte de service est tapée
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
      padding: EdgeInsets.symmetric(
        horizontal: responsive_utils.responsivePadding(context, 6.0),
        vertical: responsive_utils.responsivePadding(context, 4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centrer le contenu de la Row
        children: [
          Flexible(
            child: Text(
              // Affiche le copyright et la date/heure actuelle formatée
              "© BMSoft 2025, tous droits réservés    ${DateFormat('dd/MM/yyyy HH:mm:ss', 'fr_FR').format(_currentDisplayDate)}",
              style: TextStyle(
                fontSize: responsive_utils.responsiveFontSize(context, 9.0),
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
      appBar: _buildAppBar(context), // Construit la barre d'application
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildDateRangeSelector(), // Construit le sélecteur de plage de dates
              _buildSearchBar(), // Construit la barre de recherche
              _buildColumnHeaders(), // Construit les en-têtes de colonne
              // Affiche un message si aucune donnée n'est chargée
              if (!_dataLoaded) ...[
                const Spacer(), // Prend tout l'espace disponible verticalement
                Padding(
                  padding: EdgeInsets.all(responsive_utils.responsivePadding(context, 15.0)),
                  child: Text(
                    "Veuillez importer un fichier Excel pour commencer",
                    style: TextStyle(
                      fontSize: responsive_utils.responsiveFontSize(context, 15.0),
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(), // Prend tout l'espace disponible verticalement
              ],
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Alignement en haut des colonnes
                  children: [
                    // Affiche la colonne "Début" si _showDebutColumn est vrai
                    if (_showDebutColumn) // Conditionnel
                      _buildServiceColumn(_filteredAndSortedDebutServices, _debutScrollController, TimeCardType.debut),
                    // Affiche la colonne "Fin" si _showFinColumn est vrai
                    if (_showFinColumn) // Conditionnel
                      _buildServiceColumn(_filteredAndSortedFinServices, _finScrollController, TimeCardType.fin),
                    // Affiche la colonne "Résultat" si _showResultColumn est vrai
                    if (_showResultColumn) // Conditionnel
                      _buildServiceColumn(_filteredAndSortedDebutServices, _resultatScrollController, TimeCardType.result),
                  ],
                ),
              ),
              _buildFooter(), // Construit le pied de page
            ],
          ),
        ],
      ),
    );
  }
}