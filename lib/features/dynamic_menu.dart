import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/menu_model.dart';
import '../components/menu_tile.dart';
import '../components/digital_clock.dart';

class DynamicMenu extends StatefulWidget {
  final String jsonPath;
  final Function(String id) onItemSelected;

  const DynamicMenu({super.key, required this.jsonPath, required this.onItemSelected});

  @override
  State<DynamicMenu> createState() => _DynamicMenuState();
}

class _DynamicMenuState extends State<DynamicMenu> {
  late Future<List<MenuModel>> _menuFuture;

  @override
  void initState() {
    super.initState();
    _menuFuture = _loadMenu();
  }

  Future<List<MenuModel>> _loadMenu() async {
    final String response = await rootBundle.loadString(widget.jsonPath);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => MenuModel.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer( // Utilisation du widget Drawer
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: FutureBuilder<List<MenuModel>>(
              future: _menuFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) => MenuTile(
                    item: snapshot.data![index],
                    onTap: (id) {
                      Navigator.pop(context); // Ferme le tiroir après le clic
                      widget.onItemSelected(id);
                    },
                  ),
                );
              },
            ),
          ),
          const DigitalClockFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity, // Force la largeur totale du tiroir
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20, // Évite la barre de statut
        bottom: 20,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[900]!, Colors.blue[700]!],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu_open, color: Colors.white, size: 30),
          const SizedBox(width: 15),
          const Expanded( // Permet au texte de prendre la place restante sans déborder
            child: Text(
              "ESPACE SALARIÉ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}