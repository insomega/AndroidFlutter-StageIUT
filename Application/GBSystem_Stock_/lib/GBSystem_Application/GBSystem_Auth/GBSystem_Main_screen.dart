import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'GBSystem_ScreenHelper.dart';
import 'GBSystem_app_info_details_model.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/packages/popup_package/src/popup_menu.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/ABSENCE_SCREENS/ABSENCE_MAIN_SCREEN/GBSystem_absence_main_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/DOCUMENTS_SCREENS/DOCUMENT_MAIN_SCREEN/GBSystem_document_main_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/INFO_SALARIE_SCREENS/INFO_SALARIE_MAIN/GBSystem_info_salarie_main_screen.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/MAIN_SCREEN/GBSystem_main_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PLANNING_SCREEN/PLANNING_MAIN/GBSystem_planning_main_screen.dart';
import 'GBSystem_Ajoutpackage_info_service.dart';
import 'GBSystem_Application_Strings.dart';

class GBSystemMainScreen extends StatefulWidget {
  GBSystemMainScreen({super.key, this.selectedIndexNavBar, this.selectedIndexPopup, this.valideAuth = false});

  final int? selectedIndexNavBar, selectedIndexPopup;
  final bool valideAuth;

  @override
  State<GBSystemMainScreen> createState() => _GBSystemMainScreenState();
}

