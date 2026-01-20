import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_internet_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_planning_vacation_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/controllers/GBSystem_salarie_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_topic_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/INFO_SALARIE_SCREENS/CHAT_SCREEN/GBSystem_chat_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/MAIN_SCREEN/GBSystem_main_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/SPLASH_SCREENS/SPLASH_SCREEN/GBSystem_splash_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/topic_manager.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseSerivce {
  FirebaseSerivce(this.context);
  BuildContext context;
  final _firebaseMessaging = FirebaseMessaging.instance;
  final mainScreenController =
      Get.put<GBSystemMainScreenController>(GBSystemMainScreenController());
  final chatScreenController =
      Get.put<GBSystemChatScreenController>(GBSystemChatScreenController());
  final planningVacationController =
      Get.put<GBSystemPlanningVacationController>(
          GBSystemPlanningVacationController());
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final GBSystemSalarieController salarieController =
      Get.put(GBSystemSalarieController());
  final connectionCheckerController =
      Get.put<GBSystemInternatController>(GBSystemInternatController());
  Future<void> subscribeTopicsAndDisubscribeOld() async {
    await TopicManager().unsubscribeFromAllTopics();
    List<String> all = await TopicManager().getSubscribedTopics();
    print(all);

    (salarieController.getSalarie?.listTopics ?? []).forEach(
      (element) async {
        await TopicManager().subscribeToTopic(element.TOPICS);
        List<String> all = await TopicManager().getSubscribedTopics();
        print(all);
      },
    );
  }

  Future<void> initNotifications() async {
    await _requestNotificationPermissions();
    //topic's
    // await _firebaseMessaging.unsubscribeFromTopic("news");

    // await _firebaseMessaging
    //     .subscribeToTopic("${GbsSystemServerStrings.kTopicClient}");
    //boubaker 14/04/2025
   // await subscribeTopicsAndDisubscribeOld();
// When Token Refresh
    print("New Token :firebaseMessaging.onTokenRefresh.listen");
    _firebaseMessaging.onTokenRefresh.listen((String newToken) async {
      connectionCheckerController.initConnectivity();
      if (connectionCheckerController.isConnected) {
        print("New Token : $newToken");

        try {
          await GBSystem_AuthService(context)
              .sendTokenNotification(token: newToken);
        } catch (e) {
          GBSystem_ManageCatchErrors().catchErrors(context,
              message: e.toString(),
              method: "initNotifications",
              page: "firebase_serivce");
        }
      }
    });
// Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("message title lenght ${message.notification?.title?.length}");

      print("message body 2 lenght ${message.notification?.body?.length}");
      print("message data ${message.data}");
      if (message.data.containsKey("NT_IDF")) {
        GBSystem_AuthService(context)
            .send_NT_IDF(NT_IDF: message.data["NT_IDF"]);
      }

      if (message.data.containsKey("BMType")) {
        switch (message.data["BMType"]) {
          case "Chat":
            if (await checkConnected()) {
              Get.to(GBSystemSplashScreen(
                toMainChat: true,
              ));
            }

            break;

          case "PLA_SVR":
            if (await checkConnected()) {
              planningVacationController.setAllVacation = null;
              Get.to(GBSystemSplashScreen(
                toMainPlanning: true,
              ));
            }

            break;
        }
      }
    });
