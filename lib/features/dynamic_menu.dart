// lib/features/dynamic_menu.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/menu_tile.dart';
import '../core/menu_model.dart';
import '../components/digital_clock.dart';
import 'package:gbsystem_mainview/GBSystem_Root_MainView_Menu_Controller.dart';

class DynamicMenu extends GetView<GBSystem_MenuController> {
  const DynamicMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (controller.error.value.isNotEmpty) {
                return Center(child: Text("Erreur: ${controller.error.value}"));
              }

              return ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: controller.menuItems.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                final apiItem = controller.menuItems[index];

                // On crée un MenuModel à partir des données de GBSystem_MenuItemModel
                final menuModel = MenuModel(
                  id: apiItem.id,
                  caption: apiItem.title,
                  icon: apiItem.icon,
                  child: apiItem.children.map((child) => MenuModel(
                    id: child.id,
                    caption: child.title,
                    icon: child.icon,
                  )).toList(),
                );

                return MenuTile(
                  item: menuModel, 
                  onTap: (id) => controller.selectMenuItem(apiItem.id, apiItem.route ?? ''),
                );
              },
              );
            }),
          ),
          const DigitalClockFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[900]!, Colors.blue[700]!],
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu_open, color: Colors.white, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              "ESPACE SALARIÉ",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}