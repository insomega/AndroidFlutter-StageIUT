// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:mon_projet/dynamic_menu_pkg.dart';

// class JsonLoader {
//   static Future<List<MenuData>> loadMenu() async {
//     // Lire le fichier
//     final String response = await rootBundle.loadString('assets/menu_config.json');
//     final List<dynamic> data = json.decode(response);
    
//     // Convertir la liste JSON en liste de MenuItem
//     return data.map((json) => MenuData.fromJson(json)).toList();
//   }
// }