// import 'package:gbsystem_root/GBSystem_Root_Controller.dart';
// import 'package:gbsystem_root/GBSystem_Root_DataModel.dart';

// abstract class GBSystem_Root_lookup_controller<T extends GBSystem_Root_DataModel_Lookup> extends GBSystem_Root_Controller {
//   final RxList<T> items = <T>[].obs;
//   final RxList<T> filteredItems = <T>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxString searchQuery = ''.obs;
//   final Rxn<T> selectedItem = Rxn<T>();
//   final RxMap<String, dynamic> activeFilters = <String, dynamic>{}.obs;

//   // Méthode à implémenter par les classes filles
//   Future<void> fetchItems();
//   List<String> get availableFilters;
//   String getFilterValue(T item, String filterKey);

//   void onSearchChanged(String query) {
//     searchQuery.value = query;
//     applyFilters();
//   }

//   void setFilter(String key, dynamic value) {
//     if (value == null) {
//       activeFilters.remove(key);
//     } else {
//       activeFilters[key] = value;
//     }
//     applyFilters();
//   }

//   void applyFilters() {
//     if (isLoading.value) return;

//     filteredItems.assignAll(
//       items.where((item) {
//         // Filtre par recherche texte
//         final matchesSearch = searchQuery.value.isEmpty || item.libelle.toLowerCase().contains(searchQuery.value.toLowerCase()) || item.code.toLowerCase().contains(searchQuery.value.toLowerCase());

//         // Filtres supplémentaires
//         bool matchesAllFilters = true;
//         activeFilters.forEach((key, value) {
//           if (value != null) {
//             final itemValue = getFilterValue(item, key);
//             if (value is List) {
//               matchesAllFilters = matchesAllFilters && value.contains(itemValue);
//             } else {
//               matchesAllFilters = matchesAllFilters && (itemValue == value);
//             }
//           }
//         });

//         return matchesSearch && matchesAllFilters;
//       }),
//     );
//   }

//   @override
//   void onReady() {
//     super.onReady();
//     ever(items, (_) => applyFilters());
//   }

//   void selectItem(T item) {
//     selectedItem.value = item;
//     Get.back(result: item);
//   }
// }
