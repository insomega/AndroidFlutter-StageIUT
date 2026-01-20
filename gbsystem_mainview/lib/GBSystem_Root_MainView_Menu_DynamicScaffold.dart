import 'package:flutter/material.dart';
import 'package:gbsystem_mainview/GBSystem_Root_MainView_Menu_Controller.dart';
import 'package:gbsystem_mainview/GBSystem_Root_MainView_Menu_Item_Model.dart';
import 'package:get/get.dart';

class GBSystem_Root_MainView_Menu_DynamicMenuScaffold extends StatelessWidget {
  final GBSystem_MenuController menuController = Get.find<GBSystem_MenuController>();

  GBSystem_Root_MainView_Menu_DynamicMenuScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu Dynamique")),
      drawer: Drawer(child: ListView(children: menuController.menuItems.map((item) => _buildMenuItem(item)).toList())),
      body: const Center(child: Text("Contenu principal")),
    );
  }

  Widget _buildMenuItem(GBSystem_MenuItemModel item) {
    if (item.children.isEmpty) {
      return ListTile(
        title: Text(item.title),
        leading: Icon(Icons.circle),
        onTap: () {
          if (item.route != null) {
            Get.toNamed(item.route!);
          }
        },
      );
    } else {
      return ExpansionTile(title: Text(item.title), leading: Icon(Icons.folder), children: item.children.map(_buildMenuItem).toList());
    }
  }
}
