import 'package:flutter/material.dart';
import 'models/menu_item.dart';
import 'utils/json_loader.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Menu Dynamique')),
        body: const DynamicMenu(),
      ),
    );
  }
}

class DynamicMenu extends StatelessWidget {
  const DynamicMenu({super.key});

  // Fonction pour choisir entre icône Font ou Image Asset
  Widget _buildIcon(MenuItem item) {
    if (item.type == 'font') {
      // Pour l'exercice, on simule quelques icônes Material
      IconData iconData = Icons.help; 
      if (item.icon == 'home') iconData = Icons.home;
      if (item.icon == 'settings') iconData = Icons.settings;
      return Icon(iconData);
    } else {
      return Image.asset(item.icon, width: 24);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MenuItem>>(
      future: JsonLoader.loadMenu(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Erreur: ${snapshot.error}"));
        } else {
          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: _buildIcon(items[index]),
                title: Text(items[index].caption),
                subtitle: Text("ID: ${items[index].id}"),
                onTap: () => print("Clic sur ${items[index].id}"),
              );
            },
          );
        }
      },
    );
  }
}