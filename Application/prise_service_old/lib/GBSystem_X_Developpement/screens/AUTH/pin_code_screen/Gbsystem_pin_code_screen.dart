import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_Root_Params.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_toast.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/AUTH/pin_code_screen/Gbsystem_pin_code_screen_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class GbsystemPinCodeScreen extends StatefulWidget {
  const GbsystemPinCodeScreen(
      {super.key,
      this.isBackAvailable = false,
      required this.isValideMode,
      // required this.oldCodePIN,
      required this.destination});
  final bool isBackAvailable;
  final bool isValideMode;
  // final String oldCodePIN;
  final Widget destination;
  @override
  State<GbsystemPinCodeScreen> createState() => _GbsystemPinCodeScreenState();
}

class _GbsystemPinCodeScreenState extends State<GbsystemPinCodeScreen> {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  final m = Get.put<GbsystemPinCodeScreenController>(
      GbsystemPinCodeScreenController());
  String? pinCode, oldPinCode;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      oldPinCode = await m.getCodePIN();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          showToast(text: GbsSystemStrings.str_action_non_autoriser);
        },
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 4.0,
                shadowColor: GbsSystemServerStrings.str_primary_color,
                toolbarHeight: 80,
                backgroundColor: GbsSystemServerStrings.str_primary_color,
                title: Text(
                  GbsSystemStrings.str_code_pin,
                  style: TextStyle(color: Colors.white),
                ),
                leading: widget.isBackAvailable
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
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            GBSystem_TextHelper().largeText(
                                text: widget.isValideMode
                                    ? GbsSystemStrings.str_verification
                                    : GbsSystemStrings.str_enregistrement,
                                fontWeight: FontWeight.bold),
                            SizedBox(
                              height:
                                  GBSystem_ScreenHelper.screenHeightPercentage(
                                      context, 0.02),
                            ),
                            SizedBox(
                              width:
                                  GBSystem_ScreenHelper.screenWidthPercentage(
                                      context, 0.8),
                              child: GBSystem_TextHelper().normalText(
                                  text: widget.isValideMode
                                      ? GbsSystemStrings
                                          .str_entrer_code_pin_deja_enrigester
                                      : GbsSystemStrings
                                          .str_enrigester_nv_code_pin,
                                  fontWeight: FontWeight.bold,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  textColor: Colors.grey),
                            ),
                          ],
                        ),
                        Pinput(
                          defaultPinTheme: defaultPinTheme.copyDecorationWith(
                            border: Border.all(
                                color: Color.fromRGBO(114, 178, 238, 1)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedPinTheme: defaultPinTheme.copyDecorationWith(
                            border: Border.all(
                                color: Color.fromRGBO(114, 178, 238, 1)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration?.copyWith(
                              color: Color.fromRGBO(234, 239, 243, 1),
                            ),
                          ),
                          validator: (s) {
                            if (widget.isValideMode) {
                              if (s == oldPinCode) {
                                return null;
                              } else {
                                return GbsSystemStrings.str_code_pin_wrong;
                              }
                            } else {
                              return null;
                            }
                          },
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onCompleted: (pin) async {
                            setState(() {
                              pinCode = pin;
                            });

                            if (widget.isValideMode) {
                              if (await m.compareCodePIN(pinCode: pin)) {
                                Get.off(widget.destination);
                              } else {}
                            }
                          },
                        ),
                        CustomButton(
                            onTap: widget.isValideMode
                                ? () async {
                                    if (pinCode != null &&
                                        pinCode!.isNotEmpty) {
                                      await m
                                          .compareCodePIN(pinCode: pinCode!)
                                          .then(
                                        (value) {
                                          if (value) {
                                            Get.off(widget.destination);
                                          } else {
                                            showErrorDialog(
                                                context,
                                                GbsSystemStrings
                                                    .str_code_pin_wrong);
                                          }
                                        },
                                      );
                                    }
                                  }
                                : () async {
                                    if (pinCode != null &&
                                        pinCode!.isNotEmpty) {
                                      await m
                                          .onEnregistrerTap(codePIN: pinCode!)
                                          .then(
                                        (value) {
                                          Get.off(widget.destination);
                                        },
                                      );
                                    }
                                  },
                            text: GbsSystemStrings.str_valider),
                        Visibility(
                          visible: widget.isValideMode,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GBSystem_TextHelper().smallText(
                                    text: GbsSystemStrings.str_code_pin_oublier,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await m.viderLoginSharedPerfermences();

                                      Get.off(ActiveApplication_Params
                                          .MaterialApp_LoginPage());
                                    },
                                    child: GBSystem_TextHelper().smallText(
                                      text: GbsSystemStrings
                                          .str_nouvelle_connexion,
                                      textColor: GbsSystemServerStrings
                                          .str_primary_color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            m.isLoading.value ? Waiting() : Container()
          ],
        ),
      ),
    );
  }
}
