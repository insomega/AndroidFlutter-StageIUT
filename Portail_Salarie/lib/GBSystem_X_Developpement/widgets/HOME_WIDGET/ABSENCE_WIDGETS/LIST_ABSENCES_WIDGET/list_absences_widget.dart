import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_absences_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/LIST_ABSENCES_WIDGET/absence_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/LIST_ABSENCES_WIDGET/list_absences_widget_controller.dart';

class GBSystemListAbsenecesWidget extends StatelessWidget {
  GBSystemListAbsenecesWidget(
      {super.key, required this.updateLoading, required this.updateUI});
  final Function updateLoading, updateUI;

  final GBSystemAbsenceController absencesController =
      Get.put(GBSystemAbsenceController());

  @override
  Widget build(BuildContext context) {
    final GBSystemListAbsencesWidgetController m =
        Get.put(GBSystemListAbsencesWidgetController(context: context));
    return absencesController.getAllAbsences != null &&
            absencesController.getAllAbsences!.isNotEmpty
        ? MainWidget(
            updateUi: updateUI,
            updateLoading: updateLoading,
            absencesController: absencesController)
        : FutureBuilder(
            future: GBSystem_AuthService(context).getListAbsences(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  m.listAbsences = snapshot.data;
                  absencesController.setAllAbsence = snapshot.data;
                  absencesController.setCurrentAbsenceAbsence =
                      snapshot.data?.first;
                  return MainWidget(
                      updateUi: updateUI,
                      updateLoading: updateLoading,
                      absencesController: absencesController);
                } else {
                  return Center(child: EmptyDataWidget());
                }
              } else {
                return Container(
                  height: 250,
                  child: WaitingWidgets(),
                );
              }
            },
          );
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({
    super.key,
    required this.absencesController,
    required this.updateLoading,
    required this.updateUi,
  });

  final GBSystemAbsenceController absencesController;
  final Function updateLoading, updateUi;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
          vertical:
              GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: absencesController.getAllAbsences?.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: AbsenceWidget(
              updateUI: updateUi,
              updateLoading: updateLoading,
              onTap: () async {},
              absenceModel: absencesController.getAllAbsences![index],
            ),
          );
        },
      ),
      // GridView.builder(
      //   itemCount: absencesController.getAllAbsences?.length,
      //   clipBehavior: Clip.none,
      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //       //nmr element f l3Ordh
      //       crossAxisCount: 2,
      //       // taille t3 l element
      //       childAspectRatio: 0.62,
      //       crossAxisSpacing: 10,
      //       mainAxisSpacing: 10),
      //   itemBuilder: (context, index) {
      //     return AbsenceWidget(
      //       updateUI: updateUi,
      //       updateLoading: updateLoading,
      //       onTap: () async {},
      //       absenceModel: absencesController.getAllAbsences![index],
      //     );
      //   },
      // ),
    );
  }
}
