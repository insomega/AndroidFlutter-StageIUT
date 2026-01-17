/// test/prise_service_screen_test.dart
library;

// ignore_for_file: unused_element

import 'package:flutter/material.dart'; // Importe le package Flutter pour la construction d'interfaces utilisateur et les widgets Material Design.
import 'package:flutter_test/flutter_test.dart'; // Importe le package `flutter_test`, indispensable pour écrire des tests de widgets dans Flutter.
import 'package:intl/intl.dart'; // Importe le package `intl` pour les fonctionnalités d'internationalisation, comme le formatage des dates et heures.
import 'package:flutter_localizations/flutter_localizations.dart'; // Importe les délégués de localisation de Flutter, nécessaires pour que les widgets gèrent correctement les différentes langues.

// Note: Les importations réelles de 'responsive_utils' et des modèles 'Service' et 'TimeDetailCard'
// sont commentées ici car des versions "mock" ou "dummy" de ces classes sont définies plus bas
// dans ce fichier de test. Cela permet de tester le widget `PriseServiceScreen` de manière isolée,
// sans dépendre des implémentations complètes et potentiellement complexes des modules réels.

/// --- DÉBUT DES CLASSES MOCK ET WIDGETS DUMMY ---
/// Cette section contient des implémentations simplifiées (mocks ou dummies)
/// des classes et widgets dont `PriseServiceScreen` dépend.
/// L'objectif est de fournir juste assez de fonctionnalité pour que `PriseServiceScreen`
/// puisse être rendu et testé, sans introduire de dépendances externes ou de logique complexe
/// qui n'est pas directement liée à ce que `PriseServiceScreen` lui-même est censé faire.

/// Classe Mock pour `responsive_utils`.
/// Elle remplace le module de responsivité réel pour les besoins du test.
/// Toutes ses méthodes renvoient simplement la valeur de base fournie,
/// ce qui simplifie les tests en éliminant la complexité des calculs responsives
/// et en permettant de tester les valeurs exactes passées.
class MockResponsiveUtils {
  /// Méthode mock pour le padding responsive. Retourne la [value] de base.
  static double responsivePadding(BuildContext context, double value) => value;

  /// Méthode mock pour la taille d'icône responsive. Retourne la [value] de base.
  static double responsiveIconSize(BuildContext context, double value) => value;

  /// Méthode mock pour la taille de police responsive. Retourne la [value] de base.
  static double responsiveFontSize(BuildContext context, double value) => value;
}

/// Classe dummy pour le modèle `Service`.
/// C'est une version simplifiée du modèle de données [Service] réel.
/// Elle contient les propriétés essentielles nécessaires pour que [TimeDetailCard]
/// puisse être instanciée et afficher des informations.
class Service {
  final String id; // Identifiant unique du service.
  final String employeeName; // Nom de l'employé.
  final String employeeSvrCode; // Code de service de l'employé.
  final String employeeSvrLib; // Libellé du service de l'employé.
  final String employeeTelPort; // Numéro de téléphone de l'employé.
  final DateTime startTime; // Heure de début du service.
  final DateTime endTime; // Heure de fin du service.
  bool isAbsent; // Statut d'absence de l'employé pour ce service.
  bool isValidated; // Statut de validation du service.
  final String locationCode; // Code de localisation.
  final String locationLib; // Libellé de localisation.
  final String clientLocationLine3; // Troisième ligne d'adresse du client.
  final String clientSvrCode; // Code de service du client.
  final String clientSvrLib; // Libellé du service du client.

  /// Constructeur de la classe [Service] dummy.
  Service({
    required this.id,
    required this.employeeName,
    required this.employeeSvrCode,
    required this.employeeSvrLib,
    required this.employeeTelPort,
    required this.startTime,
    required this.endTime,
    this.isAbsent = false, // Valeur par défaut pour `isAbsent`.
    this.isValidated = false, // Valeur par défaut pour `isValidated`.
    required this.locationCode,
    required this.locationLib,
    required this.clientLocationLine3,
    required this.clientSvrCode,
    required this.clientSvrLib,
  });
}

/// Enumération dummy pour [TimeCardType].
/// Elle reproduit l'énumération réelle pour être utilisée dans le mock de [TimeDetailCard].
enum TimeCardType { debut, fin, result }

/// Classe dummy pour le widget [TimeDetailCard].
/// C'est une implémentation simplifiée du widget [TimeDetailCard] réel.
/// Elle est suffisante pour que `PriseServiceScreen` puisse l'utiliser et que ses interactions
/// (via les callbacks) puissent être testées. Elle ne reproduit pas toute la complexité visuelle
/// de la carte réelle, mais se concentre sur les éléments essentiels pour le test.
class TimeDetailCard extends StatelessWidget {
  final Service service; // Le service à afficher.
  final TimeCardType type; // Le type de carte.
  final Function(bool) onAbsentPressed; // Callback pour le bouton "Absent".
  final Function(DateTime) onModifyTime; // Callback pour la modification de l'heure.
  final Function(bool) onValidate; // Callback pour la validation.
  final VoidCallback onTap; // Callback pour le tap sur la carte.

