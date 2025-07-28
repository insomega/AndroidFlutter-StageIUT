// lib/time_detail_card.dart

import 'package:flutter/material.dart'; // Importe le package Flutter pour la création d'interfaces utilisateur.
import 'package:intl/intl.dart'; // Importe le package intl pour la mise en forme des dates et heures.
import 'package:mon_projet/models/service.dart'; // Importation de la classe Service, représentant les données d'un service.
import 'package:mon_projet/utils/time_card_helpers.dart' as helpers; // Importe les fonctions d'aide pour les tailles responsives et le formatage, en les aliasant "helpers".

// Enumération définissant les types de cartes horaires possibles.
enum TimeCardType {
  debut, // Représente une carte pour l'heure de début d'un service.
  fin, // Représente une carte pour l'heure de fin d'un service.
  result // Représente une carte affichant le résultat ou un résumé.
}

// `TimeDetailCard` est un widget StatelessWidget qui affiche les détails d'un service.
// Il est adaptable en fonction du type de carte (début, fin, ou résultat) et de l'orientation de l'écran.
class TimeDetailCard extends StatelessWidget {
  final Service service; // L'objet Service dont les détails sont affichés.
  final TimeCardType type; // Le type de carte à afficher (début, fin, ou résultat).
  // Callbacks optionnels pour les actions de l'utilisateur. Ils sont nullables car pas toujours requis.
  final Function(bool newAbsentStatus)? onAbsentPressed; // Callback appelé lorsque le bouton "Absent" est pressé. Prend le nouveau statut d'absence.
  final Function(bool newValidateStatus)? onValidate; // Callback appelé lorsque le bouton "Valider/Dévalider" est pressé. Prend le nouveau statut de validation.
  final Function(DateTime currentTime)? onModifyTime; // Callback appelé lorsque le bouton "Modifier l'heure" est pressé. Prend l'heure actuelle de la carte.
  final VoidCallback? onTap; // Callback appelé lorsque la carte est tapée.

  // Constructeur de `TimeDetailCard`.
  const TimeDetailCard({
    super.key, // Clé du widget.
    required this.service, // Le service est obligatoire.
    required this.type, // Le type de carte est obligatoire.
    this.onAbsentPressed, // Callback optionnel pour le statut d'absence.
    this.onValidate, // Callback optionnel pour le statut de validation.
    this.onModifyTime, // Callback optionnel pour la modification de l'heure.
    this.onTap, // Callback optionnel pour le tap sur la carte.
  });

  // Méthode d'aide privée pour construire la section d'en-tête de la carte (ID, Nom de l'employé, Contact).
  // S'adapte à l'orientation portrait ou paysage.
  Widget _buildHeader(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation; // Obtient l'orientation actuelle de l'écran.

    if (orientation == Orientation.portrait) {
      // Layout pour le mode portrait (les éléments sont disposés en colonne).
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligne les éléments au début (à gauche).
        children: [
          // Section Nom de l'employé
          SizedBox(
            width: double.infinity, // Prend toute la largeur disponible.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Aligne le texte au début.
              children: [
                Text(
                  service.employeeSvrCode, // Code de service de l'employé.
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey, // Couleur du texte.
                      fontSize: helpers.responsiveFontSize(context, 10.0)), // Taille de police responsive.
                ),
                Text(
                  service.employeeName, // Nom de l'employé.
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold, // Texte en gras.
                        color: const Color.fromARGB(255, 91, 168, 231), // Couleur spécifique.
                        fontSize: helpers.responsiveFontSize(context, 14.0), // Taille de police responsive.
                      ),
                  overflow: TextOverflow.ellipsis, // Tronque le texte si trop long.
                  maxLines: 1, // Limite le texte à une seule ligne.
                ),
              ],
            ),
          ),
          // Ajoute un espace vertical si le type de carte n'est pas 'result'.
          if (type != TimeCardType.result) SizedBox(height: helpers.responsivePadding(context, 8.0)),

