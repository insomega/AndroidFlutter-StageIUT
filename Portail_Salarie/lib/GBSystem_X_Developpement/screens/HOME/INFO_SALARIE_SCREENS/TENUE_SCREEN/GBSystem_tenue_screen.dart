import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_article_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/INFO_SALARIE_SCREENS/TENUE_SCREEN/GBSystem_tenue_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/modifier_informations_widget/article_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GbsystemTenueScreen extends StatefulWidget {
  const GbsystemTenueScreen({super.key, this.isCommingFromOut = false});
  final bool isCommingFromOut;
  @override
  State<GbsystemTenueScreen> createState() => _GbsystemTenueScreenState();
}

class _GbsystemTenueScreenState extends State<GbsystemTenueScreen> {
  final GbsystemTenueScreenController m =
      Get.put(GbsystemTenueScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 4.0,
        shadowColor: GbsSystemStrings.str_primary_color,
        toolbarHeight: 80,
        backgroundColor: GbsSystemStrings.str_primary_color,
        title: Text(
          GbsSystemStrings.str_tenue.tr,
          style: TextStyle(color: Colors.white),
        ),
        leading: widget.isCommingFromOut
            ? InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                ),
              )
            : Container(),
      ),
      body: StreamBuilder(
        stream: GBSystem_AuthService(context)
            .getAllArticles(salarie: m.salarieController.getSalarie!)
            .asStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: WaitingWidgets());
          } else if (snapshot.hasData) {
            List<GbsystemArticleModel> allArticles = snapshot.data ?? [];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: ListView.builder(
                  itemCount: allArticles.length,
                  itemBuilder: (context, index) =>
                      ArticleWidget(article: allArticles[index])
                  // Text(allArticles[index].ARTREF_LIB ?? "")
                  ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
