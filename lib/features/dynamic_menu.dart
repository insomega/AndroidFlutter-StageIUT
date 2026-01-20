// lib/features/dynamic_menu.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/menu_model.dart';
import '../components/menu_tile.dart';
import '../components/digital_clock.dart';
import 'package:get/get.dart'; // Importation de GetX pour la gestion d'état
import '../features/navigation_controller.dart';

class DynamicMenu extends StatefulWidget {
  final String jsonPath;

  const DynamicMenu({super.key, required this.jsonPath});

  @override
  State<DynamicMenu> createState() => _DynamicMenuState();
}

class _DynamicMenuState extends State<DynamicMenu> {
  // Future stocké pour éviter des rechargements asynchrones inutiles lors des builds
  late Future<List<MenuModel>> _menuFuture;

  @override
  void initState() {
    super.initState();
    // Chargement unique du fichier JSON au démarrage du widget
    _menuFuture = _loadMenu();
  }

  /// Charge le fichier JSON, le décode et le transforme en liste de MenuModel
  Future<List<MenuModel>> _loadMenu() async {
    final String response = await rootBundle.loadString(widget.jsonPath);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => MenuModel.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Récupération du contrôleur de navigation GetX précédemment injecté
    final navCtrl = Get.find<NavigationController>();

    return Drawer(
      child: Column(
        children: [
          // En-tête personnalisé avec dégradé bleu
          _buildHeader(),
          
          Expanded(
            child: FutureBuilder<List<MenuModel>>(
              future: _menuFuture, // Utilisation du Future initialisé
              builder: (context, snapshot) {
                // Affichage d'un indicateur de chargement tant que le JSON n'est pas prêt
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                return ListView.separated(
                  padding: EdgeInsets.zero, // Supprime les marges par défaut (notamment en haut)
                  itemCount: snapshot.data!.length,
                  // Séparateur discret entre chaque élément du menu
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    
                    return MenuTile(
                      item: item,
                      onTap: (unusedId) {
                        // Navigation réactive via GetX en utilisant le pageId extrait du href
                        navCtrl.navigateTo(item.pageId);
                        
                        // Fermeture automatique du Drawer (tiroir) après la sélection
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            ),
          ),
          
          // Pied de page contenant l'horloge numérique temps réel
          const DigitalClockFooter(),
        ],
      ),
    );
  }

  /// Construit le bandeau bleu en haut du menu
  Widget _buildHeader() {
    return Container(
      width: double.infinity, // Occupe toute la largeur du tiroir
      padding: EdgeInsets.only(
        // Calcul dynamique pour ne pas chevaucher la barre de statut (encoche/heure)
        top: MediaQuery.of(context).padding.top + 20,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        // Dégradé conforme à la charte graphique
        gradient: LinearGradient(
          colors: [Colors.blue[900]!, Colors.blue[700]!],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          // Remplacement de l'Icon simple par un IconButton cliquable
          IconButton(
            icon: const Icon(Icons.menu_open, color: Colors.white, size: 30),
            tooltip: "Fermer le menu",
            onPressed: () {
              // Cette commande ferme le Drawer (le tiroir latéral)
              Navigator.pop(context); 
            },
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              "ESPACE SALARIÉ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}