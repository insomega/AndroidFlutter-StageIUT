// lib/time_detail_card.dart (Updated for dynamic duration color and 3 buttons)

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mon_projet/models/service.dart'; // Importation mise à jour pour la classe Service

enum TimeCardType { debut, fin }

class TimeDetailCard extends StatelessWidget {
  final Service service;
  final TimeCardType type;
  // Les callbacks sont toujours nullables car elles ne sont pas toujours fournies par le parent
  final Function(bool newAbsentStatus)? onAbsentPressed;
  final VoidCallback? onValidate;
  final Function(DateTime currentTime)? onModifyTime;

  const TimeDetailCard({
    super.key,
    required this.service,
    required this.type,
    this.onAbsentPressed,
    this.onValidate,
    this.onModifyTime,
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
    return '$sign${hours}h${minutes} min';
  }

  @override
  Widget build(BuildContext context) {
    final bool isDebut = type == TimeCardType.debut;
    final DateTime displayTime = isDebut ? service.startTime : service.endTime;

    // Calcul de la durée dynamique
    Duration calculatedDuration;
    if (isDebut) {
      // Pour les cartes "Début", calculer la durée depuis l'heure de début jusqu'à l'heure actuelle
      calculatedDuration = DateTime.now().difference(service.startTime);
    } else {
      // Pour les cartes "Fin", calculer la durée entre l'heure de début et l'heure de fin
      calculatedDuration = service.endTime.difference(service.startTime);
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade200, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ligne 1: ID, Nom Employé/Client, Contact
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(service.id, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      Text(
                        isDebut ? service.employeeName : service.clientName,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    isDebut ? service.employeeContact : service.clientInfo,
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Ligne 2: Date, Heure, Durée
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Date: ${DateFormat('dd/MM/yyyy').format(displayTime)}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isDebut ? 'H.D: ${DateFormat('HH:mm').format(displayTime)}' : 'H.F: ${DateFormat('HH:mm').format(displayTime)}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                // CHANGEMENT ICI : Couleur dynamique de la durée
                Text(
                  _formatDuration(calculatedDuration),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: calculatedDuration.isNegative ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Lignes de localisation client
            Text(service.clientLocationLine1, style: TextStyle(color: Colors.grey[800], fontSize: 12)),
            Text(service.clientLocationLine2, style: TextStyle(color: Colors.grey[800], fontSize: 12)),
            Text(service.clientLocationLine3, style: TextStyle(color: Colors.grey[800], fontSize: 12)),
            const SizedBox(height: 12),

            // CHANGEMENT ICI : Les 3 boutons sont toujours présents
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Bouton "Modifier"
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onModifyTime != null ? () => onModifyTime!(displayTime) : null, // Désactivé si onModifyTime est null
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Modifier', style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Bouton "Présent/Absent"
                Expanded(
                  child: ElevatedButton(
                    onPressed: onAbsentPressed != null ? () => onAbsentPressed!(!service.isAbsent) : null, // Désactivé si onAbsentPressed est null
                    style: ElevatedButton.styleFrom(
                      backgroundColor: service.isAbsent ? Colors.red.shade700 : Colors.blueGrey.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Text(
                      service.isAbsent ? 'Absent' : 'Présent',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Bouton "Valider"
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onValidate, // Désactivé si onValidate est null
                    icon: const Icon(Icons.check, size: 18),
                    label: const Text('Valider', style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
