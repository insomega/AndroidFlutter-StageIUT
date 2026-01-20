import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'GBSystem_MainForm_BMEvents_Controller.dart';

import 'package:gbsystem_serveur/GBSystem_Serveur_UserWelcome_View.dart';
import 'package:gbsystem_root/GBSystem_Root_MainView.dart';

import 'package:gbsystem_vacation_priseservice/GBSystem_Vacation_PriseService_Widget.dart';
import 'Routes/GBSystem_Application_Routes.dart';

class GBSystem_MainForm_BMEvents_View extends GBSystem_Root_MainForm_View<GBSystem_MainForm_BMEvents_Controller> {
  GBSystem_MainForm_BMEvents_View({Key? key}) : super(key: key);

  @override
  final controller = Get.put(GBSystem_MainForm_BMEvents_Controller());

  @override
  Widget buildMainContent(BuildContext context) {
    return Column(
      children: [
        GBSystem_Serveur_View_Card(),
        GBSystem_Vacation_PriseService_Widget(
          isUpdatePause: false, //
          desconnectAfterSuccess: true,
          afficherPrecSuiv: true,
          afficherOpertaionsBar: true,
          routeLogin: GBSystem_Application_Routes.login,
        ),
      ],
    );
  }
}

// class GBSystem_MainForm_BMEvents_View extends GBSystem_Root_MainForm_View<GBSystem_MainForm_BMEvents_Controller> {
//   GBSystem_MainForm_BMEvents_View({Key? key}) : super(key: key);

//   // Ici on crée le contrôleur (via Get.put par exemple)
//   @override
//   final controller = Get.put(GBSystem_MainForm_BMEvents_Controller());

//   @override
//   Widget buildMainContent(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           //
//           horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.025),
//           vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02),
//         ),
//         child: Column(
//           children: [
//             GBSystem_Serveur_View_Card(), //
//             _buildUserEnterSortie(context),
//           ],
//         ),
//       ),
//     );

//     // return [
//     //   GBSystem_Serveur_View_Card(), //
//     //   _buildUserEnterSortie(context),
//     // ];
//   }

//   Widget _buildUserEnterSortie(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
//       child: GBSystem_Vacation_PriseService_Widget(
//         isUpdatePause: false, //
//         desconnectAfterSuccess: true,
//         afficherPrecSuiv: true,
//         afficherOpertaionsBar: true,
//         routeLogin: GBSystem_Application_Routes.login,
//       ),
//     );
//   }
// }

// class GBSystem_MainForm_BMEvents_View extends GetView<GBSystem_MainForm_BMEvents_Controller> {
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
//                 return _buildMainContent();
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

//   Widget _buildMainContent() {
//     return Scaffold(
//       appBar: GBSystem_Root_AppBar(
//         // onDeconnexionTap: handleLogout, //
//         onDeconnexionTap: controller.handleLogout, //
//         // imageSalarie: controller.imageSalarie,
//         // salarie: controller.salarie,
//       ),
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(Get.context!, 0.025), vertical: GBSystem_ScreenHelper.screenHeightPercentage(Get.context!, 0.02)),
//           child: Column(
//             children: [
//               GBSystem_Serveur_View_Card(), //
//               _buildUserEnterSortie(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Widget _buildUserWelcome() {
//   //   // final GBSystem_Serveur_Info_Model salarie = controller.salarie!;
//   //   // final String? imageSalarie = controller.imageSalarie;
//   //   return GBSystem_Serveur_View_Card();

//   //   // return GBSystem_Serveur_View_Card(imageBase: imageSalarie!, salarie: salarie);
//   // }

//   Widget _buildUserEnterSortie() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: GBSystem_ScreenHelper.screenHeightPercentage(Get.context!, 0.02)),
//       child: GBSystem_Vacation_PriseService_Widget(
//         isUpdatePause: false, //
//         desconnectAfterSuccess: true,
//         afficherPrecSuiv: true,
//         afficherOpertaionsBar: true,
//         routeLogin: GBSystem_Application_Routes.login,
//       ),
//     );
//   }
// }
