// gbsystem_menu/lib/components/menu_tile.dart

import 'package:flutter/material.dart';
import 'package:gbsystem_menu/core/bmsoft_icons.dart';
import 'package:get/get.dart';
import '../features/navigation_controller.dart';
import 'package:gbsystem_mainview/GBSystem_MenuModel.dart';

class MenuTile extends StatelessWidget {
  final GBSystem_MenuItem item;
  final Function(String id)? onTap;
  final bool isExpanded;

  const MenuTile({
    super.key,
    required this.item,
    this.onTap,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.find<NavigationController>();

    return Obx(() {
      final String currentId = navCtrl.currentViewId.value;
      final bool isParentSelected = currentId == item.pageId;

      final TextStyle menuTextStyle = TextStyle(
        fontFamily: 'Mulish',
        fontWeight: isParentSelected ? FontWeight.bold : FontWeight.w600,
        fontSize: 15,
        color: isParentSelected ? Colors.blue[900] : Colors.black87,
      );

      // CAS 1 : MENU AVEC ENFANTS (ExpansionTile)
      if (item.hasSubItems) {
        return ExpansionTile(
          key: PageStorageKey(item.id),
          initiallyExpanded: isExpanded,
          leading: _buildIcon(item.icon, isParentSelected),
          title: Text(item.title, style: menuTextStyle),
          onExpansionChanged: (bool expanded) {
            onTap?.call(item.id);
          },
          children: item.subItems!.map((subItem) {
            final bool isSubSelected = currentId == subItem.pageId;
            return ListTile(
              contentPadding: const EdgeInsets.only(left: 32),
              selected: isSubSelected,
              leading: _buildIcon(subItem.icon, isSubSelected, size: 20),
              title: Text(
                subItem.title,
                style: menuTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: isSubSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              onTap: () {
                navCtrl.navigateTo(subItem.pageId);
                if (Navigator.canPop(context)) Navigator.pop(context);
              },
            );
          }).toList(),
        );
      }

      // CAS 2 : MENU STANDARD (ListTile)
      return ListTile(
        selected: isParentSelected,
        selectedTileColor: Colors.blue[50],
        leading: _buildIcon(item.icon, isParentSelected),
        title: Text(item.title, style: menuTextStyle),
        onTap: () {
          navCtrl.navigateTo(item.pageId);
          if (Navigator.canPop(context)) Navigator.pop(context);
        },
      );
    });
  }

  Widget _buildIcon(String iconKey, bool isSelected, {double size = 24}) {
    final IconData iconData = BMSoftIcons.fromKey(iconKey);
    return Icon(
      iconData,
      color: isSelected ? Colors.blue[900] : Colors.blueGrey[600],
      size: size,
    );
  }
}