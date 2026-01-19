import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../utils/json_loader.dart';

class DynamicMenu extends StatelessWidget {
  const DynamicMenu({super.key});

  // Gestion des icônes selon le type (Font ou Asset)
  Widget _buildIcon(MenuData item) {
    if (item.type == 'font') {
      // Mapping simple des noms de chaînes vers les icônes Material
      IconData iconData;
      switch (item.icon) {
        case 'home': iconData = Icons.home; break;
        case 'settings': iconData = Icons.settings; break;
        case 'person': iconData = Icons.person; break;
        default: iconData = Icons.help_outline;
      }
      return Icon(iconData, color: Colors.blue);
    } else {
      // Pour les icônes personnalisées (ex: png/svg)
      return Image.asset(
        item.icon, 
        width: 24, 
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MenuData>>(
      future: JsonLoader.loadMenu(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Erreur de chargement : ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Aucun élément de menu trouvé"));
        }

        final menuItems = snapshot.data!;

        return ListView.separated(
          itemCount: menuItems.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return ListTile(
              leading: _buildIcon(item),
              title: Text(item.caption, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("ID: ${item.id}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Action : ${item.id}")),
                );
              },
            );
          },
        );
      },
    );
  }
}