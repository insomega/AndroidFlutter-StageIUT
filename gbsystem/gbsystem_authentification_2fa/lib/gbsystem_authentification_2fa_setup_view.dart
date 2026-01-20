import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'gbsystem_authentification_2fa_Controller.dart';
import 'gbsystem_authentification_2fa_verify_view.dart';

class SetupView extends GetView<GBSystem_AuthenticatorController> {
  const SetupView({super.key});

  @override
  Widget build(BuildContext context) {
    // Vérifier que les valeurs ne sont pas nulles ou vides
    final otpUrl = controller.otpUrl.value;
    final secret = controller.secret.value;

    return Scaffold(
      appBar: AppBar(title: const Text("Configurer Google Authenticator")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Vérification de la disponibilité du QR code
            if (otpUrl.isNotEmpty) QrImageView(data: otpUrl, version: QrVersions.auto, size: 220) else const Text("Impossible de générer le QR code", style: TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            const Text("Clé secrète :", style: TextStyle(fontSize: 16)),
            SelectableText(
              secret,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.copy),
              label: const Text("Copier la clé"),
              // tooltip: "Copier la clé dans le presse-papiers",
              onPressed: () {
                if (secret.isNotEmpty) {
                  Clipboard.setData(ClipboardData(text: secret));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Clé copiée dans le presse-papiers")));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Clé non disponible")));
                }
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Text("Passer à la vérification"),
              onPressed: () {
                if (otpUrl.isNotEmpty && secret.isNotEmpty) {
                  Get.to(() => const GBSystem_TwoFAVerifyView());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Veuillez générer la clé et le QR code d'abord")));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:flutter/services.dart';
// import 'gbsystem_authentification_2fa_Controller.dart';
// import 'gbsystem_authentification_2fa_verify_view.dart';

// class SetupView extends GetView<GBSystem_AuthenticatorController> {
//   const SetupView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Configurer Google Authenticator")),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             QrImageView(data: controller.otpUrl.value, version: QrVersions.auto, size: 220),
//             const SizedBox(height: 20),
//             Text("Clé secrète :", style: Theme.of(context).textTheme.titleMedium),
//             SelectableText(
//               controller.secret.value,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               icon: const Icon(Icons.copy),
//               label: const Text("Copier la clé"),
//               onPressed: () {
//                 Clipboard.setData(ClipboardData(text: controller.secret.value));
//                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Clé copiée dans le presse-papiers")));
//               },
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton(child: const Text("Passer à la vérification"), onPressed: () => Get.to(() => const GBSystem_TwoFAVerifyView())),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:get/get.dart';
// import 'gbsystem_authentification_2fa_Controller.dart';

// class GBSystem_TwoFASetupView extends StatelessWidget {
//   final TwoFAController controller = Get.find();
//   final codeCtrl = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Activer 2FA')),
//       body: Obx(() {
//         return Column(
//           children: [
//             ElevatedButton(onPressed: () => controller.setup2FA(), child: Text('Générer QR')),
//             if (controller.otpauthUri.isNotEmpty)
//               Column(
//                 children: [
//                   QrImageView(data: controller.otpauthUri.value, size: 200),
//                   Padding(
//                     padding: EdgeInsets.all(8),
//                     child: TextField(
//                       controller: codeCtrl,
//                       decoration: InputDecoration(labelText: 'Code Google Authenticator'),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       final res = await controller.verifySetup(codeCtrl.text.trim());
//                       // res contient backup_codes -> afficher/encourager à sauvegarder
//                       Get.dialog(AlertDialog(title: Text('Backup codes'), content: Text(res['backup_codes'].join('\n'))));
//                     },
//                     child: Text('Valider et activer'),
//                   ),
//                 ],
//               ),
//           ],
//         );
//       }),
//     );
//   }
// }
