import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:async';

// --- MODÈLE ---
class MenuData {
  final String caption;
  final String id;
  final String icon;
  final String? classColor;
  final List<MenuData> child;

  MenuData({required this.caption, required this.id, required this.icon, this.classColor, this.child = const []});

  factory MenuData.fromJson(Map<String, dynamic> json) {
    var list = json['child'] as List? ?? [];
    return MenuData(
      caption: json['caption'] ?? '',
      id: json['bmsyu_objet'] ?? json['id'] ?? '',
      icon: json['icon'] ?? '',
      classColor: json['classColor'],
      child: list.map((i) => MenuData.fromJson(i)).toList(),
    );
  }
}

class DynamicMenuPackage extends StatefulWidget {
  final String jsonPath;
  final Function(String id) onDestinationSelected;

  const DynamicMenuPackage({super.key, required this.jsonPath, required this.onDestinationSelected});

  @override
  State<DynamicMenuPackage> createState() => _DynamicMenuPackageState();
}

class _DynamicMenuPackageState extends State<DynamicMenuPackage> {
  // On utilise un Future stocké dans une variable pour éviter que le FutureBuilder
  // ne se relance à chaque setState.
  late Future<List<MenuData>> _menuFuture;

  @override
  void initState() {
    super.initState();
    // On charge les données UNE SEULE FOIS ici
    _menuFuture = _loadMenuData();
  }

  Future<List<MenuData>> _loadMenuData() async {
    final String response = await rootBundle.loadString(widget.jsonPath);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => MenuData.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTopBanner(),
        Expanded(
          child: FutureBuilder<List<MenuData>>(
            future: _menuFuture, // Utilise la variable stable
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              
              final menuItems = snapshot.data!;
              return ListView.separated(
                itemCount: menuItems.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) => _buildMenuItem(menuItems[index]),
              );
            },
          ),
        ),
        const DigitalClockFooter(), // Widget séparé pour l'horloge
      ],
    );
  }

  // Fonctions de design (inchangées)
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
    if (iconName == null) return Icons.circle;
    String name = iconName.toLowerCase();
    if (name.contains('planning')) return Icons.calendar_month;
    if (name.contains('absence')) return Icons.event_busy;
    if (name.contains('info')) return Icons.person_search;
    if (name.contains('dossier') || name.contains('doc')) return Icons.folder_shared;
    if (name.contains('entite')) return Icons.business;
    return Icons.label_important;
  }

  Widget _buildMenuItem(MenuData item) {
    if (item.child.isNotEmpty) {
      return ExpansionTile(
        key: PageStorageKey(item.id), // Permet de garder l'état ouvert/fermé
        leading: CircleAvatar(
          backgroundColor: _getColor(item.classColor).withOpacity(0.1),
          child: Icon(_getIconData(item.icon), color: _getColor(item.classColor)),
        ),
        title: Text(item.caption, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: item.child.map((subItem) => ListTile(
          contentPadding: const EdgeInsets.only(left: 70),
          title: Text(subItem.caption),
          onTap: () => widget.onDestinationSelected(subItem.id),
        )).toList(),
      );
    }
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getColor(item.classColor).withOpacity(0.1),
        child: Icon(_getIconData(item.icon), color: _getColor(item.classColor)),
      ),
      title: Text(item.caption, style: const TextStyle(fontWeight: FontWeight.bold)),
      onTap: () => widget.onDestinationSelected(item.id),
    );
  }

  Widget _buildTopBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue[900]!, Colors.blue[700]!])),
      child: const Row(
        children: [
          Icon(Icons.menu_open, color: Colors.white, size: 30),
          SizedBox(width: 15),
          Text("ESPACE SALARIÉ", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// --- WIDGET SÉPARÉ POUR L'HORLOGE ---
// Seul ce petit widget se rafraîchira chaque seconde
class DigitalClockFooter extends StatefulWidget {
  const DigitalClockFooter({super.key});

  @override
  State<DigitalClockFooter> createState() => _DigitalClockFooterState();
}

class _DigitalClockFooterState extends State<DigitalClockFooter> {
  late DateTime _currentDate;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _currentDate = DateTime.now().add(const Duration(hours: 1)));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: Colors.grey[200],
      child: Center(
        child: Text(
          "BMSoft • ${DateFormat('dd/MM/yyyy HH:mm:ss').format(_currentDate)}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blueGrey),
        ),
      ),
    );
  }
}