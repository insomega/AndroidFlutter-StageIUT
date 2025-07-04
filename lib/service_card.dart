// // lib/service_card.dart

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// // import 'package:mon_projet/prise_service.dart';
// import 'package:mon_projet/models/service.dart';

// class ServiceCard extends StatefulWidget {
//   final Service service; // Passe l'objet Service complet
//   final Function(bool newAbsentStatus) onAbsentPressed; // Callback pour informer le parent
//   final VoidCallback onModify;
//   final VoidCallback onValidate;

//   const ServiceCard({
//     super.key,
//     required this.service,
//     required this.onAbsentPressed,
//     required this.onModify,
//     required this.onValidate,
//   });

//   @override
//   State<ServiceCard> createState() => _ServiceCardState();
// }

// class _ServiceCardState extends State<ServiceCard> {
//   @override
//   Widget build(BuildContext context) {
//     final service = widget.service;

//     return Card(
//       // Augmentation de la marge verticale pour mieux séparer les cartes
//       margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//       elevation: 3.0, // Légère augmentation de l'ombre pour plus de relief
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0), // Bords légèrement plus arrondis
//         side: BorderSide(color: Colors.grey.shade300, width: 1.0), // Ajout d'une bordure fine
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0), // Augmentation du padding interne
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start, // Aligne les contenus en haut
//           children: [
//             // Colonne "Début"
//             Expanded(
//               flex: 2,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(service.employeeName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                   //Text(service.vacationDetails, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
//                   const SizedBox(height: 8), // Plus d'espace
//                   Text('Date: ${DateFormat('dd/MM/yyyy').format(service.startTime)}', style: const TextStyle(fontSize: 13)),
//                   Text('HLD: ${DateFormat('HH:mm').format(service.startTime)}', style: const TextStyle(fontSize: 13)),
//                   Text('• ${DateFormat('HH:mm').format(service.endTime)}', style: const TextStyle(fontSize: 13)),
//                   const SizedBox(height: 12), // Plus d'espace avant le bouton
//                   // Le bouton "Absent"
//                   ElevatedButton(
//                     onPressed: () {
//                       widget.onAbsentPressed(!service.isAbsent);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: service.isAbsent ? Colors.red.shade700 : Colors.blueGrey.shade600, // Couleurs plus profondes
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Plus grand padding
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Bords plus arrondis
//                     ),
//                     child: Text(
//                       service.isAbsent ? 'Absent' : 'Présent',
//                       style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Colonne "Fin"
//             Expanded(
//               flex: 2,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(service.clientLocationLine3, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                   Text(service.clientSvrLib, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
//                   const SizedBox(height: 8),
//                   Text('Date: ${DateFormat('dd/MM/yyyy').format(service.endTime)}', style: const TextStyle(fontSize: 13)),
//                   Text('HLF: ${DateFormat('HH:mm').format(service.endTime)}', style: const TextStyle(fontSize: 13)),
//                   Text('• ${service.endTime.difference(service.startTime).inMinutes} min', style: const TextStyle(fontSize: 13)),
//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.edit, size: 22, color: Colors.blue),
//                         onPressed: widget.onModify,
//                         tooltip: 'Modifier',
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.check_circle, size: 22, color: Colors.green),
//                         onPressed: widget.onValidate,
//                         tooltip: 'Valider',
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             // Colonne "Résultat"
//             const Expanded(
//               flex: 1,
//               child: SizedBox.shrink(), // Rien à afficher ici pour l'instant
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
