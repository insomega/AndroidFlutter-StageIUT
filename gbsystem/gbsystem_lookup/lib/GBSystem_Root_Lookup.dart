import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gbsystem_root/GBSystem_Root_Controller.dart';
import "package:gbsystem_root/GBSystem_custom_text_field.dart";
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_Root_DataModel.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

class GBSystem_Root_Lookup_TextEditingController<T extends GBSystem_Root_DataModel_Lookup> extends TextEditingController {
  String? idf_Value;
  T? selectedItem; // 👈 stockage direct de l'objet sélectionné

  GBSystem_Root_Lookup_TextEditingController({super.text, this.idf_Value});

  void updateSelection(T? item) {
    if (item != null) {
      idf_Value = item.id; // tu gardes encore l’ID
      text = item.libelle; // tu affiches le libellé
    } else {
      idf_Value = null;
      text = '';
    }
    selectedItem = item; // 👈 on garde l’objet complet
  }

  void clearSelection() {
    idf_Value = null;
    text = '';
    selectedItem = null;
  }

  @override
  void dispose() {
    idf_Value = null;
    selectedItem = null;
    super.dispose();
  }
}

// class GBSystem_Root_Lookup_TextEditingController extends TextEditingController {
//   String? idf_Value;

//   GBSystem_Root_Lookup_TextEditingController({String? text, this.idf_Value}) : super(text: text);

//   void updateSelection(String? id, String displayText) {
//     idf_Value = id;
//     text = displayText;
//   }

//   void clearSelection() {
//     idf_Value = null;
//     text = '';
//   }

//   @override
//   void dispose() {
//     idf_Value = null;
//     super.dispose();
//   }
// }

abstract class Filterable<T> {
  Map<String, dynamic Function(T item)> get availableFilters;
}

class GBSystem_Root_Lookup_Controller<T extends GBSystem_Root_DataModel_Lookup> extends GBSystem_Root_Controller implements Filterable<T> {
  final RxList<T> items = <T>[].obs;
  final RxList<T> filteredItems = <T>[].obs;
  //final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final Rxn<T> selectedItem = Rxn<T>();
  final RxMap<String, dynamic> activeFilters = <String, dynamic>{}.obs;
  final GBSystem_Root_Lookup_TextEditingController searchController = GBSystem_Root_Lookup_TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  final TextEditingController searchTextController = TextEditingController();

  final Widget Function(T) itemBuilder = _defaultItemBuilder;

  String get labelText => "";
  String get title => "";

  // Builder par défaut basé sur GBSystem_Root_DataModel_Lookup
  static Widget _defaultItemBuilder<T extends GBSystem_Root_DataModel_Lookup>(T item) {
    return ListTile(
      title: Text(item.libelle),
      subtitle: item.code.isNotEmpty == true ? Text(item.code) : null,
      leading: CircleAvatar(child: Text(item.libelle[0])),
      //
    );
  }

