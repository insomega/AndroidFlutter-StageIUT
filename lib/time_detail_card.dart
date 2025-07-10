// lib/time_detail_card.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mon_projet/models/service.dart'; // Importation mise à jour pour la classe Service

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Code service de l'employé
              Text(
                service.employeeSvrCode,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              // Nom de l'employé
              Text(
                service.employeeName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 91, 168, 231), // Couleur d'origine
                    ),
              ),
            ],
          ),
        ),
        // Numéro de téléphone de l'employé, visible sauf pour le type 'result'
        if (type != TimeCardType.result)
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.phone, size: 16),
                const SizedBox(width: 4),
                Text(
                  "0${service.employeeTelPort}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
      ],
    );
  }

  // Méthode d'aide pour construire la ligne de date, heure et durée
  Widget _buildTimeAndDuration(BuildContext context, DateTime displayTime, Duration calculatedDuration) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Tag de la date
        _buildTimeTag(
          context,
          'Date: ${DateFormat('dd/MM/yyyy').format(displayTime)}',
          Colors.red.shade600, // Couleur d'origine
        ),
        // Tag de l'heure (début ou fin)
        Spacer(),
        _buildTimeTag(
          context,
          type == TimeCardType.debut
              ? 'H.D: ${DateFormat('HH:mm').format(displayTime)}'
              : 'H.F: ${DateFormat('HH:mm').format(displayTime)}',
          Colors.red.shade600, // Couleur d'origine
        ),
        // Affichage de la durée calculée avec la couleur d'origine
        Spacer(),
        Icon(Icons.watch_later_outlined, size: 16, color: calculatedDuration.isNegative ? Colors.green : Colors.red),
        Text(" ${_formatDuration(calculatedDuration)}",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12, // Taille de police d'origine
                fontWeight: FontWeight.bold,
                color: calculatedDuration.isNegative ? Colors.green : Colors.red, // Logique de couleur d'origine
              ),
        ),
      ],
    );
  }

  // Méthode d'aide pour créer les tags de date/heure stylisés
  Widget _buildTimeTag(BuildContext context, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
      ),
    );
  }

  // Méthode d'aide pour construire les lignes de localisation du client
  Widget _buildLocation(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Colonne gauche : infos du service
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    service.locationCode,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800]),
                  ),
                ],
              ),
              Text(
                service.locationLib,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800]),
              ),
              Text(
                service.clientLocationLine3,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[800]),
              ),
            ],
          ),
        ),

        // Colonne droite : texte client fixe
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Row(
                children: [
                  Icon(Icons.location_city, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text("BM-SECU-CL1 | Client"),
                ],
              ),
              Text("Sécurité BMSoft n°1"),
            ],
          ),
        ),
      ],
    );
  }

  // Méthode d'aide pour construire les boutons d'action (Modifier, Absent/Présent, Valider/Dévalider) 
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Bouton "Modifier", visible sauf pour le type 'result'
        if (type != TimeCardType.result)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onModifyTime != null ? () => onModifyTime!(type == TimeCardType.debut ? service.startTime : service.endTime) : null,
              icon: const Icon(Icons.edit, size: 18),
              label: const Text('Modifier', style: TextStyle(fontSize: 12)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600, // Couleur d'origine
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
            ),
          ),
        if (type != TimeCardType.result) const SizedBox(width: 8),

        // Bouton "Présent/Absent"
        Expanded(
          child: ElevatedButton(
            onPressed: onAbsentPressed != null ? () => onAbsentPressed!(!service.isAbsent) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: service.isAbsent
                  ? Colors.red.shade700 // Couleur d'origine
                  : Colors.blueGrey.shade600, // Couleur d'origine
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: Text(
              service.isAbsent ? 'Absent' : 'Présent',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Bouton "Valider/Dévalider"
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onValidate != null && !service.isAbsent ? () => onValidate!(!service.isValidated) : null,
            icon: Icon(service.isValidated ? Icons.undo : Icons.check, size: 18),
            label: Text(
              service.isValidated ? 'Dévalider' : 'Valider',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: service.isAbsent
                  ? Colors.grey.shade400 // Couleur d'origine (désactivé si absent)
                  : (service.isValidated ? Colors.orange.shade600 : Colors.green.shade600), // Couleurs d'origine
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime displayTime = type == TimeCardType.debut ? service.startTime : service.endTime;

    // Calcul de la durée dynamique
    Duration calculatedDuration;
    if (type == TimeCardType.debut) {
      // Pour les cartes "Début", calculer la durée depuis l'heure de début jusqu'à l'heure actuelle
      calculatedDuration = DateTime.now().difference(service.startTime);
    } else {
      // Pour les cartes "Fin", calculer la durée depuis l'heure de fin jusqu'à l'heure actuelle
      calculatedDuration = DateTime.now().difference(service.endTime);
    }

    return GestureDetector(
      onTap: onTap,
      child: Card(
        // Couleur de la carte si le service est absent (rouge clair)
        color: service.isAbsent ? Colors.red.shade100 : null, // Couleur d'origine
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.grey.shade200, width: 1.0), // Couleur d'origine
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(context),
              const SizedBox(height: 8),
              // Les détails de temps et de localisation ne sont pas affichés pour le type 'result'
              if (type != TimeCardType.result) ...[
                _buildTimeAndDuration(context, displayTime, calculatedDuration),
                const SizedBox(height: 8),
                _buildLocation(context),
                const SizedBox(height: 12),
              ],
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }
}
