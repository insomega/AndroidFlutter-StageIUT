// lib/time_detail_card.dart

import 'package:flutter/material.dart'; // Importe le package Flutter, essentiel pour construire des interfaces utilisateur (widgets, Material Design, etc.).
import 'package:intl/intl.dart'; // Importe le package `intl` pour des fonctionnalités d'internationalisation, notamment pour la mise en forme des dates et heures selon des formats locaux.
import 'package:mon_projet/models/service.dart'; // Importe la définition de la classe `Service` depuis le chemin `models/service.dart`. Cette classe représente la structure des données pour un service.
import 'package:mon_projet/utils/time_card_helpers.dart' as helpers; // Importe un ensemble de fonctions d'aide (`helpers`) définies dans `utils/time_card_helpers.dart`. Ces fonctions sont utilisées pour calculer des tailles responsives (police, espacement, icônes) et formater des durées, améliorant l'adaptabilité de l'UI.

/// Enumération (énum) définissant les différents types que peut prendre une carte horaire.
enum TimeCardType {
  /// Représente une carte affichant les détails d'un service en se concentrant sur son heure de début.
  debut,

  /// Représente une carte affichant les détails d'un service en se concentrant sur son heure de fin.
  fin,

  /// Représente une carte affichant un résumé ou un résultat final pour un service.
  result
}

/// `TimeDetailCard` est un widget de type [StatelessWidget].
///
/// Il est conçu pour afficher les détails d'un [Service] et s'adapte en fonction du
/// [type] de carte (début, fin, ou résultat) et de l'orientation de l'écran
/// (portrait ou paysage). Il inclut également des callbacks pour gérer les interactions utilisateur.
class TimeDetailCard extends StatelessWidget {
  /// L'objet [Service] dont les détails doivent être affichés par cette carte.
  /// Il est obligatoire.
  final Service service;

  /// Le type spécifique de carte à afficher, déterminant quelles informations
  /// sont mises en avant ou masquées. Il est obligatoire.
  final TimeCardType type;

  /// Callback optionnel déclenché lorsque le bouton "Absent" est pressé.
  ///
  /// Il passe le nouveau statut d'absence (`true` si absent, `false` si présent).
  final Function(bool newAbsentStatus)? onAbsentPressed;

  /// Callback optionnel déclenché lorsque le bouton "Valider/Dévalider" est pressé.
  ///
  /// Il passe le nouveau statut de validation du service.
  final Function(bool newValidateStatus)? onValidate;

  /// Callback optionnel déclenché lorsque le bouton "Modifier l'heure" est pressé.
  ///
  /// Il reçoit l'heure actuellement affichée sur la carte.
  final Function(DateTime currentTime)? onModifyTime;

  /// Callback simple sans argument, appelé lorsque la carte est tapée.
  /// (ex: pour naviguer vers les détails complets).
  final VoidCallback? onTap;

  /// Constructeur de la classe [TimeDetailCard].
  ///
  /// [key]: Clé optionnelle du widget, utile pour identifier de manière unique
  /// les widgets dans les listes ou pour les tests.
  /// [service]: Le service à afficher est une propriété obligatoire.
  /// [type]: Le type de carte est une propriété obligatoire pour adapter l'affichage.
  /// [onAbsentPressed]: Le callback pour le statut d'absence est optionnel.
  /// [onValidate]: Le callback pour la validation est optionnel.
  /// [onModifyTime]: Le callback pour la modification de l'heure est optionnel.
  /// [onTap]: Le callback pour le tap sur la carte est optionnel.
  const TimeDetailCard({
    super.key,
    required this.service,
    required this.type,
    this.onAbsentPressed,
    this.onValidate,
    this.onModifyTime,
    this.onTap,
  });

