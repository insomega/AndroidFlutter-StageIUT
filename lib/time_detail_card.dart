// lib/time_detail_card.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mon_projet/models/service.dart'; // Importation mise à jour pour la classe Service
import 'dart:math'; // Pour max

// Constantes pour le redimensionnement adaptatif (copie de prise_service_mobile.dart pour autonomie)
const double kReferenceScreenWidth = 1000.0; // Largeur d'écran de référence
const double kMinFontSize = 8.5;
const double kMinIconSize = 14.0;
const double kMinPadding = 4.0;

enum TimeCardType { debut, fin, result }

class TimeDetailCard extends StatelessWidget {
  final Service service;
  final TimeCardType type;
  // Rendu les callbacks nullables car ils ne sont pas toujours requis pour les deux types de cartes
  final Function(bool newAbsentStatus)? onAbsentPressed;
  final Function(bool newValidateStatus)? onValidate; // MODIFIÉ: Accepte un booléen
  final Function(DateTime currentTime)? onModifyTime; // Modifier pour les deux types
  final VoidCallback? onTap;

  const TimeDetailCard({
    super.key,
    required this.service,
    required this.type,
    this.onAbsentPressed,
    this.onValidate,
    this.onModifyTime,
    this.onTap,
  });

  // Fonctions d'aide pour le redimensionnement
  double _responsiveFontSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    return max(kMinFontSize, baseSize * (screenWidth / kReferenceScreenWidth));
  }

  double _responsiveIconSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    return max(kMinIconSize, baseSize * (screenWidth / kReferenceScreenWidth));
  }

  double _responsivePadding(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    return max(kMinPadding, baseSize * (screenWidth / kReferenceScreenWidth));
  }

  // Fonction utilitaire pour formater la durée (gère les négatifs)
  String _formatDuration(Duration duration) {
    String sign = '';
    if (duration.isNegative) {
      sign = '-'; // Ajoute un signe moins pour les durées négatives
      duration = -duration; // Rend la durée positive pour le calcul des heures/minutes
    } else {
      sign = '+'; // Ajoute un signe plus pour les durées positives
    }

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String hours = twoDigits(duration.inHours);
    final String minutes = twoDigits(duration.inMinutes.remainder(60));
    return '$sign${hours}h$minutes min';
  }




  // Méthode d'aide pour construire la ligne d'en-tête (ID, Nom, Contact)
  Widget _buildHeader(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      // Layout pour le mode portrait (tout en colonne)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligne à gauche
        children: [
          // Section Nom de l'employé
          SizedBox(
            width: double.infinity, // Prend toute la largeur disponible
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.employeeSvrCode,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                      fontSize: _responsiveFontSize(context, 10.0)),
                ),
                Text(
                  service.employeeName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 91, 168, 231),
                        fontSize: _responsiveFontSize(context, 14.0),
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          if (type != TimeCardType.result) SizedBox(height: _responsivePadding(context, 8.0)), // Espace entre les sections

          // Section Numéro de téléphone de l'employé (si non 'result')
          if (type != TimeCardType.result)
            SizedBox(
              width: double.infinity, // Prend toute la largeur disponible
              child: Row( // Garde Icon + Text sur la même ligne, mais la section est en colonne
                mainAxisAlignment: MainAxisAlignment.end, // Aligne le contenu à droite
                children: [
                  Icon(Icons.phone, size: _responsiveIconSize(context, 15.0)),
                  SizedBox(width: _responsivePadding(context, 3.0)),
                  Flexible(
                    child: Text(
                      "0${service.employeeTelPort}",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: _responsiveFontSize(context, 11.0)),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    } else {
      // Layout original pour le mode paysage
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service.employeeSvrCode, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey, fontSize: _responsiveFontSize(context, 10.0))),
                Text(service.employeeName, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 91, 168, 231), fontSize: _responsiveFontSize(context, 14.0)), overflow: TextOverflow.ellipsis, maxLines: 1),
              ],
            ),
          ),
          if (type != TimeCardType.result)
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.phone, size: _responsiveIconSize(context, 15.0)),
                  SizedBox(width: _responsivePadding(context, 3.0)),
                  Flexible(child: Text("0${service.employeeTelPort}", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: _responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1)),
                ],
              ),
            ),
        ],
      );
    }
  }

  // Méthode d'aide pour construire la ligne de date, heure et durée
  Widget _buildTimeAndDuration(BuildContext context, DateTime displayTime, Duration calculatedDuration) {
    final orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      // Layout pour le mode portrait (tout en colonne)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligne les éléments à gauche
        children: [
          Row( // Les tags restent en ligne s'il y a assez de place, sinon ils passeront à la ligne si Wrapped
            children: [
              _buildTimeTag(context, 'Date: ${DateFormat('dd/MM/yyyy').format(displayTime)}', Colors.red.shade600),
              SizedBox(width: _responsivePadding(context, 3.0)), // Espace entre les tags
              _buildTimeTag(context, type == TimeCardType.debut ? 'H.D: ${DateFormat('HH:mm').format(displayTime)}' : 'H.F: ${DateFormat('HH:mm').format(displayTime)}', Colors.red.shade600),
            ],
          ),
          SizedBox(height: _responsivePadding(context, 5.0)), // Espace vertical

          // Durée
          Row( // Reste en ligne pour l'icône et la durée
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.watch_later_outlined, size: _responsiveIconSize(context, 15.0)),
              Flexible(
                child: Text(
                  " ${_formatDuration(calculatedDuration)}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: _responsiveFontSize(context, 11.0),
                        fontWeight: FontWeight.bold,
                        color: calculatedDuration.isNegative ? Colors.green : Colors.red,
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
      // Layout original pour le mode paysage
      return Row(
        children: [
          _buildTimeTag(context, 'Date: ${DateFormat('dd/MM/yyyy').format(displayTime)}', Colors.red.shade600),
          SizedBox(width: _responsivePadding(context, 3.0)),
          _buildTimeTag(context, type == TimeCardType.debut ? 'H.D: ${DateFormat('HH:mm').format(displayTime)}' : 'H.F: ${DateFormat('HH:mm').format(displayTime)}', Colors.red.shade600),
          const Spacer(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.watch_later_outlined, size: _responsiveIconSize(context, 15.0)),
                Flexible(child: Text(" ${_formatDuration(calculatedDuration)}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: _responsiveFontSize(context, 11.0), fontWeight: FontWeight.bold, color: calculatedDuration.isNegative ? Colors.green : Colors.red), overflow: TextOverflow.ellipsis, maxLines: 1)),
              ],
            ),
          ),
        ],
      );
    }
  }

  // Méthode d'aide pour créer les tags de date/heure stylisés 
  Widget _buildTimeTag(BuildContext context, String text, Color color) {
    return Container(
      // Réduisez la base du padding horizontal si nécessaire
      padding: EdgeInsets.symmetric(horizontal: _responsivePadding(context, 3.0), vertical: _responsivePadding(context, 2.0)), // Base ajustée de 4.0 à 3.0
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(_responsivePadding(context, 3.0)),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white, fontSize: _responsiveFontSize(context, 10.0)),
          maxLines: 1,
        ),
      ),
    );
  }

  // Méthode d'aide pour construire les lignes de localisation du client
  Widget _buildLocation(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      // Layout pour le mode portrait (tout en colonne)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligne à gauche
        children: [
          // Première section de localisation
          SizedBox(
            width: double.infinity, // Prend toute la largeur disponible
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: _responsiveIconSize(context, 15.0), color: Colors.grey),
                    SizedBox(width: _responsivePadding(context, 3.0)),
                    Flexible(child: Text(service.locationCode, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: _responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1)),
                  ],
                ),
                Text(service.locationLib, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: _responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1),
                Text(service.clientLocationLine3, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: _responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1),
              ],
            ),
          ),
          SizedBox(height: _responsivePadding(context, 8.0)), // Espace vertical entre les sections

          // Deuxième section de localisation
          SizedBox(
            width: double.infinity, // Prend toute la largeur disponible
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_city, size: _responsiveIconSize(context, 15.0), color: Colors.grey),
                    SizedBox(width: _responsivePadding(context, 3.0)),
                    Flexible(child: Text("BM-SECU-CL1 | Client", style: TextStyle(fontSize: _responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1)),
                  ],
                ),
                Text("Sécurité BMSoft n°1", style: TextStyle(fontSize: _responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1),
              ],
            ),
          ),
        ],
      );
    } else {
      // Layout original pour le mode paysage
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Icon(Icons.person, size: _responsiveIconSize(context, 15.0), color: Colors.grey), SizedBox(width: _responsivePadding(context, 3.0)), Flexible(child: Text(service.locationCode, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: _responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1))]),
                Text(service.locationLib, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: _responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1),
                Text(service.clientLocationLine3, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800], fontSize: _responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Icon(Icons.location_city, size: _responsiveIconSize(context, 15.0), color: Colors.grey), SizedBox(width: _responsivePadding(context, 3.0)), Flexible(child: Text("BM-SECU-CL1 | Client", style: TextStyle(fontSize: _responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1))]),
                Text("Sécurité BMSoft n°1", style: TextStyle(fontSize: _responsiveFontSize(context, 11.0)), overflow: TextOverflow.ellipsis, maxLines: 1),
              ],
            ),
          ),
        ],
      );
    }
  }

  // Méthode d'aide pour construire les boutons d'action (Modifier, Absent/Présent, Valider/Dévalider)
  Widget _buildActionButtons(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      // Layout pour le mode portrait (boutons en colonne)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Rend les boutons pleins largeur
        children: [
          if (type != TimeCardType.result) ...[
            ElevatedButton.icon(
              onPressed: onModifyTime != null ? () => onModifyTime!(type == TimeCardType.debut ? service.startTime : service.endTime) : null,
              icon: Icon(Icons.edit, size: _responsiveIconSize(context, 16.0)),
              label: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('Modifier', style: TextStyle(fontSize: _responsiveFontSize(context, 10.0))),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: _responsivePadding(context, 3.0), vertical: _responsivePadding(context, 4.0)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_responsivePadding(context, 4.0))),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            SizedBox(height: _responsivePadding(context, 5.0)), // Espacement vertical
          ],

          ElevatedButton(
            onPressed: onAbsentPressed != null ? () => onAbsentPressed!(!service.isAbsent) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: service.isAbsent ? Colors.red.shade700 : Colors.blueGrey.shade600,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: _responsivePadding(context, 3.0), vertical: _responsivePadding(context, 4.0)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_responsivePadding(context, 4.0))),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                service.isAbsent ? 'Absent' : 'Présent',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: _responsiveFontSize(context, 10.0)),
              ),
            ),
          ),
          SizedBox(height: _responsivePadding(context, 5.0)), // Espacement vertical

          ElevatedButton.icon(
            onPressed: onValidate != null && !service.isAbsent ? () => onValidate!(!service.isValidated) : null,
            icon: Icon(service.isValidated ? Icons.undo : Icons.check, size: _responsiveIconSize(context, 16.0)),
            label: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                service.isValidated ? 'Dévalider' : 'Valider',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: _responsiveFontSize(context, 10.0)),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: service.isAbsent ? Colors.grey.shade400 : (service.isValidated ? Colors.orange.shade600 : Colors.green.shade600),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: _responsivePadding(context, 3.0), vertical: _responsivePadding(context, 4.0)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_responsivePadding(context, 4.0))),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      );
    } else {
      // Layout original pour le mode paysage
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (type != TimeCardType.result)
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onModifyTime != null ? () => onModifyTime!(type == TimeCardType.debut ? service.startTime : service.endTime) : null,
                icon: Icon(Icons.edit, size: _responsiveIconSize(context, 16.0)),
                label: FittedBox(fit: BoxFit.scaleDown, child: Text('Modifier', style: TextStyle(fontSize: _responsiveFontSize(context, 10.0)))),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade600, foregroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: _responsivePadding(context, 3.0), vertical: _responsivePadding(context, 4.0)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_responsivePadding(context, 4.0))), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              ),
            ),
          if (type != TimeCardType.result) SizedBox(width: _responsivePadding(context, 3.0)),

          Expanded(
            child: ElevatedButton(
              onPressed: onAbsentPressed != null ? () => onAbsentPressed!(!service.isAbsent) : null,
              style: ElevatedButton.styleFrom(backgroundColor: service.isAbsent ? Colors.red.shade700 : Colors.blueGrey.shade600, foregroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: _responsivePadding(context, 3.0), vertical: _responsivePadding(context, 4.0)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_responsivePadding(context, 4.0))), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: FittedBox(fit: BoxFit.scaleDown, child: Text(service.isAbsent ? 'Absent' : 'Présent', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: _responsiveFontSize(context, 10.0)))),
            ),
          ),
          SizedBox(width: _responsivePadding(context, 3.0)),

          Expanded(
            child: ElevatedButton.icon(
              onPressed: onValidate != null && !service.isAbsent ? () => onValidate!(!service.isValidated) : null,
              icon: Icon(service.isValidated ? Icons.undo : Icons.check, size: _responsiveIconSize(context, 16.0)),
              label: FittedBox(fit: BoxFit.scaleDown, child: Text(service.isValidated ? 'Dévalider' : 'Valider', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: _responsiveFontSize(context, 10.0)))),
              style: ElevatedButton.styleFrom(backgroundColor: service.isAbsent ? Colors.grey.shade400 : (service.isValidated ? Colors.orange.shade600 : Colors.green.shade600), foregroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: _responsivePadding(context, 3.0), vertical: _responsivePadding(context, 4.0)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_responsivePadding(context, 4.0))), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime displayTime = type == TimeCardType.debut ? service.startTime : service.endTime;

    Duration calculatedDuration;
    if (type == TimeCardType.debut) {
      calculatedDuration = DateTime.now().difference(service.startTime);
    } else {
      calculatedDuration = DateTime.now().difference(service.endTime);
    }

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: service.isAbsent ? Colors.red.shade100 : null,
        margin: EdgeInsets.symmetric(horizontal: _responsivePadding(context, 5.0), vertical: _responsivePadding(context, 7.0)), // Base 5.0, 7.0
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_responsivePadding(context, 5.0)), // Base 5.0
          side: BorderSide(color: Colors.grey.shade200, width: 1.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(_responsivePadding(context, 8.0)), // Base 8.0
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(context),
              SizedBox(height: _responsivePadding(context, 5.0)), // Base 5.0
              if (type != TimeCardType.result) ...[
                _buildTimeAndDuration(context, displayTime, calculatedDuration),
                SizedBox(height: _responsivePadding(context, 5.0)), // Base 5.0
                _buildLocation(context),
                SizedBox(height: _responsivePadding(context, 7.0)), // Base 7.0
              ],
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }
}