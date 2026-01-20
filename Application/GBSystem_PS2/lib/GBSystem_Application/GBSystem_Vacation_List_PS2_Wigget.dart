import 'dart:ui';

import 'package:bmsoft_ps2/GBSystem_Application/GBSystem_FilterBottomSheet.dart';
import 'package:gbsystem_root/GBSystem_Root_CardView_Widget.dart';
import 'package:bmsoft_ps2/GBSystem_Application/GBSystem_Vacation_List_PS2_Controller.dart';
import 'package:gbsystem_root/GBSystem_DisplayPhoneNumberWidget.dart';
import 'package:gbsystem_root/GBSystem_SlideToAaction_Call_Phone_Widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_button_entrer_sortie.dart';
import 'package:gbsystem_root/GBSystem_snack_bar.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_root/GBSystem_url_launcher_service.dart';
import 'package:gbsystem_root/GBSystem_waiting.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

import 'package:gbsystem_root/GBSystem_vacation_model.dart';
import 'package:get/get.dart';

// gbsystem_select_item_vacation_screen.dart
class GBSystem_Vacation_List_PS2_Wigget extends StatelessWidget {
  //const GBSystem_Vacation_List_PS2_Wigget({super.key, });

  //final bool toListVacations;
  //final Widget destination;

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(GBSystem_Vacation_List_PS2_Controller(context: context, destination: destination, updateUI: () => Get.find<GBSystem_Vacation_List_PS2_Controller>().update()));
    final controller = Get.put(GBSystem_Vacation_List_PS2_Controller());

