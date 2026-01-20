import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthScreen extends StatefulWidget {
  const LocalAuthScreen(
      {super.key, this.isBackAvailable = false, required this.destination});

  final bool isBackAvailable;

  final Widget destination;

  @override
  _LocalAuthScreenState createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  String _authStatus = GbsSystemStrings.str_auth_please_authentificate.tr;

  // Check if device supports biometrics
  Future<bool> _checkBiometrics() async {
    bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
    return canCheckBiometrics;
  }

  // Authenticate using biometrics
  Future<bool> _authenticate() async {
    try {
      bool authenticated = await _localAuth.authenticate(
        localizedReason:
            GbsSystemStrings.str_auth_please_authentificate_to_proceed.tr,
        options: AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      setState(() {
        _authStatus = authenticated
            ? GbsSystemStrings.str_auth_auth_success.tr
            : GbsSystemStrings.str_auth_auth_failed.tr;
      });

      return authenticated;
    } catch (e) {
      setState(() {
        _authStatus =
            "${GbsSystemStrings.str_dialog_erreur.tr}: ${e.toString()}";
      });
      Get.off(widget.destination);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 4.0,
        shadowColor: GbsSystemServerStrings.str_primary_color,
        toolbarHeight: 80,
        backgroundColor: GbsSystemServerStrings.str_primary_color,
        title: Text(
          GbsSystemStrings.str_auth_biometric_auth.tr,
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [GbsSystemServerStrings.str_primary_color, Colors.cyan],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Title Text
                  GBSystem_TextHelper().largeText(
                      text: GbsSystemStrings.str_auth_auth_with_biometrics.tr,
                      textColor: Colors.white,
                      fontWeight: FontWeight.bold,
                      maxLines: 4),
                  Spacer(),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.fingerprint,
                            size: 80,
                            color: GbsSystemServerStrings.str_primary_color,
                          ),
                          SizedBox(height: 20),
                          Icon(
                            Icons.face,
                            size: 80,
                            color: GbsSystemServerStrings.str_primary_color,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  // SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                      bool canAuthenticate = await _checkBiometrics();

                      if (canAuthenticate) {
                        _authenticate().then(
                          (value) {
                            if (value) {
                              Get.off(widget.destination);
                            }
                          },
                        );
                      } else {
                        setState(() {
                          _authStatus = GbsSystemStrings
                              .str_auth_biometrics_not_available.tr;
                        });
                        Get.off(widget.destination);
                      }
                    },
                    child: GBSystem_TextHelper().normalText(
                        text: GbsSystemStrings.str_auth_start_auth.tr,
                        textColor: Colors.white,
                        fontWeight: FontWeight.normal,
                        maxLines: 2),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: GbsSystemServerStrings.str_primary_color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  // SizedBox(height: 20),
                  GBSystem_TextHelper().normalText(
                      text: _authStatus,
                      textColor: Colors.white,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      maxLines: 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
