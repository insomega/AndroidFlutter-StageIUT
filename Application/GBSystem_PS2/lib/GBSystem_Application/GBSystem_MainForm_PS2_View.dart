import 'package:bmsoft_ps2/GBSystem_Application/GBSystem_FilterBottomSheet.dart';
import 'package:gbsystem_root/GBSystem_Root_CardView_Widget.dart';
import 'package:bmsoft_ps2/GBSystem_Application/GBSystem_Vacation_List_PS2_Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_DisplayPhoneNumberWidget.dart';
import 'package:gbsystem_root/GBSystem_SlideToAaction_Call_Phone_Widget.dart';
import 'package:gbsystem_root/GBSystem_button_entrer_sortie.dart';
import 'package:gbsystem_root/GBSystem_snack_bar.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_root/GBSystem_url_launcher_service.dart';
import 'package:gbsystem_root/GBSystem_vacation_model.dart';
import 'package:gbsystem_root/GBSystem_waiting.dart';
//import 'package:gbsystem_root/GBSystem_waiting.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';
import '../GBSystem_Application/GBSystem_MainForm_PS2_Controller.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';

//import 'package:gbsystem_serveur/GBSystem_Serveur_UserWelcome_View.dart';
import 'package:gbsystem_root/GBSystem_Root_MainView.dart';

class GBSystem_MainForm_PS2_View extends GBSystem_Root_MainForm_View<GBSystem_MainForm_PS2_Controller> {
  GBSystem_MainForm_PS2_View({Key? key}) : super(key: key);

  @override
  final controller = Get.put(GBSystem_MainForm_PS2_Controller());

  @override
  Widget buildMainContent(BuildContext context) {
    final Vacation_List_PS2_Controller = Get.put(GBSystem_Vacation_List_PS2_Controller());

    return Column(
      children: [
        SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
        _buildSearchBar(Vacation_List_PS2_Controller),
        SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
        _buildMultiSelectSection(Vacation_List_PS2_Controller),
        SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
        //      Obx(() => Expanded(child: _buildVacationList(context, Vacation_List_PS2_Controller))),
        Expanded(child: Obx(() => _buildVacationList(context, Vacation_List_PS2_Controller))),
      ],
    );
  }

  /// Ici on active le flou seulement quand callBool est vrai
  @override
  bool get shouldBlur => Get.put(GBSystem_Vacation_List_PS2_Controller()).callBool.value;

  @override
  Widget? buildOverlay(BuildContext context) {
    final Vacation_List_PS2_Controller = Get.put(GBSystem_Vacation_List_PS2_Controller());
    return Obx(() {
      if (Vacation_List_PS2_Controller.isLoading.value) return Waiting();
      if (Vacation_List_PS2_Controller.callBool.value) return _buildCallOverlay(context, Vacation_List_PS2_Controller);
      return Container();
    });
  }

  // Widget _buildCallOverlay(BuildContext context) {
  //   return Container(color: Colors.black54, alignment: Alignment.center, child: const Text("En appel..."));
  // }

  //import 'package:gbsystem_vacation_priseservice/GBSystem_Vacation_PriseService_Widget.dart';
  //import 'Routes/GBSystem_Application_Routes.dart';

  // class GBSystem_MainForm_PS2_View extends GBSystem_Root_MainForm_View<GBSystem_MainForm_PS2_Controller> {
  //   GBSystem_MainForm_PS2_View({Key? key}) : super(key: key);

  //   // Ici on crée le contrôleur (via Get.put par exemple)
  //   @override
  //   final controller = Get.put(GBSystem_MainForm_PS2_Controller());

  @override
  List<Widget> appBarActionsBuilder(BuildContext context) => [_buildFilterButton(context)];

  //   @override
  //   Widget buildMainContent(BuildContext context) {
  //     final controller = Get.put(GBSystem_Vacation_List_PS2_Controller());
  //     return Padding(
  //       padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02), vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: [
  //           // 🔍 Barre de recherche
  //           _buildSearchBar(controller),

  //           SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),

  //           // ✅ Section de filtres / multi-select
  //           _buildMultiSelectSection(controller),

  //           SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),

  //           // 📋 Liste des vacations → occupe tout l’espace restant
  //           Expanded(child: _buildVacationList(context, controller)),
  //         ],
  //       ),
  //     );

