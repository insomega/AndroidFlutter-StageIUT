// lib/dynamic_menu_pkg.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 1. LE MODÈLE (La Classe) : Pour un code propre et sans fautes de frappe
class MenuData {
  final String caption;
  final String id;
  final String icon;
  final String type;

  MenuData({
    required this.caption,
    required this.id,
    required this.icon,
    required this.type,
  });

  // Constructeur pour transformer le JSON brut en objet MenuData
  factory MenuData.fromJson(Map<String, dynamic> json) {
    return MenuData(
      caption: json['caption'] ?? 'Sans nom',
      id: json['id'] ?? '',
      icon: json['icon'] ?? '',
      type: json['type'] ?? 'font',
    );
  }
}

// 2. LE WIDGET (La Vue) : Optimisé avec ListView.builder
class DynamicMenuPackage extends StatelessWidget {
  final String jsonPath;
  final Function(String id) onDestinationSelected;

  const DynamicMenuPackage({
    super.key,
    required this.jsonPath,
    required this.onDestinationSelected,
  });

  // Charge le JSON et le transforme en une liste d'objets MenuData
  Future<List<MenuData>> _loadMenuData() async {
    final String response = await rootBundle.loadString(jsonPath);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => MenuData.fromJson(json)).toList();
  }

  // 3. GESTION DES ICÔNES (Switch complet + Sécurité Images)
  Widget _buildLeadingIcon(MenuData item) {
    if (item.type == 'asset') {
      return Image.asset(
        item.icon,
        width: 24,
        // Si le fichier image n'existe pas, on affiche une icône par défaut
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.person_outline),
      );
    } else {
      IconData iconData;
      // Switch complet basé sur le nom de l'icône dans le JSON
      switch (item.icon) {
        case 'home':
          iconData = Icons.home;
          break;
        case 'work':
          iconData = Icons.work;
          break;
        case 'settings':
          iconData = Icons.settings;
          break;
        default:
          iconData = Icons.apps; // Icône par défaut si non reconnue
      }
      return Icon(iconData, color: Colors.blueAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MenuData>>(
      future: _loadMenuData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text("Erreur de chargement du menu"));
        }

        final menuItems = snapshot.data!;

        // Utilisation de ListView.builder pour la performance
        return ListView.builder(
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: _buildLeadingIcon(item),
                title: Text(
                  item.caption,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Navigation vers: ${item.id}"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => onDestinationSelected(item.id),
              ),
            );
          },
        );
      },
    );
  }
}