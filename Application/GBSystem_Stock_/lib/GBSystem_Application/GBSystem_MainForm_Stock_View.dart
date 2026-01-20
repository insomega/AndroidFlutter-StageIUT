import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:gbsystem_root/GBSystem_DisplayPhoneNumberWidget.dart';
// import 'package:gbsystem_root/GBSystem_SlideToAaction_Call_Phone_Widget.dart';
// import 'package:gbsystem_root/GBSystem_button_entrer_sortie.dart';
// import 'package:gbsystem_root/GBSystem_snack_bar.dart';
// import 'package:gbsystem_root/GBSystem_text_helper.dart';
// import 'package:gbsystem_root/GBSystem_url_launcher_service.dart';
// import 'package:gbsystem_root/GBSystem_vacation_model.dart';
// import 'package:gbsystem_root/GBSystem_waiting.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_home_affectuer_articles_gestion_stock_screen.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_home_gestion_stock_screen.dart';
import 'package:gbsystem_stock/GBSystem_Application/choose_mode_button_widget.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_Ajout_Article_To_Stock_View.dart';
import 'package:gbsystem_stock/GBSystem_Application/home_add_article_screen.dart';
import 'package:gbsystem_stock/GBSystem_Application/select_item_article_screen.dart';
//import 'package:gbsystem_root/GBSystem_waiting.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';
import 'GBSystem_MainForm_Stock_Controller.dart';
//import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';

//import 'package:gbsystem_serveur/GBSystem_Serveur_UserWelcome_View.dart';
import 'package:gbsystem_root/GBSystem_Root_MainView.dart';

class GBSystem_MainForm_Stock_View extends GBSystem_Root_MainForm_View<GBSystem_MainForm_Stock_Controller> {
  GBSystem_MainForm_Stock_View({Key? key}) : super(key: key);

  @override
  final controller = Get.put(GBSystem_MainForm_Stock_Controller());

  @override
  Widget buildMainContent(BuildContext context) {
    return Column(
      children: [
        _buildModeButton(
          onTap: () => _navigateToAddArticle(),
          icon: Icon(CupertinoIcons.add_circled_solid, color: Colors.black, size: 80),
          text: GBSystem_Application_Strings.str_ajouter_articles,
        ),
        const SizedBox(height: 5),
        _buildModeButton(
          onTap: () => _navigateToGestionStock(),
          icon: Icon(CupertinoIcons.bag_fill, color: Colors.black, size: 80),
          text: GBSystem_Application_Strings.str_article_affectuer,
        ),
        const SizedBox(height: 5),
        _buildModeButton(
          onTap: () => _navigateToAffecterArticles(),
          icon: Icon(CupertinoIcons.bag_fill_badge_plus, color: Colors.black, size: 80),
          text: GBSystem_Application_Strings.str_affecter_article,
        ),
        const SizedBox(height: 5),
        _buildModeButton(
          onTap: () => _navigateToGenerateCodes(),
          icon: Icon(CupertinoIcons.barcode, color: Colors.black, size: 80),
          text: "${GBSystem_Application_Strings.str_generation} ${GBSystem_Application_Strings.str_qr_code} / ${GBSystem_Application_Strings.str_bar_code}",
        ),
      ],
    );
  }

  Widget _buildModeButton({required VoidCallback onTap, required Icon icon, required String text}) {
    return ChooseModeButtonWidget(onTap: onTap, icon: icon, text: text);
  }

  void _navigateToAddArticle() {
    controller.viderPreviousData();
    //Get.to(GBSystem_Ajout_Article_To_Stock_View());
    Get.to(HomeAddArticleScreen());
  }

  void _navigateToGestionStock() {
    controller.viderPreviousData();
    controller.viderDataAgenceSalarie();
    Get.to(GBSystemHomeGestionStockScreen());
  }

  void _navigateToAffecterArticles() {
    controller.viderPreviousData();
    controller.viderDataAgenceSalarie();
    Get.to(GBSystemHomeAffectuerArticlesGestionStockScreen());
  }

  void _navigateToGenerateCodes() {
    controller.viderPreviousData();
    controller.loadArticlesRef();
    Get.to(GBSystem_SelectItemArticleScreen());
  }

