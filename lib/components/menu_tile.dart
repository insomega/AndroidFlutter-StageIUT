// lib/components/menu_tile.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/menu_model.dart';
import '../features/navigation_controller.dart';

class MenuTile extends StatelessWidget {
  final MenuModel item;
  final Function(String id)? onTap;

  const MenuTile({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.find<NavigationController>();

    // On utilise Obx ici pour que le menu se recolore en temps réel si l'ID change
    return Obx(() {
      final String currentId = navCtrl.currentViewId.value;
      final bool isParentSelected = currentId == item.pageId;

      if (item.child.isNotEmpty) {
        return ExpansionTile(
          key: PageStorageKey(item.id),
          leading: _buildLeadingIcon(item),
          // Le parent devient bleu si lui-même est sélectionné
          title: Text(
            item.caption,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isParentSelected ? Colors.blue[900] : Colors.black87,
            ),
          ),
          children: item.child.map((subItem) {
            // VERIFICATION DE SELECTION POUR CHAQUE SOUS-MENU
            final bool isSubSelected = currentId == subItem.pageId;
            
            return ListTile(
              selected: isSubSelected,
              selectedTileColor: Colors.blue[50],
              contentPadding: const EdgeInsets.only(left: 65),
              leading: Icon(
                _getIconData(subItem.icon), 
                size: 20, 
                color: isSubSelected ? Colors.blue[900] : Colors.blueGrey[400]
              ),
              title: Text(
                subItem.caption, 
                style: TextStyle(
                  fontSize: 14,
                  color: isSubSelected ? Colors.blue[900] : Colors.black87,
                  fontWeight: isSubSelected ? FontWeight.bold : FontWeight.normal,
                )
              ),
              onTap: () {
                navCtrl.navigateTo(subItem.pageId);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      }

      // Cas standard (Accueil, etc.)
      return ListTile(
        selected: isParentSelected,
        selectedTileColor: Colors.blue[50],
        leading: _buildLeadingIcon(item),
        title: Text(
          item.caption,
          style: TextStyle(
            fontWeight: isParentSelected ? FontWeight.bold : FontWeight.normal,
            color: isParentSelected ? Colors.blue[900] : Colors.black87,
          ),
        ),
        onTap: () {
          navCtrl.navigateTo(item.pageId);
          Navigator.pop(context);
        },
      );
    });
  }

  // --- Widgets de construction interne ---
  Widget _buildLeadingIcon(MenuModel item) {
    return CircleAvatar(
      backgroundColor: _getColor(item.classColor).withOpacity(0.1),
      child: Icon(_getIconData(item.icon), color: _getColor(item.classColor)),
    );
  }

  Color _getColor(String? classColor) {
    switch (classColor) {
      case 'it-red': return Colors.redAccent;
      case 'it-green': return Colors.green;
      case 'it-yallow': return Colors.orange;
      case 'it-purple': return Colors.purple;
      case 'it-black': return Colors.black87;
      default: return Colors.blueGrey;
    }
  }

  IconData _getIconData(String? iconName) {
    String name = (iconName ?? '').toLowerCase();
    // Priorité aux mots clés du href ou de l'icône
    if (name.contains('planning')) return Icons.calendar_month;
    if (name.contains('prise')) return Icons.assignment_turned_in_outlined;
    if (name.contains('ventilation')) return Icons.fact_check_outlined;
    if (name.contains('disponible')) return Icons.event_available;
    if (name.contains('exclure')) return Icons.person_off_outlined;
    if (name.contains('absence')) return Icons.event_busy;
    if (name.contains('indisponibilites')) return Icons.do_not_disturb_on_outlined;
    if (name.contains('box')) return Icons.inventory_2_outlined;
    if (name.contains('info')) return Icons.badge_outlined;
    if (name.contains('tenues')) return Icons.checkroom;
    if (name.contains('messagerie')) return Icons.chat_outlined;
    if (name.contains('option')) return Icons.settings_outlined;
    if (name.contains('dossier') || name.contains('doc')) return Icons.folder_shared;
    if (name.contains('facturation')) return Icons.euro_symbol;
    if (name.contains('entite')) return Icons.business;
    return Icons.label_important_outline;
  }
}