import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gbsystem_root/GBSystem_Storage_Service.dart';
import 'GBSystem_MenuModel.dart';

class MenuService extends GetxService {
  final Rx<GBSystem_MenuConfig> menuConfig = GBSystem_MenuConfig(items: [], version: '1.0.0', lastUpdated: DateTime.now()).obs;
  final RxList<GBSystem_MenuItem> filteredGBSystem_MenuItems = <GBSystem_MenuItem>[].obs;
  final RxMap<String, bool> expandedItems = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadGBSystem_MenuConfig();
  }

  Future<void> loadGBSystem_MenuConfig() async {
    try {
      // Charger depuis les assets locaux (version simplifiée)
      final localConfig = await _loadFromAssets();
      menuConfig.value = localConfig;

      // Filtrer les items selon les permissions utilisateur
      _filterGBSystem_MenuItems();
    } catch (e) {
      // En cas d'erreur, charger la configuration par défaut
      final defaultConfig = await _loadDefaultConfig();
      menuConfig.value = defaultConfig;
      _filterGBSystem_MenuItems();
    }
  }

  Future<GBSystem_MenuConfig> _loadFromAssets() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/config/menu_config.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return GBSystem_MenuConfig.fromJson(jsonData);
    } catch (e) {
      return _loadDefaultConfig();
    }
  }

  // Future<GBSystem_MenuConfig> _loadDefaultConfig() async {
  //   // Configuration par défaut à 2 niveaux maximum
  //   return GBSystem_MenuConfig(
  //     items: [
  //       GBSystem_MenuItem(id: 'dashboard', title: 'Tableau de bord', icon: 'assets/icons/dashboard.svg', route: GBSystem_Application_Routes.dashboard, requiredPermissions: []),
  //       GBSystem_MenuItem(
  //         id: 'planning',
  //         title: 'Planning',
  //         icon: 'assets/icons/calendar.svg',
  //         route: GBSystem_Application_Routes.mainAppView,
  //         requiredPermissions: ['planning_access'],
  //         isExpandable: true,
  //         subItems: [
  //           GBSystem_MenuItem(id: 'planning_view', title: 'Vue Planning', icon: 'assets/icons/view.svg', route: GBSystem_Application_Routes.View1, requiredPermissions: ['planning_view']),
  //           GBSystem_MenuItem(id: 'planning_edit', title: 'Édition Planning', icon: 'assets/icons/edit.svg', route: GBSystem_Application_Routes.View2, requiredPermissions: ['planning_edit']),
  //         ],
  //       ),
  //       GBSystem_MenuItem(
  //         id: 'stock',
  //         title: 'Gestion Stock',
  //         icon: 'assets/icons/stock.svg',
  //         route: GBSystem_Application_Routes.View3,
  //         requiredPermissions: ['stock_access'],
  //         isExpandable: true,
  //         subItems: [
  //           GBSystem_MenuItem(id: 'stock_view', title: 'Vue Stock', icon: 'assets/icons/view.svg', route: GBSystem_Application_Routes.View3, requiredPermissions: ['stock_view']),
  //           GBSystem_MenuItem(id: 'stock_edit', title: 'Édition Stock', icon: 'assets/icons/edit.svg', route: GBSystem_Application_Routes.View4, requiredPermissions: ['stock_edit']),
  //         ],
  //       ),
  //       GBSystem_MenuItem(id: 'reports', title: 'Rapports', icon: 'assets/icons/reports.svg', route: GBSystem_Application_Routes.View4, requiredPermissions: ['reports_access']),
  //     ],
  //     version: '1.0.0',
  //     lastUpdated: DateTime.now(),
  //   );
  // }

  void _filterGBSystem_MenuItems() {
    final userPermissions = GBSystem_Storage_Service().getUserPermissions();

    filteredGBSystem_MenuItems.value = menuConfig.value.items.where((item) {
      // Vérifier si l'item principal est actif et a les permissions
      final hasMainPermission = item.isActive && item.requiredPermissions.every((permission) => userPermissions.contains(permission));

      if (!hasMainPermission) return false;

      // Si l'item a des sous-items, vérifier qu'au moins un sous-item est accessible
      if (item.hasSubItems) {
        final accessibleSubItems = item.subItems!.where((subItem) {
          return subItem.isActive && subItem.requiredPermissions.every((permission) => userPermissions.contains(permission));
        }).toList();

        return accessibleSubItems.isNotEmpty;
      }

      return true;
    }).toList();
  }

  void toggleExpansion(String itemId) {
    expandedItems[itemId] = !(expandedItems[itemId] ?? false);
    expandedItems.refresh();
  }

  bool isExpanded(String itemId) {
    return expandedItems[itemId] ?? false;
  }

  void refreshMenu() {
    _filterGBSystem_MenuItems();
    expandedItems.clear();
  }

  // Méthode pour obtenir tous les items accessibles (niveaux 1 et 2)
  List<GBSystem_MenuItem> getAllAccessibleItems() {
    final List<GBSystem_MenuItem> allItems = [];

    for (final mainItem in filteredGBSystem_MenuItems) {
      allItems.add(mainItem);

      if (mainItem.hasSubItems && isExpanded(mainItem.id)) {
        final accessibleSubItems = mainItem.subItems!.where((subItem) {
          return subItem.isActive && subItem.requiredPermissions.every((permission) => GBSystem_Storage_Service().getUserPermissions().contains(permission));
        }).toList();

        allItems.addAll(accessibleSubItems);
      }
    }

    return allItems;
  }
}