// forground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("message title lenght ${message.notification?.title?.length}");

      print("message body lenght ${message.notification?.body?.length}");

      if (message.data.containsKey("NT_IDF")) {
        GBSystem_AuthService(context)
            .send_NT_IDF(NT_IDF: message.data["NT_IDF"]);
      }
      if (message.data.containsKey("BMType")) {
        switch (message.data["BMType"]) {
          case "Chat":
            // if (mainScreenController.checkChatPage() == false &&
            //     chatScreenController.isPageOpened == false) {
            _showLocalNotification(message, "1");
            // }
            break;

          case "PLA_SVR":
            _showLocalNotification(message, "2");

            break;
          default:
            _showLocalNotification(message, "0");
        }
      } else {
        _showLocalNotification(message, "0");
      }
    });
    //terminated
    FirebaseMessaging.onBackgroundMessage(
      (message) async {
        print("message title lenght ${message.notification?.title?.length}");

        print("message body lenght ${message.notification?.body?.length}");
        if (message.data.containsKey("NT_IDF")) {
          GBSystem_AuthService(context)
              .send_NT_IDF(NT_IDF: message.data["NT_IDF"]);
        }
        if (message.data.containsKey("BMType")) {
          switch (message.data["BMType"]) {
            case "Chat":
              if (await checkConnected()) {
                Get.to(GBSystemSplashScreen(
                  toMainChat: true,
                ));
                // Get.to(GBSystemMainScreen(
                //   selectedIndexNavBar: 3,
                //   selectedIndexPopup: 3,
                // ));
              }
              break;

            case "PLA_SVR":
              if (await checkConnected()) {
                planningVacationController.setAllVacation = null;
                Get.to(GBSystemSplashScreen(
                  toMainPlanning: true,
                ));
              }

              break;
          }
        }
      },
    );
  }

  void _showNotificationDialog(RemoteMessage message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message.notification?.title ?? 'Notification'),
          content:
              Text(message.notification?.body ?? 'You have a new message.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<void> getToken() async {
    await _firebaseMessaging.requestPermission();

    String? FCMToken = await _firebaseMessaging.getToken();
    print("token : $FCMToken");
    if (FCMToken != null) {
      try {
        await GBSystem_AuthService(context)
            .sendTokenNotification(token: FCMToken);
      } catch (e) {
        GBSystem_ManageCatchErrors().catchErrors(context,
            message: e.toString(),
            method: "getToken",
            page: "firebase_serivce");
      }
    }
  }

  Future<void> _requestNotificationPermissions() async {
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
  void  notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}
  Future<void> _initializeLocalNotifications(String channelID) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher_foreground');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    //notificationCategories: darwinNotificationCategories,
  );

     InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,//DarwinInitializationSettings(),
    );



    if (Platform.isIOS) {
          await _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _localNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();
     // setState(() {
    //    _notificationsEnabled = grantedNotificationPermission ?? false;
    //  });
    }
          // else android
  //  _flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //      onDidReceiveNotificationResponse: onNotificationTap,
  //      onDidReceiveBackgroundNotificationResponse: onNotificationTap);
 // }


    await _localNotificationsPlugin.initialize(
      initializationSettings,
    // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: (details) async {
         print('onDidReceiveNotificationResponse');
        switch (channelID) {
          case "1":
            Get.to(GBSystemSplashScreen(
              toMainChat: true,
            ));

            break;
          case "2":
            planningVacationController.setAllVacation = null;
            Get.to(GBSystemSplashScreen(
              toMainPlanning: true,
            ));

            break;
        }
        // if (await checkConnected()) {
        //   Get.to(GBSystemSplashScreen(
        //     toMainChat: true,
        //   ));
        //   // Get.to(GBSystemMainScreen(
        //   //   selectedIndexNavBar: 3,
        //   //   selectedIndexPopup: 3,
        //   // ));
        // }
      },
    );
  }

  Future<void> _showLocalNotification(
      RemoteMessage message, String channelID) async {
    await _initializeLocalNotifications(channelID);

    switch (channelID) {
      case "1":
        await _createNotificationChannel(
            canalID: "1", canalName: "BMSoft Chat");

        break;

      case "2":
        await _createNotificationChannel(
            canalID: "2", canalName: "BMSoft PLA_SVR");

        break;
      default:
        await _createNotificationChannel(
            canalID: "0", canalName: "BMSoft New Canal");
    }

    // final largeIconPath = await downloadFile(
    //   "https://www.photo-paysage.com/albums/userpics/10001/thumb_Tignes-ruisseau_du_lac.jpeg",
    //   "largeIcon",
    // );
    // final bigPicturePath = await downloadFile(
    //   "https://www.photo-paysage.com/albums/userpics/10001/thumb_Tignes-ruisseau_du_lac.jpeg",
    //   "bigPicturePath",
    // );
    // StyleInformation styleInformation = BigPictureStyleInformation(
    //   FilePathAndroidBitmap(bigPicturePath!),
    //   largeIcon: FilePathAndroidBitmap(largeIconPath!),
    // );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '0', // Your channel ID
      'BMSoft Messagerie', // Your channel name
      channelDescription: 'description messagerie',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      // styleInformation: styleInformation
    );

    //boubaker 17/03/2025 Notification FCM IOS
// Create iOS notification details
const DarwinNotificationDetails iosPlatformChannelSpecifics = DarwinNotificationDetails(
  presentAlert: true,  // Show alert
  presentBadge: true,  // Show badge
  presentSound: true,  // Play sound
);

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      //boubaker 17/03/2025 Notification FCM IOS
      iOS: iosPlatformChannelSpecifics, // Use DarwinNotificationDetails for iOS
    );

    await _localNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,

      // payload: message.data.toString(), // Pass data to navigate if needed
      payload: message.data['payload'], // Add your payload if needed
    );
  }

  Future<void> _createNotificationChannel(
      {required String canalID, required String canalName}) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      canalID, // Your channel ID
      canalName, // Your channel name
      description: canalName,
      importance: Importance.max,
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

///////////
  Future<String?> downloadFile(String url, String filename) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/$filename';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return filePath;
      }
    } catch (e) {
      print("Error downloading file: $e");
    }
    return null;
  }

  Future<bool> checkConnected() async {
    RxString? token, cookies;
    await SharedPreferences.getInstance().then((value) {
      value.getString(GbsSystemServerStrings.kToken) != null &&
              value.getString(GbsSystemServerStrings.kToken)!.isNotEmpty
          ? token = RxString(value.getString(GbsSystemServerStrings.kToken)!)
          : null;
      value.getString(GbsSystemServerStrings.kCookies) != null &&
              value.getString(GbsSystemServerStrings.kToken)!.isNotEmpty
          ? cookies =
              RxString(value.getString(GbsSystemServerStrings.kCookies)!)
          : null;
    });
    return ((token?.value != null && cookies?.value != null) == true);
  }
}
