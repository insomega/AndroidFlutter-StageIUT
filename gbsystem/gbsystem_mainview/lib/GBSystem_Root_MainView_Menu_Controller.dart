import 'dart:convert';

import 'package:gbsystem_mainview/GBSystem_Root_MainView_Menu_Item_Model.dart';
import 'package:gbsystem_root/GBSystem_Root_Controller.dart';
import 'package:get/get.dart';

//

class GBSystem_MenuController extends GBSystem_Root_Controller {
  final RxList<GBSystem_MenuItemModel> menuItems = <GBSystem_MenuItemModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = "".obs;

  Future<void> loadMenuFromApi() async {
    try {
      isLoading.value = true;
      error.value = "";
      String aJson =
          '[  {    "title": "Administration",    "icon": "admin_panel_settings",    "children": [      {        "title": "Utilisateurs",        "route": "/admin/users"      },      {        "title": "Rôles",        "route": "/admin/roles"      },      {        "title": "Paramètres système",        "children": [          {            "title": "Sécurité",            "route": "/admin/system/security"          },          {            "title": "Notifications",            "route": "/admin/system/notifications"          }        ]      }    ]  }]';

      menuItems.value = (json.decode(aJson) as List).map((e) => GBSystem_MenuItemModel.fromJson(e)).toList();
      // TODO : remplacer par ton vrai endpoint
      //    final response = await http.get(Uri.parse("https://api.example.com/menu"));
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  final RxBool isMenuOpen = false.obs;
  final RxString currentRoute = ''.obs;
  
  void toggleMenu() {
    isMenuOpen.toggle();
  }
  
  void closeMenu() {
    isMenuOpen.value = false;
  }

  void selectMenuItem(String itemId, String route) {
    currentRoute.value = route;
    isMenuOpen.value = false;
    // Add any additional logic here (e.g., navigation, analytics)
    Get.toNamed(route);
  }

  final RxString selectedMenuItemId = ''.obs;
  
  get menuService => null;
  
  get filteredMenuItems => null;
  bool isCurrentItem(String itemId) {
    return selectedMenuItemId.value == itemId;
  }

  void toggleSubMenu(String itemId) {
    menuService.toggleExpanded(itemId);
  }

  void toggleExpanded(String itemId) {
    final index = filteredMenuItems.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      filteredMenuItems[index].isExpanded = !filteredMenuItems[index].isExpanded;
    }
  }
}