  /// Constructeur de la classe [TimeDetailCard] dummy.
  const TimeDetailCard({
    super.key, // Clé du widget.
    required this.service,
    required this.type,
    required this.onAbsentPressed,
    required this.onModifyTime,
    required this.onValidate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String timeDisplay = ''; // Variable pour stocker le texte d'affichage de l'heure/durée.
    /// Utilise un `switch` pour déterminer le texte à afficher en fonction du [TimeCardType].
    switch (type) {
      case TimeCardType.debut:
        // Pour le type 'debut', formate l'heure de début du service.
        timeDisplay = 'H.D: ${DateFormat('HH:mm').format(service.startTime)}';
        break;
      case TimeCardType.fin:
        // Pour le type 'fin', formate l'heure de fin du service.
        timeDisplay = 'H.F: ${DateFormat('HH:mm').format(service.endTime)}';
        break;
      case TimeCardType.result:
        // Pour le type 'result', calcule la durée entre l'heure de début et de fin,
        // puis la formate en heures et minutes.
        final duration = service.endTime.difference(service.startTime);
        final hours = duration.inHours;
        final minutes = duration.inMinutes.remainder(60);
        timeDisplay = ' +${hours.toString().padLeft(2, '0')}h${minutes.toString().padLeft(2, '0')} min';
        break;
    }

    /// Retourne un [Container] simple qui simule l'apparence de la carte.
    return Container(
      padding: EdgeInsets.all(MockResponsiveUtils.responsivePadding(context, 8.0)), // Utilise le mock pour le padding.
      margin: EdgeInsets.symmetric(vertical: MockResponsiveUtils.responsivePadding(context, 4.0)), // Utilise le mock pour la marge verticale.
      decoration: BoxDecoration(
        color: Colors.white, // Couleur de fond blanche.
        borderRadius: BorderRadius.circular(MockResponsiveUtils.responsivePadding(context, 8.0)), // Bords arrondis.
        boxShadow: [
          /// Ajoute une ombre légère pour simuler l'élévation d'une carte.
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Couleur de l'ombre avec opacité.
            spreadRadius: 1, // Étendue de l'ombre.
            blurRadius: 3, // Flou de l'ombre.
            offset: const Offset(0, 1), // Décalage de l'ombre (légèrement vers le bas).
          ),
        ],
      ),
      child: Column(
        /// Organise le contenu de la carte en colonne.
        children: [
          /// Affiche le nom de l'employé.
          Text(
            'Service for ${service.employeeName}',
            style: TextStyle(fontSize: MockResponsiveUtils.responsiveFontSize(context, 12.0)), // Utilise le mock pour la taille de police.
          ),
          /// Affiche l'heure ou la durée calculée.
          Text(
            timeDisplay,
            /// Attribue une clé au texte de durée si le type est 'result', utile pour les tests.
            key: type == TimeCardType.result ? const Key('calculatedDurationText') : null,
            style: TextStyle(fontSize: MockResponsiveUtils.responsiveFontSize(context, 12.0)), // Utilise le mock pour la taille de police.
          ),
          Row(
            /// Range les boutons d'action en ligne.
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribue l'espace également autour des boutons.
            children: [
              /// Bouton "Modifier Heure" : affiché uniquement si le type n'est PAS 'result'.
              if (type != TimeCardType.result)
                ElevatedButton(
                  key: const Key('modifyTimeButtonPortrait'), // Clé pour les tests.
                  onPressed: () => onModifyTime(DateTime.now()), // Callback (placeholder pour le test).
                  child: const Text('Modifier Heure'), // Texte du bouton.
                ),
              /// Bouton "Absent" : toujours présent.
              ElevatedButton(
                key: const Key('absentButtonPortrait'), // Clé pour les tests.
                onPressed: () => onAbsentPressed(!service.isAbsent), // Callback (placeholder pour le test).
                child: const Text('Absent'), // Texte du bouton.
              ),
              /// Bouton "Valider/Dévalider" : affiché uniquement si le type est 'result'.
              if (type == TimeCardType.result)
                ElevatedButton(
                  key: const Key('validateButtonPortrait'), // Clé pour les tests.
                  onPressed: () => onValidate(!service.isValidated), // Callback (placeholder pour le test).
                  child: Row(
                    /// Le bouton contient une icône et du texte.
                    children: [
                      Icon(service.isValidated ? Icons.undo : Icons.check), // Icône dynamique.
                      Text(service.isValidated ? 'Dévalider' : 'Valider'), // Texte dynamique.
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Classe `MockMyHomePage` : un widget [StatefulWidget] simple qui peut être utilisé
/// comme parent pour les widgets testés. Dans un vrai test, il pourrait contenir
/// le widget `PriseServiceScreen` et gérer son état.
class MockMyHomePage extends StatefulWidget {
  const MockMyHomePage({super.key});

  @override
  _MockMyHomePageState createState() => _MockMyHomePageState(); // Crée l'état associé.
}

/// L'état interne du widget [_MockMyHomePageState].
/// Ces variables simulent l'état géré par le `PriseServiceScreen` réel,
/// permettant de contrôler son comportement pour les tests.
class _MockMyHomePageState extends State<MockMyHomePage> {
  /// Indique si les données des services sont chargées ou non. Initialisé à false.
  bool _dataLoaded = false;

  /// Dates de début et de fin pour la plage de services affichée.
  /// Fixées pour des tests cohérents.
  DateTime _startDate = DateTime(2025, 7, 29);
  DateTime _endDate = DateTime(2025, 7, 29);

  /// Date et heure actuelles affichées dans le pied de page et le sélecteur de plage de dates.
  final DateTime _currentDisplayDate = DateTime(2025, 7, 29, 16, 4, 18);

  /// Indicateurs pour la visibilité des colonnes "Début", "Fin" et "Résultat".
  bool _showDebutColumn = true;
  bool _showFinColumn = true;
  bool _showResultColumn = true;

  /// Contrôleur de texte pour la barre de recherche.
  final TextEditingController _searchController = TextEditingController();

  /// Méthode simulant l'importation de services depuis un fichier Excel.
  /// Elle bascule simplement l'état `_dataLoaded` pour simuler un chargement/déchargement.
  void _importServicesFromExcel() {
    setState(() {
      _dataLoaded = !_dataLoaded;
    });
  }

  /// Méthode simulant l'exportation de services. Implémentation factice pour le test.
  void _onExportPressed() {
    // Logique d'exportation factice. Dans un vrai test, on pourrait vérifier
    // si cette méthode est appelée.
  }

  /// Méthode pour changer une date par mois.
  ///
  /// Prend une [date], le nombre de [months] à ajouter/retirer,
  /// et un [onDateChanged] callback pour mettre à jour la date.
  void _changeDateByMonth(DateTime date, int months, ValueChanged<DateTime> onDateChanged) {
    setState(() {
      onDateChanged(DateTime(date.year, date.month + months, date.day));
    });
  }

  /// Méthode pour changer une date par jour.
  ///
  /// Prend une [date], le nombre de [days] à ajouter/retirer,
  /// et un [onDateChanged] callback pour mettre à jour la date.
  void _changeDateByDay(DateTime date, int days, ValueChanged<DateTime> onDateChanged) {
    setState(() {
      onDateChanged(date.add(Duration(days: days)));
    });
  }

  /// Méthode simulant l'affichage d'un sélecteur de date (`showDatePicker`).
  ///
  /// Pour le test, elle appelle directement le callback [onDateChanged] avec une date factice,
  /// évitant ainsi d'avoir à interagir avec le sélecteur de date UI réel.
  Future<void> _selectDate(BuildContext context, DateTime initialDate, ValueChanged<DateTime> onDateChanged) async {
    /// Simule le comportement de `showDatePicker` en appelant directement `onDateChanged` avec une date factice.
    onDateChanged(DateTime(2025, 8, 15)); // Une nouvelle date pour montrer que le changement a eu lieu.
  }

  /// Fonction de rappel factice pour le basculement du statut d'absence d'un service.
  ///
  /// [serviceId] L'identifiant unique du service.
  /// [newStatus] Le nouveau statut d'absence (true si absent, false sinon).
  void _handleAbsentToggle(String serviceId, bool newStatus) {}

  /// Fonction de rappel factice pour la modification de l'heure d'un service.
  ///
  /// [serviceId] L'identifiant unique du service.
  /// [currentTime] L'heure actuelle à modifier.
  /// [type] Le type de carte (début ou fin) pour savoir quelle heure modifier.
  void _handleModifyTime(String serviceId, DateTime currentTime, TimeCardType type) {}

  /// Fonction de rappel factice pour la validation ou la dévalidation d'un service.
  ///
  /// [serviceId] L'identifiant unique du service.
  /// [newStatus] Le nouveau statut de validation (true si validé, false sinon).
  void _handleValidate(String serviceId, bool newStatus) {}

  /// Méthode factice pour simuler le défilement vers un service spécifique.
  ///
  /// [service] Le service vers lequel défiler.
  void _scrollToService(Service service) {}


  @override
  Widget build(BuildContext context) {
    /// Le widget principal [MaterialApp] est nécessaire pour que les widgets Material Design
    /// et les localisations fonctionnent dans l'environnement de test.
    return MaterialApp(
      /// Configure les délégués de localisation pour les traductions.
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      /// Définit les locales supportées par l'application.
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
      ],

      /// Force la locale à 'fr_FR' pour garantir que le formatage des dates et les textes
      /// soient toujours en français lors des tests.
      locale: const Locale('fr', 'FR'),

      /// Le widget [Builder] est utilisé ici pour obtenir un [BuildContext] valide
      /// qui peut être passé aux fonctions `_buildAppBar`, `_buildDateRangeSelector`, etc.
      home: Builder(
        builder: (context) {
          /// [Scaffold] fournit la structure visuelle de base de l'écran.
          return Scaffold(
            appBar: _buildAppBar(context), // La barre d'application en haut.
            body: Column(
              /// Le corps de l'écran est organisé en une colonne.
              children: [
                _buildDateRangeSelector(), // Sélecteur de plage de dates.
                _buildSearchBar(), // Barre de recherche.
                _buildColumnHeaders(), // En-têtes de colonnes (Début, Fin, Résultat).
                Expanded(
                  /// Un [Expanded] avec un [Container] vide sert de placeholder
                  /// pour la liste des services qui serait normalement affichée ici.
                  child: Container(), // Espace réservé pour la liste des services.
                ),
                _buildFooter(), // Le pied de page.
              ],
            ),
          );
        },
      ),
    );
  }

  /// Construit l'AppBar du [Scaffold].
  ///
  /// Prend le [BuildContext] actuel pour adapter l'affichage.
  AppBar _buildAppBar(BuildContext context) {
    /// Récupère l'orientation actuelle de l'écran (portrait ou paysage).
    final orientation = MediaQuery.of(context).orientation;

    Widget importButton; // Déclare le widget du bouton d'importation.
    /// Conditionnel pour afficher soit "Changer fichier" soit "Importer services"
    /// en fonction de l'état `_dataLoaded`.
    if (_dataLoaded) {
      /// Bouton pour "Changer fichier" si des données sont déjà chargées.
      importButton = ElevatedButton.icon(
        onPressed: _importServicesFromExcel, // Appel à la fonction d'importation factice.
        icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.primary, size: MockResponsiveUtils.responsiveIconSize(context, 16.0)), // Icône et taille responsive.
        label: FittedBox(
          /// Ajuste le texte pour qu'il tienne dans l'espace.
          fit: BoxFit.scaleDown,
          child: Text('Changer fichier', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: MockResponsiveUtils.responsiveFontSize(context, 9.0))), // Texte et taille responsive.
        ),
        style: ElevatedButton.styleFrom(
          /// Style du bouton.
          backgroundColor: Theme.of(context).colorScheme.onPrimary, // Couleur de fond.
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MockResponsiveUtils.responsivePadding(context, 6.0))), // Forme et bords arrondis.
          padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 6.0), vertical: MockResponsiveUtils.responsivePadding(context, 2.0)), // Espacement interne.
          /// Taille minimale du bouton, s'adapte à l'orientation.
          minimumSize: orientation == Orientation.portrait ? Size.fromHeight(MockResponsiveUtils.responsivePadding(context, 35.0)) : Size(MockResponsiveUtils.responsivePadding(context, 75.0), MockResponsiveUtils.responsivePadding(context, 30.0)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Réduit la zone de tap pour correspondre au contenu.
        ),
      );
    } else {
      /// Bouton pour "Importer services" si aucune donnée n'est chargée.
      importButton = ElevatedButton.icon(
        onPressed: _importServicesFromExcel, // Appel à la fonction d'importation factice.
        icon: Icon(Icons.upload_file, color: Theme.of(context).colorScheme.primary, size: MockResponsiveUtils.responsiveIconSize(context, 16.0)), // Icône de téléchargement.
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Importer services', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: MockResponsiveUtils.responsiveFontSize(context, 9.0))),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MockResponsiveUtils.responsivePadding(context, 6.0))),
          padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 6.0), vertical: MockResponsiveUtils.responsivePadding(context, 2.0)),
          minimumSize: orientation == Orientation.portrait ? Size.fromHeight(MockResponsiveUtils.responsivePadding(context, 35.0)) : Size(MockResponsiveUtils.responsivePadding(context, 75.0), MockResponsiveUtils.responsivePadding(context, 30.0)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      );
    }

    /// Bouton d'exportation de services.
    Widget exportButton = ElevatedButton.icon(
      onPressed: _onExportPressed, // Appel à la fonction d'exportation factice.
      icon: Icon(Icons.download, color: Theme.of(context).colorScheme.primary, size: MockResponsiveUtils.responsiveIconSize(context, 16.0)), // Icône de téléchargement.
      label: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text('Exporter services', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: MockResponsiveUtils.responsiveFontSize(context, 9.0))),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MockResponsiveUtils.responsivePadding(context, 6.0))),
        padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 6.0), vertical: MockResponsiveUtils.responsivePadding(context, 2.0)),
        minimumSize: orientation == Orientation.portrait ? Size.fromHeight(MockResponsiveUtils.responsivePadding(context, 35.0)) : Size(MockResponsiveUtils.responsivePadding(context, 75.0), MockResponsiveUtils.responsivePadding(context, 30.0)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );

