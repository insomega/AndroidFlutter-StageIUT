// import 'package:get/get.dart';
// import 'package:gbsystem_root/GBSystem_Root_Controller.dart';
// import 'GBSystem_lookup_item.dart';



// abstract class GenericLookupController<T extends LookupModel> extends GetxController {
//   final RxList<T> items = <T>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxString searchQuery = ''.obs;
//   final Rxn<T> selectedItem = Rxn<T>();

//   Future<void> fetchItems();

//   void onSearchChanged(String query) {
//     searchQuery.value = query;
//     fetchItems();
//   }

//   void selectItem(T item) {
//     selectedItem.value = item;
//     Get.back(result: item);
//   }
// }

// // abstract class GBSystem_LookupController<T extends GBSystem_LookupItem> extends GBSystem_Root_Controller {
// //   var items = <T>[].obs;
// //   var isLoading = false.obs;

// //   /// Méthode que les classes filles doivent implémenter
// //   Future<List<T>> fetchItems();

// //   void loadData() async {
// //     isLoading.value = true;
// //     items.value = await fetchItems();
// //     isLoading.value = false;
// //   }

// //   void selectItem(T item) {
// //     Get.back(result: item);
// //   }
// // }

// // Exemple Controller spécifique : salarie_lookup_controller.dart

// // dart
// // Copier
// // Modifier
// // import 'lookup_controller.dart';
// // import '../models/salarie_item.dart';

// // class SalarieLookupController extends LookupController<SalarieItem> {
// //   @override
// //   Future<List<SalarieItem>> fetchItems() async {
// //     await Future.delayed(Duration(milliseconds: 500)); // Simuler API
// //     return [
// //       SalarieItem(id: '1', code: 'SAL001', label: 'Ahmed Benali', departement: 'IT'),
// //       SalarieItem(id: '2', code: 'SAL002', label: 'Sofia Karim', departement: 'RH'),
// //     ];
// //   }
// // }


// GenericLookupController