  /*---------------------------------------------------------------------------------------------------------------------------------- */
  /*---------------------------------------------------------------------------------------------------------------------------------- */
  /*---------------------------------------------------------------------------------------------------------------------------------- */
  /*---------------------------------------------------------------------------------------------------------------------------------- */
  /*---------------------------------------------------------------------------------------------------------------------------------- */
  /// Ici on active le flou seulement quand callBool est vrai
  @override
  bool get shouldBlur => false; //Get.put(GBSystemSelectItemVacationController()).callBool.value;

  // @override
  // Widget? buildOverlay(BuildContext context) {
  //   final subController = Get.put(GBSystemSelectItemVacationController());
  //   return Obx(() {
  //     if (subController.isLoading.value) return Waiting();
  //     if (subController.callBool.value) return _buildCallOverlay(context, subController);
  //     return Container();
  //   });
  // }

  // @override
  // List<Widget> appBarActionsBuilder(BuildContext context) => [_buildFilterButton(context)];

  // Widget _buildSearchBar(GBSystemSelectItemVacationController controller) {
  //   return SearchBar(
  //     shape: MaterialStateProperty.all(
  //       RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12.0),
  //         side: const BorderSide(color: Colors.grey, width: 1.0),
  //       ),
  //     ),
  //     hintText: GBSystem_Application_Strings.str_rechercher,
  //     controller: controller.controllerSearch,
  //     leading: const Icon(CupertinoIcons.search),
  //     trailing: [
  //       GestureDetector(
  //         onTap: () async {
  //           controller.controllerSearch.text = "";
  //           controller.text.value = "";
  //           controller.vacationController.setSearchtext = "";
  //           // await controller.getItemsWithAllConditions();
  //         },

  //         child: const Icon(Icons.close),
  //       ),
  //     ],
  //     onChanged: controller.filterDataSalarie,
  //   );
  // }

  // Widget _buildMultiSelectSection(GBSystemSelectItemVacationController controller) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       /// 🔹 Affiche la card uniquement si au moins une vacation est sélectionnée
  //       Obx(
  //         () => controller.vacationController.allSelectedVacations.isNotEmpty
  //             ? //
  //               _buildMultiSelectCard(controller)
  //             : const SizedBox.shrink(),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildMultiSelectCard(GBSystemSelectItemVacationController controller) {
  //   return Card(
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
  //       child: Row(
  //         children: [
  //           /// 🔹 Case "Tout sélectionner"
  //           Obx(
  //             () => CupertinoCheckbox(
  //               value: controller.isSelectAllChecked.value,
  //               activeColor: GBSystem_Application_Strings.str_primary_color,
  //               onChanged: (value) {
  //                 if (value ?? false) {
  //                   controller.selectAllVacations(controller.usedListVacation());
  //                 } else {
  //                   controller.clearAllVacations();
  //                 }
  //               },
  //             ),
  //           ),
  //           const SizedBox(width: 6),

  //           Text(GBSystem_Application_Strings.str_tous.tr, style: const TextStyle(fontSize: 14)),
  //           const Spacer(),

  //           /// 🔹 Compteur sélectionnés / total
  //           Obx(
  //             () => Text(
  //               '${controller.selectedItems.value} / ${controller.totalItems.value}',
  //               style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: GBSystem_Application_Strings.str_primary_color),
  //             ),
  //           ),

  //           const SizedBox(width: 12),

  //           /// 🔹 Bouton Entrer
  //           _buildActionButton(onTap: () => controller.entrerFunction(false), text: GBSystem_Application_Strings.str_entrer, color: Colors.green),

  //           const SizedBox(width: 8),

  //           /// 🔹 Bouton Sortie
  //           _buildActionButton(onTap: () => controller.sortieFunction(false), text: GBSystem_Application_Strings.str_sortie, color: Colors.red),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildActionButton({required VoidCallback onTap, required String text, required Color color}) {
  //   return ButtonEntrerSortieWithIconAndText(
  //     onTap: onTap,
  //     number: null,
  //     icon: const Icon(CupertinoIcons.hand_draw_fill, color: Colors.white),
  //     verPadd: GBSystem_ScreenHelper.screenWidthPercentage(Get.context!, 0.02),
  //     horPadd: GBSystem_ScreenHelper.screenWidthPercentage(Get.context!, 0.02),
  //     text: text,
  //     color: color,
  //   );
  // }

