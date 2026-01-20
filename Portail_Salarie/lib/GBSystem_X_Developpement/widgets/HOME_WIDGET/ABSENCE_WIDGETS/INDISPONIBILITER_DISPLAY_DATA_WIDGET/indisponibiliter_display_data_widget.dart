import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_indisponibiliter_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/INDISPONIBILITER_DISPLAY_DATA_WIDGET/indisponibiliter_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/ABSENCE_WIDGETS/INDISPONIBILITER_DISPLAY_DATA_WIDGET/indisponibiliter_widget_controller.dart';

class GBSystemListIndisponibiliterWidget extends StatelessWidget {
  GBSystemListIndisponibiliterWidget({super.key, required this.updateLoading});

  final GBSystemIndisponibiliterController indisponibiliterController =
      Get.put(GBSystemIndisponibiliterController());
  final Function updateLoading;
  @override
  Widget build(BuildContext context) {
    final GBSystemListIndisponibiliterWidgetController m =
        Get.put(GBSystemListIndisponibiliterWidgetController(context: context));
    return indisponibiliterController.getAllIndisponibiliters != null &&
            indisponibiliterController.getAllIndisponibiliters!.isNotEmpty
        ? MainWidget(
            updateLoading: updateLoading,
            indisponibiliterController: indisponibiliterController)
        : FutureBuilder(
            future: GBSystem_AuthService(context).getListIndisponibiliter2(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  m.listAbsences = snapshot.data;
                  indisponibiliterController.setAllIndisponibiliter =
                      snapshot.data;
                  indisponibiliterController.setCurrentIndisponibiliter =
                      snapshot.data?.first;
                  return MainWidget(
                      updateLoading: updateLoading,
                      indisponibiliterController: indisponibiliterController);
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
    required this.indisponibiliterController,
    required this.updateLoading,
  });

  final GBSystemIndisponibiliterController indisponibiliterController;
  final Function updateLoading;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal:
                GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
            vertical:
                GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
        // child: GridView.builder(
        //   itemCount: indisponibiliterController.getAllIndisponibiliters?.length,
        //   clipBehavior: Clip.none,
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       //nmr element f l3Ordh
        //       crossAxisCount: 2,
        //       // taille t3 l element
        //       childAspectRatio: 0.62,
        //       crossAxisSpacing: 10,
        //       mainAxisSpacing: 10),
        //   itemBuilder: (context, index) {
        //     return IndisponibiliterWidget(
        //       updateLoading: updateLoading,
        //       onTap: () async {},
        //       indisponibiliterModel:
        //           indisponibiliterController.getAllIndisponibiliters![index],
        //     );
        //   },
        // ),
        child: SizedBox(
          height: 500,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount:
                  indisponibiliterController.getAllIndisponibiliters?.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: IndisponibiliterWidget(
                      updateLoading: updateLoading,
                      onTap: () async {},
                      indisponibiliterModel: indisponibiliterController
                          .getAllIndisponibiliters![index],
                    ),
                  )),
        ));
  }
}