class _GBSystemMainScreenState extends State<GBSystemMainScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  String _authStatus = GBSystem_Application_Strings.str_auth_please_authentificate.tr;
  bool authSuccess = false;

  // Check if device supports biometrics
  Future<bool> _checkBiometrics() async {
    bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
    return canCheckBiometrics;
  }

  // Authenticate using biometrics
  Future<bool> _authenticate() async {
    try {
      bool authenticated = await _localAuth.authenticate(localizedReason: GBSystem_Application_Strings.str_auth_please_authentificate_to_proceed.tr, options: AuthenticationOptions(useErrorDialogs: true, stickyAuth: true));
      setState(() {
        _authStatus = authenticated ? GBSystem_Application_Strings.str_auth_auth_success.tr : GBSystem_Application_Strings.str_auth_auth_failed.tr;
      });
      authSuccess = authenticated;
      return authenticated;
    } catch (e) {
      setState(() {
        _authStatus = "${GBSystem_Application_Strings.str_dialog_erreur.tr}: ${e.toString()}";
      });
      authSuccess = true;

      return false;
    }
  }

  Future<void> resultAuth() async {
    bool canAuthenticate = await _checkBiometrics();

    if (canAuthenticate) {
      // Loop until authentication succeeds
      if (!authSuccess) {
        await _authenticate();
        if (authSuccess) {
          // Authentication succeeded, print success message
          print("auth success -----");
        } else {
          exit(0);
        }
      }
    } else {
      setState(() {
        _authStatus = GBSystem_Application_Strings.str_auth_biometrics_not_available.tr;
      });

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(GBSystem_Application_Strings.str_auth_biometrics_not_available.tr),
            content: Text(GBSystem_Application_Strings.str_device_dont_support_biometrics.tr),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  authSuccess = true;
                },
                child: Text(GBSystem_Application_Strings.str_fermer.tr),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    m.currentIndex.value = 0;
    m.selectedIndex = 0;
    if (widget.selectedIndexNavBar != null) {
      _selectedItemPosition = widget.selectedIndexNavBar!;
    }
    if (widget.selectedIndexNavBar != null) {
      m.currentIndex.value = widget.selectedIndexNavBar!;
    }

    if (widget.selectedIndexPopup != null) {
      m.selectedIndex = widget.selectedIndexPopup!;
    }

    if (widget.valideAuth) {
      resultAuth();
    }
    updateAppVersion();
    super.initState();
  }

  final m = Get.put<GBSystemMainScreenController>(GBSystemMainScreenController());

  void updateAppVersion() async {
    if (m.salarieController.getSalarie?.appInfo?.APP_INFO != null) {
      GbsystemAppInfoDetailsModel? appInfoDetailsModel = GbsystemAppInfoDetailsModel.parseStringToData(dataString: m.salarieController.getSalarie?.appInfo?.APP_INFO);
      print(appInfoDetailsModel?.app_store_link);
      print(appInfoDetailsModel?.play_store_link);
      print(appInfoDetailsModel?.update_required);
      print(appInfoDetailsModel?.version);

      String currentVersion = await PackageInfoService().getAppVersion();
      print("current $currentVersion");
      print("test ${appInfoDetailsModel?.update_required}");

      if (appInfoDetailsModel?.version != currentVersion) {
        m.showUpdateDialog(context, isDissmisible: appInfoDetailsModel?.update_required != "1", appInfoDetails: appInfoDetailsModel);
      }
    }
  }

  //// bottom nav bar
  int _selectedItemPosition = 0, _selectedItemPositionHelper = 0;
  //// popup menu bar

  ///Global keys
  GlobalKey _planningKey = GlobalKey();
  GlobalKey _absenceKey = GlobalKey();
  GlobalKey _infoSalarieKey = GlobalKey();
  GlobalKey _documentsKey = GlobalKey();
  GlobalKey _bottomBarKey = GlobalKey();

  void popupPlanning(BuildContext context) {
    PopupMenu menu = PopupMenu(
      context: context,
      config: MenuConfig(
        arrowHeight: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.03),
        // 20,
        itemHeight: 65,
        itemWidth: 75,

        type: MenuType.grid,
        backgroundColor: GBSystem_Application_Strings.str_primary_color,
        lineColor: Colors.white,
        // border: BorderConfig(color: Colors.white,w),
        highlightColor: Colors.black54,
      ),
      items: [
        PopUpMenuItem(
          userInfo: 0,
          textStyle: TextStyle(fontSize: 12, color: Colors.white, height: 0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          title: GBSystem_Application_Strings.str_planning.tr,
          image: Icon(Icons.event, color: Colors.white),
        ),
        PopUpMenuItem(
          userInfo: 1,
          textStyle: TextStyle(fontSize: 12, color: Colors.white, height: 0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          title: GBSystem_Application_Strings.str_prise_de_vacation.tr,
          image: Icon(Icons.calendar_today, color: Colors.white),
        ),
        PopUpMenuItem(
          userInfo: 2,
          textStyle: TextStyle(fontSize: 12, color: Colors.white, height: 0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          title: GBSystem_Application_Strings.str_disponibiliter_propositions_de_vacation.tr,
          image: Icon(Icons.access_time, color: Colors.white),
        ),
        PopUpMenuItem(
          userInfo: 3,
          textStyle: TextStyle(fontSize: 12, color: Colors.white, height: 0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          title: GBSystem_Application_Strings.str_exclusions_propositions_vacation.tr,
          image: Icon(Icons.cancel, color: Colors.white),
        ),
      ],
      onClickMenu: (item) {
        setState(() {
          m.selectedIndex = int.parse(item.menuUserInfo.toString());
        });

        setState(() {
          _selectedItemPosition = _selectedItemPositionHelper;
        });
      },
      onShow: () {
        if (m.currentIndex.value != 1) {
          m.selectedIndex = null;
        }
      },
      onDismiss: () {
        print("dissmis");
      },
    );

    // Get the size and position of the widget using the GlobalKey
    final RenderBox renderBox = _planningKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    // Adjust the rect by moving it 20 pixels up
    Rect rect = Rect.fromLTWH(
      position.dx,
      position.dy - 40, // Move the popup 20 pixels up
      size.width,
      size.height,
    );

    menu.show(widgetKey: _planningKey, rect: rect);
  }

  void popupAbsence(BuildContext context) {
    PopupMenu menu = PopupMenu(
      context: context,
      config: MenuConfig(
        arrowHeight: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.03),

        // arrowHeight: 10,
        itemHeight: 65,
        itemWidth: 75,
        type: MenuType.grid,
        backgroundColor: GBSystem_Application_Strings.str_primary_color,
        lineColor: Colors.white,
        highlightColor: Colors.black54,
      ),
      items: [
        PopUpMenuItem(
          userInfo: 0,
          textStyle: TextStyle(fontSize: 12, color: Colors.white, height: 0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          title: GBSystem_Application_Strings.str_absence.tr,
          image: Icon(Icons.directions_walk, color: Colors.white),
        ),
        PopUpMenuItem(
          userInfo: 1,
          textStyle: TextStyle(fontSize: 12, color: Colors.white, height: 0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          title: GBSystem_Application_Strings.str_indisponibiliter.tr,
          image: Icon(Icons.do_not_disturb_alt, color: Colors.white),
        ),
        // PopUpMenuItem(
        //     userInfo: 2,
        //     textStyle: TextStyle(
        //         fontSize: 12,
        //         color: Colors.white,
        //         height: 0,
        //         fontWeight: FontWeight.w500),
        //     textAlign: TextAlign.center,
        //     title: GBSystem_Application_Strings.str_indisponibiliter.tr,
        //     image: Icon(
        //       Icons.not_interested,
        //       color: Colors.white,
        //     )),
        PopUpMenuItem(
          userInfo: 2,
          textStyle: TextStyle(fontSize: 12, color: Colors.white, height: 0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          title: GBSystem_Application_Strings.str_cet,
          image: Icon(Icons.manage_history, color: Colors.white),
        ),
      ],
      onClickMenu: (item) {
        setState(() {
          m.selectedIndex = int.parse(item.menuUserInfo.toString());
        });

        setState(() {
          _selectedItemPosition = _selectedItemPositionHelper;
        });
      },
      onShow: () {
        if (m.currentIndex.value != 2) {
          m.selectedIndex = null;
        }
      },
      onDismiss: () {},
    );

    // Get the size and position of the widget using the GlobalKey
    final RenderBox renderBox = _absenceKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    // Adjust the rect by moving it 20 pixels up
    Rect rect = Rect.fromLTWH(
      position.dx,
      position.dy - 40, // Move the popup 20 pixels up
      size.width,
      size.height,
    );

    menu.show(widgetKey: _absenceKey, rect: rect);
  }

  void popupInfoSalarie(BuildContext context) {
    PopupMenu menu = PopupMenu(
      context: context,
      config: MenuConfig(
        // arrowHeight: 10,
        arrowHeight: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.03),

        itemHeight: 65,
        itemWidth: 75,
        type: MenuType.grid,
        backgroundColor: GBSystem_Application_Strings.str_primary_color,
        lineColor: Colors.white,
        highlightColor: Colors.black54,
      ),
      items: [
        PopUpMenuItem(
          userInfo: 0,
          textStyle: TextStyle(fontSize: 12, color: Colors.white, height: 0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          title: GBSystem_Application_Strings.str_info_salarie.tr,
          image: Icon(Icons.person, color: Colors.white),
        ),
        PopUpMenuItem(
          userInfo: 1,
          textStyle: TextStyle(fontSize: 12, color: Colors.white, height: 0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          title: GBSystem_Application_Strings.str_carte_proffisionel.tr,
          image: Icon(Icons.credit_card, color: Colors.white),
        ),
        PopUpMenuItem(
          userInfo: 2,
          textStyle: TextStyle(fontSize: 12, color: Colors.white, height: 0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          title: GBSystem_Application_Strings.str_tenue.tr,
          image: Icon(Icons.wc, color: Colors.white),
        ),
        PopUpMenuItem(
          userInfo: 3,
          textStyle: TextStyle(fontSize: 12, color: Colors.white, height: 0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          title: GBSystem_Application_Strings.str_messagerie.tr,
          image: Icon(Icons.message, color: Colors.white),
        ),
        PopUpMenuItem(
          userInfo: 4,
          textStyle: TextStyle(fontSize: 12, color: Colors.white, height: 0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          title: GBSystem_Application_Strings.str_options.tr,
          image: Icon(Icons.settings, color: Colors.white),
        ),
      ],
      onClickMenu: (item) {
        setState(() {
          m.selectedIndex = int.parse(item.menuUserInfo.toString());
        });

        setState(() {
          _selectedItemPosition = _selectedItemPositionHelper;
        });
      },
      onShow: () {
        if (m.currentIndex.value != 3) {
          m.selectedIndex = null;
        }
      },
      onDismiss: () {},
    );

    // Get the size and position of the widget using the GlobalKey
    final RenderBox renderBox = _infoSalarieKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    // Adjust the rect by moving it 20 pixels up
    Rect rect = Rect.fromLTWH(
      position.dx,
      position.dy - 35, // Move the popup 20 pixels up
      size.width,
      size.height,
    );

    menu.show(widgetKey: _infoSalarieKey, rect: rect);
  }

  void popupDocuments(BuildContext context) {
    PopupMenu menu = PopupMenu(
      context: context,
      config: MenuConfig(
        // arrowHeight: 10,
        arrowHeight: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.03),

        itemHeight: 65,
        itemWidth: 75,
        type: MenuType.grid,
        backgroundColor: GBSystem_Application_Strings.str_primary_color,
        lineColor: Colors.white,
        highlightColor: Colors.black54,
      ),
      items: [
        PopUpMenuItem(
          userInfo: 0,
          textStyle: TextStyle(fontSize: 12, color: Colors.white, height: 0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          title: GBSystem_Application_Strings.str_documents.tr,
          image: Icon(Icons.folder, color: Colors.white),
        ),
        PopUpMenuItem(
          userInfo: 1,
          textStyle: TextStyle(fontSize: 12, color: Colors.white, height: 0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          title: GBSystem_Application_Strings.str_documents_de_lentreprise.tr,
          image: Icon(Icons.business, color: Colors.white),
        ),
      ],
      onClickMenu: (item) {
        setState(() {
          m.selectedIndex = int.parse(item.menuUserInfo.toString());
        });

        setState(() {
          _selectedItemPosition = _selectedItemPositionHelper;
        });
      },
      onShow: () {
        if (m.currentIndex.value != 4) {
          m.selectedIndex = null;
        }
      },
      onDismiss: () {},
    );

    // Get the size and position of the widget using the GlobalKey
    final RenderBox renderBox = _documentsKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    // Adjust the rect by moving it 20 pixels up
    Rect rect = Rect.fromLTWH(
      position.dx,
      position.dy - 40, // Move the popup 20 pixels up
      size.width,
      size.height,
    );

    menu.show(widgetKey: _documentsKey, rect: rect);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: SnakeNavigationBar.color(
          backgroundColor: GBSystem_Application_Strings.str_primary_color,
          height: 70,
          behaviour: SnakeBarBehaviour.floating,
          snakeShape: SnakeShape.indicator,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
          padding: const EdgeInsets.only(right: 10, left: 10, bottom: 5, top: 10),
          snakeViewColor: Colors.white,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          currentIndex: _selectedItemPosition,
          key: _bottomBarKey,
          onTap: (index) {
            print(_selectedItemPosition);
            // restart with first index when change item
            if (index != m.currentIndex.value) {
              m.selectedIndex = null;
            }
            //change page when click in item
            m.currentIndex.value = index;

            //change item when open popup
            if (index == 0) {
              setState(() {
                _selectedItemPosition = index;
              });
            }

            _selectedItemPositionHelper = index;
            switch (index) {
              case 0:
                print("no sous items");
                break;
              case 1:
                popupPlanning(context);
                break;
              case 2:
                popupAbsence(context);
                break;
              case 3:
                popupInfoSalarie(context);
                break;
              case 4:
                popupDocuments(context);
                break;

              default:
                0;
            }
          },
          items: [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: GBSystem_Application_Strings.str_home.tr),
            BottomNavigationBarItem(
              icon: Container(key: _planningKey, child: Icon(CupertinoIcons.calendar)),
              label: GBSystem_Application_Strings.str_planning.tr,
            ),
            BottomNavigationBarItem(
              icon: Container(key: _absenceKey, child: Icon(CupertinoIcons.person_crop_circle_badge_xmark)),
              label: GBSystem_Application_Strings.str_absence.tr,
            ),
            BottomNavigationBarItem(
              icon: Container(
                key: _infoSalarieKey,
                child: Center(child: Icon(CupertinoIcons.person_solid)),
              ),
              label: "${GBSystem_Application_Strings.str_info_salarie.tr}",
            ),
            BottomNavigationBarItem(
              icon: Container(key: _documentsKey, child: Icon(CupertinoIcons.doc_on_clipboard)),
              label: GBSystem_Application_Strings.str_documents.tr,
            ),
          ],
          selectedLabelStyle: const TextStyle(fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontSize: 9),
        ),
      ),

      body: Column(
        children: [
          m.currentIndex.value == 1
              ? Expanded(child: GBSystemPlanningMainScreen(selectedIndexFromOut: m.selectedIndex ?? 0))
              : m.currentIndex.value == 2
              ? Expanded(child: GBSystemAbsenceMainScreen(selectedIndexFromOut: m.selectedIndex ?? 0))
              : m.currentIndex.value == 3
              ? Expanded(child: GBSystemInfoSalarieMainScreen(selectedIndexFromOut: m.selectedIndex ?? 0))
              : m.currentIndex.value == 4
              ? Expanded(child: GBSystemDocumentMainScreen(selectedIndexFromOut: m.selectedIndex ?? 0))
              : Expanded(child: m.screens[m.currentIndex.value]),
        ],
      ),

      // Obx(
      //   () => Column(
      //     children: [
      //       m.currentIndex.value == 1
      //           ? Expanded(
      //               child: GBSystemPlanningMainScreen(
      //               selectedIndexFromOut: selectedIndex ?? 0,
      //             ))
      //           : Expanded(child: m.screens[m.currentIndex.value]),
      //     ],
      //   ),
      // )
    );
  }
}
