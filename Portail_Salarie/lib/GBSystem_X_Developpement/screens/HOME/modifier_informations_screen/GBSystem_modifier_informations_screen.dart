import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/modifier_informations_screen/GBSystem_modifier_informations_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/tab_bar.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemModifierInformationsScreen extends StatelessWidget {
  GBSystemModifierInformationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final m = Get.put<ModifierInformationController>(
        ModifierInformationController(context));

    return Obx(() => Stack(
          children: [
            Scaffold(
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                centerTitle: true,
                elevation: 4.0,
                shadowColor: GbsSystemStrings.str_primary_color,
                toolbarHeight: 80,
                backgroundColor: GbsSystemStrings.str_primary_color,
                title: Text(
                  GbsSystemStrings.str_my_info.tr,
                  style: TextStyle(color: Colors.white),
                ),
                leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                  ),
                ),
              ),
              body: Column(
                children: [
                  TabBarWidget(
                    pageController: m.pageController,
                    items: m.items,
                    current: m.current,
                    scrollController: m.scrollController,
                  ),
                  Expanded(
                    child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: m.pageController,
                        children: m.listPagesFormulaires),
                  )
                ],
              ),
            ),
            m.isLoading.value ? Waiting() : Container()
          ],
        ));
  }
}
