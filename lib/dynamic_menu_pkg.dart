// // lib/dynamic_menu_pkg.dart

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'dart:async';

// // --- MODÈLE ---
// class MenuData {
//   final String caption;
//   final String id;
//   final String icon;
//   final String type;
//   final String? classColor; // Pour la couleur it-red, it-green, etc.
//   final List<MenuData> child; // Pour les sous-menus

//   MenuData({
//     required this.caption,
//     required this.id,
//     required this.icon,
//     required this.type,
//     this.classColor,
//     this.child = const [],
//   });

//   factory MenuData.fromJson(Map<String, dynamic> json) {
//     var list = json['child'] as List? ?? [];
//     List<MenuData> childList = list.map((i) => MenuData.fromJson(i)).toList();

//     return MenuData(
//       caption: json['caption'] ?? '',
//       id: json['bmsyu_objet'] ?? json['id'] ?? '', // On mappe bmsyu_objet sur id
//       icon: json['icon'] ?? '',
//       type: json['type'] ?? '',
//       classColor: json['classColor'],
//       child: childList,
//     );
//   }
// }

// class DynamicMenuPackage extends StatefulWidget {
//   final String jsonPath;
//   final Function(String id) onDestinationSelected;

//   const DynamicMenuPackage({super.key, required this.jsonPath, required this.onDestinationSelected});

//   @override
//   State<DynamicMenuPackage> createState() => _DynamicMenuPackageState();
// }

// class _DynamicMenuPackageState extends State<DynamicMenuPackage> {
//   // On utilise un Future stocké dans une variable pour éviter que le FutureBuilder
//   // ne se relance à chaque setState.
//   late Future<List<MenuData>> _menuFuture;

//   @override
//   void initState() {
//     super.initState();
//     // On charge les données UNE SEULE FOIS ici
//     _menuFuture = _loadMenuData();
//   }

//   Future<List<MenuData>> _loadMenuData() async {
//     final String response = await rootBundle.loadString(widget.jsonPath);
//     final List<dynamic> data = json.decode(response);
//     return data.map((json) => MenuData.fromJson(json)).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _buildTopBanner(),
//         Expanded(
//           child: FutureBuilder<List<MenuData>>(
//             future: _menuFuture, // Utilise la variable stable
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              
//               final menuItems = snapshot.data!;
//               return ListView.separated(
//                 itemCount: menuItems.length,
//                 separatorBuilder: (context, index) => const Divider(height: 1),
//                 itemBuilder: (context, index) => _buildMenuItem(menuItems[index]),
//               );
//             },
//           ),
//         ),
//         const DigitalClockFooter(), // Widget séparé pour l'horloge
//       ],
//     );
//   }

//   // Fonctions de design (inchangées)
//   Color _getColor(String? classColor) {
//     switch (classColor) {
//       case 'it-red': return Colors.redAccent;
//       case 'it-green': return Colors.green;
//       case 'it-yallow': return Colors.orange;
//       case 'it-purple': return Colors.purple;
//       case 'it-black': return Colors.black87;
//       default: return Colors.blueGrey;
//     }
//   }

//   IconData _getIconData(String? iconName) {
//     if (iconName == null) return Icons.circle;
//     String name = iconName.toLowerCase();

//     // --- PLANNING & TEMPS ---
//     if (name.contains('planning')) return Icons.calendar_month;
//     if (name.contains('ventilation')) return Icons.fact_check_outlined; // Prise de vacations
//     if (name.contains('disponible')) return Icons.event_available; // Disponibilités
//     if (name.contains('exclure')) return Icons.person_off_outlined; // Préférences / Exclusions

//     // --- ABSENCES & INDISPO ---
//     if (name.contains('absence')) return Icons.event_busy;
//     if (name.contains('indisponibilites')) return Icons.do_not_disturb_on_outlined;
//     if (name.contains('indisponible')) return Icons.event_note;
//     if (name.contains('box')) return Icons.inventory_2_outlined; // C.E.T (Compte Épargne Temps)

//     // --- INFOS & MESSAGERIE ---
//     if (name.contains('info')) return Icons.badge_outlined; // Cartes pro / Infos
//     if (name.contains('tenues')) return Icons.checkroom; // Tenue
//     if (name.contains('messagerie')) return Icons.chat_outlined; // Messenger
//     if (name.contains('option')) return Icons.settings_outlined;

//     // --- DOCUMENTS & FINANCE ---
//     if (name.contains('dossier') || name.contains('documents')) return Icons.folder_shared;
//     if (name.contains('facturation')) return Icons.euro_symbol; // Note de frais
    
//     // --- DIVERS ---
//     if (name.contains('entite')) return Icons.business;
    
//     return Icons.label_important_outline;
//   }

//   Widget _buildMenuItem(MenuData item) {
//     if (item.child.isNotEmpty) {
//       return ExpansionTile(
//         key: PageStorageKey(item.id),
//         leading: CircleAvatar(
//           backgroundColor: _getColor(item.classColor).withOpacity(0.1),
//           child: Icon(_getIconData(item.icon), color: _getColor(item.classColor)),
//         ),
//         title: Text(item.caption, style: const TextStyle(fontWeight: FontWeight.bold)),
//         // Configuration des sous-menus
//         children: item.child.map((subItem) => ListTile(
//           contentPadding: const EdgeInsets.only(left: 20, right: 16), // Ajustement du padding
//           leading: Padding(
//             padding: const EdgeInsets.only(left: 45), // Aligne l'icône enfant sous le texte parent
//             child: Icon(
//               _getIconData(subItem.icon), 
//               size: 20, // Icône légèrement plus petite pour les enfants
//               color: Colors.blueGrey[400],
//             ),
//           ),
//           title: Text(
//             subItem.caption,
//             style: const TextStyle(fontSize: 14), // Texte un peu plus fin pour la hiérarchie
//           ),
//           onTap: () => widget.onDestinationSelected(subItem.id)
//         )).toList(),
//       );
//     }

//     // Widget pour les items sans enfants (ex: Accueil)
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundColor: _getColor(item.classColor).withOpacity(0.1),
//         child: Icon(_getIconData(item.icon), color: _getColor(item.classColor)),
//       ),
//       title: Text(item.caption, style: const TextStyle(fontWeight: FontWeight.bold)),
//       onTap: () => widget.onDestinationSelected(item.id),
//     );
//   }

//   Widget _buildTopBanner() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue[900]!, Colors.blue[700]!])),
//       child: const Row(
//         children: [
//           Icon(Icons.menu_open, color: Colors.white, size: 30),
//           SizedBox(width: 15),
//           Text("ESPACE SALARIÉ", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// }

// // --- WIDGET SÉPARÉ POUR L'HORLOGE ---
// // Seul ce petit widget se rafraîchira chaque seconde
// class DigitalClockFooter extends StatefulWidget {
//   const DigitalClockFooter({super.key});

//   @override
//   State<DigitalClockFooter> createState() => _DigitalClockFooterState();
// }

// class _DigitalClockFooterState extends State<DigitalClockFooter> {
//   late DateTime _currentDate;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _currentDate = DateTime.now();
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (mounted) setState(() => _currentDate = DateTime.now());
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(12),
//       color: Colors.grey[200],
//       child: Center(
//         child: Text(
//           "BMSoft • ${DateFormat('dd/MM/yyyy HH:mm:ss').format(_currentDate)}",
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blueGrey),
//         ),
//       ),
//     );
//   }
// }