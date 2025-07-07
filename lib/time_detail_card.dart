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
      // Pour les cartes "Fin", calculer la durée depuis l'heure de fin jusqu'à l'heure actuelle
      calculatedDuration = DateTime.now().difference(service.endTime);
    }

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: service.isAbsent ? Colors.red.shade100 : null,
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
                          service.employeeName,
                          //isDebut ? service.employeeName : service.clientSvrLib, // Utilise clientSvrLib pour la colonne Fin
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color.fromARGB(255, 91, 168, 231)),
                        ),
                      ],
                    ),
                  ),
                  if (type != TimeCardType.result) ...[
                    Expanded(
                      flex: 2,
                      child: Text(
                        service.employeeTelPort,
                        //isDebut ? service.employeeTelPort : service.clientLocationLine3, // Utilise clientLocationLine3 pour la colonne Fin
                        textAlign: TextAlign.end,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),

              // Ligne 2: Date, Heure, Durée
              if (type != TimeCardType.result) ...[
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
                Text(service.locationCode, style: TextStyle(color: Colors.grey[800], fontSize: 12)),
                Text(service.locationLib, style: TextStyle(color: Colors.grey[800], fontSize: 12)),
                Text(service.clientLocationLine3, style: TextStyle(color: Colors.grey[800], fontSize: 12)),
                const SizedBox(height: 12),
              ],
              
              // Boutons d'action
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (type != TimeCardType.result) ...[
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onModifyTime != null ? () => onModifyTime!(displayTime) : null,
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
                  ],


                  // Bouton "Présent/Absent"
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onAbsentPressed != null ? () => onAbsentPressed!(!service.isAbsent) : null,
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
                      onPressed: onValidate != null && !service.isAbsent ? () => onValidate!(!service.isValidated) : null,
                      icon: Icon(service.isValidated ? Icons.undo : Icons.check, size: 18),
                      label: Text(
                        service.isValidated ? 'Dévalider' : 'Valider',
                        style: const TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: service.isAbsent
                            ? Colors.grey.shade400 // Couleur grise si absent et désactivé
                            : (service.isValidated ? Colors.orange.shade600 : Colors.green.shade600),
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
      ),
    );
  }
}