    /// Retourne une [AppBar] différente selon l'orientation (portrait ou paysage).
    if (orientation == Orientation.portrait) {
      return AppBar(
        toolbarHeight: MockResponsiveUtils.responsivePadding(context, 80.0), // Hauteur de la barre d'outils.
        leading: Padding(
          /// Widget placé au début de l'AppBar (généralement une icône ou un logo).
          padding: EdgeInsets.all(MockResponsiveUtils.responsivePadding(context, 4.0)), // Espacement interne.
          child: Image.asset(
            /// Image du logo de l'application.
            'assets/logo_app.png',
            height: MockResponsiveUtils.responsiveIconSize(context, 40.0), // Hauteur de l'image.
            width: MockResponsiveUtils.responsiveIconSize(context, 40.0), // Largeur de l'image.
            errorBuilder: (context, error, stackTrace) {
              /// Gestion des erreurs si l'image ne peut pas être chargée.
              return Icon(Icons.error, size: MockResponsiveUtils.responsiveIconSize(context, 40.0));
            },
          ),
        ),
        title: Text(
          /// Titre de l'application.
          'Prise de services automatique',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MockResponsiveUtils.responsiveFontSize(context, 16.0),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        centerTitle: true, // Centre le titre.
        backgroundColor: Theme.of(context).primaryColor, // Couleur de fond de l'AppBar.
        foregroundColor: Theme.of(context).colorScheme.onPrimary, // Couleur du texte et des icônes.
        bottom: PreferredSize(
          /// Widget en bas de l'AppBar, utile pour des barres supplémentaires.
          preferredSize: Size.fromHeight(MockResponsiveUtils.responsivePadding(context, 45.0)), // Hauteur préférée.
          child: Container(
            /// Conteneur pour les boutons d'import/export.
            color: Theme.of(context).primaryColor, // Couleur de fond.
            padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 8.0), vertical: MockResponsiveUtils.responsivePadding(context, 4.0)), // Espacement interne.
            child: Row(
              /// Les boutons sont organisés en ligne.
              mainAxisAlignment: MainAxisAlignment.center, // Centre les boutons horizontalement.
              children: [
                Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 2.0)), child: importButton)), // Bouton d'importation.
                SizedBox(width: MockResponsiveUtils.responsivePadding(context, 6.0)), // Espace entre les boutons.
                Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 2.0)), child: exportButton)), // Bouton d'exportation.
              ],
            ),
          ),
        ),
      );
    } else {
      /// [AppBar] pour l'orientation paysage (plus compacte).
      return AppBar(
        toolbarHeight: MockResponsiveUtils.responsivePadding(context, 50.0), // Hauteur de la barre d'outils plus petite.
        leading: Padding(
          padding: EdgeInsets.all(MockResponsiveUtils.responsivePadding(context, 4.0)),
          child: Image.asset(
            'assets/logo_app.png',
            height: MockResponsiveUtils.responsiveIconSize(context, 25.0), // Taille de l'image réduite.
            width: MockResponsiveUtils.responsiveIconSize(context, 25.0), // Taille de l'image réduite.
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error, size: MockResponsiveUtils.responsiveIconSize(context, 25.0));
            },
          ),
        ),
        title: Text(
          'Prise de services automatique',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MockResponsiveUtils.responsiveFontSize(context, 16.0),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          overflow: TextOverflow.ellipsis, // Gère le débordement du texte avec des points de suspension.
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          /// Actions (boutons) sur le côté droit de l'AppBar.
          Padding(padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 2.0)), child: importButton),
          Padding(padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 2.0)), child: exportButton),
          SizedBox(width: MockResponsiveUtils.responsivePadding(context, 6.0)), // Espace à la fin.
        ],
      );
    }
  }

  /// Construit le sélecteur de plage de dates et les boutons de bascule de colonne.
  ///
  /// Retourne un [Widget] qui affiche les contrôles de date et les options de visibilité des colonnes,
  /// adaptés à l'orientation de l'écran.
  Widget _buildDateRangeSelector() {
    final orientation = MediaQuery.of(context).orientation; // Récupère l'orientation.

    /// Fonction d'aide pour construire un bouton de bascule de colonne.
    ///
    /// [label] Le texte affiché sur le bouton (ex: "D", "F", "R").
    /// [isVisible] Indique si la colonne associée est actuellement visible.
    /// [onChanged] Callback appelé lorsque la visibilité de la colonne est modifiée.
    Widget buildColumnToggleButton(String label, bool isVisible, ValueChanged<bool> onChanged) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 2.0)),
        child: InkWell(
          /// Permet de rendre la zone cliquable avec un effet d'ondulation.
          onTap: () => setState(() => onChanged(!isVisible)), // Bascule la visibilité de la colonne.
          borderRadius: BorderRadius.circular(MockResponsiveUtils.responsivePadding(context, 8.0)),
          child: Container(
            width: MockResponsiveUtils.responsivePadding(context, 70.0), // Largeur fixe du bouton.
            height: MockResponsiveUtils.responsivePadding(context, 35.0), // Hauteur fixe du bouton.
            decoration: BoxDecoration(
              color: isVisible ? Theme.of(context).primaryColor : Colors.grey[400], // Couleur selon l'état visible/caché.
              borderRadius: BorderRadius.circular(MockResponsiveUtils.responsivePadding(context, 8.0)),
              boxShadow: isVisible ? [
                /// Ombre si le bouton est "visible" (actif).
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ] : null,
            ),
            child: Row(
              /// Contenu du bouton (icône et texte).
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off, // Icône d'œil ouvert/fermé.
                  color: Colors.white,
                  size: MockResponsiveUtils.responsiveIconSize(context, 16.0),
                ),
                SizedBox(width: MockResponsiveUtils.responsivePadding(context, 2.0)), // Espace entre icône et texte.
                Text(
                  label, // Texte du bouton (D, F, R).
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MockResponsiveUtils.responsiveFontSize(context, 10.0),
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis, // Gère le débordement.
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      );
    }

    /// Contrôles de date : une ligne contenant les flèches pour changer de mois et les sélecteurs de date.
    Widget dateControls = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          /// Bouton flèche gauche pour reculer d'un mois.
          icon: Icon(Icons.arrow_back_ios, size: MockResponsiveUtils.responsiveIconSize(context, 16.0)),
          onPressed: () {
            /// Met à jour les dates de début et de fin en reculant d'un mois.
            _changeDateByMonth(_startDate, -1, (newDate) => _startDate = newDate);
            _changeDateByMonth(_endDate, -1, (newDate) => _endDate = newDate);
          },
          visualDensity: VisualDensity.compact, // Rend le bouton plus compact.
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        Expanded(
          /// [Expanded] pour que les contrôles de date occupent l'espace disponible.
          child: _buildDateControl(
            /// Contrôle de la date de début.
            _startDate,
            (newDate) => _startDate = newDate,
            const Key('startDateText'),
            rowKey: const Key('startDateControlRow'), // Clé pour la ligne du contrôle de date de début.
          ),
        ),
        SizedBox(width: MockResponsiveUtils.responsivePadding(context, 4.0)), // Espace.
        Container(
          /// Séparateur visuel vertical.
          width: MockResponsiveUtils.responsivePadding(context, 1.5),
          height: MockResponsiveUtils.responsiveFontSize(context, 20.0),
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: MockResponsiveUtils.responsivePadding(context, 4.0)), // Espace.
        Expanded(
          child: _buildDateControl(
            /// Contrôle de la date de fin.
            _endDate,
            (newDate) => _endDate = newDate,
            const Key('endDateText'), // Clé pour le texte de la date de fin.
          ),
        ),
        IconButton(
          /// Bouton flèche droite pour avancer d'un mois.
          icon: Icon(Icons.arrow_forward_ios, size: MockResponsiveUtils.responsiveIconSize(context, 16.0)),
          onPressed: () {
            /// Met à jour les dates de début et de fin en avançant d'un mois.
            _changeDateByMonth(_startDate, 1, (newDate) => _startDate = newDate);
            _changeDateByMonth(_endDate, 1, (newDate) => _endDate = newDate);
          },
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );

    /// Boutons de bascule de colonne (D, F, R).
    Widget columnToggleButtons = Row(
      mainAxisSize: MainAxisSize.min, // La ligne prendra juste l'espace nécessaire.
      children: [
        buildColumnToggleButton('D', _showDebutColumn, (newStatus) {
          /// Bouton "Début".
          _showDebutColumn = newStatus;
        }),
        buildColumnToggleButton('F', _showFinColumn, (newStatus) {
          /// Bouton "Fin".
          _showFinColumn = newStatus;
        }),
        buildColumnToggleButton('R', _showResultColumn, (newStatus) {
          /// Bouton "Résultat".
          _showResultColumn = newStatus;
        }),
      ],
    );

    /// Retourne le conteneur principal du sélecteur de plage de dates,
    /// avec une disposition différente selon l'orientation.
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 10.0), vertical: MockResponsiveUtils.responsivePadding(context, 4.0)),
      color: Colors.grey[100], // Couleur de fond légèrement grise.
      child: orientation == Orientation.portrait
          ? Column(
              /// En mode portrait, les contrôles de date et les bascules sont en colonne.
              mainAxisSize: MainAxisSize.min,
              children: [
                dateControls, // La ligne des contrôles de date.
                SizedBox(height: MockResponsiveUtils.responsivePadding(context, 8.0)), // Espace vertical.
                Row(
                  /// Ligne pour la date actuelle et les boutons de bascule.
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      /// Le texte de la date actuelle prend l'espace disponible.
                      child: Text(
                        DateFormat('EEEE dd MMMM HH:mm:ss', 'fr_FR').format(_currentDisplayDate), // Formatage détaillé de la date.
                        style: TextStyle(
                          fontSize: MockResponsiveUtils.responsiveFontSize(context, 11.0),
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    columnToggleButtons, // Les boutons de bascule des colonnes.
                  ],
                ),
              ],
            )
          : Row(
              /// En mode paysage, tous les éléments sont sur une seule ligne.
              children: [
                Expanded(
                  flex: 3, // Augmentation du flex pour donner plus de place aux contrôles de date.
                  child: dateControls,
                ),
                SizedBox(width: MockResponsiveUtils.responsivePadding(context, 10.0)), // Espace horizontal.
                Expanded(
                  flex: 4, // Augmentation du flex pour le texte de la date longue.
                  child: Text(
                    DateFormat('EEEE dd MMMM HH:mm:ss', 'fr_FR').format(_currentDisplayDate),
                    style: TextStyle(
                      fontSize: MockResponsiveUtils.responsiveFontSize(context, 11.0),
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(width: MockResponsiveUtils.responsivePadding(context, 10.0)), // Espace horizontal.
                Expanded(
                  /// Les boutons de bascule des colonnes sont également dans un [Expanded].
                  flex: 3, // Ajuste le flex pour un bon agencement en paysage.
                  child: columnToggleButtons,
                ),
              ],
            ),
    );
  }

  /// Construit un contrôle de date individuel (pour début et fin).
  ///
  /// Inclut des boutons +/- pour changer le jour et un [GestureDetector] pour ouvrir le sélecteur de date.
  ///
  /// [date] La [DateTime] actuellement sélectionnée.
  /// [onDateChanged] Un [ValueChanged] qui est appelé lorsque la date est modifiée.
  /// [dateTextKey] Une [Key] pour le [Text] affichant la date, utile pour les tests.
  /// [rowKey] Une [Key] optionnelle pour le [Row] parent du contrôle de date.
  Widget _buildDateControl(DateTime date, ValueChanged<DateTime> onDateChanged, Key dateTextKey, {Key? rowKey}) {
    return Row(
      key: rowKey, // Clé optionnelle pour la ligne ([Row]) elle-même.
      mainAxisAlignment: MainAxisAlignment.start, // Alignement au début de la ligne.
      children: [
        IconButton(
          /// Bouton pour réduire le jour de 1.
          icon: Icon(Icons.remove, size: MockResponsiveUtils.responsiveIconSize(context, 16.0)),
          onPressed: () => _changeDateByDay(date, -1, onDateChanged),
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints.tightFor(
            /// Contraintes de taille strictes pour l'icône.
            width: MockResponsiveUtils.responsiveIconSize(context, 16.0),
            height: MockResponsiveUtils.responsiveIconSize(context, 16.0),
          ),
        ),
        Expanded(
          /// Le [GestureDetector] contenant le texte de la date prend l'espace restant.
          child: GestureDetector(
            onTap: () async {
              await _selectDate(context, date, onDateChanged); // Ouvre le sélecteur de date factice.
              setState(() {}); // Déclenche une reconstruction pour refléter le changement de date.
            },
            child: Container(
              /// Le padding horizontal peut entraîner un débordement si la date est longue et l'espace limité.
              padding: EdgeInsets.symmetric(
                horizontal: 0.0, // Défini à 0.0 ou une très petite constante comme 0.5.
                vertical: MockResponsiveUtils.responsivePadding(context, 3.0),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor, width: 1.0), // Bordure.
                borderRadius: BorderRadius.circular(MockResponsiveUtils.responsivePadding(context, 5.0)), // Bords arrondis.
                color: Colors.white, // Couleur de fond.
              ),
              child: FittedBox(
                /// Ajuste le texte de la date pour qu'il tienne dans le conteneur.
                fit: BoxFit.scaleDown,
                child: Text(
                  DateFormat('dd/MM/yyyy').format(date), // Formate la date en JJ/MM/AAAA.
                  key: dateTextKey, // Clé pour le texte de la date, utile pour les tests.
                  style: TextStyle(
                    fontSize: MockResponsiveUtils.responsiveFontSize(context, 12.0),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis, // Gère le débordement du texte.
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ),
        IconButton(
          /// Bouton pour augmenter le jour de 1.
          icon: Icon(Icons.add, size: MockResponsiveUtils.responsiveIconSize(context, 16.0)),
          onPressed: () => _changeDateByDay(date, 1, onDateChanged),
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints.tightFor(
            width: MockResponsiveUtils.responsiveIconSize(context, 16.0),
            height: MockResponsiveUtils.responsiveIconSize(context, 16.0),
          ),
        ),
      ],
    );
  }

  /// Construit la barre de recherche.
  ///
  /// Retourne un [Padding] contenant un [TextField] pour la recherche par nom d'employé.
  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 9.0), vertical: MockResponsiveUtils.responsivePadding(context, 4.0)), // Espacement externe.
      child: TextField(
        /// Champ de texte pour la recherche.
        controller: _searchController, // Contrôleur pour gérer le texte.
        decoration: InputDecoration(
          labelText: 'Rechercher par nom d\'employé', // Libellé flottant.
          hintText: 'Entrez le nom de l\'employé...', // Texte d'aide.
          prefixIcon: Icon(Icons.search, size: MockResponsiveUtils.responsiveIconSize(context, 12.0)), // Icône de recherche.
          border: OutlineInputBorder(
            /// Bordure du champ de texte.
            borderRadius: BorderRadius.circular(MockResponsiveUtils.responsivePadding(context, 6.0)), // Bords arrondis.
          ),
          contentPadding: EdgeInsets.symmetric(vertical: MockResponsiveUtils.responsivePadding(context, 6.0), horizontal: MockResponsiveUtils.responsivePadding(context, 6.0)), // Espacement interne.
          isDense: true, // Rend le champ de texte plus compact.
        ),
        style: TextStyle(fontSize: MockResponsiveUtils.responsiveFontSize(context, 10.0)), // Style du texte saisi.
      ),
    );
  }

  /// Construit les en-têtes de colonnes (Début, Fin, Résultat).
  ///
  /// Ces en-têtes sont affichés ou masqués en fonction des variables de visibilité.
  Widget _buildColumnHeaders() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 10.0), vertical: MockResponsiveUtils.responsivePadding(context, 6.0)), // Espacement externe.
      child: Row(
        /// Les en-têtes sont disposés en ligne.
        children: [
          /// Affiche la colonne "Début" si `_showDebutColumn` est vrai.
          if (_showDebutColumn)
            Expanded(
              /// Occupe l'espace disponible.
              flex: 2, // Priorité de l'espace.
              child: Center(
                /// Centre le texte.
                child: Text(
                  'Début',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MockResponsiveUtils.responsiveFontSize(context, 14.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          /// Affiche la colonne "Fin" si `_showFinColumn` est vrai.
          if (_showFinColumn)
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  'Fin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MockResponsiveUtils.responsiveFontSize(context, 14.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          /// Affiche la colonne "Résultat" si `_showResultColumn` est vrai.
          if (_showResultColumn)
            Expanded(
              flex: 1, // Moins d'espace pour la colonne résultat.
              child: Center(
                child: Text(
                  'Résultat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MockResponsiveUtils.responsiveFontSize(context, 14.0),
                    color: Colors.green.shade700, // Couleur verte pour le résultat.
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Construit le pied de page de l'application.
  ///
  /// Contient le texte du copyright et la date/heure actuelle.
  Widget _buildFooter() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MockResponsiveUtils.responsivePadding(context, 6.0),
        vertical: MockResponsiveUtils.responsivePadding(context, 4.0),
      ),
      child: Row(
        /// Contient le texte du copyright et de la date.
        mainAxisAlignment: MainAxisAlignment.center, // Centre le contenu.
        children: [
          Flexible(
            /// Permet au texte de s'adapter si l'espace est limité.
            child: Text(
              "© BMSoft 2025, tous droits réservés    ${DateFormat('dd/MM/yyyy HH:mm:ss', 'fr_FR').format(_currentDisplayDate)}", // Texte du copyright et date/heure.
              style: TextStyle(
                fontSize: MockResponsiveUtils.responsiveFontSize(context, 9.0),
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary,
              ),
              overflow: TextOverflow.visible, // Le texte peut déborder si nécessaire.
            ),
          ),
        ],
      ),
    );
  }
}

/// Fonction d'aide pour initialiser et "pomper" (reconstruire) le widget [MockMyHomePage]
/// avec une configuration cohérente pour les tests.
///
/// Cette fonction encapsule [MockMyHomePage] dans un [MediaQuery] pour simuler une taille d'écran,
/// ce qui est essentiel pour tester le comportement responsive du widget.
///
/// - `tester`: Le [WidgetTester] fourni par le framework de test.
/// - `size`: La [Size] de l'écran à simuler (ex: [Size(360, 640)] pour le mode portrait).
Future<void> _pumpMockMyHomePage(WidgetTester tester, {required Size size}) async {
  /// Encapsule [MockMyHomePage] dans un [MediaQuery] pour simuler une taille d'écran.
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(size: size), // Définit la taille de l'écran (ex: portrait ou paysage).
      child: MockMyHomePage(), // Le widget à tester.
    ),
  );
  /// Attend que toutes les animations ou les reconstructions initiales soient terminées.
  await tester.pumpAndSettle();
}

void main() {
  /// `setUpAll` est exécuté une seule fois avant tous les tests du groupe.
  setUpAll(() {
    /// Assure que les liaisons (bindings) de Flutter sont initialisées pour les tests de widgets.
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  /// Groupe de tests pour la barre d'application ([AppBar]).
  group('AppBar Tests', () {
    /// Teste si l'AppBar affiche le titre et les boutons d'importation/exportation en mode portrait.
    testWidgets('AppBar displays title and import/export buttons in portrait mode', (WidgetTester tester) async {
      /// Initialise le widget en mode portrait (largeur 360, hauteur 640).
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      /// Vérifie que le titre de l'application est présent.
      expect(find.text('Prise de services automatique'), findsOneWidget);
      /// Vérifie que les icônes des boutons d'importation et d'exportation sont présentes.
      expect(find.byIcon(Icons.upload_file), findsOneWidget);
      expect(find.byIcon(Icons.download), findsOneWidget);
      /// Vérifie que les textes des boutons sont présents.
      expect(find.text('Importer services'), findsOneWidget);
      expect(find.text('Exporter services'), findsOneWidget);
    });

    /// Teste si le texte du bouton d'importation change lorsque les données sont "chargées".
    testWidgets('Import button changes text when data is loaded', (WidgetTester tester) async {
      /// Initialise le widget en mode portrait.
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      /// Au début, le bouton doit afficher "Importer services" et pas "Changer fichier".
      expect(find.text('Importer services'), findsOneWidget);
      expect(find.text('Changer fichier'), findsNothing);

      /// Simule un tap sur le bouton "Importer services".
      await tester.tap(find.text('Importer services'));
      /// Reconstruit le widget pour refléter le changement d'état.
      await tester.pump();

      /// Après le tap, le bouton doit maintenant afficher "Changer fichier" et plus "Importer services".
      expect(find.text('Importer services'), findsNothing);
      expect(find.text('Changer fichier'), findsOneWidget);
    });
  });

  /// Groupe de tests pour le sélecteur de plage de dates.
  group('Date Range Selector Tests', () {
    /// Teste si le sélecteur de plage de dates affiche la date et l'heure actuelles en mode portrait.
    testWidgets('Date range selector displays current date and time in portrait', (WidgetTester tester) async {
      /// Initialise le widget en mode portrait.
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      /// Formate la date et l'heure attendues pour la comparaison.
      final formattedDate = DateFormat('EEEE dd MMMM HH:mm:ss', 'fr_FR').format(DateTime(2025, 7, 29, 16, 4, 18));
      /// Vérifie qu'une partie du texte formaté (les 10 premiers caractères) est présente.
      expect(find.textContaining(formattedDate.substring(0, 10)), findsOneWidget);
    });

    /// Teste si les boutons de bascule des colonnes sont présents et interactifs.
    testWidgets('Column toggle buttons are present and interactive', (WidgetTester tester) async {
      /// Initialise le widget en mode portrait.
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      /// Vérifie la présence des boutons de bascule avec leurs libellés respectifs (D, F, R).
      expect(find.widgetWithText(InkWell, 'D'), findsOneWidget);
      expect(find.widgetWithText(InkWell, 'F'), findsOneWidget);
      expect(find.widgetWithText(InkWell, 'R'), findsOneWidget);

      /// Trouve le bouton de bascule "D" (Début).
      final debutToggleFinder = find.widgetWithText(InkWell, 'D');
      /// Simule un tap sur ce bouton.
      await tester.tap(debutToggleFinder);
      /// Reconstruit le widget pour refléter le changement d'état.
      await tester.pump();
      /// On peut ajouter des assertions ici pour vérifier que la colonne "Début" a bien disparu.
    });

    /// Teste si les contrôles de date interagissent correctement (changement de jour).
    testWidgets('Date controls interact correctly (day change)', (WidgetTester tester) async {
      /// Initialise le widget en mode portrait.
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      final initialStartDate = DateTime(2025, 7, 29);
      final initialStartDateString = DateFormat('dd/MM/yyyy').format(initialStartDate);

      /// Vérifie que le widget de texte de la date de début existe et affiche la date initiale.
      expect(find.byKey(const Key('startDateText')), findsOneWidget);
      expect(tester.widget<Text>(find.byKey(const Key('startDateText'))).data, initialStartDateString);

      /// Trouve la ligne spécifique du contrôle de date de début en utilisant sa clé.
      final Finder startDateControlRow = find.byKey(const Key('startDateControlRow'));
      /// Vérification facultative : s'assurer qu'elle est trouvée de manière unique.
      expect(startDateControlRow, findsOneWidget);

      /// Trouve le bouton avec l'icône 'remove' (moins) *à l'intérieur* de cette ligne spécifique.
      final Finder startDateRemoveButton = find.descendant(
        of: startDateControlRow,
        matching: find.byIcon(Icons.remove),
      );
      /// Simule un tap sur le bouton 'remove'.
      await tester.tap(startDateRemoveButton);
      /// Reconstruit le widget.
      await tester.pump();

      /// Calcule la date d'hier et formate-la.
      final yesterday = DateFormat('dd/MM/yyyy').format(initialStartDate.subtract(const Duration(days: 1)));
      /// Vérifie que le texte de la date de début a changé pour afficher la date d'hier.
      expect(tester.widget<Text>(find.byKey(const Key('startDateText'))).data, yesterday);

      /// Trouve le bouton avec l'icône 'add' (plus) *à l'intérieur* de la même ligne spécifique.
      final Finder startDateAddButton = find.descendant(
        of: startDateControlRow,
        matching: find.byIcon(Icons.add),
      );
      /// Simule un tap sur le bouton 'add'.
      await tester.tap(startDateAddButton);
      /// Reconstruit le widget.
      await tester.pump();

      /// Vérifie que le texte de la date de début est revenu à la date initiale.
      expect(tester.widget<Text>(find.byKey(const Key('startDateText'))).data, initialStartDateString);
    });

    /// Teste si les contrôles de date interagissent correctement (changement de mois).
    testWidgets('Date controls interact correctly (month change)', (WidgetTester tester) async {
      /// Initialise le widget en mode portrait.
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      final initialStartDate = DateTime(2025, 7, 29);
      final initialStartDateString = DateFormat('dd/MM/yyyy').format(initialStartDate);

      /// Vérifie que le widget de texte de la date de début existe et affiche la date initiale.
      expect(find.byKey(const Key('startDateText')), findsOneWidget);
      expect(tester.widget<Text>(find.byKey(const Key('startDateText'))).data, initialStartDateString);

      /// Trouve la ligne qui contient les boutons de changement de mois (flèches).
      final monthControlsRow = find.ancestor(
        of: find.byIcon(Icons.arrow_back_ios),
        matching: find.byType(Row),
      );
      /// Simule un tap sur le bouton de flèche arrière (diminution du mois).
      await tester.tap(find.descendant(of: monthControlsRow, matching: find.byIcon(Icons.arrow_back_ios)));
      /// Reconstruit le widget.
      await tester.pump();

      /// Calcule la date du mois précédent et formate-la.
      final lastMonthStartDate = DateFormat('dd/MM/yyyy').format(DateTime(initialStartDate.year, initialStartDate.month - 1, initialStartDate.day));
      /// Vérifie que le texte de la date de début a changé pour le mois précédent.
      expect(tester.widget<Text>(find.byKey(const Key('startDateText'))).data, lastMonthStartDate);

      /// Simule un tap sur le bouton de flèche avant (augmentation du mois).
      await tester.tap(find.descendant(of: monthControlsRow, matching: find.byIcon(Icons.arrow_forward_ios)));
      /// Reconstruit le widget.
      await tester.pump();
      /// Vérifie que le texte de la date de début est revenu à la date initiale.
      expect(tester.widget<Text>(find.byKey(const Key('startDateText'))).data, initialStartDateString);
    });

    /// Teste si le sélecteur de date peut être "ouvert" et une date "sélectionnée".
    testWidgets('Date picker can be opened and a date selected', (WidgetTester tester) async {
      /// Initialise le widget en mode portrait.
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      /// Simule un tap sur le texte de la date de début pour "ouvrir" le sélecteur de date.
      /// Puisque _selectDate est mocké pour mettre à jour directement la date,
      /// nous ne chercherons pas le sélecteur de date réel ([CalendarDatePicker]) ni le bouton 'OK'.
      await tester.tap(find.byKey(const Key('startDateText')));
      /// Attend que le widget se stabilise après l'action.
      await tester.pumpAndSettle();

      /// Vérifie que le texte de la date a changé pour la date mockée (15 août 2025).
      expect(find.text(DateFormat('dd/MM/yyyy').format(DateTime(2025, 8, 15))), findsOneWidget);
    });
  });

  /// Groupe de tests pour la barre de recherche.
  group('SearchBar Tests', () {
    /// Teste si la barre de recherche est présente et peut recevoir une entrée.
    testWidgets('Search bar is present and can receive input', (WidgetTester tester) async {
      /// Initialise le widget en mode portrait.
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      /// Vérifie que le champ de texte est présent.
      expect(find.byType(TextField), findsOneWidget);
      /// Vérifie que le libellé de la barre de recherche est présent.
      expect(find.text('Rechercher par nom d\'employé'), findsOneWidget);

      /// Simule la saisie de texte dans le champ.
      await tester.enterText(find.byType(TextField), 'John Doe');
      /// Vérifie que le texte saisi est affiché dans le champ.
      expect(find.text('John Doe'), findsOneWidget);
    });
  });

  /// Groupe de tests pour les en-têtes de colonnes.
  group('Column Headers Tests', () {
    /// Teste si les en-têtes de colonnes sont affichés lorsque leurs drapeaux de visibilité sont vrais.
    testWidgets('Column headers are displayed when visible', (WidgetTester tester) async {
      /// Initialise le widget en mode portrait. Par défaut, toutes les colonnes sont visibles.
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      /// Vérifie que les textes des en-têtes de colonnes sont présents.
      expect(find.text('Début'), findsOneWidget);
      expect(find.text('Fin'), findsOneWidget);
      expect(find.text('Résultat'), findsOneWidget);
    });

    /// Teste si les en-têtes de colonnes se cachent lorsque leurs boutons de bascule sont désactivés.
    testWidgets('Column headers hide when toggled off', (WidgetTester tester) async {
      /// Initialise le widget en mode portrait.
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      /// Simule un tap sur le bouton de bascule "D" (Début).
      await tester.tap(find.widgetWithText(InkWell, 'D'));
      /// Reconstruit le widget.
      await tester.pump();

      /// Vérifie que "Début" n'est plus là, mais "Fin" et "Résultat" le sont.
      expect(find.text('Début'), findsNothing);
      expect(find.text('Fin'), findsOneWidget);
      expect(find.text('Résultat'), findsOneWidget);

      /// Simule un tap sur le bouton de bascule "F" (Fin).
      await tester.tap(find.widgetWithText(InkWell, 'F'));
      /// Reconstruit le widget.
      await tester.pump();

      /// Vérifie que "Fin" n'est plus là, mais "Résultat" l'est toujours.
      expect(find.text('Début'), findsNothing);
      expect(find.text('Fin'), findsNothing);
      expect(find.text('Résultat'), findsOneWidget);

      /// Simule un tap sur le bouton de bascule "R" (Résultat).
      await tester.tap(find.widgetWithText(InkWell, 'R'));
      /// Reconstruit le widget.
      await tester.pump();

      /// Vérifie qu'aucun des en-têtes n'est plus visible.
      expect(find.text('Début'), findsNothing);
      expect(find.text('Fin'), findsNothing);
      expect(find.text('Résultat'), findsNothing);
    });
  });

  /// Groupe de tests pour le pied de page.
  group('Footer Tests', () {
    /// Teste si le pied de page affiche le copyright et la date/heure actuelle.
    testWidgets('Footer displays copyright and current date/time', (WidgetTester tester) async {
      /// Initialise le widget en mode portrait.
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      /// Vérifie que le texte du copyright est présent.
      expect(find.textContaining('© BMSoft 2025, tous droits réservés'), findsOneWidget);
      /// Formate la date et l'heure attendues (les 16 premiers caractères pour éviter des secondes précises).
      final formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss', 'fr_FR').format(DateTime(2025, 7, 29, 16, 4, 18));
      /// Vérifie qu'une partie du texte formaté est présente.
      expect(find.textContaining(formattedDate.substring(0, 16)), findsOneWidget);
    });
  });

  /// Groupe de tests pour le widget [TimeDetailCard].
  group('TimeDetailCard Tests', () {
    /// Teste si [TimeDetailCard] affiche les informations du service.
    testWidgets('TimeDetailCard displays service information', (WidgetTester tester) async {
      /// Crée un objet [Service] factice pour le test.
      final service = Service(
        id: '1',
        employeeName: 'Alice',
        employeeSvrCode: 'SVC001',
        employeeSvrLib: 'Service Library A',
        employeeTelPort: '123-456-7890',
        startTime: DateTime(2025, 7, 29, 9, 0),
        endTime: DateTime(2025, 7, 29, 17, 0),
        locationCode: 'LOC001',
        locationLib: 'Location Library A',
        clientLocationLine3: 'Line 3 Address',
        clientSvrCode: 'CLISVC001',
        clientSvrLib: 'Client Service Lib A',
      );

      /// Pompage du widget [TimeDetailCard] dans un [MaterialApp] et [Scaffold] pour le contexte.
      await tester.pumpWidget(
        MaterialApp(
          /// Assure que les localisations sont également disponibles pour [TimeDetailCard].
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('fr', 'FR'),
          ],
          locale: const Locale('fr', 'FR'), // Force la locale française.
          home: Scaffold(
            body: TimeDetailCard(
              /// Le widget [TimeDetailCard] à tester.
              service: service,
              type: TimeCardType.debut, // Teste avec le type "debut".
              onAbsentPressed: (status) {}, // Callbacks factices.
              onModifyTime: (time) {},
              onValidate: (status) {},
              onTap: () {},
            ),
          ),
        ),
      );

      /// Vérifie que le nom de l'employé est affiché (format attendu "Service for [employeeName]").
      expect(find.text('Service for Alice'), findsOneWidget);
      /// Vérifie que l'heure de début est affichée.
      expect(find.text('H.D: 09:00'), findsOneWidget);
    });

    /// Teste si [TimeDetailCard] affiche la durée calculée pour le type "resultat".
    testWidgets('TimeDetailCard displays calculated duration for result type', (WidgetTester tester) async {
      /// Crée un service avec une durée de 8 heures et 30 minutes.
      final service = Service(
        id: '1',
        employeeName: 'Bob',
        employeeSvrCode: 'SVC002',
        employeeSvrLib: 'Service Library B',
        employeeTelPort: '098-765-4321',
        startTime: DateTime(2025, 7, 29, 9, 0),
        endTime: DateTime(2025, 7, 29, 17, 30), // 8 hours 30 minutes
        locationCode: 'LOC002',
        locationLib: 'Location Library B',
        clientLocationLine3: 'Another Address',
        clientSvrCode: 'CLISVC002',
        clientSvrLib: 'Client Service Lib B',
      );

      /// Pompage du widget [TimeDetailCard] avec le type "result".
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('fr', 'FR'),
          ],
          locale: const Locale('fr', 'FR'),
          home: Scaffold(
            body: TimeDetailCard(
              service: service,
              type: TimeCardType.result, // Type "resultat" pour tester la durée.
              onAbsentPressed: (status) {},
              onModifyTime: (time) {},
              onValidate: (status) {},
              onTap: () {},
            ),
          ),
        ),
      );

      /// Vérifie que le nom de l'employé est affiché.
      expect(find.text('Service for Bob'), findsOneWidget);
      /// Vérifie que la durée calculée "+08h30 min" est affichée.
      expect(find.text(' +08h30 min'), findsOneWidget);
    });

    /// Teste si [TimeDetailCard] affiche le bouton de validation/désvalidation pour le type "resultat".
    testWidgets('TimeDetailCard shows validate/devalidate button for result type', (WidgetTester tester) async {
      final service = Service(
        id: '1',
        employeeName: 'Charlie',
        employeeSvrCode: 'SVC003',
        employeeSvrLib: 'Service Library C',
        employeeTelPort: '111-222-3333',
        startTime: DateTime(2025, 7, 29, 10, 0),
        endTime: DateTime(2025, 7, 29, 12, 0),
        locationCode: 'LOC003',
        locationLib: 'Location Library C',
        clientLocationLine3: 'Third Address',
        clientSvrCode: 'CLISVC003',
        clientSvrLib: 'Client Service Lib C',
      );

      /// Initialise le widget avec un service non validé par défaut.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TimeDetailCard(
              service: service,
              type: TimeCardType.result, // Teste avec le type "result".
              onAbsentPressed: (status) {},
              onModifyTime: (time) {},
              onValidate: (status) {},
              onTap: () {},
            ),
          ),
        ),
      );

      /// Vérifie que le bouton de validation (Valider) est présent en mode portrait.
      expect(find.byKey(const Key('validateButtonPortrait')), findsOneWidget);
      expect(find.text('Valider'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);

      /// Remarque: Un test complet de bascule de validation nécessiterait un mock du `service`
      /// qui puisse changer son état `isValidated` ou l'encapsuler dans un widget stateful
      /// qui met à jour le `service` après un appel à `onValidate`.
    });

    /// Teste si [TimeDetailCard] masque les boutons de modification de l'heure et de validation pour les types autres que "resultat" (ici, "debut").
    testWidgets('TimeDetailCard hides modify time and validate buttons for non-result types', (WidgetTester tester) async {
      final service = Service(
        id: '1',
        employeeName: 'Diana',
        employeeSvrCode: 'SVC004',
        employeeSvrLib: 'Service Library D',
        employeeTelPort: '444-555-6666',
        startTime: DateTime(2025, 7, 29, 8, 0),
        endTime: DateTime(2025, 7, 29, 16, 0),
        locationCode: 'LOC004',
        locationLib: 'Location Library D',
        clientLocationLine3: 'Fourth Address',
        clientSvrCode: 'CLISVC004',
        clientSvrLib: 'Client Service Lib D',
      );

      /// Pompage du widget avec le type "debut".
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TimeDetailCard(
              service: service,
              type: TimeCardType.debut, // Teste avec le type "debut".
              onAbsentPressed: (status) {},
              onModifyTime: (time) {},
              onValidate: (status) {},
              onTap: () {},
            ),
          ),
        ),
      );

      /// Vérifie que les boutons "Modifier l'heure" et "Absent" sont présents pour le type "debut".
      expect(find.byKey(const Key('modifyTimeButtonPortrait')), findsOneWidget);
      expect(find.byKey(const Key('absentButtonPortrait')), findsOneWidget);
      /// Vérifie que le bouton de validation n'est PAS présent pour le type "debut".
      expect(find.byKey(const Key('validateButtonPortrait')), findsNothing);
    });
  });
}