  //     // return Padding(
  //     //   padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02), vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
  //     //   child: Column(
  //     //     children: [
  //     //       _buildSearchBar(controller),
  //     //       SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
  //     //       _buildMultiSelectSection(controller),
  //     //       SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
  //     //       _buildVacationList(context, controller),
  //     //     ],
  //     //   ),
  //     // );
  //   }

  Widget _buildSearchBar(GBSystem_Vacation_List_PS2_Controller Vacation_List_PS2_Controller) {
    return SearchBar(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      hintText: GBSystem_Application_Strings.str_rechercher,
      controller: Vacation_List_PS2_Controller.controllerSearch,
      leading: const Icon(CupertinoIcons.search),
      trailing: [
        GestureDetector(
          onTap: () async {
            Vacation_List_PS2_Controller.controllerSearch.text = "";
            Vacation_List_PS2_Controller.text.value = "";
            Vacation_List_PS2_Controller.Vacation_Informations_Controller.setSearchtext = "";
            // await controller.getItemsWithAllConditions();
          },

          child: const Icon(Icons.close),
        ),
      ],
      onChanged: Vacation_List_PS2_Controller.filterDataSalarie,
    );
  }

  Widget _buildMultiSelectSection(GBSystem_Vacation_List_PS2_Controller Vacation_List_PS2_Controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 Affiche la card uniquement si au moins une vacation est sélectionnée
        Obx(
          () => Vacation_List_PS2_Controller.Vacation_Informations_Controller.allSelectedVacations.isNotEmpty
              ? //
                _buildMultiSelectCard(Vacation_List_PS2_Controller)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildMultiSelectCard(GBSystem_Vacation_List_PS2_Controller Vacation_List_PS2_Controller) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          children: [
            /// 🔹 Case "Tout sélectionner"
            Obx(
              () => CupertinoCheckbox(
                value: Vacation_List_PS2_Controller.isSelectAllChecked.value,
                activeColor: GBSystem_Application_Strings.str_primary_color,
                onChanged: (value) {
                  if (value ?? false) {
                    Vacation_List_PS2_Controller.selectAllVacations(Vacation_List_PS2_Controller.usedListVacation());
                  } else {
                    Vacation_List_PS2_Controller.clearAllVacations();
                  }
                },
              ),
            ),
            const SizedBox(width: 6),

            Text(GBSystem_Application_Strings.str_tous.tr, style: const TextStyle(fontSize: 14)),
            const Spacer(),

            /// 🔹 Compteur sélectionnés / total
            Obx(
              () => Text(
                '${Vacation_List_PS2_Controller.selectedItems.value} / ${Vacation_List_PS2_Controller.totalItems.value}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: GBSystem_Application_Strings.str_primary_color),
              ),
            ),

            const SizedBox(width: 12),

            /// 🔹 Bouton Entrer
            _buildActionButton(onTap: () => Vacation_List_PS2_Controller.entrerFunction(false), text: GBSystem_Application_Strings.str_entrer, color: Colors.green),

            const SizedBox(width: 8),

            /// 🔹 Bouton Sortie
            _buildActionButton(onTap: () => Vacation_List_PS2_Controller.sortieFunction(false), text: GBSystem_Application_Strings.str_sortie, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required VoidCallback onTap, required String text, required Color color}) {
    return ButtonEntrerSortieWithIconAndText(
      onTap: onTap,
      number: null,
      icon: const Icon(CupertinoIcons.hand_draw_fill, color: Colors.white),
      verPadd: GBSystem_ScreenHelper.screenWidthPercentage(Get.context!, 0.02),
      horPadd: GBSystem_ScreenHelper.screenWidthPercentage(Get.context!, 0.02),
      text: text,
      color: color,
    );
  }

  Widget _buildVacationList(BuildContext context, GBSystem_Vacation_List_PS2_Controller Vacation_List_PS2_Controller) {
    final vacations = Vacation_List_PS2_Controller.usedListVacation;
    //return SizedBox(width: 12);
    return RefreshIndicator(
      onRefresh: () async {
        // 👇 fonction de rechargement
        await Vacation_List_PS2_Controller.initializeController();
      },
      child: vacations.isEmpty
          ? ListView(
              // 👈 obligé pour RefreshIndicator
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        // 👇 reload au tap
                        await Vacation_List_PS2_Controller.initializeController();
                      },
                      child: GBSystem_TextHelper().largeText(text: GBSystem_Application_Strings.str_no_item),
                    ),
                  ),
                ),
              ],
            )
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: vacations.length,
              itemBuilder: (context, index) {
                final vacation = vacations[index];
                return _buildVacationItem(Vacation_List_PS2_Controller, vacation, index);
              },
            ),
    );
  }

  Widget _buildVacationItem(GBSystem_Vacation_List_PS2_Controller Vacation_List_PS2_Controller, GBSystem_Vacation_Model vacation, int index) {
    // 👇 seul le champ isSelected est observé
    return Obx(() {
      final isSelected = Vacation_List_PS2_Controller.Vacation_Informations_Controller.allSelectedVacations.contains(vacation);

      return GBSystem_Root_CardView_VacationWidget(
        vacation: vacation,
        isSelected: isSelected,
        tileColor: index % 2 == 0 ? Colors.grey.withOpacity(0.2) : Colors.white,
        onEnterTap: () => Vacation_List_PS2_Controller.entrerFunctionSingle(PointageVacation: vacation),
        onSortieTap: () => Vacation_List_PS2_Controller.sortieFunctionSingle(PointageVacation: vacation),
        onCallTap: () {
          Vacation_List_PS2_Controller.callBool.value = true;
          Vacation_List_PS2_Controller.phoneNumber = vacation.SVR_TELPH;
        },
        onTap: () => _onVacationTap(Vacation_List_PS2_Controller, vacation),
        onLeadingTap: () => Vacation_List_PS2_Controller.selectItemAllSelectedVacation(selectedVacation: vacation),
      );
    });
  }

  void _onVacationTap(GBSystem_Vacation_List_PS2_Controller Vacation_List_PS2_Controller, GBSystem_Vacation_Model vacation) {
    if (Vacation_List_PS2_Controller.isSwitchOn.value) {
      Vacation_List_PS2_Controller.selectItemAllSelectedVacation(selectedVacation: vacation);
      Vacation_List_PS2_Controller.isSelectAllChecked.value = (Vacation_List_PS2_Controller.totalItems.value == Vacation_List_PS2_Controller.selectedItems.value);
      // if (Vacation_List_PS2_Controller.totalItems.value == Vacation_List_PS2_Controller.selectedItems.value) {
      //   Vacation_List_PS2_Controller.isSelectAllChecked.value = true;
      // } else {
      //   Vacation_List_PS2_Controller.isSelectAllChecked.value = false;
      // }
    } else {
      Vacation_List_PS2_Controller.selectItemAllVacationFunction(selectedVacation: vacation);
    }
  }

  Widget _buildCallOverlay(BuildContext context, GBSystem_Vacation_List_PS2_Controller Vacation_List_PS2_Controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GBSystem_SlideToAaction_Call_Phone_Widget(
          onSubmit: () async {
            Vacation_List_PS2_Controller.callBool.value = false;
            if (Vacation_List_PS2_Controller.phoneNumber != null && Vacation_List_PS2_Controller.phoneNumber!.isNotEmpty) {
              GBSystem_UrlLauncherService().callNumber(context, number: Vacation_List_PS2_Controller.phoneNumber ?? "");
            } else {
              showWarningDialog(GBSystem_Application_Strings.str_numero_telephone_vide);
            }
          },
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 10),
              Transform.translate(
                offset: Offset(-GBSystem_ScreenHelper.screenWidthPercentage(context, 0.1), 0),
                child: GBSystem_DisplayPhoneNumberWidget(phoneNumber: Vacation_List_PS2_Controller.phoneNumber ?? ""),
              ),
              CupertinoButton(
                onPressed: () => Vacation_List_PS2_Controller.callBool.value = false,
                child: const Icon(CupertinoIcons.xmark, size: 40, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return InkWell(
      onTap: () => _showFilterBottomSheet(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.filter_list, color: Colors.white),
          GBSystem_TextHelper().superSmallText(text: GBSystem_Application_Strings.str_filtre, textColor: Colors.white),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      //builder: (context) => FilterBottomSheet(updateUI: () => controller.updateUI()),
      builder: (context) => FilterBottomSheet(),
    );
  }
}
