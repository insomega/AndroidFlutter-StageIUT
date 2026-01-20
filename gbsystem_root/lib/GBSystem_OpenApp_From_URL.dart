//import 'dart:async';
// import 'package:app_links/app_links.dart';
// import 'package:flutter/foundation.dart';

// import 'GBSystem_AppPreferences.dart';

class GBSystem_OpenApp_From_URL {
  // final AppLinks _appLinks = AppLinks();
  // StreamSubscription<Uri>? _linkSubscription;

  // final StreamController _authLinkController = StreamController.broadcast();

  // /// Public stream to listen for parsed auth links
  // Stream get onAuthLink => _authLinkController.stream;

  // Future<void> init() async {
  //   // Handle initial URI if app was launched from a link
  //   try {
  //     final Uri? initialUri = await _appLinks.getInitialLink();
  //     if (initialUri != null) {
  //       debugPrint(initialUri as String?);
  //       //print(initialUri);
  //       await _handleUri(initialUri);
  //     }
  //   } catch (e) {
  //     debugPrint('Failed to get initial app link: $e');
  //   }

  //   // Listen for incoming URIs
  //   _linkSubscription = _appLinks.uriLinkStream.listen(await _handleUri, onError: (err) => print('URI stream error: $err'));
  // }

  // void dispose() {
  //   _linkSubscription?.cancel();
  //   _authLinkController.close();
  // }

  // Future<void> _handleUri(Uri uri) async {
  //   final host = uri.queryParameters['host'];
  //   final port = uri.queryParameters['port'];
  //   final WID = uri.queryParameters['WID'];
  //   final CQS = uri.queryParameters['CQS'];
  //   final S19 = uri.queryParameters['S19'];

  //   // print("host $host");
  //   // print("port $port");
  //   // print("WID $WID");
  //   // print("CQS $CQS");
  //   // print("S19 $S19");

  //   if (WID != null && WID.isNotEmpty) {
  //     GBSystem_AppPreferences.setwid(WID);
  //   }
  //   if (CQS != null && CQS.isNotEmpty) {
  //     GBSystem_AppPreferences.setcookies('B5512=$CQS');
  //   }
  //   String myHost = port != null && port.isNotEmpty ? "https://$host:$port/BMServerR.dll/BMRest" : "https://$host/BMServerR.dll/BMRest";
  //   if (host != null && host.isNotEmpty) {
  //     GBSystem_AppPreferences.setsiteWeb(myHost);
  //   }
  //   if (S19 != null && S19.isNotEmpty) {
  //     GBSystem_AppPreferences.sets19(S19);
  //   }
  //   if (host != null && host.isNotEmpty && CQS != null && CQS.isNotEmpty && WID != null && WID.isNotEmpty) {
  //     GBSystem_AppPreferences.setSSOMode(true);
  //   }

  //   GBSystem_AppPreferences.setFirstTime(true);

  //###################  Get.offAll(GBSystemSplashScreen());

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // if (WID != null && WID.isNotEmpty) {
  //   await prefs.setString(GBSystem_System_Strings.kToken, WID);
  // }

  // if (CQS != null && CQS.isNotEmpty) {
  //   await prefs.setString(GBSystem_System_Strings.kCookies, 'B5512=${CQS}');
  // }

  // String myHost = port != null && port.isNotEmpty ? "https://$host:$port/BMServerR.dll/BMRest" : "https://$host/BMServerR.dll/BMRest";
  // if (host != null && host.isNotEmpty) {
  //   await prefs.setString(GBSystem_System_Strings.kSiteWeb, myHost);
  // }
  // if (S19 != null && S19.isNotEmpty) {
  //   await prefs.setString(GBSystem_System_Strings.kS19, S19);
  // }
  // is sso
  // if (host != null && host.isNotEmpty && CQS != null && CQS.isNotEmpty && WID != null && WID.isNotEmpty) {
  //   await prefs.setBool(GBSystem_System_Strings.kSSO, true);
  // }
  // to auto direct to home if connection checked
  //await prefs.setBool(GBSystem_System_Strings.kIsFirstTime, false);
  //  }
}
