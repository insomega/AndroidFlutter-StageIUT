import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_historique_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/HISTORIQUE_SCREEN/GBSystem_historique_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/empty_data_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/historique_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemHistoriqueScreen extends StatelessWidget {
  GBSystemHistoriqueScreen({super.key});

  final GBSystemHistoriqueScreenController m =
      Get.put(GBSystemHistoriqueScreenController());
  final GBSystemHistoriqueController historiqueController =
      Get.put(GBSystemHistoriqueController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 4.0,
        shadowColor: GbsSystemStrings.str_primary_color,
        toolbarHeight: 80,
        backgroundColor: GbsSystemStrings.str_primary_color,
        title: Text(
          GbsSystemStrings.str_historique.tr,
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
      body: m.historiqueController.getAllHistoriques != null &&
              m.historiqueController.getAllHistoriques!.isNotEmpty
          ? ListView.builder(
              itemCount: m.historiqueController.getAllHistoriques!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                          context, 0.02),
                      vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.01)),
                  child: HistoriqueWidget(
                    historiqueModel:
                        m.historiqueController.getAllHistoriques![index],
                  ),
                );
              },
            )
          : FutureBuilder(
              future: GBSystem_AuthService(context).getListHistorique(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    m.historiqueController.setAllHistorique = snapshot.data;
                    return ListView.builder(
                      itemCount:
                          m.historiqueController.getAllHistoriques!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  GBSystem_ScreenHelper.screenWidthPercentage(
                                      context, 0.02),
                              vertical:
                                  GBSystem_ScreenHelper.screenHeightPercentage(
                                      context, 0.01)),
                          child: HistoriqueWidget(
                            historiqueModel: m
                                .historiqueController.getAllHistoriques![index],
                          ),
                        );
                      },
                    );
                  } else {
                    return EmptyDataWidget();
                  }
                } else {
                  return Container(
                    height: 250,
                    child: WaitingWidgets(),
                  );
                }
              },
            ),
    );
  }
}