  /// Méthode d'aide privée pour construire la section de l'en-tête de la carte.
  ///
  /// L'en-tête contient le code et le nom de l'employé, ainsi que son numéro de téléphone
  /// (sauf pour le type [TimeCardType.result]). La disposition s'adapte à l'orientation
  /// de l'écran (portrait ou paysage).
  ///
  /// [context]: Le [BuildContext] pour accéder au thème et aux médias.
  ///
  /// Retourne un [Widget] représentant l'en-tête.
  Widget _buildHeader(BuildContext context) {
    /// Détermine l'orientation actuelle de l'écran (portrait ou paysage).
    final orientation = MediaQuery.of(context).orientation;

    /// Si l'orientation est portrait, arrange les éléments en colonne.
    if (orientation == Orientation.portrait) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligne les enfants au début (à gauche) de la colonne.
        children: [
          SizedBox(
            width: double.infinity, // La largeur de ce [SizedBox] est infinie pour prendre toute la largeur disponible.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Aligne les enfants au début (à gauche) de la colonne imbriquée.
              children: [
                /// Affiche le code du service de l'employé avec un style spécifique (gris, petite taille).
                Text(
                  service.employeeSvrCode,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                      fontSize: helpers.responsiveFontSize(context, 10.0)), // Utilise une taille de police responsive.
                ),
                /// Affiche le nom de l'employé avec un style plus prononcé (bleu, gras, taille moyenne).
                Text(
                  service.employeeName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 91, 168, 231),
                                fontSize: helpers.responsiveFontSize(context, 14.0), // Utilise une taille de police responsive.
                              ),
                  overflow: TextOverflow.ellipsis, // Si le texte est trop long, il est tronqué avec des points de suspension.
                  maxLines: 1, // Limite le texte à une seule ligne.
                ),
              ],
            ),
          ),
          /// Ajoute un espace vertical après l'en-tête, sauf si le type de carte est 'result'.
          if (type != TimeCardType.result) SizedBox(height: helpers.responsivePadding(context, 8.0)),

          /// Affiche le numéro de téléphone de l'employé, uniquement si le type de carte n'est PAS [TimeCardType.result].
          if (type != TimeCardType.result)
            SizedBox(
              width: double.infinity, // La largeur est infinie pour pousser le contenu à droite.
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // Aligne les éléments de la ligne à la fin (à droite).
                children: [
                  Icon(Icons.phone, size: helpers.responsiveIconSize(context, 15.0)), // Icône de téléphone avec taille responsive.
                  SizedBox(width: helpers.responsivePadding(context, 3.0)), // Petit espace horizontal.
                  Flexible( // Permet au texte de se rétrécir ou de tronquer si l'espace est limité.
                    child: Text(
                      "0${service.employeeTelPort}", // Affiche le numéro de téléphone.
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: helpers.responsiveFontSize(context, 11.0)), // Style de texte avec taille responsive.
                      overflow: TextOverflow.ellipsis, // Tronque si trop long.
                      maxLines: 1, // Limite à une ligne.
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    } else {
      /// Si l'orientation est paysage, arrange les éléments en ligne ([Row]).
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribue l'espace également entre et autour des éléments.
        children: [
          Expanded( // L'employé prend 3 parts de l'espace disponible.
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Aligne le contenu au début.
              children: [
                /// Affiche le code du service de l'employé.
                Text(service.employeeSvrCode, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey, fontSize: helpers.responsiveFontSize(context, 10.0))),
                /// Affiche le nom de l'employé.
                Text(service.employeeName, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 91, 168, 231), fontSize: helpers.responsiveFontSize(context, 14.0)), overflow: TextOverflow.ellipsis, maxLines: 1),
              ],
            ),
          ),
          /// Affiche le numéro de téléphone, uniquement si le type de carte n'est PAS [TimeCardType.result].
          if (type != TimeCardType.result)
            Expanded( // Le téléphone prend 2 parts de l'espace disponible.
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // Aligne les éléments à droite.
                children: [
                  Icon(Icons.phone, size: helpers.responsiveIconSize(context, 15.0)), // Icône de téléphone.
                  SizedBox(width: helpers.responsivePadding(context, 3.0)), // Petit espace.
                  Flexible(child: Text("0${service.employeeTelPort}", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1)), // Numéro de téléphone.
                ],
              ),
            ),
        ],
      );
    }
  }

  /// Méthode d'aide privée pour construire la section de la carte affichant
  /// la date, l'heure et la durée calculée.
  ///
  /// Cette section s'adapte également à l'orientation de l'écran.
  ///
  /// [context]: Le [BuildContext] pour accéder au thème et aux médias.
  /// [displayTime]: Le [DateTime] à afficher pour la date et l'heure (début ou fin du service).
  /// [calculatedDuration]: La [Duration] calculée à afficher.
  ///
  /// Retourne un [Widget] représentant la section de temps et de durée.
  Widget _buildTimeAndDuration(BuildContext context, DateTime displayTime, Duration calculatedDuration) {
    final orientation = MediaQuery.of(context).orientation; // Récupère l'orientation actuelle.

    /// Disposition en mode portrait.
    if (orientation == Orientation.portrait) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligne le contenu au début.
        children: [
          Wrap( // Un [Wrap] permet aux tags de passer à la ligne suivante s'il n'y a pas assez d'espace horizontal.
            spacing: helpers.responsivePadding(context, 2.0), // Espacement horizontal entre les tags.
            runSpacing: helpers.responsivePadding(context, 5.0), // Espacement vertical entre les lignes de tags.
            children: [
              /// Affiche le tag de la date.
              _buildTimeTag(context, 'Date: ${DateFormat('dd/MM/yyyy').format(displayTime)}', Colors.red.shade600),
              /// Affiche le tag de l'heure de début ou de fin selon le type de carte.
              _buildTimeTag(context, type == TimeCardType.debut ? 'H.D: ${DateFormat('HH:mm').format(displayTime)}' : 'H.F: ${DateFormat('HH:mm').format(displayTime)}', Colors.red.shade600),
            ],
          ),
          SizedBox(height: helpers.responsivePadding(context, 5.0)), // Espace vertical.
          Row(
            mainAxisAlignment: MainAxisAlignment.end, // Aligne la durée à droite.
            children: [
              Icon(Icons.watch_later_outlined, size: helpers.responsiveIconSize(context, 15.0)), // Icône de montre.
              Flexible( // Permet au texte de la durée de s'adapter.
                child: Text(
                  key: const Key('calculatedDurationText'), // Clé pour les tests.
                  " ${helpers.formatDuration(calculatedDuration)}", // Formate et affiche la durée.
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: helpers.responsiveFontSize(context, 11.0),
                                fontWeight: FontWeight.bold,
                                /// La couleur de la durée est verte si négative et rouge si positive.
                                color: calculatedDuration.isNegative ? Colors.green : Colors.red,
                              ),
                  overflow: TextOverflow.ellipsis, // Tronque si trop long.
                  maxLines: 1, // Limite à une ligne.
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      /// Disposition en mode paysage.
      return Row(
        children: [
          _buildTimeTag(context, 'Date: ${DateFormat('dd/MM/yyyy').format(displayTime)}', Colors.red.shade600), // Tag de la date.
          SizedBox(width: helpers.responsivePadding(context, 3.0)), // Espace horizontal.
          _buildTimeTag(context, type == TimeCardType.debut ? 'H.D: ${DateFormat('HH:mm').format(displayTime)}' : 'H.F: ${DateFormat('HH:mm').format(displayTime)}', Colors.red.shade600), // Tag de l'heure.
          const Spacer(), // Prend tout l'espace disponible entre les tags d'heure et la durée.
          Expanded( // Permet à la durée de prendre l'espace restant.
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, // Aligne la durée à droite.
              children: [
                Icon(Icons.watch_later_outlined, size: helpers.responsiveIconSize(context, 15.0)), // Icône de montre.
                Flexible(child: Text(" ${helpers.formatDuration(calculatedDuration)}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: helpers.responsiveFontSize(context, 11.0), fontWeight: FontWeight.bold, color: calculatedDuration.isNegative ? Colors.green : Colors.red), overflow: TextOverflow.ellipsis, maxLines: 1)), // Texte de la durée.
              ],
            ),
          ),
        ],
      );
    }
  }

  /// Méthode d'aide privée pour créer un "tag" de temps stylisé.
  ///
  /// Il s'agit d'un petit conteneur avec du texte [text] et une couleur de fond [color].
  /// Le texte est ajusté pour s'adapter à l'espace disponible.
  ///
  /// [context]: Le [BuildContext] pour accéder au thème et aux fonctions d'aide.
  /// [text]: Le texte à afficher dans le tag.
  /// [color]: La couleur de fond du tag.
  ///
  /// Retourne un [Widget] de type [Container] stylisé.
  Widget _buildTimeTag(BuildContext context, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: helpers.responsivePadding(context, 3.0), vertical: helpers.responsivePadding(context, 2.0)), // Rembourrage interne du conteneur.
      decoration: BoxDecoration(
        color: color, // Couleur de fond du tag.
        borderRadius: BorderRadius.circular(helpers.responsivePadding(context, 3.0)), // Bords arrondis.
      ),
      child: FittedBox( // Ajuste la taille de son enfant (le texte) pour qu'il tienne dans l'espace disponible.
        fit: BoxFit.scaleDown, // Réduit la taille si nécessaire, mais ne l'agrandit pas.
        child: Text(
          text, // Le texte à afficher dans le tag.
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white, fontSize: helpers.responsiveFontSize(context, 10.0)), // Style du texte (blanc, petite taille responsive).
          maxLines: 1, // Limite le texte à une seule ligne.
        ),
      ),
    );
  }

  /// Méthode d'aide privée pour construire la section affichant les informations
  /// de localisation du client et du service.
  ///
  /// Son contenu varie si le [type] est [TimeCardType.result].
  /// La disposition s'adapte à l'orientation de l'écran.
  ///
  /// [context]: Le [BuildContext] pour accéder au thème et aux médias.
  ///
  /// Retourne un [Widget] représentant la section de localisation.
  Widget _buildLocation(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation; // Récupère l'orientation de l'écran.

    /// Disposition en mode portrait.
    if (orientation == Orientation.portrait) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligne les enfants au début.
        children: [
          /// Ces informations (code et libellé de localisation de l'employé) ne sont pas
          /// affichées pour le type [TimeCardType.result].
          if (type != TimeCardType.result) ...[
            SizedBox(
              width: double.infinity, // Prend toute la largeur.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Aligne le contenu au début.
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, size: helpers.responsiveIconSize(context, 15.0), color: Colors.grey), // Icône de personne.
                      SizedBox(width: helpers.responsivePadding(context, 3.0)), // Espace.
                      Flexible(child: Text(service.locationCode, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1)), // Code de localisation.
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Aligne le contenu au début.
                    children: [
                      Text(service.locationLib, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1), // Libellé de localisation.
                      /// Ces lignes représentent les informations du client (code et libellé du service client),
                      /// et elles sont toujours affichées, même pour le type [TimeCardType.result] en mode portrait.
                      Row(children: [Icon(Icons.location_city, size: helpers.responsiveIconSize(context, 15.0), color: Colors.grey), SizedBox(width: helpers.responsivePadding(context, 3.0)), Flexible(child: Text("BM-SECU-CL1 | Client", style: TextStyle(fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1))]),
                      Text("Sécurité BMSoft n°1", style: TextStyle(fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: helpers.responsivePadding(context, 8.0)), // Espace vertical.
          ],
        ],
      );
    } else {
      /// Mode Paysage.
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligne les éléments au début de la ligne.
        children: [
          /// Ces informations (code et libellé de localisation de l'employé) ne sont pas
          /// affichées pour le type [TimeCardType.result].
          if (type != TimeCardType.result) ...[
            Expanded( // Prend l'espace disponible.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Aligne le contenu au début.
                children: [
                  Row(children: [Icon(Icons.person, size: helpers.responsiveIconSize(context, 15.0), color: Colors.grey), SizedBox(width: helpers.responsivePadding(context, 3.0)), Flexible(child: Text(service.locationCode, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1))]), // Code de localisation.
                  Text(service.locationLib, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1), // Libellé de localisation.
                  Text(service.clientLocationLine3, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1), // Ligne 3 de l'adresse client.
                ],
              ),
            ),
            SizedBox(width: helpers.responsivePadding(context, 8.0)), // Espace entre les colonnes en mode paysage.
            /// Cette section contient les informations du client (code et libellé du service client).
            Expanded( // L'Expanded permet à cette section de prendre l'espace disponible.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Aligne le contenu au début.
              children: [
                Row(children: [Icon(Icons.location_city, size: helpers.responsiveIconSize(context, 15.0), color: Colors.grey), SizedBox(width: helpers.responsivePadding(context, 3.0)), Flexible(child: Text("BM-SECU-CL1 | Client", style: TextStyle(fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1))]), // Code et libellé du service client.
                Text("Sécurité BMSoft n°1", style: TextStyle(fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1), // Nom du client.
              ],
            ),
            ),
          ],
        ],
      );
    }
  }

  /// Méthode d'aide privée pour construire la section des boutons d'action.
  ///
  /// La disposition des boutons s'adapte à l'orientation de l'écran.
  /// Les boutons sont : "Modifier", "Absent/Présent", et "Valider/Dévalider".
  /// Leur visibilité et leur comportement dépendent du [type] de carte et de l'état du [service].
  ///
  /// [context]: Le [BuildContext] pour accéder aux médias et afficher des dialogues.
  ///
  /// Retourne un [Widget] contenant les boutons d'action.
  Widget _buildActionButtons(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation; // Récupère l'orientation.

    /// Disposition en mode portrait (boutons empilés verticalement).
    if (orientation == Orientation.portrait) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Étire les boutons pour qu'ils prennent toute la largeur disponible.
        children: [
          /// Bouton "Modifier" : affiché uniquement si le type de carte n'est PAS [TimeCardType.result].
          if (type != TimeCardType.result) ...[
            ElevatedButton.icon(
              key: const Key('modifyTimeButtonPortrait'), // Clé pour les tests.
              /// Le bouton est activé si le callback [onModifyTime] est fourni.
              onPressed: onModifyTime != null
                  ? () async {
                      /// Détermine l'heure initiale à modifier (début ou fin du service).
                      final initialTime = type == TimeCardType.debut ? service.startTime : service.endTime;
                      /// Ouvre un sélecteur d'heure ([showTimePicker]).
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(initialTime), // Initialise le sélecteur avec l'heure actuelle du service.
                      );
                      /// Si une nouvelle heure a été sélectionnée.
                      if (pickedTime != null) {
                        /// Crée un nouveau [DateTime] en combinant la date originale et l'heure sélectionnée.
                        final newDateTime = DateTime(
                          initialTime.year,
                          initialTime.month,
                          initialTime.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                        onModifyTime!(newDateTime); // Appelle le callback avec la nouvelle heure.
                      }
                    }
                  : null, // Si [onModifyTime] est nul, le bouton est désactivé.
              icon: Icon(Icons.edit, size: helpers.responsiveIconSize(context, 16.0)), // Icône d'édition.
              label: FittedBox( // Ajuste la taille du texte si nécessaire.
                fit: BoxFit.scaleDown,
                child: Text('Modifier', style: TextStyle(fontSize: helpers.responsiveFontSize(context, 10.0))), // Texte du bouton avec taille responsive.
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600, // Couleur de fond bleue.
                foregroundColor: Colors.white, // Couleur du texte et de l'icône en blanc.
                padding: EdgeInsets.symmetric(horizontal: helpers.responsivePadding(context, 3.0), vertical: helpers.responsivePadding(context, 4.0)), // Rembourrage.
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(helpers.responsivePadding(context, 4.0))), // Bords arrondis.
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Réduit la zone interactive du bouton pour qu'elle corresponde à son contenu.
              ),
            ),
            SizedBox(height: helpers.responsivePadding(context, 5.0)), // Espace vertical.
          ],

          /// Bouton "Absent/Présent" : toujours visible, mais son comportement et sa couleur
          /// dépendent du statut d'absence du [service].
          ElevatedButton(
            key: const Key('absentButtonPortrait'), // Clé pour les tests.
            /// Le callback [onAbsentPressed] est toujours appelé si non nul,
            /// indépendamment du type de carte.
            onPressed: onAbsentPressed != null ? () => onAbsentPressed!(!service.isAbsent) : null, // Inverse le statut [isAbsent].
            style: ElevatedButton.styleFrom(
              /// La couleur de fond est rouge si le service est "Absent", sinon gris-bleu.
              backgroundColor: service.isAbsent ? Colors.red.shade700 : Colors.blueGrey.shade600,
              foregroundColor: Colors.white, // Couleur du texte en blanc.
              padding: EdgeInsets.symmetric(horizontal: helpers.responsivePadding(context, 3.0), vertical: helpers.responsivePadding(context, 4.0)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(helpers.responsivePadding(context, 4.0))),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: FittedBox( // Ajuste la taille du texte si nécessaire.
              fit: BoxFit.scaleDown,
              child: Text(
                service.isAbsent ? 'Absent' : 'Absent', // Le texte est toujours 'Absent', comme demandé.
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: helpers.responsiveFontSize(context, 10.0)),
              ),
            ),
          ),
          SizedBox(height: helpers.responsivePadding(context, 5.0)), // Espace vertical.

          /// Bouton "Valider/Dévalider" : son activation et son texte dépendent du statut
          /// de validation et d'absence du [service].
          ElevatedButton.icon(
            key: const Key('validateButtonPortrait'), // Clé pour les tests.
            /// Le callback [onValidate] est appelé si non nul ET si le service n'est PAS absent.
            onPressed: onValidate != null && !service.isAbsent ? () => onValidate!(!service.isValidated) : null, // Inverse le statut [isValidated].
            icon: Icon(service.isValidated ? Icons.undo : Icons.check, size: helpers.responsiveIconSize(context, 16.0)), // Icône 'undo' si validé, 'check' si non validé.
            label: FittedBox( // Ajuste la taille du texte si nécessaire.
              fit: BoxFit.scaleDown,
              child: Text(
                service.isValidated ? 'Dévalider' : 'Valider', // Texte 'Dévalider' si validé, 'Valider' sinon.
                key: ValueKey('validateButtonText_${service.isValidated ? "devalider" : "valider"}'), // Clé dynamique pour les tests.
                style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: helpers.responsiveFontSize(context, 10.0)),
              ),
            ),
            style: ElevatedButton.styleFrom(
              /// La couleur de fond dépend de [isValidated] et [isAbsent].
              /// Gris si absent, orange si validé, vert si non validé.
              backgroundColor: service.isAbsent ? Colors.grey.shade400 : (service.isValidated ? Colors.orange.shade600 : Colors.green.shade600),
              foregroundColor: Colors.white, // Couleur du texte en blanc.
              padding: EdgeInsets.symmetric(horizontal: helpers.responsivePadding(context, 3.0), vertical: helpers.responsivePadding(context, 4.0)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(helpers.responsivePadding(context, 4.0))),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      );
    } else {
      /// Disposition pour le mode paysage (boutons alignés horizontalement).
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribue l'espace entre les boutons.
        children: [
          /// Bouton "Modifier" : affiché uniquement si le type de carte n'est PAS [TimeCardType.result].
          if (type != TimeCardType.result)
            Expanded( // Le bouton prend l'espace disponible.
              child: ElevatedButton.icon(
                onPressed: onModifyTime != null ? () => onModifyTime!(type == TimeCardType.debut ? service.startTime : service.endTime) : null, // Active si callback fourni.
                icon: Icon(Icons.edit, size: helpers.responsiveIconSize(context, 16.0)),
                label: FittedBox(fit: BoxFit.scaleDown, child: Text('Modifier', style: TextStyle(fontSize: helpers.responsiveFontSize(context, 10.0)))),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade600, foregroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: helpers.responsivePadding(context, 3.0), vertical: helpers.responsivePadding(context, 4.0)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(helpers.responsivePadding(context, 4.0))), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              ),
            ),
          if (type != TimeCardType.result) SizedBox(width: helpers.responsivePadding(context, 3.0)), // Espace entre les boutons.

          /// Bouton "Absent/Présent" : toujours présent.
          Expanded( // Prend l'espace disponible.
            child: ElevatedButton(
              onPressed: onAbsentPressed != null ? () => onAbsentPressed!(!service.isAbsent) : null, // Active si callback fourni.
              style: ElevatedButton.styleFrom(backgroundColor: service.isAbsent ? Colors.red.shade700 : Colors.blueGrey.shade600, foregroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: helpers.responsivePadding(context, 3.0), vertical: helpers.responsivePadding(context, 4.0)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(helpers.responsivePadding(context, 4.0))), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: FittedBox(fit: BoxFit.scaleDown, child: Text(service.isAbsent ? 'Absent' : 'Absent', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: helpers.responsiveFontSize(context, 10.0)))), // Texte toujours 'Absent'.
            ),
          ),
          SizedBox(width: helpers.responsivePadding(context, 3.0)), // Espace entre les boutons.

          /// Bouton "Valider/Dévalider" : toujours présent, activé si pas absent.
          Expanded( // Prend l'espace disponible.
            child: ElevatedButton.icon(
              onPressed: onValidate != null && !service.isAbsent ? () => onValidate!(!service.isValidated) : null, // Active si callback fourni et pas absent.
              icon: Icon(service.isValidated ? Icons.undo : Icons.check, size: helpers.responsiveIconSize(context, 16.0)),
              label: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  service.isValidated ? 'Dévalider' : 'Valider', // Texte dynamique.
                  key: ValueKey('validateButtonText_${service.isValidated ? "devalider" : "valider"}'), // Clé dynamique.
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: helpers.responsiveFontSize(context, 10.0)),
                ),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: service.isAbsent ? Colors.grey.shade400 : (service.isValidated ? Colors.orange.shade600 : Colors.green.shade600), foregroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: helpers.responsivePadding(context, 3.0), vertical: helpers.responsivePadding(context, 4.0)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(helpers.responsivePadding(context, 4.0))), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            ),
          ),
        ],
      );
    }
  }

  /// Décrit la partie de l'interface utilisateur représentée par ce widget.
  ///
  /// La méthode [build] construit l'interface de la carte de détail du temps,
  /// organisant les différentes sections ([_buildHeader], [_buildTimeAndDuration],
  /// [_buildLocation], [_buildActionButtons]) en fonction du [type] de carte
  /// et de l'orientation de l'écran.
  ///
  /// [context]: Le [BuildContext] pour construire le widget.
  ///
  /// Retourne un [Widget] représentant la carte de détail du temps.
  @override
  Widget build(BuildContext context) {
    /// Détermine la date et l'heure à afficher sur la carte (heure de début ou de fin du service).
    final DateTime displayTime = type == TimeCardType.debut ? service.startTime : service.endTime;
    Duration calculatedDuration; // Variable pour stocker la durée calculée.

    /// Calcule la durée en fonction du type de carte :
    if (type == TimeCardType.result) {
      /// Pour le type 'result', calcule la durée totale du service.
      calculatedDuration = service.endTime.difference(service.startTime);
    } else if (type == TimeCardType.debut) {
      /// Pour le type 'debut', calcule la durée écoulée depuis le début du service jusqu'à maintenant.
      calculatedDuration = DateTime.now().difference(service.startTime);
    } else {
      /// Pour le type 'fin', calcule la durée écoulée depuis la fin du service jusqu'à maintenant.
      /// C'est le cas par défaut si le type n'est ni 'result' ni 'debut'.
      calculatedDuration = DateTime.now().difference(service.endTime);
    }

    /// Le widget principal est un [GestureDetector] pour permettre la détection des taps sur la carte.
    return GestureDetector(
      onTap: onTap, // Appelle le callback [onTap] si la carte est tapée.
      child: Card( // La carte elle-même, avec un style Material Design.
        color: service.isAbsent ? Colors.red.shade100 : null, // La couleur de fond de la carte est rouge clair si le service est absent.
        margin: EdgeInsets.symmetric(horizontal: helpers.responsivePadding(context, 5.0), vertical: helpers.responsivePadding(context, 7.0)), // Marge autour de la carte avec espacements responsives.
        elevation: 2.0, // Ombre légère sous la carte pour un effet de profondeur.
        shape: RoundedRectangleBorder( // Forme de la carte avec bords arrondis et une bordure.
          borderRadius: BorderRadius.circular(helpers.responsivePadding(context, 5.0)), // Rayon des bords arrondis.
          side: BorderSide(color: Colors.grey.shade200, width: 1.0), // Bordure fine et grise.
        ),
        child: Padding( // Rembourrage interne pour le contenu de la carte.
          padding: EdgeInsets.all(helpers.responsivePadding(context, 8.0)), // Rembourrage uniforme avec espacement responsif.
          child: Column( // Les éléments internes de la carte sont organisés en colonne.
            crossAxisAlignment: CrossAxisAlignment.start, // Aligne les éléments au début (à gauche) de la colonne.
            mainAxisSize: MainAxisSize.min, // La colonne prend la taille minimale nécessaire à ses enfants.
            children: [
              _buildHeader(context), // Affiche la section de l'en-tête (nom de l'employé, code, téléphone).
              SizedBox(height: helpers.responsivePadding(context, 5.0)), // Espacement vertical.

              /// La section suivante change en fonction du type de carte.
              if (type == TimeCardType.result) ...[
                /// Si le type est 'result', affiche UNIQUEMENT la section de localisation filtrée (infos client).
                _buildLocation(context), // Appel de la méthode qui affichera la localisation client.
                SizedBox(height: helpers.responsivePadding(context, 7.0)), // Espacement vertical.
              ] else ...[
                /// Si le type est 'debut' ou 'fin', affiche la section temps/durée, puis la localisation complète.
                _buildTimeAndDuration(context, displayTime, calculatedDuration), // Affiche la date, l'heure et la durée.
                SizedBox(height: helpers.responsivePadding(context, 5.0)), // Espacement vertical.
                _buildLocation(context), // Affiche la section de localisation complète (employé et client).
                SizedBox(height: helpers.responsivePadding(context, 7.0)), // Espacement vertical.
              ],

              _buildActionButtons(context), // Affiche toujours la section des boutons d'action (Modifier, Absent, Valider).
            ],
          ),
        ),
      ),
    );
  }
}