  // Widget _buildVacationList(BuildContext context, GBSystemSelectItemVacationController controller) {
  //   final vacations = controller.usedListVacation;
  //   //return SizedBox(width: 12);
  //   return RefreshIndicator(
  //     onRefresh: () async {
  //       // 👇 fonction de rechargement
  //       await controller.initializeController();
  //     },
  //     child: vacations.isEmpty
  //         ? ListView(
  //             // 👈 obligé pour RefreshIndicator
  //             physics: const AlwaysScrollableScrollPhysics(),
  //             children: [
  //               SizedBox(
  //                 height: MediaQuery.of(context).size.height * 0.7,
  //                 child: Center(
  //                   child: GestureDetector(
  //                     onTap: () async {
  //                       // 👇 reload au tap
  //                       await controller.initializeController();
  //                     },
  //                     child: GBSystem_TextHelper().largeText(text: GBSystem_Application_Strings.str_no_item),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           )
  //         : ListView.builder(
  //             physics: const AlwaysScrollableScrollPhysics(),
  //             itemCount: vacations.length,
  //             itemBuilder: (context, index) {
  //               final vacation = vacations[index];
  //               return _buildVacationItem(controller, vacation, index);
  //             },
  //           ),
  //   );
  // }

  // Widget _buildVacationItem(GBSystemSelectItemVacationController controller, GBSystem_Vacation_Model vacation, int index) {
  //   // 👇 seul le champ isSelected est observé
  //   return Obx(() {
  //     final isSelected = controller.vacationController.allSelectedVacations.contains(vacation);

  //     return GBSystem_Root_CardView_VacationWidget(
  //       vacation: vacation,
  //       isSelected: isSelected,
  //       tileColor: index % 2 == 0 ? Colors.grey.withOpacity(0.2) : Colors.white,
  //       onEnterTap: () => controller.entrerFunctionSingle(PointageVacation: vacation),
  //       onSortieTap: () => controller.sortieFunctionSingle(PointageVacation: vacation),
  //       onCallTap: () {
  //         controller.callBool.value = true;
  //         controller.phoneNumber = vacation.SVR_TELPH;
  //       },
  //       onTap: () => _onVacationTap(controller, vacation),
  //       onLeadingTap: () => controller.selectItemAllSelectedVacation(selectedVacation: vacation),
  //     );
  //   });
  // }

  // void _onVacationTap(GBSystemSelectItemVacationController controller, GBSystem_Vacation_Model vacation) {
  //   if (controller.isSwitchOn.value) {
  //     controller.selectItemAllSelectedVacation(selectedVacation: vacation);

  //     if (controller.totalItems.value == controller.selectedItems.value) {
  //       controller.isSelectAllChecked.value = true;
  //     } else {
  //       controller.isSelectAllChecked.value = false;
  //     }
  //   } else {
  //     controller.selectItemAllVacationFunction(selectedVacation: vacation);
  //   }
  // }

  // Widget _buildCallOverlay(BuildContext context, GBSystemSelectItemVacationController controller) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       GBSystem_SlideToAaction_Call_Phone_Widget(
  //         onSubmit: () async {
  //           controller.callBool.value = false;
  //           if (controller.phoneNumber != null && controller.phoneNumber!.isNotEmpty) {
  //             GBSystem_UrlLauncherService().callNumber(context, number: controller.phoneNumber ?? "");
  //           } else {
  //             showWarningDialog(GBSystem_Application_Strings.str_numero_telephone_vide);
  //           }
  //         },
  //       ),
  //       Positioned(
  //         top: 10,
  //         right: 10,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             const SizedBox(height: 10),
  //             Transform.translate(
  //               offset: Offset(-GBSystem_ScreenHelper.screenWidthPercentage(context, 0.1), 0),
  //               child: GBSystem_DisplayPhoneNumberWidget(phoneNumber: controller.phoneNumber ?? ""),
  //             ),
  //             CupertinoButton(
  //               onPressed: () => controller.callBool.value = false,
  //               child: const Icon(CupertinoIcons.xmark, size: 40, color: Colors.white),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildFilterButton(BuildContext context) {
  //   return InkWell(
  //     onTap: () => _showFilterBottomSheet(context),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         const Icon(Icons.filter_list, color: Colors.white),
  //         GBSystem_TextHelper().superSmallText(text: GBSystem_Application_Strings.str_filtre, textColor: Colors.white),
  //       ],
  //     ),
  //   );
  // }

  // void _showFilterBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
  //     //builder: (context) => FilterBottomSheet(updateUI: () => controller.updateUI()),
  //     builder: (context) => FilterBottomSheet(),
  //   );
  // }
}
