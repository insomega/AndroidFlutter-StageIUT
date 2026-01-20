import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:get/get.dart';
//import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_root/GBSystem_Root_AppBar.dart';
//import 'package:gbsystem_root/GBSystem_LogEvent.dart';

//import 'package:gbsystem_root/GBSystem_waiting.dart';

import 'package:gbsystem_root/GBSystem_Root_MainView_Controller.dart';
//import 'package:get/get.dart';

/// Vue racine commune
abstract class GBSystem_Root_MainForm_View<T extends GBSystem_Root_MainForm_Controller> extends StatelessWidget {
  const GBSystem_Root_MainForm_View({Key? key}) : super(key: key);

  T get controller;

  /// Contenu principal spécifique à chaque vue
  Widget buildMainContent(BuildContext context);

  /// Actions AppBar (optionnel)
  List<Widget> appBarActionsBuilder(BuildContext context) => [];

  /// Overlay spécifique (par défaut rien)
  Widget? buildOverlay(BuildContext context) => null;

  /// Indique si le contenu doit être flouté / bloqué (par défaut false)
  bool get shouldBlur => false;

  @override
  Widget build(BuildContext context) {
    // Force la status bar visible + couleur adaptée
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // 👈 fond blanc derrière l’heure et batterie
        statusBarIconBrightness: Brightness.dark, // 👈 icônes noires (comme sur ton screenshot)
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: SafeArea(
        child: Stack(
          children: [
            _buildContentWithBlur(context),
            if (buildOverlay(context) != null) buildOverlay(context)!,
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return WillPopScope(
  //     onWillPop: () async {
  //       exit(0);
  //     },
  //     child: Stack(
  //       children: [
  //         _buildContentWithBlur(context),
  //         if (buildOverlay(context) != null) buildOverlay(context)!,
  //       ],
  //     ),
  //   );
  // }

  Widget _buildContentWithBlur(BuildContext context) {
    final blurActive = shouldBlur;
    return AbsorbPointer(
      absorbing: blurActive,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: blurActive ? 10.0 : 0.0,
          sigmaY: blurActive ? 10.0 : 0.0,
        ),
        child: _buildScaffold(context),
      ),
    );
  }

  // Widget _buildContentWithBlur(BuildContext context) {
  //   return Obx(() {
  //     final blurActive = shouldBlur;
  //     return AbsorbPointer(
  //       absorbing: blurActive,
  //       child: ImageFiltered(
  //         imageFilter: ImageFilter.blur(
  //           sigmaX: blurActive ? 10.0 : 0.0,
  //           sigmaY: blurActive ? 10.0 : 0.0,
  //         ),
  //         child: _buildScaffold(context),
  //       ),
  //     );
  //   });
  // }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: GBSystem_Root_AppBar(
        onDeconnexionTap: controller.handleLogout,
        actionsBuilder: appBarActionsBuilder,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        // 👈 Protection contre le chevauchement avec la status bar
        child: buildMainContent(context),
      ),
    );
  }
}

//import '../../../_Packages/gbsystem_vacation_priseservice/lib/GBSystem_Vacation_PriseService_Widget.dart';

// abstract class GBSystem_Root_MainForm_View<T extends GBSystem_Root_MainForm_Controller> extends StatelessWidget {
//   const GBSystem_Root_MainForm_View({Key? key}) : super(key: key);

//   /// Chaque sous-classe doit fournir son contrôleur
//   T get controller;

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => exit(0),
//       child: SafeArea(
//         child: Stack(
//           children: [
//             Obx(() {
//               if (controller.isLoading.value) {
//                 return Waiting();
//               } else {
//                 return _buildMainContent(context);
//               }
//             }),
//             //} controller.isLoading.value ? Waiting() : _buildMainContent()),
//             // _buildMainContent(), //
//             // if (controller.loading.value) Waiting(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildMainContent(BuildContext context) {
//     return Container();
//   }

//   /// 👇 Getter des actions (par défaut vide)
//   //final List<Widget> Function(BuildContext)? actionsBuilder;

//   List<Widget> appBarActionsBuilder(BuildContext context) => [];

//   Widget _buildMainContent(BuildContext context) {
//     return Scaffold(
//       appBar: GBSystem_Root_AppBar(
//         // onDeconnexionTap: handleLogout, //
//         onDeconnexionTap: controller.handleLogout, //
//         actionsBuilder: appBarActionsBuilder,
//         // imageSalarie: controller.imageSalarie,
//         // salarie: controller.salarie,
//       ),
//       resizeToAvoidBottomInset: false,
//       body: buildMainContent(context),
//       // body: SingleChildScrollView(
//       //   child: Padding(
//       //     padding: EdgeInsets.symmetric(
//       //         //
//       //         horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.025),
//       //         vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
//       //     child: Column(
//       //       children: buildMainContent(context),
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }
