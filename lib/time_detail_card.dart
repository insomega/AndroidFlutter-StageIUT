// lib/time_detail_card.dart (All buttons clickable, Validate/Unvalidate toggle)

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mon_projet/models/service.dart';

enum TimeCardType { debut, fin }

class TimeDetailCard extends StatelessWidget {
  final Service service;
  final TimeCardType type;
  // Les callbacks ne sont plus nullables ici, ils doivent toujours être fournis par le parent
  // Le parent fournira une fonction vide si l'action n'est pas pertinente pour la colonne.
  final Function(bool newAbsentStatus) onAbsentPressed;
  final Function(bool newValidateStatus) onValidate; // Change pour un booléen pour le toggle
  final Function(DateTime currentTime) onModifyTime;

  const TimeDetailCard({
    super.key,
    required this.service,
    required this.type,
    required this.onAbsentPressed, // Rendu obligatoire
    required this.onValidate,     // Rendu obligatoire
    required this.onModifyTime,   // Rendu obligatoire
  });

  String _formatDuration(Duration duration) {
    String sign = '';
    if (duration.isNegative) {
      sign = '-';
      duration = -duration;
    } else {
      sign = '+';
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

    Duration calculatedDuration;
    if (isDebut) {
      calculatedDuration = DateTime.now().difference(service.startTime);
    } else {
      calculatedDuration = DateTime.now().difference(service.endTime);
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
                      if (isDebut)
                        Text(
                          service.employeeDetails,
                          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        )
                      else
                        Text(
                          service.clientInfo,
                          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
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

            // Les 3 boutons sont toujours présents et cliquables
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Bouton "Modifier"
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => onModifyTime(displayTime), // Toujours cliquable
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
                    onPressed: () => onAbsentPressed(!service.isAbsent), // Toujours cliquable
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

                // Bouton "Valider" / "Dévalider"
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => onValidate(!service.isValidated), // Toujours cliquable, passe le nouvel état
                    icon: Icon(service.isValidated ? Icons.undo : Icons.check, size: 18), // Icône change
                    label: Text(
                      service.isValidated ? 'Dévalider' : 'Valider', // Texte change
                      style: const TextStyle(fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: service.isValidated ? Colors.orange.shade600 : Colors.green.shade600, // Couleur change
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