  Future ActivateLookup() async {
    bool canContinue = await initializeData();
    if (canContinue) {
      await Get.to(
        GBSystem_Root_Lookup_View<T>(
          title: '${GBSystem_Application_Strings.str_rechercher.tr}  /  $title', //'Recherche de salariés',
          controller: this, //SalarieLookupController(),
          txtController: searchController,
          //  itemBuilder: (salarie) => ListTile(title: Text(salarie.libelle), subtitle: Text(salarie.departement)),
          itemBuilder: itemBuilder,
          customFilterWidgets: [
            // Vous pouvez ajouter des widgets de filtre supplémentaires ici
          ],
        ),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    //initializeData();
  }

  // Méthode abstraite à implémenter par les classes filles
  Future<List<T>> loadData() async {
    // Implémentation spécifique pour charger les salariés
    // Par exemple:
    // 1. Depuis une API
    // return await SalarieApi.fetchAll();

    // 2. Depuis une base de données locale
    // return await DatabaseHelper.getSalaries();

    // 3. Depuis des données mock (pour les tests)
    return <T>[]; // Retourne une liste vide par défaut
  }

  // Méthode pour charger et initialiser les données
  Future<bool> initializeData() async {
    try {
      isLoading.value = true;
      final data = await loadData();
      items.assignAll(data);
      filteredItems.assignAll(items);
      return true;
    } catch (e) {
      Get.snackbar('Erreur', 'Échec du chargement des données: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
    return false;
  }

  @override
  Map<String, dynamic Function(T item)> get availableFilters => {};

  void onSearchChanged(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void setFilter(String key, dynamic value) {
    if (value == null) {
      activeFilters.remove(key);
    } else {
      activeFilters[key] = value;
    }
    applyFilters();
  }

  void applyFilters() {
    filteredItems.assignAll(
      items.where((item) {
        // Filtre par recherche texte
        final matchesSearch =
            searchQuery
                .value
                .isEmpty //
                ||
            item.id.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            item.libelle.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            item.code.toLowerCase().contains(searchQuery.value.toLowerCase());

        // Filtres supplémentaires
        bool matchesAllFilters = true;
        activeFilters.forEach((key, value) {
          if (value != null) {
            final filterFn = availableFilters[key];
            if (filterFn != null) {
              final itemValue = filterFn(item);
              if (value is List) {
                matchesAllFilters = matchesAllFilters && value.contains(itemValue);
              } else {
                matchesAllFilters = matchesAllFilters && (itemValue == value);
              }
            }
          }
        });

        return matchesSearch && matchesAllFilters;
      }),
    );
  }

  void selectItem(T item, GBSystem_Root_Lookup_TextEditingController txtController) {
    selectedItem.value = item;
    // Mettre à jour le TextEditingController si fourni
    //txtController.updateSelection(item.id, item.libelle);
    txtController.updateSelection(item); // 👈 on lui passe l’objet complet
    Get.back(result: item);
  }
}

class Root_Lookup_Params<T extends GBSystem_Root_DataModel_Lookup> {
  final String title;
  final Future<List<T>> Function() dataLoader;
  final Map<String, dynamic Function(T item)> availableFilters;
  final Widget Function(T) itemBuilder; // Plus final et non nullable
  final String hintText;
  final InputDecoration? decoration;
  final List<Widget>? customFilterWidgets;

  Root_Lookup_Params({
    required this.title,
    required this.dataLoader,
    required this.availableFilters,
    Widget Function(T)? itemBuilder, // Paramètre optionnel
    this.hintText = 'Rechercher...',
    this.decoration,
    this.customFilterWidgets,
  }) : itemBuilder = itemBuilder ?? _defaultItemBuilder; // Initialisation directe

  // Builder par défaut basé sur GBSystem_Root_DataModel_Lookup
  static Widget _defaultItemBuilder<T extends GBSystem_Root_DataModel_Lookup>(T item) {
    return ListTile(
      title: Text(item.libelle),
      subtitle: item.code.isNotEmpty == true ? Text(item.code) : null,
      leading: CircleAvatar(child: Text(item.libelle[0])),
      //
    );
  }
}

class GBSystem_Root_Lookup_View<T extends GBSystem_Root_DataModel_Lookup> extends StatelessWidget {
  final String title;
  final GBSystem_Root_Lookup_Controller<T> controller;
  final Widget Function(T) itemBuilder;
  final List<Widget>? customFilterWidgets;
  final GBSystem_Root_Lookup_TextEditingController? txtController;

  const GBSystem_Root_Lookup_View({
    super.key,
    required this.title,
    required this.controller,
    required this.itemBuilder,
    this.customFilterWidgets,
    this.txtController,
    //
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,

      // appBar: AppBar(
      //   title: Text(title),
      //   actions: [
      //     if (controller.availableFilters.isNotEmpty)
      //       IconButton(
      //         onPressed: () => _showFilterDialog(context),
      //         icon: Obx(() => Badge(isLabelVisible: controller.activeFilters.isNotEmpty, child: Icon(Icons.filter_alt))),
      //       ),
      //   ],
      // ),
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (controller.availableFilters.isNotEmpty)
            IconButton(
              onPressed: () => _showFilterDialog(context),
              icon: Obx(() => Badge(isLabelVisible: controller.activeFilters.isNotEmpty, child: Icon(Icons.filter_alt))),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.searchTextController,
              decoration: InputDecoration(
                hintText: "Rechercher",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                filled: true,
                suffixIcon: Obx(() {
                  if (controller.searchQuery.isNotEmpty) {
                    return IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        controller.searchQuery.value = '';
                        controller.applyFilters();
                        controller.searchTextController.clear();
                      },
                    );
                  }
                  return SizedBox.shrink();
                }),
              ),
              onChanged: controller.onSearchChanged,
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       labelText: 'Rechercher',
          //       prefixIcon: Icon(Icons.search),
          //       border: OutlineInputBorder(),
          //       suffixIcon: Obx(() {
          //         if (controller.searchQuery.isNotEmpty) {
          //           return IconButton(
          //             icon: Icon(Icons.clear),
          //             onPressed: () {
          //               controller.searchQuery.value = '';
          //               controller.applyFilters();
          //             },
          //           );
          //         }
          //         return Container();
          //       }),
          //     ),
          //     onChanged: controller.onSearchChanged,
          //   ),
          // ),
          if (customFilterWidgets != null) ...customFilterWidgets!,

          Obx(() => controller.activeFilters.isNotEmpty ? _buildActiveFiltersChips() : SizedBox.shrink()),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return controller.filteredItems.isEmpty
                  ? Center(child: Text('Aucun résultat trouvé'))
                  : ListView.builder(
                      itemCount: controller.filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = controller.filteredItems[index];
                        return InkWell(onTap: () => controller.selectItem(item, txtController!), child: itemBuilder(item));
                      },
                    );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveFiltersChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Wrap(
        spacing: 4.0,
        children: controller.activeFilters.entries.map((entry) {
          return Chip(label: Text('${entry.key}: ${entry.value}'), onDeleted: () => controller.setFilter(entry.key, null));
        }).toList(),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filtres'),
        content: _buildFilterOptions(),
        actions: [
          TextButton(
            onPressed: () {
              controller.activeFilters.clear();
              controller.applyFilters();
              Get.back();
            },
            child: Text('Réinitialiser'),
          ),
          TextButton(onPressed: () => Get.back(), child: Text('Appliquer')),
        ],
      ),
    );
  }

  Widget _buildFilterOptions() {
    return SizedBox(
      width: double.maxFinite,
      child: ListView(
        shrinkWrap: true,
        children: controller.availableFilters.entries.map((entry) {
          final filterKey = entry.key;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(filterKey, style: TextStyle(fontWeight: FontWeight.bold)),
              _buildGenericFilterWidget(filterKey),
              SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGenericFilterWidget(String filterKey) {
    final filterFn = controller.availableFilters[filterKey];
    if (filterFn == null) return SizedBox.shrink();

    final values = controller.items.map(filterFn).toSet().toList();
    values.sort((a, b) => a.toString().compareTo(b.toString()));

    return DropdownButtonFormField<dynamic>(
      initialValue: controller.activeFilters[filterKey],
      items: values.map((value) {
        return DropdownMenuItem(value: value, child: Text(value.toString()));
      }).toList(),
      onChanged: (value) => controller.setFilter(filterKey, value),
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }
}

class GBSystem_Root_Lookup_TextField extends StatelessWidget {
  final dynamic controller_lookup;

  const GBSystem_Root_Lookup_TextField({super.key, required this.controller_lookup});

  @override
  Widget build(BuildContext context) {
    //final controller_lookup = Get.put(GBSystem_Exemple_Serveur_Lookup_Controller());

    return Padding(
      padding: EdgeInsets.only(bottom: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.015)),
      child: CustomTextField(
        //
        controller: controller_lookup.searchController,
        focusNode: controller_lookup.searchFocusNode,
        keyboardType: TextInputType.text,
        suffixIcon: const Icon(Icons.search),
        text: controller_lookup.labelText,
        readOnly: true,
        onTap: controller_lookup.ActivateLookup,
      ),
    );
  }
}
