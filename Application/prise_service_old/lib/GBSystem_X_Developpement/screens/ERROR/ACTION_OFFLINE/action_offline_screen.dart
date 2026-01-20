import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/SPLASH_SCREENS/splash_screen/GBSystem_Splash_screen.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_local_database_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/GBSystem_waiting.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hive/hive.dart';

class ActionOfflineScreen extends StatefulWidget {
  const ActionOfflineScreen({super.key});

  @override
  State<ActionOfflineScreen> createState() => _ActionOfflineScreenState();
}

class _ActionOfflineScreenState extends State<ActionOfflineScreen> {
  RxInt nombreActions = RxInt(0);
  RxInt progress = RxInt(0);

  @override
  void initState() {
    doActions();
    // LocalDatabaseService().getAllStoredRequests().then(
    //   (value) {
    //     nombreActions.value = value.length;
    //   },
    // );

    super.initState();
  }

  Future doActions() async {
    final box = Hive.box(GbsSystemServerStrings.kHiveBox_Requests);
    nombreActions.value = box.length;
    for (int i = (box.length - 1); i >= 0; i--) {
      print(i);
      final request = box.getAt(i);
      print(request);
      await LocalDatabaseService().retrySingleRequests(request).then(
        (value) async {
          if (value) {
            progress.value++;
            await box.deleteAt(i);
          } else {
            print("action $i error");
          }
        },
      );
    }
    Get.offAll(GBSystemSplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        shadowColor: Colors.grey.withOpacity(0.5),
        toolbarHeight: 80,
        backgroundColor: GbsSystemServerStrings.str_primary_color,
        title: const Text(
          GbsSystemStrings.str_actions_offline,
          style: TextStyle(color: Colors.white),
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              CupertinoIcons.arrow_left,
              color: Colors.white,
            )),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WaitingWidgets(
                size: 50,
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => GBSystem_TextHelper().smallText(
                    text: "${progress.value} / ${nombreActions.value}",
                    textColor: GbsSystemServerStrings.str_primary_color),
              )
            ],
          ),
        ],
      ),
    );
  }
}
