// gbsystem_menu/lib/features/dynamic_menu.dart

import 'package:flutter/material.dart';
import 'package:gbsystem_menu/features/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:gbsystem_menu/components/menu_tile.dart';
import 'package:gbsystem_menu/components/digital_clock.dart';
import 'package:gbsystem_mainview/GBSystem_Root_MainView_Menu_Controller.dart';
import 'package:gbsystem_mainview/GBSystem_MenuModel.dart';
import 'package:gbsystem_translations/gbsystem_application_strings.dart';

class GBSystem_DynamicMenu extends GetView<GBSystem_MenuController> {
  const GBSystem_DynamicMenu({super.key});

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
                return Center(child: Text("${GBSystem_Application_Strings.str_dialog_erreur} ${controller.error.value}"));
              }

              return ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: controller.menuItems.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  // apiItem est déjà un GBSystem_MenuItem
                  final GBSystem_MenuItem apiItem = controller.menuItems[index];

                  return Obx(() {
                    final bool isExpanded = controller.menuService.isExpanded(apiItem.id);
                    
                    return GBSystem_MenuTile(
                      item: apiItem, 
                      isExpanded: isExpanded,
                      onTap: (id) {
                        if (apiItem.hasSubItems) {
                          controller.toggleSubMenu(id);
                        } else {
                          // On envoie le pageId (ex: bmserver_Planning_VacPriseNG)
                          Get.find<GBSystem_NavigationController>().navigateTo(apiItem.pageId);
                          if (Navigator.canPop(context)) Navigator.pop(context);
                        }
                      },
                    );
                  });
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
        bottom: 20, left: 20, right: 20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue[900]!, Colors.blue[700]!]),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu_open, color: Colors.white, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 15),
          const Text(
            GBSystem_Application_Strings.str_app_title,
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}