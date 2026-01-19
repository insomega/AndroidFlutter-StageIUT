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
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: FutureBuilder<List<MenuModel>>(
            future: _menuFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              return ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) => MenuTile(
                  item: snapshot.data![index],
                  onTap: widget.onItemSelected,
                ),
              );
            },
          ),
        ),
        const DigitalClockFooter(),
      ],
    );
  }

  Widget _buildHeader() {
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