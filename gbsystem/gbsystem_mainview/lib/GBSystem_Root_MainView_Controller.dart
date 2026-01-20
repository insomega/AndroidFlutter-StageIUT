import 'package:get/get.dart';
import 'MenuService.dart';

class GBSystem_MainViewController extends GetxController {
  final GBSystem_MenuService menuService = Get.find<GBSystem_MenuService>();
  final RxString selectedItemId = ''.obs;
  final RxBool isMenuOpen = false.obs;
  final RxString currentRoute = GBSystem_Application_Routes.dashboard.obs;

  @override
  void onInit() {
    super.onInit();
    // Sélectionner le premier item par défaut
    ever(menuService.filteredMenuItems, (_) {
      if (menuService.filteredMenuItems.isNotEmpty && selectedItemId.isEmpty) {
        selectedItemId.value = menuService.filteredMenuItems.first.id;
      }
    });
  }

  void selectMenuItem(String itemId, String route) {
    selectedItemId.value = itemId;
    currentRoute.value = route;
    Get.toNamed(route);
    toggleMenu();
  }

  void toggleSubMenu(String itemId) {
    menuService.toggleExpansion(itemId);
  }

  void toggleMenu() {
    isMenuOpen.toggle();
    if (!isMenuOpen.value) {
      // Fermer tous les sous-menus quand le menu principal se ferme
      menuService.expandedItems.clear();
    }
  }

  void closeMenu() {
    isMenuOpen.value = false;
    menuService.expandedItems.clear();
  }

  void openMenu() {
    isMenuOpen.value = true;
  }

  bool isCurrentItem(String itemId) {
    return selectedItemId.value == itemId;
  }

  // Méthode pour obtenir l'index réel en comptant les sous-items développés
  int getFlatIndex(int mainIndex) {
    int flatIndex = mainIndex;
    for (int i = 0; i < mainIndex; i++) {
      final item = menuService.filteredMenuItems[i];
      if (item.hasSubItems && menuService.isExpanded(item.id)) {
        flatIndex += item.subItems!.length;
      }
    }
    return flatIndex;
  }
}
