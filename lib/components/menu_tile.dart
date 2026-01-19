// lib/components/menu_tile.dart

import 'package:flutter/material.dart';
import '../core/menu_model.dart';

class MenuTile extends StatelessWidget {
  final MenuModel item;
  final Function(String id) onTap;

  const MenuTile({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (item.child.isNotEmpty) {
      return ExpansionTile(
        key: PageStorageKey(item.id),
        leading: _buildLeadingIcon(item),
        title: Text(item.caption, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: item.child.map((subItem) => ListTile(
          contentPadding: const EdgeInsets.only(left: 65),
          leading: Icon(_getIconData(subItem.icon), size: 20, color: Colors.blueGrey[400]),
          title: Text(subItem.caption, style: const TextStyle(fontSize: 14)),
          onTap: () => onTap(subItem.id),
        )).toList(),
      );
    }

    return ListTile(
      leading: _buildLeadingIcon(item),
      title: Text(item.caption, style: const TextStyle(fontWeight: FontWeight.bold)),
      onTap: () => onTap(item.id),
    );
  }

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
    if (name.contains('planning')) return Icons.calendar_month;
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