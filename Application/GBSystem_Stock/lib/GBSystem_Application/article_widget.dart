import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_article_gestion_stock_model.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_article_ref_model.dart';
import 'package:gbsystem_stock/GBSystem_Application/GBSystem_article_salarie_gestion_stock_model.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

import 'package:qr_flutter/qr_flutter.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.article, this.onBtnTap, this.textBtn});

  final GbsystemArticleGestionStockModel article;
  final void Function()? onBtnTap;
  final String? textBtn;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        height: 150,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.5), borderRadius: BorderRadius.circular(18)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.7),
                      child: GBSystem_TextHelper().largeText(text: article.ARTREF_LIB, textColor: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.7),
                      child: GBSystem_TextHelper().normalText(text: article.ARTFOUREF_PRIX, textColor: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(width: 8),
                ClipOval(
                  child: Image.asset(
                    GBSystem_System_Strings.str_vetments_image_path,
                    fit: BoxFit.fill,
                    width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.13),
                    height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.13),
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.12),
                      height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.12),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(300), color: GBSystem_Application_Strings.str_primary_color.withOpacity(0.8)),
                      child: Center(
                        child: GBSystem_TextHelper().normalText(text: "ERR", textColor: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            SizedBox(
              width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
              child: GBSystem_TextHelper().smallText(text: article.ENTR_LIB, textColor: Colors.black38, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            InkWell(
              onTap: onBtnTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(color: GBSystem_Application_Strings.str_primary_color, borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: GBSystem_TextHelper().smallText(text: textBtn ?? 'Retour', textColor: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleNonAffectuerWidget extends StatelessWidget {
  const ArticleNonAffectuerWidget({super.key, required this.article, this.onBtnTap, this.textBtn});

  final GbsystemArticleGestionStockModel article;
  final void Function()? onBtnTap;
  final String? textBtn;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        height: 260,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.5), borderRadius: BorderRadius.circular(18)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.7),
                      child: GBSystem_TextHelper().largeText(text: article.ARTCAT_LIB, textColor: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.7),
                      child: GBSystem_TextHelper().largeText(text: article.ARTREF_LIB, textColor: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    Visibility(
                      visible: article.TPOI_LIB != null,
                      child: SizedBox(
                        width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.7),
                        child: GBSystem_TextHelper().normalText(text: article.TPOI_LIB ?? "", textColor: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.7),
                      child: GBSystem_TextHelper().normalText(text: "${article.ARTFOUREF_PRIX}" + r" $", textColor: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.7),
                      child: GBSystem_TextHelper().largeText(text: article.ART_QTE_STOCK, textColor: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(width: 8),
                ClipOval(
                  child: Image.asset(
                    GBSystem_System_Strings.str_vetments_image_path,
                    fit: BoxFit.fill,
                    width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.13),
                    height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.13),
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.12),
                      height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.12),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(300), color: GBSystem_Application_Strings.str_primary_color.withOpacity(0.8)),
                      child: Center(
                        child: GBSystem_TextHelper().normalText(text: "ERR", textColor: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            SizedBox(
              width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
              child: GBSystem_TextHelper().smallText(text: article.ENTR_LIB, textColor: Colors.black38, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 3),
            SizedBox(
              width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
              child: GBSystem_TextHelper().smallText(text: article.FOU_LIB, textColor: Colors.black38, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 3),
            InkWell(
              onTap: onBtnTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(color: GBSystem_Application_Strings.str_primary_color, borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: GBSystem_TextHelper().smallText(text: textBtn ?? 'Retour', textColor: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleWidgetTypeTwo extends StatelessWidget {
  const ArticleWidgetTypeTwo({super.key, required this.article, this.onBtnTap, this.textBtn});

  final GbsystemArticleGestionStockModel article;
  final void Function()? onBtnTap;
  final String? textBtn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        height: 200,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(color: GBSystem_Application_Strings.str_primary_color, border: Border.all(width: 0.5), borderRadius: BorderRadius.circular(18)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: GBSystem_TextHelper().largeText(text: article.ARTREF_LIB, textColor: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   width: GBSystem_ScreenHelper.screenWidthPercentage(
                    //       context, 0.7),
                    //   child: GBSystem_TextHelper().largeText(
                    //       text: article.ARTREF_LIB,
                    //       textColor: Colors.white,
                    //       fontWeight: FontWeight.w500),
                    // ),
                    Row(
                      children: [
                        // cube_box_fill
                        Icon(Icons.shopping_cart_checkout_sharp, color: Colors.white),
                        SizedBox(width: 5),
                        SizedBox(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.5),
                          child: GBSystem_TextHelper().normalText(text: article.ART_QTE_STOCK, textColor: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          // directions_bus_sharp
                          Icons.local_shipping,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        SizedBox(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.5),
                          child: GBSystem_TextHelper().normalText(text: article.FOU_LIB, textColor: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(CupertinoIcons.color_filter, color: Colors.white),
                        SizedBox(width: 5),
                        SizedBox(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.5),
                          child: GBSystem_TextHelper().normalText(text: article.CLR_LIB, textColor: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 8),
                ClipOval(
                  child: Image.asset(
                    GBSystem_System_Strings.str_vetments_image_path,
                    fit: BoxFit.fill,
                    width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.13),
                    height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.13),
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.12),
                      height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.12),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(300), color: Colors.white),
                      child: Center(
                        child: GBSystem_TextHelper().normalText(text: "ERR", textColor: GBSystem_Application_Strings.str_primary_color),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Icon(Icons.warehouse_rounded, color: Colors.white),
                SizedBox(width: 5),
                SizedBox(
                  width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.5),
                  child: GBSystem_TextHelper().normalText(text: article.ENTR_LIB, textColor: Colors.white, fontWeight: FontWeight.w500),
                ),
              ],
            ),

            // SizedBox(
            //   width:
            //       GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
            //   child: GBSystem_TextHelper().smallText(
            //       text: article.ENTR_LIB,
            //       textColor: Colors.white54,
            //       fontWeight: FontWeight.w500),
            // ),
            SizedBox(height: 5),
            InkWell(
              onTap: onBtnTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: GBSystem_TextHelper().smallText(text: textBtn ?? GBSystem_Application_Strings.str_retour, textColor: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleSalarieWidget extends StatelessWidget {
  const ArticleSalarieWidget({super.key, required this.articleSalarie, this.btnText, this.onBtnTap});

  final ArticleSalarieGestionStockModel articleSalarie;
  final String? btnText;
  final void Function()? onBtnTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        height: 150,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(color: GBSystem_Application_Strings.str_primary_color, border: Border.all(width: 0.5), borderRadius: BorderRadius.circular(18)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.7),
                      child: GBSystem_TextHelper().largeText(text: articleSalarie.ARTREF_LIB, textColor: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.7),
                      child: GBSystem_TextHelper().normalText(text: articleSalarie.ENTR_LIB, textColor: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(width: 8),
                ClipOval(
                  child: Image.asset(
                    GBSystem_System_Strings.str_vetments_image_path,
                    fit: BoxFit.fill,
                    width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.13),
                    height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.13),
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.12),
                      height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.12),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(300), color: Colors.white),
                      child: Center(
                        child: GBSystem_TextHelper().normalText(text: "ERR", textColor: GBSystem_Application_Strings.str_primary_color),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            SizedBox(
              width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
              child: GBSystem_TextHelper().smallText(text: articleSalarie.ARTAFFEC_START_DATE != null ? ArticleSalarieGestionStockModel.convertDate(articleSalarie.ARTAFFEC_START_DATE!) : "", textColor: Colors.white38, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            InkWell(
              onTap: onBtnTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: GBSystem_TextHelper().smallText(text: btnText ?? GBSystem_Application_Strings.str_retour, textColor: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleSalarieWidgetWhite extends StatelessWidget {
  const ArticleSalarieWidgetWhite({super.key, required this.articleSalarie, this.onBtnTap, this.btnText});

  final ArticleSalarieGestionStockModel articleSalarie;
  final void Function()? onBtnTap;
  final String? btnText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        height: 200,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.5), borderRadius: BorderRadius.circular(18)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: GBSystem_TextHelper().largeText(text: articleSalarie.ARTREF_LIB, textColor: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   width: GBSystem_ScreenHelper.screenWidthPercentage(
                    //       context, 0.7),
                    //   child: GBSystem_TextHelper().largeText(
                    //       text: articleSalarie.ARTREF_LIB,
                    //       textColor: Colors.white,
                    //       fontWeight: FontWeight.w500),
                    // ),
                    Row(
                      children: [
                        // cube_box_fill
                        Icon(Icons.date_range, color: Colors.black),
                        SizedBox(width: 5),
                        SizedBox(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.5),
                          child: GBSystem_TextHelper().normalText(text: articleSalarie.ARTAFFEC_START_DATE != null ? ArticleSalarieGestionStockModel.convertDate(articleSalarie.ARTAFFEC_START_DATE!) : "", textColor: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          // directions_bus_sharp
                          Icons.local_shipping,
                          color: Colors.black,
                        ),
                        SizedBox(width: 5),
                        SizedBox(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.5),
                          child: GBSystem_TextHelper().normalText(text: articleSalarie.FOU_LIB, textColor: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(CupertinoIcons.color_filter, color: Colors.black),
                        SizedBox(width: 5),
                        SizedBox(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.5),
                          child: GBSystem_TextHelper().normalText(text: articleSalarie.CLR_LIB, textColor: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 8),
                ClipOval(
                  child: Image.asset(
                    GBSystem_System_Strings.str_vetments_image_path,
                    fit: BoxFit.fill,
                    width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.13),
                    height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.13),
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.12),
                      height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.12),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(300), color: Colors.white),
                      child: Center(
                        child: GBSystem_TextHelper().normalText(text: "ERR", textColor: GBSystem_Application_Strings.str_primary_color),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Icon(Icons.warehouse_rounded, color: Colors.black),
                SizedBox(width: 5),
                SizedBox(
                  width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.5),
                  child: GBSystem_TextHelper().normalText(text: articleSalarie.ENTR_LIB, textColor: Colors.black, fontWeight: FontWeight.w500),
                ),
              ],
            ),

            // SizedBox(
            //   width:
            //       GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
            //   child: GBSystem_TextHelper().smallText(
            //       text: article.ENTR_LIB,
            //       textColor: Colors.white54,
            //       fontWeight: FontWeight.w500),
            // ),
            SizedBox(height: 5),
            InkWell(
              onTap: onBtnTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(color: GBSystem_Application_Strings.str_primary_color, borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: GBSystem_TextHelper().smallText(text: btnText ?? GBSystem_Application_Strings.str_retour, textColor: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleRefAddWidget extends StatelessWidget {
  const ArticleRefAddWidget({super.key, required this.article, this.onBtnTap, this.textBtn, this.textBtn2});

  final GbsystemArticleRefModel article;
  final void Function()? onBtnTap;
  final String? textBtn, textBtn2;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.5), borderRadius: BorderRadius.circular(18)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.7),
                    child: GBSystem_TextHelper().largeText(text: article.ARTREF_LIB, textColor: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.7),
                    child: GBSystem_TextHelper().normalText(text: article.ARTCAT_LIB, textColor: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(width: 8),
              ClipOval(
                child: Image.asset(
                  GBSystem_System_Strings.str_vetments_image_path,
                  fit: BoxFit.fill,
                  width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.13),
                  height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.13),
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.12),
                    height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.12),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(300), color: GBSystem_Application_Strings.str_primary_color.withOpacity(0.8)),
                    child: Center(
                      child: GBSystem_TextHelper().normalText(text: "ERR", textColor: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          SizedBox(
            width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
            child: GBSystem_TextHelper().smallText(text: article.ARTREF_LIB, textColor: Colors.black38, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5),
          InkWell(
            onTap: onBtnTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(color: GBSystem_Application_Strings.str_primary_color, borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: GBSystem_TextHelper().smallText(text: textBtn ?? GBSystem_Application_Strings.str_ajouter_catalogue, textColor: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ArticleWithQRWidget extends StatefulWidget {
  const ArticleWithQRWidget({super.key, required this.article});

  final GbsystemArticleRefModel article;

  @override
  State<ArticleWithQRWidget> createState() => _ArticleWithQRWidgetState();
}

class _ArticleWithQRWidgetState extends State<ArticleWithQRWidget> {
  final GlobalKey _qrkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.5), borderRadius: BorderRadius.circular(18)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.7),
                    child: GBSystem_TextHelper().largeText(text: widget.article.ARTREF_LIB, textColor: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.7),
                    child: GBSystem_TextHelper().normalText(text: widget.article.ARTCAT_LIB, textColor: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(width: 8),
              ClipOval(
                child: Image.asset(
                  GBSystem_System_Strings.str_vetments_image_path,
                  fit: BoxFit.fill,
                  width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.13),
                  height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.13),
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.12),
                    height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.12),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(300), color: GBSystem_Application_Strings.str_primary_color.withOpacity(0.8)),
                    child: Center(
                      child: GBSystem_TextHelper().normalText(text: "ERR", textColor: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          SizedBox(
            width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
            child: GBSystem_TextHelper().smallText(text: widget.article.ARTREF_LIB, textColor: Colors.black38, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5),
          RepaintBoundary(
            key: _qrkey,
            child: QrImageView(
              data: widget.article.ARTREF_IDF,
              version: QrVersions.auto,
              size: 120,
              gapless: false,
              errorStateBuilder: (context, error) => Center(child: Text(GBSystem_Application_Strings.str_error_generate_qrcode)),
            ),
          ),
        ],
      ),
    );
  }
}

// class ArticleSalarieWidget extends StatelessWidget {
//   const ArticleSalarieWidget({
//     super.key,
//     required this.articleSalarie,
//     this.btnText,
//     this.onBtnTap,
//   });

//   final ArticleSalarieGestionStockModel articleSalarie;
//   final String? btnText;
//   final void Function()? onBtnTap;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//       child: Container(
//           height: 150,
//           padding: EdgeInsets.symmetric(
//             vertical: 10,
//             horizontal: 15,
//           ),
//           decoration: BoxDecoration(
//             color: GBSystem_Application_Strings.str_primary_color,
//             border: Border.all(
//               width: 0.5,
//             ),
//             borderRadius: BorderRadius.circular(18),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         width: GBSystem_ScreenHelper.screenWidthPercentage(
//                             context, 0.7),
//                         child: GBSystem_TextHelper().largeText(
//                             text: articleSalarie.ARTREF_LIB,
//                             textColor: Colors.white,
//                             fontWeight: FontWeight.w500),
//                       ),
//                       SizedBox(
//                         width: GBSystem_ScreenHelper.screenWidthPercentage(
//                             context, 0.7),
//                         child: GBSystem_TextHelper().normalText(
//                             text: articleSalarie.ENTR_LIB,
//                             textColor: Colors.white,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     width: 8,
//                   ),
//                   ClipOval(
//                       child: Image.asset(
//                     GBSystem_Application_Strings.str_vetments_image_path,
//                     fit: BoxFit.fill,
//                     width: GBSystem_ScreenHelper.screenWidthPercentage(
//                         context, 0.13),
//                     height: GBSystem_ScreenHelper.screenWidthPercentage(
//                         context, 0.13),
//                     errorBuilder: (context, error, stackTrace) => Container(
//                       width: GBSystem_ScreenHelper.screenWidthPercentage(
//                           context, 0.12),
//                       height: GBSystem_ScreenHelper.screenWidthPercentage(
//                           context, 0.12),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(300),
//                           color: Colors.white),
//                       child: Center(
//                         child: GBSystem_TextHelper().normalText(
//                             text: "ERR",
//                             textColor: GBSystem_Application_Strings.str_primary_color),
//                       ),
//                     ),
//                   ))
//                 ],
//               ),
//               SizedBox(
//                 height: 3,
//               ),
//               SizedBox(
//                 width:
//                     GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
//                 child: GBSystem_TextHelper().smallText(
//                     text: articleSalarie.ARTAFFEC_START_DATE != null
//                         ? ArticleSalarieGestionStockModel.convertDate(
//                             articleSalarie.ARTAFFEC_START_DATE!)
//                         : "",
//                     textColor: Colors.white38,
//                     fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               InkWell(
//                 onTap: onBtnTap,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 8),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Center(
//                           child: GBSystem_TextHelper().smallText(
//                               text: btnText ?? GBSystem_Application_Strings.str_retour,
//                               textColor: Colors.black,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }

// class ArticleSalarieWidgetWhite extends StatelessWidget {
//   const ArticleSalarieWidgetWhite({
//     super.key,
//     required this.articleSalarie,
//     this.btnText,
//     this.onBtnTap,
//   });

//   final ArticleSalarieGestionStockModel articleSalarie;
//   final String? btnText;
//   final void Function()? onBtnTap;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//       child: Container(
//           height: 150,
//           padding: EdgeInsets.symmetric(
//             vertical: 10,
//             horizontal: 15,
//           ),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(
//               width: 0.5,
//             ),
//             borderRadius: BorderRadius.circular(18),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         width: GBSystem_ScreenHelper.screenWidthPercentage(
//                             context, 0.7),
//                         child: GBSystem_TextHelper().largeText(
//                             text: articleSalarie.ARTREF_LIB,
//                             textColor: Colors.black,
//                             fontWeight: FontWeight.w500),
//                       ),
//                       SizedBox(
//                         width: GBSystem_ScreenHelper.screenWidthPercentage(
//                             context, 0.7),
//                         child: GBSystem_TextHelper().normalText(
//                             text: articleSalarie.ENTR_LIB,
//                             textColor: Colors.black,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     width: 8,
//                   ),
//                   ClipOval(
//                       child: Image.asset(
//                     GBSystem_Application_Strings.str_vetments_image_path,
//                     fit: BoxFit.fill,
//                     width: GBSystem_ScreenHelper.screenWidthPercentage(
//                         context, 0.13),
//                     height: GBSystem_ScreenHelper.screenWidthPercentage(
//                         context, 0.13),
//                     errorBuilder: (context, error, stackTrace) => Container(
//                       width: GBSystem_ScreenHelper.screenWidthPercentage(
//                           context, 0.12),
//                       height: GBSystem_ScreenHelper.screenWidthPercentage(
//                           context, 0.12),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(300),
//                           color: Colors.white),
//                       child: Center(
//                         child: GBSystem_TextHelper().normalText(
//                             text: "ERR",
//                             textColor: GBSystem_Application_Strings.str_primary_color),
//                       ),
//                     ),
//                   ))
//                 ],
//               ),
//               SizedBox(
//                 height: 3,
//               ),
//               SizedBox(
//                 width:
//                     GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8),
//                 child: GBSystem_TextHelper().smallText(
//                     text: articleSalarie.ARTAFFEC_START_DATE != null
//                         ? ArticleSalarieGestionStockModel.convertDate(
//                             articleSalarie.ARTAFFEC_START_DATE!)
//                         : "",
//                     textColor: Colors.black38,
//                     fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               InkWell(
//                 onTap: onBtnTap,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 8),
//                         decoration: BoxDecoration(
//                           color: GBSystem_Application_Strings.str_primary_color,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Center(
//                           child: GBSystem_TextHelper().smallText(
//                               text: btnText ?? GBSystem_Application_Strings.str_retour,
//                               textColor: Colors.white,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }
