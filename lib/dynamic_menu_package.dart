import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// --- LE MODÈLE ---
class MenuData {
  final String caption;
  final String id;
  final String icon;
  final String type;

  MenuData.fromJson(Map<String, dynamic> json)
      : caption = json['caption'],
        id = json['id'],
        icon = json['icon'],
        type = json['type'];
}

// --- LE WIDGET AUTONOME ---
class CustomDynamicMenu extends StatelessWidget {
  final String jsonPath;
  final Function(String id) onNavigate;

  const CustomDynamicMenu({
    super.key, 
    required this.jsonPath, 
    required this.onNavigate
  });

  Future<List<MenuData>> _loadData() async {
    final String response = await rootBundle.loadString(jsonPath);
    final List<dynamic> data = json.decode(response);
    return data.map((e) => MenuData.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MenuData>>(
      future: _loadData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        return ListView(
          children: snapshot.data!.map((item) => ListTile(
            leading: item.type == 'font' 
                ? const Icon(Icons.home) // Logique simplifiée
                : Image.asset(item.icon, width: 24),
            title: Text(item.caption),
            subtitle: Text(item.id),
            onTap: () => onNavigate(item.id),
          )).toList(),
        );
      },
    );
  }
}