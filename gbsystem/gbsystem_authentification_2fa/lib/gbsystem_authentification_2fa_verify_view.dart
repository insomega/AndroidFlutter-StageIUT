import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gbsystem_root/GBSystem_snack_bar.dart';
import 'package:gbsystem_authentification_2fa/gbsystem_authentification_2fa_Controller.dart';

class GBSystem_TwoFAVerifyView extends StatefulWidget {
  const GBSystem_TwoFAVerifyView({super.key});

  @override
  State<GBSystem_TwoFAVerifyView> createState() => _GBSystem_TwoFAVerifyViewState();
}

class _GBSystem_TwoFAVerifyViewState extends State<GBSystem_TwoFAVerifyView> {
  final TextEditingController _codeController = TextEditingController();
  bool _isVerifying = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _verifyCode() async {
    final controller = Get.find<GBSystem_AuthenticatorController>();
    final code = _codeController.text.trim();

    if (code.isEmpty) {
      showErrorDialog("Veuillez entrer un code OTP");
      return;
    }

    setState(() => _isVerifying = true);

    try {
      final bool isValid = await controller.verifyCode(code);

      if (isValid) {
        showSuccesDialog("✅ Code valide, configuration réussie !");
        // Optionnellement, naviguer ou fermer la vue après succès
      } else {
        showErrorDialog("❌ Code invalide, réessayez.");
      }
    } catch (e) {
      showErrorDialog("Erreur lors de la vérification du code : $e");
    } finally {
      setState(() => _isVerifying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vérifier le code OTP")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Code OTP", border: OutlineInputBorder()),
                enabled: !_isVerifying,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isVerifying ? null : _verifyCode,
                child: _isVerifying ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text("Vérifier"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:gbsystem_root/GBSystem_snack_bar.dart';
// import 'package:get/get.dart';
// import 'package:gbsystem_authentification_2fa/gbsystem_authentification_2fa_Controller.dart';

// class GBSystem_TwoFAVerifyView extends StatefulWidget {
//   const GBSystem_TwoFAVerifyView({super.key});

//   @override
//   State<GBSystem_TwoFAVerifyView> createState() => _GBSystem_TwoFAVerifyViewState();
// }

// class _GBSystem_TwoFAVerifyViewState extends State<GBSystem_TwoFAVerifyView> {
//   final _codeController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<GBSystem_AuthenticatorController>();

//     return Scaffold(
//       appBar: AppBar(title: const Text("Vérifier le code OTP")),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _codeController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: "Code OTP", border: OutlineInputBorder()),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               child: const Text("Vérifier"),
//               onPressed: () {
//                 final code = _codeController.text.trim();
//                 final isValid = await controller.verifyCode(code);
//                 showErrorDialog(isValid ? "✅ Code valide, configuration réussie !" : "❌ Code invalide, réessayez.");
//                 //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isValid ? "✅ Code valide, configuration réussie !" : "❌ Code invalide, réessayez.")));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// import 'package:gbsystem_authentification_2fa/gbsystem_authentification_2fa_Controller.dart';
// import 'package:get/get.dart';

// class GBSystem_TwoFAGBSystem_TwoFAVerifyView extends StatelessWidget {
//   final TwoFAController controller = Get.find();
//   final codeCtrl = TextEditingController();
//   final String tempToken;
//   GBSystem_TwoFAGBSystem_TwoFAVerifyView(this.tempToken);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Saisir code 2FA')),
//       body: Column(
//         children: [
//           TextField(
//             controller: codeCtrl,
//             decoration: InputDecoration(labelText: 'Code'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               final res = await controller.verifyLogin(tempToken, codeCtrl.text.trim());
//               if (res['auth_token'] != null) {
//                 // stocker token et rediriger
//               } else {
//                 Get.snackbar('Erreur', 'Code invalide');
//               }
//             },
//             child: Text('Valider'),
//           ),
//         ],
//       ),
//     );
//   }
// }
