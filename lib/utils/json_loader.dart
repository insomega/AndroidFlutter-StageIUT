import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/menu_item.dart';

class JsonLoader {
  static Future<List<MenuItem>> loadMenu() async {
    // Lire le fichier
    final String response = await rootBundle.loadString('assets/menu_config.json');
    final List<dynamic> data = json.decode(response);
    
    // Convertir la liste JSON en liste de MenuItem
    return data.map((json) => MenuItem.fromJson(json)).toList();
  }
}