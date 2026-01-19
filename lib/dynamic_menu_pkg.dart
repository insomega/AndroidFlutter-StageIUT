// lib/dynamic_menu_pkg.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DynamicMenuPackage extends StatelessWidget {
  final String jsonPath;
  final Function(String) onDestinationSelected;

  const DynamicMenuPackage({
    super.key,
    required this.jsonPath,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: rootBundle.loadString(jsonPath),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final List<dynamic> menuItems = json.decode(snapshot.data!);

        return ListView.builder(
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return ListTile(
              leading: Icon(item['icon'] == 'work' ? Icons.work : Icons.home),
              title: Text(item['caption']),
              onTap: () => onDestinationSelected(item['id']), 
            );
          },
        );
      },
    );
  }
}