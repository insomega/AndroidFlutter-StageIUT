// import 'package:animated_toggle/animated_toggle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/PLANNING_SCREEN/PLANNING_SCREEN/GBSystem_planning_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/package_info_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/CALENDAR_WIDGET/calendar_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/PLANNING_INFORMATION_WIDGET/planning_informations_widget.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/PLANNING_WIDGETS/vacation_informations_widget.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

import 'package:toggle_switch/toggle_switch.dart';

class GBSystemPlanningScreen extends StatefulWidget {
  const GBSystemPlanningScreen({super.key, this.isCommingFromOut = false});

  final bool isCommingFromOut;
  @override
  State<GBSystemPlanningScreen> createState() => _GBSystemPlanningScreenState();
}

class _GBSystemPlanningScreenState extends State<GBSystemPlanningScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      m.pageController.jumpToPage(m.selectedIndex.value);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _scrollController.dispose();
    // m.pageController.dispose();
  }

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool loading = false;
  final m = Get.put<GBSystemPlanningScreenController>(
      GBSystemPlanningScreenController());

  void updateLoading(bool loadingBool) {
    setState(() {
      loading = loadingBool;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            extendBodyBehindAppBar: false,
            appBar: AppBar(
              centerTitle: true,
              elevation: 4.0,
              shadowColor: GbsSystemStrings.str_primary_color,
              toolbarHeight: 80,
              backgroundColor: GbsSystemStrings.str_primary_color,
              title: Text(
                GbsSystemStrings.str_planning.tr,
                style: TextStyle(color: Colors.white),
              ),
              leading: widget.isCommingFromOut
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
            body: Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: GBSystem_ScreenHelper.screenHeightPercentage(
                          context, 0.02),
                    ),
                    child: Obx(
                      () => ToggleSwitch(
                        minWidth: MediaQuery.of(context).size.width - 20,
                        minHeight: 38,
                        fontSize: 14.0,
                        initialLabelIndex: m.selectedIndex.value,
                        activeBgColor: [GbsSystemStrings.str_primary_color],
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey.shade200.withOpacity(0.6),
                        inactiveFgColor: GbsSystemStrings.str_primary_color,
                        animate: false,
                        cornerRadius: 14,
                        totalSwitches: 3,
                        centerText: true,
                        labels: m.listType,
                        onToggle: (index) {
                          if (index != null) {
                            try {
                              // m.selectedType.value =
                              //     m.listType[ index ?? 0];

                              if (m.pageController.hasClients &&
                                  _scrollController.positions.isNotEmpty) {}
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                m.pageController.animateToPage(index ?? 0,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.linear);
                              });
                            } catch (e) {
                              GBSystem_ManageCatchErrors().catchErrors(context,
                                  message: e.toString(),
                                  method: "AnimatedHorizontalToggle",
                                  page: "GBSystem_planning_screen");
                            }
                          }
                        },
                      ),
                      // AnimatedHorizontalToggle(
                      //   taps: m.listType,
                      //   width: MediaQuery.of(context).size.width - 20,
                      //   height: 48,
                      //   activeBoxShadow: [
                      //     BoxShadow(
                      //       color: Colors.black12,
                      //       blurRadius: 1,
                      //       spreadRadius: 1,
                      //     ),
                      //   ],
                      //   duration: const Duration(milliseconds: 200),
                      //   initialIndex: m.selectedIndex.value,
                      //   background: Colors.grey.shade200.withOpacity(0.6),
                      //   activeColor: GbsSystemStrings.str_primary_color,
                      //   activeTextStyle: const TextStyle(
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w600,
                      //       color: Colors.white),
                      //   inActiveTextStyle: const TextStyle(
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w400,
                      //       color: GbsSystemStrings.str_primary_color),
                      //   horizontalPadding: 4,
                      //   verticalPadding: 4,
                      //   activeHorizontalPadding: 2,
                      //   activeVerticalPadding: 4,
                      //   radius: 14,
                      //   activeButtonRadius: 14,
                      //   onChange: (int currentIndex, int targetIndex) {
                      //     try {
                      //       m.selectedType.value = m.listType[targetIndex];
                      //       m.pageController.animateToPage(currentIndex,
                      //           duration: Duration(milliseconds: 300),
                      //           curve: Curves.linear);
                      //     } catch (e) {
                      //       GBSystem_ManageCatchErrors().catchErrors(context,
                      //           message: e.toString(),
                      //           method: "AnimatedHorizontalToggle",
                      //           page: "GBSystem_planning_screen");
                      //     }
                      //     // write Your Personal Code Here
                      //   },
                      //   showActiveButtonColor: true,
                      // ),
                    )),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                          context,
                          0.01,
                        ),
                        vertical: 5),
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: m.pageController,
                      children: [
                        Center(child: VacationInformationsWidget()),
                        Center(
                          child: PlanningInformationsWidget(
                              updateLoading: updateLoading),
                        ),
                        CalendarWidget()
                      ],
                    ),
                  ),
                )
              ],
            )),
        loading ? Waiting() : Container()
      ],
    );
  }
}
