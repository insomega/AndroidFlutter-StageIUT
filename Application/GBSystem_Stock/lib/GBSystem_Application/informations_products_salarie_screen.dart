import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_LogEvent.dart';
import 'package:gbsystem_root/GBSystem_waiting.dart';
import 'package:gbsystem_stock/GBSystem_Application/app_bar_gestion_stock.dart';
import 'package:gbsystem_stock/GBSystem_Application/article_widget.dart';
import 'package:gbsystem_stock/GBSystem_Application/empty_data_widget.dart';
import 'package:gbsystem_stock/GBSystem_Application/informations_products_salarie_screen_controller.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

import 'package:get/get.dart';

import 'dart:developer';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';

class InformationsProductsSalarieScreen extends StatefulWidget {
  const InformationsProductsSalarieScreen({super.key});

  @override
  State<InformationsProductsSalarieScreen> createState() => _InformationsProductsSalarieScreenState();
}

class _InformationsProductsSalarieScreenState extends State<InformationsProductsSalarieScreen> {
  String barcode = 'Tap  to scan';

  void updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final InformationsProductsSalarieScreenController m = Get.put(InformationsProductsSalarieScreenController(context));

    return Obx(
      () => Stack(
        children: [
          Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: GBSystem_Application_Strings.str_primary_color,
              child: Icon(CupertinoIcons.add, color: Colors.white),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Obx(
                      () => Stack(
                        children: [
                          AiBarcodeScanner(
                            // hideDragHandler: true,
                            // hideTitle: true,
                            // successColor: Colors.green,
                            // errorColor: Colors.red,
                            onDispose: () {
                              debugPrint("Barcode scanner disposed!");
                            },
                            controller: MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates),
                            onDetect: (p0) async {
                              try {
                                setState(() {
                                  barcode = p0.barcodes.first.rawValue.toString();
                                  log(barcode, name: 'Barcode');
                                });
                                m.isLoading.value = true;
                                // await GBSystem_AuthService(context).affectuerArticleByTag(salarie: m.salarieGestionStockController.getCurrentSalarie!, site: m.siteGestionStockController.getCurrentSite!, tag: barcode).then((value) {
                                //   m.articlesController.setSelectedArticle = value;
                                //   m.isLoading.value = false;
                                //   Get.off(SelectedArticleScreen(updateUI: updateUI));
                                // });
                              } catch (e) {
                                m.isLoading.value = false;
                                GBSystem_Add_LogEvent(message: e.toString(), method: "affectuerArticleByTag", page: "informations_products_salarie_screen");
                              }
                            },
                            // validator: (p0) =>
                            //     p0.barcodes.first.rawValue?.startsWith('https://') ??
                            //     false,
                            validator: (p0) => p0.barcodes.first.rawValue != null,
                          ),
                          m.isLoading.value ? Waiting() : Container(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            appBar: GBSystemAppBarGestionStock(
              onBackTap: () {
                Get.back();
              },
              salarie: m.articlesAndDatasetController.getCurrentArticlesAndDataSet!.salarieDataSetModel,
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Obx(
                () => m.articlesAndDatasetController.getAllArticlesRx.value != null && m.articlesAndDatasetController.getAllArticlesRx.value!.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: m.articlesAndDatasetController.getAllArticlesRx.value?.length ?? 0,
                        itemBuilder: (context, index) {
                          return ArticleSalarieWidgetWhite(
                            btnText: GBSystem_Application_Strings.str_retour,
                            onBtnTap: () async {
                              await m.retourArticleSalarie(m.articlesAndDatasetController.getAllArticlesRx.value![index]);
                            },
                            articleSalarie: m.articlesAndDatasetController.getAllArticlesRx.value![index],
                          );
                        },
                      )
                    : EmptyDataWidget(),
              ),
            ),
          ),
          m.isLoading.value ? Waiting() : Container(),
        ],
      ),
    );
  }
}
