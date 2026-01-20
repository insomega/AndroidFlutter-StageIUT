import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gbsystem_root/GBSystem_Storage_Service.dart';
import 'package:get/get.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'GBSystem_Root_MainView_Controller.dart';
import 'GBSystem_MenuService.dart';
import 'GBSystem_MenuModel.dart';
import 'GBSystem_Root_MainView_Menu_Controller.dart';

class GBSystem_Root_MainView extends StatelessWidget {
  GBSystem_Root_MainView({super.key});

  final GBSystem_MenuController controller = Get.put(GBSystem_MenuController());
  final MenuService menuService = Get.find<MenuService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Content Area
          _buildContentArea(),
          
          // Menu Overlay
          Obx(() => controller.isMenuOpen.value ? _buildMenuOverlay() : const SizedBox()),  // *
        ],
      ),
      
      // Floating Action Button for Menu
      floatingActionButton: Obx(() => _buildMenuButton()),
    );
  }

  Widget _buildContentArea() {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: Obx(() => GBSystem_TextHelper().normalText(
          text: 'Contenu de: ${controller.currentRoute.value}',  // *
          textColor: Colors.black,
        )),
      ),
    );
  }

  Widget _buildMenuOverlay() {
    return GestureDetector(
      onTap: controller.closeMenu, // *
      child: Container(
        color: Colors.black54,
        child: Row(
          children: [
            // Menu Drawer
            _buildMenuDrawer(),
            
            // Empty space to close menu on tap
            Expanded(
              child: GestureDetector(
                onTap: controller.closeMenu, // *
                child: Container(color: Colors.transparent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuDrawer() {
    return Container(
      width: GBSystem_ScreenHelper.screenWidthPercentage(Get.context!, 0.8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Obx(() => Column(
        children: [
          // Header
          _buildMenuHeader(),
          
          // Menu Items
          Expanded(
            child: ListView.builder(
              itemCount: menuService.filteredMenuItems.length, // *
              itemBuilder: (context, index) => _buildMenuItem(index),
            ),
          ),
          
          // Footer
          _buildMenuFooter(),
        ],
      )),
    );
  }

  Widget _buildMenuHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 40, color: Colors.blue[800]),
          ),
          const SizedBox(height: 10),
         GBSystem_TextHelper().normalText(text: 'Utilisateur',
              textColor: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          
           GBSystem_TextHelper().smallText(text:'user@example.com', textColor: Colors.white70),
          
        ],
      ),
    );
  }

  Widget _buildMenuItem(int mainIndex) {
    final item = menuService.filteredMenuItems[mainIndex]; // *
    final isSelected = controller.isCurrentItem(item.id); // *
    final isExpanded = menuService.isExpanded(item.id);

    return Column(
      children: [
        // Item principal
        _buildMainMenuItem(item, isSelected, isExpanded),
        
        // Sous-items (niveau 2)
        if (item.hasSubItems && isExpanded) 
          ..._buildSubMenuItems(item),
      ],
    );
  }

  Widget _buildMainMenuItem(GBSystem_MenuItem item, bool isSelected, bool isExpanded) { // *
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue[50] : Colors.transparent,
        border: Border(
          left: BorderSide(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 3,
          ),
        ),
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          item.icon,
          width: 24,
          height: 24,
          color: isSelected ? Colors.blue : Colors.grey[700],
        ),
        title: GBSystem_TextHelper().normalText(text: item.title,
            textColor: isSelected ? Colors.blue : Colors.grey[700] ?? Colors.grey, // *
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        
        trailing: item.hasSubItems
            ? Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: isSelected ? Colors.blue : Colors.grey[700],
              )
            : isSelected
                ? const Icon(Icons.arrow_forward, color: Colors.blue)
                : null,
        onTap: () {
          if (item.hasSubItems) {
            controller.toggleSubMenu(item.id); // *
          } else {
            controller.selectMenuItem(item.id, item.route); // *
          }
        },
      ),
    );
  }

  List<Widget> _buildSubMenuItems(GBSystem_MenuItem mainItem) { // *
    return mainItem.subItems!.where((subItem) {
      // Filtrer les sous-items selon les permissions
      final userPermissions = GBSystem_Storage_Service().getUserPermissions(); // *
      return subItem.isActive && 
             subItem.requiredPermissions.every((permission) => userPermissions.contains(permission));
    }).map((subItem) {
      final isSubSelected = controller.isCurrentItem(subItem.id); // *

      return Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: isSubSelected ? Colors.blue[25] : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: isSubSelected ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: ListTile(
            leading: SvgPicture.asset(
              subItem.icon,
              width: 20,
              height: 20,
              color: isSubSelected ? Colors.blue : Colors.grey[600],
            ),
            title: GBSystem_TextHelper().smallText(text:  subItem.title,
                textColor: isSubSelected ? Colors.blue : Colors.grey[600],
                fontWeight: isSubSelected ? FontWeight.bold : FontWeight.normal,
              ),
            
            trailing: isSubSelected 
                ? const Icon(Icons.arrow_forward, size: 16, color: Colors.blue)
                : null,
            onTap: () => controller.selectMenuItem(subItem.id, subItem.route), // *
            contentPadding: const EdgeInsets.only(left: 16, right: 16),
            visualDensity: const VisualDensity(vertical: -3),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildMenuFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)), // *
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.grey),
            title:  GBSystem_TextHelper().normalText( text: 'Paramètres', textColor: Colors.grey),
            
            onTap: () {
              controller.closeMenu(); // *
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title:
              
               GBSystem_TextHelper().normalText(text:'Déconnexion', textColor: Colors.red),
            
            onTap: () {
              controller.closeMenu(); // *
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton() {
    return AnimatedScale(
      duration: const Duration(milliseconds: 300),
      scale: controller.isMenuOpen.value ? 0 : 1, // *
      child: FloatingActionButton(
        onPressed: controller.toggleMenu, // *
        backgroundColor: Colors.blue[800],
        child: AnimatedRotation(
          duration: const Duration(milliseconds: 300),
          turns: controller.isMenuOpen.value ? 0.125 : 0, // *
          child: const Icon(Icons.menu, color: Colors.white),
        ),
      ),
    );
  }
}