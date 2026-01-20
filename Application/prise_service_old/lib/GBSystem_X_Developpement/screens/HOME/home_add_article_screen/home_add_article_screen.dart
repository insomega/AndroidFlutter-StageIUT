import 'dart:developer';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/home_add_article_screen/home_add_article_screen_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_GESTION_STOCK_WIDGETS/article_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_GESTION_STOCK_WIDGETS/catalogue_widget.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/choose_mode_button_widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class HomeAddArticleScreen extends StatefulWidget {
  const HomeAddArticleScreen({super.key});

  @override
  State<HomeAddArticleScreen> createState() => _HomeAddArticleScreenState();
}

class _HomeAddArticleScreenState extends State<HomeAddArticleScreen> {
  String barcode = 'Tappez  pour scanner';

  void updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final HomeAddArticleScreenController m = Get.put(HomeAddArticleScreenController(context, updateUI: updateUI));

    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    // m.articlesController.setSelectedArticle = null;
                    Get.back();
                  },
                  child: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                  )),
              elevation: 4.0,
              centerTitle: true,
              shadowColor: Colors.grey.withOpacity(0.5),
              toolbarHeight: 70,
              backgroundColor: GbsSystemServerStrings.str_primary_color,
              title: Text(
                GbsSystemStrings.str_ajouter_articles,
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => Visibility(
                      visible: m.articlesController.getSelectedArticleObx.value == null,
                      child: ChooseModeButtonWidget(
                        onTap: () async {
                          try {
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
                                        controller: MobileScannerController(
                                          detectionSpeed: DetectionSpeed.noDuplicates,
                                        ),
                                        onDetect: (p0) async {
                                          print("qrrrr : ${p0.barcodes.first.rawValue}");

                                          try {
                                            setState(() {
                                              barcode = p0.barcodes.first.rawValue.toString();
                                              log(barcode, name: 'Barcode');
                                            });
                                            m.isLoading.value = true;

                                            await GBSystem_AuthService(context).getArticleByTag(tagType: p0.barcodes.first.format == BarcodeFormat.qrCode ? "2" : "3", tag: barcode).then(
                                              (value) async {
                                                m.articlesController.setSelectedArticle = value;
                                                if (value != null) {
                                                  await GBSystem_AuthService(context)
                                                      .getAllCatalogueArticle(
                                                    articleRef: value,
                                                  )
                                                      .then(
                                                    (listCatalogue) {
                                                      // setState(() {
                                                      m.catalogueController.setAllCatalogues = listCatalogue;
                                                      // });
                                                      setState(() {});
                                                    },
                                                  );
                                                } else {
                                                  showErrorDialog(context, GbsSystemStrings.str_no_article_associer_a_cette_code);
                                                }
                                                m.isLoading.value = false;
                                                Get.back();
                                              },
                                            );
                                          } catch (e) {
                                            m.isLoading.value = false;
                                            GBSystem_ManageCatchErrors().catchErrors(context, message: e.toString(), method: "affectuerArticleByTag", page: "informations_products_salarie_screen");
                                          }
                                        },
                                        // validator: (p0) =>
                                        //     p0.barcodes.first.rawValue?.startsWith('https://') ??
                                        //     false,
                                        validator: (p0) => p0.barcodes.first.rawValue != null,
                                      ),
                                      m.isLoading.value ? Waiting() : Container()
                                    ],
                                  ),
                                ),
                              ),
                            );

                            Get.to(HomeAddArticleScreen());
                          } catch (e) {
                            GBSystem_ManageCatchErrors().catchErrors(
                              context,
                              message: e.toString(),
                              method: "HomeAddArticleScreen",
                              page: "choose_mode_stock_screen",
                            );
                          }
                        },
                        icon: Icon(
                          Icons.qr_code_scanner,
                          color: Colors.black,
                          size: 80,
                        ),
                        text: "${GbsSystemStrings.str_scanner_article}",
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 8),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       GBSystem_TextHelper().normalText(
                  //           text: GbsSystemStrings.str_article,
                  //           textColor: Colors.black,
                  //           fontWeight: FontWeight.bold),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Obx(
                      () => m.articlesController.getSelectedArticleObx.value != null
                          ? ArticleRefAddWidget(
                              onBtnTap: () async {
                                m.isLoadingMain.value = true;
                                await GBSystem_AuthService(context).getAllTailles(article: m.articlesController.getSelectedArticleObx.value!).then(
                                  (value) async {
                                    m.tailleController.setAllTailles = value;
                                    m.isLoadingMain.value = false;
                                    await m.showDialogAddCatalogue(context: context, artiecleRef: m.articlesController.getSelectedArticleObx.value!);
                                  },
                                );
                              },
                              article: m.articlesController.getSelectedArticleObx.value!)
                          : Container(),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () => m.catalogueController.getAllCataloguesRx.value != null
                        ? SizedBox(
                            height: 330,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              // shrinkWrap: true,
                              itemCount: m.catalogueController.getAllCatalogues?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  child: CatalogueWidget(
                                      onDeleteTap: () async {
                                        showWarningSnackBar(
                                          context,
                                          GbsSystemStrings.str_supprission_question,
                                          () async {
                                            m.isLoadingMain.value = true;
                                            await GBSystem_AuthService(context).deleteCatalogue(catalogue: m.catalogueController.getAllCatalogues![index]).then(
                                              (value) {
                                                m.isLoadingMain.value = false;
                                                if (value) {
                                                  m.catalogueController.deleteCatalogue(m.catalogueController.getAllCatalogues![index]);
                                                  showSuccesDialog(context, GbsSystemStrings.str_operation_effectuer);
                                                }
                                              },
                                            );
                                          },
                                        );
                                      },
                                      onAddStockTap: () async {
                                        await m.showDialogAddToStock(
                                          context: context,
                                          catalogue: m.catalogueController.getAllCatalogues![index],
                                        );
                                      },
                                      onUpdateTap: () async {
                                        await m.showDialogUpdateCatalogue(
                                          context: context,
                                          catalogue: m.catalogueController.getAllCatalogues![index],
                                        );
                                      },
                                      catalogueModel: m.catalogueController.getAllCatalogues![index]),
                                );
                              },
                            ),
                          )
                        : Container(),
                  ),

                  // SizedBox(
                  //   height: 300,
                  //   child: Center(
                  //     child: GBSystem_TextHelper().smallText(
                  //         text: GbsSystemStrings.str_aucune_catalogue),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          m.isLoadingMain.value ? Waiting() : Container()
        ],
      ),
    );
  }
}