          // Section Numéro de téléphone de l'employé (visible si le type n'est pas 'result').
          if (type != TimeCardType.result)
            SizedBox(
              width: double.infinity, // Prend toute la largeur disponible.
              child: Row(
                // Garde l'icône et le texte sur la même ligne.
                mainAxisAlignment: MainAxisAlignment.end, // Aligne le contenu à droite.
                children: [
                  Icon(Icons.phone, size: helpers.responsiveIconSize(context, 15.0)), // Icône de téléphone responsive.
                  SizedBox(width: helpers.responsivePadding(context, 3.0)), // Espace horizontal.
                  Flexible(
                    // Permet au texte de s'adapter à l'espace disponible.
                    child: Text(
                      "0${service.employeeTelPort}", // Numéro de téléphone de l'employé.
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: helpers.responsiveFontSize(context, 11.0)),
                      overflow: TextOverflow.ellipsis, // Tronque le texte si trop long.
                      maxLines: 1, // Limite le texte à une seule ligne.
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    } else {
      // Layout pour le mode paysage (les éléments sont disposés en ligne).
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribue l'espace également entre les éléments.
        children: [
          Expanded(
            flex: 3, // Prend 3 parts de l'espace disponible.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Aligne les éléments au début.
              children: [
                Text(service.employeeSvrCode, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey, fontSize: helpers.responsiveFontSize(context, 10.0))),
                Text(service.employeeName, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 91, 168, 231), fontSize: helpers.responsiveFontSize(context, 14.0)), overflow: TextOverflow.ellipsis, maxLines: 1),
              ],
            ),
          ),
          // Section Numéro de téléphone si le type n'est pas 'result'.
          if (type != TimeCardType.result)
            Expanded(
              flex: 2, // Prend 2 parts de l'espace disponible.
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // Aligne le contenu à droite.
                children: [
                  Icon(Icons.phone, size: helpers.responsiveIconSize(context, 15.0)),
                  SizedBox(width: helpers.responsivePadding(context, 3.0)),
                  Flexible(child: Text("0${service.employeeTelPort}", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1)),
                ],
              ),
            ),
        ],
      );
    }
  }

  // Méthode d'aide privée pour construire la section de la carte affichant la date, l'heure et la durée.
  // S'adapte à l'orientation portrait ou paysage.
  Widget _buildTimeAndDuration(BuildContext context, DateTime displayTime, Duration calculatedDuration) {
    final orientation = MediaQuery.of(context).orientation; // Obtient l'orientation actuelle.

    if (orientation == Orientation.portrait) {
      // Layout pour le mode portrait (éléments en colonne).
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligne les éléments au début.
        children: [
          Row(
            // Les tags de temps restent en ligne s'il y a assez de place.
            children: [
              _buildTimeTag(context, 'Date: ${DateFormat('dd/MM/yyyy').format(displayTime)}', Colors.red.shade600), // Tag de la date.
              SizedBox(width: helpers.responsivePadding(context, 3.0)), // Espace entre les tags.
              _buildTimeTag(context, type == TimeCardType.debut ? 'H.D: ${DateFormat('HH:mm').format(displayTime)}' : 'H.F: ${DateFormat('HH:mm').format(displayTime)}', Colors.red.shade600), // Tag de l'heure de début ou de fin.
            ],
          ),
          SizedBox(height: helpers.responsivePadding(context, 5.0)), // Espace vertical.

          // Section Durée.
          Row(
            mainAxisAlignment: MainAxisAlignment.end, // Aligne l'icône et la durée à droite.
            children: [
              Icon(Icons.watch_later_outlined, size: helpers.responsiveIconSize(context, 15.0)), // Icône d'horloge.
              Flexible(
                child: Text(
                  " ${helpers.formatDuration(calculatedDuration)}", // Durée formatée.
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: helpers.responsiveFontSize(context, 11.0),
                        fontWeight: FontWeight.bold,
                        color: calculatedDuration.isNegative ? Colors.green : Colors.red, // Couleur de la durée (vert si négatif, rouge sinon).
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      // Layout original pour le mode paysage (éléments en ligne).
      return Row(
        children: [
          _buildTimeTag(context, 'Date: ${DateFormat('dd/MM/yyyy').format(displayTime)}', Colors.red.shade600),
          SizedBox(width: helpers.responsivePadding(context, 3.0)),
          _buildTimeTag(context, type == TimeCardType.debut ? 'H.D: ${DateFormat('HH:mm').format(displayTime)}' : 'H.F: ${DateFormat('HH:mm').format(displayTime)}', Colors.red.shade600),
          const Spacer(), // Prend tout l'espace restant pour pousser le prochain élément à droite.
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.watch_later_outlined, size: helpers.responsiveIconSize(context, 15.0)),
                Flexible(child: Text(" ${helpers.formatDuration(calculatedDuration)}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: helpers.responsiveFontSize(context, 11.0), fontWeight: FontWeight.bold, color: calculatedDuration.isNegative ? Colors.green : Colors.red), overflow: TextOverflow.ellipsis, maxLines: 1)),
              ],
            ),
          ),
        ],
      );
    }
  }

  // Méthode d'aide privée pour créer un "tag" stylisé pour afficher la date ou l'heure.
  Widget _buildTimeTag(BuildContext context, String text, Color color) {
    return Container(
      // Padding horizontal et vertical réactif.
      padding: EdgeInsets.symmetric(horizontal: helpers.responsivePadding(context, 3.0), vertical: helpers.responsivePadding(context, 2.0)),
      decoration: BoxDecoration(
        color: color, // Couleur de fond du tag.
        borderRadius: BorderRadius.circular(helpers.responsivePadding(context, 3.0)), // Bordures arrondies responsives.
      ),
      child: FittedBox(
        // S'adapte à la taille disponible en réduisant la police si nécessaire.
        fit: BoxFit.scaleDown,
        child: Text(
          text, // Le texte à afficher dans le tag.
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white, fontSize: helpers.responsiveFontSize(context, 10.0)), // Style du texte.
          maxLines: 1, // Limite le texte à une ligne.
        ),
      ),
    );
  }

  // Méthode d'aide privée pour construire la section de localisation du client.
  // S'adapte à l'orientation portrait ou paysage.
  Widget _buildLocation(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation; // Obtient l'orientation actuelle.

    if (orientation == Orientation.portrait) {
      // Layout pour le mode portrait (les sections de localisation sont en colonne).
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligne les éléments au début.
        children: [
          // Première section de localisation.
          SizedBox(
            width: double.infinity, // Prend toute la largeur.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: helpers.responsiveIconSize(context, 15.0), color: Colors.grey), // Icône de personne.
                    SizedBox(width: helpers.responsivePadding(context, 3.0)),
                    Flexible(child: Text(service.locationCode, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1)),
                  ],
                ),
                Column(
                  children: [
                    Text(service.locationLib, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1),
                    // Commentaire: La ligne suivante est commentée dans le code original, mais maintenue pour référence.
                    //Text(service.clientLocationLine3, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: helpers.responsivePadding(context, 8.0)), // Espace vertical entre les sections.

          // Deuxième section de localisation.
          SizedBox(
            width: double.infinity, // Prend toute la largeur.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_city, size: helpers.responsiveIconSize(context, 15.0), color: Colors.grey), // Icône de ville.
                    SizedBox(width: helpers.responsivePadding(context, 3.0)),
                    Flexible(child: Text("BM-SECU-CL1 | Client", style: TextStyle(fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1)),
                  ],
                ),
                Text("Sécurité BMSoft n°1", style: TextStyle(fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1),
              ],
            ),
          ),
        ],
      );
    } else {
      // Layout original pour le mode paysage (éléments en ligne).
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Icon(Icons.person, size: helpers.responsiveIconSize(context, 15.0), color: Colors.grey), SizedBox(width: helpers.responsivePadding(context, 3.0)), Flexible(child: Text(service.locationCode, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1))]),
                Text(service.locationLib, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1),
                Text(service.clientLocationLine3, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Icon(Icons.location_city, size: helpers.responsiveIconSize(context, 15.0), color: Colors.grey), SizedBox(width: helpers.responsivePadding(context, 3.0)), Flexible(child: Text("BM-SECU-CL1 | Client", style: TextStyle(fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1))]),
                Text("Sécurité BMSoft n°1", style: TextStyle(fontSize: helpers.responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1),
              ],
            ),
          ),
        ],
      );
    }
  }

  // Méthode d'aide privée pour construire les boutons d'action au bas de la carte (Modifier, Absent/Présent, Valider/Dévalider).
  // S'adapte à l'orientation portrait ou paysage.
  Widget _buildActionButtons(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation; // Obtient l'orientation actuelle.

    if (orientation == Orientation.portrait) {
      // Layout pour le mode portrait (boutons en colonne, pleine largeur).
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Étire les boutons pour prendre toute la largeur disponible.
        children: [
          // Bouton "Modifier" (si le type n'est pas 'result').
          if (type != TimeCardType.result) ...[
            ElevatedButton.icon(
              onPressed: onModifyTime != null ? () => onModifyTime!(type == TimeCardType.debut ? service.startTime : service.endTime) : null, // Active le bouton si le callback est fourni.
              icon: Icon(Icons.edit, size: helpers.responsiveIconSize(context, 16.0)), // Icône d'édition.
              label: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('Modifier', style: TextStyle(fontSize: helpers.responsiveFontSize(context, 10.0))),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600, // Couleur de fond du bouton.
                foregroundColor: Colors.white, // Couleur du texte et de l'icône.
                padding: EdgeInsets.symmetric(horizontal: helpers.responsivePadding(context, 3.0), vertical: helpers.responsivePadding(context, 4.0)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(helpers.responsivePadding(context, 4.0))),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Réduit la zone de tap pour le bouton.
              ),
            ),
            SizedBox(height: helpers.responsivePadding(context, 5.0)), // Espacement vertical.
          ],

          // Bouton "Absent/Présent".
          ElevatedButton(
            onPressed: onAbsentPressed != null ? () => onAbsentPressed!(!service.isAbsent) : null, // Active le bouton si le callback est fourni, inverse le statut d'absence.
            style: ElevatedButton.styleFrom(
              backgroundColor: service.isAbsent ? Colors.red.shade700 : Colors.blueGrey.shade600, // Couleur basée sur le statut d'absence.
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: helpers.responsivePadding(context, 3.0), vertical: helpers.responsivePadding(context, 4.0)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(helpers.responsivePadding(context, 4.0))),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              // Le texte du bouton est toujours "Absent" quel que soit le statut actuel. Ceci pourrait être une faute de frappe et devrait probablement basculer entre "Absent" et "Présent".
              child: Text(
                service.isAbsent ? 'Absent' : 'Absent',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: helpers.responsiveFontSize(context, 10.0)),
              ),
            ),
          ),
          SizedBox(height: helpers.responsivePadding(context, 5.0)), // Espacement vertical.

          // Bouton "Valider/Dévalider".
          ElevatedButton.icon(
            onPressed: onValidate != null && !service.isAbsent ? () => onValidate!(!service.isValidated) : null, // Active si le callback est fourni et si le service n'est pas absent.
            icon: Icon(service.isValidated ? Icons.undo : Icons.check, size: helpers.responsiveIconSize(context, 16.0)), // Icône changeante.
            label: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                service.isValidated ? 'Dévalider' : 'Valider', // Texte changeant.
                style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: helpers.responsiveFontSize(context, 10.0)),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: service.isAbsent ? Colors.grey.shade400 : (service.isValidated ? Colors.orange.shade600 : Colors.green.shade600), // Couleur basée sur le statut et l'absence.
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: helpers.responsivePadding(context, 3.0), vertical: helpers.responsivePadding(context, 4.0)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(helpers.responsivePadding(context, 4.0))),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      );
    } else {
      // Layout original pour le mode paysage (boutons en ligne).
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribue l'espace également.
        children: [
          // Bouton "Modifier" (si le type n'est pas 'result').
          if (type != TimeCardType.result)
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onModifyTime != null ? () => onModifyTime!(type == TimeCardType.debut ? service.startTime : service.endTime) : null,
                icon: Icon(Icons.edit, size: helpers.responsiveIconSize(context, 16.0)),
                label: FittedBox(fit: BoxFit.scaleDown, child: Text('Modifier', style: TextStyle(fontSize: helpers.responsiveFontSize(context, 10.0)))),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade600, foregroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: helpers.responsivePadding(context, 3.0), vertical: helpers.responsivePadding(context, 4.0)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(helpers.responsivePadding(context, 4.0))), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              ),
            ),
          if (type != TimeCardType.result) SizedBox(width: helpers.responsivePadding(context, 3.0)), // Espace.

          // Bouton "Absent/Présent".
          Expanded(
            child: ElevatedButton(
              onPressed: onAbsentPressed != null ? () => onAbsentPressed!(!service.isAbsent) : null,
              style: ElevatedButton.styleFrom(backgroundColor: service.isAbsent ? Colors.red.shade700 : Colors.blueGrey.shade600, foregroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: helpers.responsivePadding(context, 3.0), vertical: helpers.responsivePadding(context, 4.0)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(helpers.responsivePadding(context, 4.0))), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: FittedBox(fit: BoxFit.scaleDown, child: Text(service.isAbsent ? 'Absent' : 'Présent', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: helpers.responsiveFontSize(context, 10.0)))), // Le texte est ici 'Présent' quand !isAbsent.
            ),
          ),
          SizedBox(width: helpers.responsivePadding(context, 3.0)), // Espace.

          // Bouton "Valider/Dévalider".
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onValidate != null && !service.isAbsent ? () => onValidate!(!service.isValidated) : null,
              icon: Icon(service.isValidated ? Icons.undo : Icons.check, size: helpers.responsiveIconSize(context, 16.0)),
              label: FittedBox(fit: BoxFit.scaleDown, child: Text(service.isValidated ? 'Dévalider' : 'Valider', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: helpers.responsiveFontSize(context, 10.0)))),
              style: ElevatedButton.styleFrom(backgroundColor: service.isAbsent ? Colors.grey.shade400 : (service.isValidated ? Colors.orange.shade600 : Colors.green.shade600), foregroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: helpers.responsivePadding(context, 3.0), vertical: helpers.responsivePadding(context, 4.0)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(helpers.responsivePadding(context, 4.0))), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            ),
          ),
        ],
      );
    }
  }

  // La méthode `build` est appelée pour construire l'interface utilisateur de ce widget.
  @override
  Widget build(BuildContext context) {
    // Détermine l'heure à afficher en fonction du type de carte.
    final DateTime displayTime = type == TimeCardType.debut ? service.startTime : service.endTime;

    // Calcule la durée. Si c'est une carte de début, c'est la différence entre maintenant et l'heure de début.
    // Si c'est une carte de fin, c'est la différence entre maintenant et l'heure de fin.
    Duration calculatedDuration;
    if (type == TimeCardType.debut) {
      calculatedDuration = DateTime.now().difference(service.startTime);
    } else {
      calculatedDuration = DateTime.now().difference(service.endTime);
    }

    return GestureDetector(
      onTap: onTap, // Permet à la carte d'être tapable.
      child: Card(
        color: service.isAbsent ? Colors.red.shade100 : null, // Change la couleur de fond si l'employé est absent.
        margin: EdgeInsets.symmetric(horizontal: helpers.responsivePadding(context, 5.0), vertical: helpers.responsivePadding(context, 7.0)), // Marges responsives.
        elevation: 2.0, // Ombre de la carte.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(helpers.responsivePadding(context, 5.0)), // Rayon des bordures de la carte.
          side: BorderSide(color: Colors.grey.shade200, width: 1.0), // Bordure de la carte.
        ),
        child: Padding(
          padding: EdgeInsets.all(helpers.responsivePadding(context, 8.0)), // Padding interne de la carte.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Aligne le contenu de la colonne au début.
            mainAxisSize: MainAxisSize.min, // La colonne prend la taille minimale requise par ses enfants.
            children: [
              _buildHeader(context), // Construit l'en-tête de la carte.
              SizedBox(height: helpers.responsivePadding(context, 5.0)), // Espace vertical.
              // Affiche les sections de temps et de localisation si le type n'est pas 'result'.
              if (type != TimeCardType.result) ...[
                _buildTimeAndDuration(context, displayTime, calculatedDuration), // Construit la section temps et durée.
                SizedBox(height: helpers.responsivePadding(context, 5.0)), // Espace vertical.
                _buildLocation(context), // Construit la section de localisation.
                SizedBox(height: helpers.responsivePadding(context, 7.0)), // Espace vertical.
              ],
              _buildActionButtons(context), // Construit les boutons d'action.
            ],
          ),
        ),
      ),
    );
  }
}