    return Scaffold(body: Obx(() => _buildMainContent(context, controller)));
  }

  Widget _buildMainContent(BuildContext context, GBSystem_Vacation_List_PS2_Controller controller) {
    return Stack(
      children: [
        AbsorbPointer(
          absorbing: controller.callBool.value,
          child: ImageFiltered(
            imageFilter: controller.callBool.value ? ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0) : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.white,
              appBar: _buildAppBar(context, controller),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02), vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
                child: Column(
                  children: [
                    _buildSearchBar(controller),
                    SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
                    _buildMultiSelectSection(controller),
                    SizedBox(height: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
                    _buildVacationList(context, controller),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (controller.callBool.value) _buildCallOverlay(context, controller),
        if (controller.isLoading.value) Waiting(),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context, GBSystem_Vacation_List_PS2_Controller controller) {
    return AppBar(
      elevation: 4.0,
      shadowColor: Colors.grey.withOpacity(0.5),
      toolbarHeight: 70,
      backgroundColor: GBSystem_Application_Strings.str_primary_color,
      centerTitle: true,
      title: const Text(GBSystem_Application_Strings.str_home_page, style: TextStyle(color: Colors.white)),
      leading: InkWell(
        onTap: () => _onBackPressed(controller),
        child: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
      ),
      actions: [_buildFilterButton(context, controller)],
    );
  }

  void _onBackPressed(GBSystem_Vacation_List_PS2_Controller controller) {
    controller.Vacation_Informations_Controller.setFilterDebutBool = false;
    controller.Vacation_Informations_Controller.setFilterFinBool = false;
    controller.Vacation_Informations_Controller.setFilterLieuBool = false;
    controller.Vacation_Informations_Controller.setFilterEvenementsBool = false;

    controller.Vacation_Informations_Controller.setFilterDateDebut = null;
    controller.Vacation_Informations_Controller.setFilterDateFin = null;
    controller.Vacation_Informations_Controller.setAllFiltredLieu = null;
    controller.Vacation_Informations_Controller.setAllFiltredEvenements = null;

    Get.back();
  }

  Widget _buildFilterButton(BuildContext context, GBSystem_Vacation_List_PS2_Controller controller) {
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

  Widget _buildSearchBar(GBSystem_Vacation_List_PS2_Controller controller) {
    return SearchBar(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      hintText: GBSystem_Application_Strings.str_rechercher,
      controller: controller.controllerSearch,
      leading: const Icon(CupertinoIcons.search),
      trailing: [
        GestureDetector(
          onTap: () async {
            controller.controllerSearch.text = "";
            controller.text.value = "";
            controller.Vacation_Informations_Controller.setSearchtext = "";
            // await controller.getItemsWithAllConditions();
          },

          child: const Icon(Icons.close),
        ),
      ],
      onChanged: controller.filterDataSalarie,
    );
  }

  Widget _buildMultiSelectSection(GBSystem_Vacation_List_PS2_Controller controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 Affiche la card uniquement si au moins une vacation est sélectionnée
        Obx(() => controller.Vacation_Informations_Controller.allSelectedVacations.isNotEmpty ? _buildMultiSelectCard(controller) : const SizedBox.shrink()),
      ],
    );
  }

  Widget _buildMultiSelectCard(GBSystem_Vacation_List_PS2_Controller controller) {
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
                value: controller.isSelectAllChecked.value,
                activeColor: GBSystem_Application_Strings.str_primary_color,
                onChanged: (value) {
                  if (value ?? false) {
                    controller.selectAllVacations(controller.usedListVacation());
                  } else {
                    controller.clearAllVacations();
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
                '${controller.selectedItems.value} / ${controller.totalItems.value}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: GBSystem_Application_Strings.str_primary_color),
              ),
            ),

            const SizedBox(width: 12),

            /// 🔹 Bouton Entrer
            _buildActionButton(onTap: () => controller.entrerFunction(false), text: GBSystem_Application_Strings.str_entrer, color: Colors.green),

            const SizedBox(width: 8),

            /// 🔹 Bouton Sortie
            _buildActionButton(onTap: () => controller.sortieFunction(false), text: GBSystem_Application_Strings.str_sortie, color: Colors.red),
          ],
        ),
      ),
    );
  }

  // Widget _buildMultiSelectCard(GBSystem_Vacation_List_PS2_Controller controller) {
  //   return Card(
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //     child: Padding(
  //       padding: const EdgeInsets.all(12.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           /// 🔹 Case "Tout sélectionner"
  //           Row(
  //             children: [
  //               Obx(
  //                 () => CupertinoCheckbox(
  //                   value: controller.isSelectAllChecked.value,
  //                   activeColor: GBSystem_Application_Strings.str_primary_color,
  //                   onChanged: (value) {
  //                     if (value ?? false) {
  //                       controller.selectAllVacations(controller.usedListVacation());
  //                     } else {
  //                       controller.clearAllVacations();
  //                     }
  //                   },
  //                 ),
  //               ),
  //               Text(GBSystem_Application_Strings.str_selectionner_tous, style: const TextStyle(fontSize: 16)),
  //             ],
  //           ),

  //           const SizedBox(height: 5),

  //           /// 🔹 Compteur sélectionnés / total
  //           Obx(
  //             () => Text(
  //               '${GBSystem_Application_Strings.str_selected_vacations}: '
  //               '${controller.selectedItems.value} / ${controller.totalItems.value}',
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: GBSystem_Application_Strings.str_primary_color),
  //             ),
  //           ),

  //           const SizedBox(height: 12),

  //           /// 🔹 Boutons actions
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               _buildActionButton(onTap: () => controller.entrerFunction(false), text: GBSystem_Application_Strings.str_entrer, color: Colors.green),
  //               _buildActionButton(onTap: () => controller.sortieFunction(false), text: GBSystem_Application_Strings.str_sortie, color: Colors.red),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildMultiSelectSection(GBSystem_Vacation_List_PS2_Controller controller) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       // Option cachée (inchangée)
  //       Visibility(
  //         visible: false,
  //         child: ListTile(
  //           title: Text(GBSystem_Application_Strings.str_vacation_non_pointer, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //           leading: SizedBox(
  //             height: 15,
  //             width: 15,
  //             child: Obx(
  //               () => CupertinoCheckbox(
  //                 value: controller.isVacationNonPointer.value,
  //                 activeColor: GBSystem_Application_Strings.str_primary_color,
  //                 onChanged: (value) {
  //                   controller.isVacationNonPointer.value = value ?? false;
  //                 },
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),

  //       /// 🔹 Affiche la card uniquement s’il y a au moins 1 sélection
  //       Obx(() {
  //         final hasSelection = controller.Vacation_Informations_Controller.allSelectedVacations.isNotEmpty;
  //         return hasSelection ? _buildMultiSelectCard(controller) : const SizedBox.shrink();
  //       }),
  //     ],
  //   );
  // }

  // Widget _buildMultiSelectCard(GBSystem_Vacation_List_PS2_Controller controller) {
  //   final total = controller.usedListVacation().length;

  //   return Card(
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           /// 🔹 Sélectionner tous
  //           Row(
  //             children: [
  //               Obx(
  //                 () => CupertinoCheckbox(
  //                   value: controller.isSelectAllChecked.value,
  //                   activeColor: GBSystem_Application_Strings.str_primary_color,
  //                   onChanged: (value) {
  //                     if (value ?? false) {
  //                       controller.selectAllVacations(controller.usedListVacation());
  //                     } else {
  //                       controller.clearAllVacations();
  //                     }
  //                   },
  //                 ),
  //               ),
  //               Text(GBSystem_Application_Strings.str_selectionner_tous, style: const TextStyle(fontSize: 16)),
  //             ],
  //           ),

  //           const SizedBox(height: 5),

  //           /// 🔹 Nombre sélectionnés
  //           Obx(
  //             () => Text(
  //               '${GBSystem_Application_Strings.str_selected_vacations}: '
  //               '${controller.Vacation_Informations_Controller.allSelectedVacations.length} / $total',
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: GBSystem_Application_Strings.str_primary_color),
  //             ),
  //           ),

  //           /// 🔹 Boutons actions
  //           Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 8),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 _buildActionButton(onTap: () => controller.entrerFunction(false), text: GBSystem_Application_Strings.str_entrer, color: Colors.green),
  //                 _buildActionButton(onTap: () => controller.sortieFunction(false), text: GBSystem_Application_Strings.str_sortie, color: Colors.red),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildMultiSelectSection(GBSystem_Vacation_List_PS2_Controller controller) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Visibility(
  //         visible: false,
  //         child: ListTile(
  //           title: Text(GBSystem_Application_Strings.str_vacation_non_pointer, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //           leading: SizedBox(
  //             height: 15,
  //             width: 15,
  //             child: Obx(
  //               () => CupertinoCheckbox(
  //                 value: controller.isVacationNonPointer.value,
  //                 activeColor: GBSystem_Application_Strings.str_primary_color,
  //                 onChanged: (value) {
  //                   controller.isVacationNonPointer.value = value ?? false;
  //                 },
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(GBSystem_Application_Strings.str_multiselect_mode, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //           Obx(
  //             () => Switch(
  //               value: controller.isSwitchOn,
  //               onChanged: (value) {
  //                 controller.isSwitchOn = value;
  //                 if (!controller.isSwitchOn) {
  //                   controller.isSelectAllChecked = false;
  //                   controller.selectedItems = 0;
  //                   controller.Vacation_Informations_Controller.setAllSelectedVacation = [];
  //                 }
  //                 controller.updateUI();
  //               },
  //               activeColor: GBSystem_Application_Strings.str_primary_color,
  //             ),
  //           ),
  //         ],
  //       ),
  //       //     if (controller.isSwitchOn) _buildMultiSelectCard(controller),
  //       Obx(() {
  //         return controller.isSwitchOn.value ? _buildMultiSelectCard(controller) : const SizedBox.shrink();
  //       }),
  //     ],
  //   );
  // }
  // Widget _buildMultiSelectSection(GBSystem_Vacation_List_PS2_Controller controller) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       // (option cachée que tu avais déjà)
  //       Visibility(
  //         visible: false,
  //         child: ListTile(
  //           title: Text(GBSystem_Application_Strings.str_vacation_non_pointer, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //           leading: SizedBox(
  //             height: 15,
  //             width: 15,
  //             child: Obx(
  //               () => CupertinoCheckbox(
  //                 value: controller.isVacationNonPointer.value,
  //                 activeColor: GBSystem_Application_Strings.str_primary_color,
  //                 onChanged: (value) {
  //                   controller.isVacationNonPointer.value = value ?? false;
  //                 },
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),

  //       /// 🔹 Switch observable
  //       Obx(
  //         () => Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(GBSystem_Application_Strings.str_multiselect_mode, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //             Switch(
  //               value: controller.isSwitchOn.value,
  //               onChanged: (value) {
  //                 controller.isSwitchOn.value = value;
  //                 controller.totalItems.value = controller.usedListVacation().length;
  //                 if (!value) {
  //                   controller.isSelectAllChecked.value = false;
  //                   controller.selectedItems.value = 0;
  //                   controller.Vacation_Informations_Controller.setAllSelectedVacation = [];
  //                 }
  //               },
  //               activeColor: GBSystem_Application_Strings.str_primary_color,
  //             ),
  //           ],
  //         ),
  //       ),

  //       /// 🔹 Affiche la card uniquement si le switch est activé
  //       Obx(() => controller.isSwitchOn.value ? _buildMultiSelectCard(controller) : const SizedBox.shrink()),
  //     ],
  //   );
  // }

  // Widget _buildMultiSelectCard(GBSystem_Vacation_List_PS2_Controller controller) {
  //   return Card(
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               CupertinoCheckbox(
  //                 value: controller.isSelectAllChecked,
  //                 onChanged: (value) {
  //                   controller.isSelectAllChecked = value ?? false;
  //                   controller.selectedItems = controller.isSelectAllChecked ? controller.totalItems : 0;
  //                   if (value ?? false) {
  //                     controller.Vacation_Informations_Controller.setAllSelectedVacation = [];
  //                     List<GBSystem_Vacation_Model> allVacExists = controller.usedListVacation();
  //                     for (var vacation in allVacExists) {
  //                       controller.Vacation_Informations_Controller.setSelectedVacation = vacation;
  //                     }
  //                   } else {
  //                     controller.Vacation_Informations_Controller.setAllSelectedVacation = [];
  //                   }
  //                   controller.updateUI();
  //                 },
  //                 activeColor: GBSystem_Application_Strings.str_primary_color,
  //               ),
  //               Text(GBSystem_Application_Strings.str_selectionner_tous, style: TextStyle(fontSize: 16)),
  //             ],
  //           ),
  //           const SizedBox(height: 5),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Text(
  //                 '${GBSystem_Application_Strings.str_selected_vacations}: ${controller.selectedItems} / ${controller.totalItems}',
  //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: GBSystem_Application_Strings.str_primary_color),
  //               ),
  //             ],
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 8),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 _buildActionButton(onTap: () => controller.entrerFunction(false), text: GBSystem_Application_Strings.str_entrer, color: Colors.green),
  //                 _buildActionButton(onTap: () => controller.sortieFunction(false), text: GBSystem_Application_Strings.str_sortie, color: Colors.red),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  // Widget _buildMultiSelectCard(GBSystem_Vacation_List_PS2_Controller controller) {
  //   return Card(
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               Obx(
  //                 () => CupertinoCheckbox(
  //                   value: controller.isSelectAllChecked.value,
  //                   activeColor: GBSystem_Application_Strings.str_primary_color,
  //                   // onChanged: (value) {
  //                   //   controller.isSelectAllChecked.value = value ?? false;
  //                   //   controller.selectedItems.value = controller.isSelectAllChecked.value ? controller.totalItems.value : 0;

  //                   //   if (controller.isSelectAllChecked.value) {
  //                   //     controller.Vacation_Informations_Controller.setAllSelectedVacation = [];
  //                   //     List<GBSystem_Vacation_Model> allVacExists = controller.usedListVacation();
  //                   //     for (var vacation in allVacExists) {
  //                   //       controller.Vacation_Informations_Controller.setSelectedVacation = vacation;
  //                   //     }
  //                   //   } else {
  //                   //     controller.Vacation_Informations_Controller.setAllSelectedVacation = [];
  //                   //   }
  //                   // },
  //                   onChanged: (value) {
  //                     if (value ?? false) {
  //                       controller.selectAllVacations(controller.usedListVacation);
  //                     } else {
  //                       controller.clearAllVacations();
  //                     }
  //                   },
  //                 ),
  //               ),
  //               Text(GBSystem_Application_Strings.str_selectionner_tous, style: TextStyle(fontSize: 16)),
  //             ],
  //           ),
  //           const SizedBox(height: 5),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Obx(
  //                 () => Text(
  //                   '${GBSystem_Application_Strings.str_selected_vacations}: '
  //                   '${controller.selectedItems.value} / ${controller.totalItems.value}',
  //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: GBSystem_Application_Strings.str_primary_color),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 8),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 _buildActionButton(onTap: () => controller.entrerFunction(false), text: GBSystem_Application_Strings.str_entrer, color: Colors.green),
  //                 _buildActionButton(onTap: () => controller.sortieFunction(false), text: GBSystem_Application_Strings.str_sortie, color: Colors.red),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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

  // Widget _buildVacationList(GBSystem_Vacation_List_PS2_Controller controller) {
  //       return Obx(() {
  //     return controller.usedListVacation.isNotEmpty
  //         ? Expanded(
  //             child: ListView.builder(
  //               itemCount: controller.usedListVacation.length, //
  //               itemBuilder: (context, index) => _buildVacationItem(controller, controller.usedListVacation[index], index),
  //             ),
  //           )
  //         : Center(child: GBSystem_TextHelper().smallText(text: GBSystem_Application_Strings.str_no_item));
  //   });
  // }

  Widget _buildVacationList(BuildContext context, GBSystem_Vacation_List_PS2_Controller controller) {
    final vacations = controller.usedListVacation;

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          // 👇 fonction de rechargement
          await controller.initializeController();
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
                          await controller.initializeController();
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
                  return _buildVacationItem(controller, vacation, index);
                },
              ),
      ),
    );
  }

  // Widget _buildVacationList(GBSystem_Vacation_List_PS2_Controller controller) {
  //   final vacations = controller.usedListVacation;

  //   if (vacations.isEmpty) {
  //     return Center(child: GBSystem_TextHelper().largeText(text: GBSystem_Application_Strings.str_no_item));
  //   }

  //   return Expanded(
  //     child: RefreshIndicator(
  //       onRefresh: () async {
  //         // 👇 appelle la fonction de rechargement de tes données
  //         await controller.initializeController();
  //         // si tu n’as pas de fonction encore, mets ton API ou refresh logique ici
  //       },
  //       child: ListView.builder(
  //         physics: const AlwaysScrollableScrollPhysics(), // 👈 important pour activer le "pull"
  //         itemCount: vacations.length,
  //         itemBuilder: (context, index) {
  //           final vacation = vacations[index];
  //           return _buildVacationItem(controller, vacation, index);
  //         },
  //       ),
  //     ),
  //   );

  // return Expanded(
  //   child: ListView.builder(
  //     itemCount: vacations.length,
  //     itemBuilder: (context, index) {
  //       final vacation = vacations[index];
  //       return _buildVacationItem(controller, vacation, index);
  //     },
  //   ),
  // );
  //}

  // Widget _buildVacationItem(GBSystem_Vacation_List_PS2_Controller controller, GBSystem_Vacation_Model vacation, int index) {
  //   //final isSelected = controller.isSwitchOn.value && (controller.Vacation_Informations_Controller.getAllSelectedVacations ?? []).contains(vacation);
  //   return Obx(() {
  //     final isSelected = (controller.Vacation_Informations_Controller.allSelectedVacations).contains(vacation);

  //     return GBSystem_Root_CardView_VacationWidget(
  //       onEnterTap: () => controller.entrerFunctionSingle(PointageVacation: vacation),
  //       onSortieTap: () => controller.sortieFunctionSingle(PointageVacation: vacation),
  //       onCallTap: () {
  //         controller.callBool.value = true;
  //         controller.phoneNumber = vacation.SVR_TELPH;
  //       },
  //       isSelected: isSelected,
  //       tileColor: index % 2 == 0 ? Colors.grey.withOpacity(0.2) : Colors.white,
  //       onTap: () => _onVacationTap(controller, vacation),
  //       vacation: vacation,
  //       onLeadingTap: () => controller.selectItemAllSelectedVacation(selectedVacation: vacation),
  //     );
  //   });
  // }
  Widget _buildVacationItem(GBSystem_Vacation_List_PS2_Controller controller, GBSystem_Vacation_Model vacation, int index) {
    // 👇 seul le champ isSelected est observé
    return Obx(() {
      final isSelected = controller.Vacation_Informations_Controller.allSelectedVacations.contains(vacation);

      return GBSystem_Root_CardView_VacationWidget(
        vacation: vacation,
        isSelected: isSelected,
        tileColor: index % 2 == 0 ? Colors.grey.withOpacity(0.2) : Colors.white,
        onEnterTap: () => controller.entrerFunctionSingle(PointageVacation: vacation),
        onSortieTap: () => controller.sortieFunctionSingle(PointageVacation: vacation),
        onCallTap: () {
          controller.callBool.value = true;
          controller.phoneNumber = vacation.SVR_TELPH;
        },
        onTap: () => _onVacationTap(controller, vacation),
        onLeadingTap: () => controller.selectItemAllSelectedVacation(selectedVacation: vacation),
      );
    });
  }

  void _onVacationTap(GBSystem_Vacation_List_PS2_Controller controller, GBSystem_Vacation_Model vacation) {
    if (controller.isSwitchOn.value) {
      controller.selectItemAllSelectedVacation(selectedVacation: vacation);

      if (controller.totalItems.value == controller.selectedItems.value) {
        controller.isSelectAllChecked.value = true;
      } else {
        controller.isSelectAllChecked.value = false;
      }
    } else {
      controller.selectItemAllVacationFunction(selectedVacation: vacation);
    }
  }

  Widget _buildCallOverlay(BuildContext context, GBSystem_Vacation_List_PS2_Controller controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GBSystem_SlideToAaction_Call_Phone_Widget(
          onSubmit: () async {
            controller.callBool.value = false;
            if (controller.phoneNumber != null && controller.phoneNumber!.isNotEmpty) {
              GBSystem_UrlLauncherService().callNumber(context, number: controller.phoneNumber ?? "");
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
                child: GBSystem_DisplayPhoneNumberWidget(phoneNumber: controller.phoneNumber ?? ""),
              ),
              CupertinoButton(
                onPressed: () => controller.callBool.value = false,
                child: const Icon(CupertinoIcons.xmark, size: 40, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
