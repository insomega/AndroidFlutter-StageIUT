import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/ABSENCE_SCREENS/INDISPONIBILITER_MAIN_SCREEN/GBSystem_indisponibiliter_main_screen_controller.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemIndisponibiliterMainScreen extends StatefulWidget {
  GBSystemIndisponibiliterMainScreen(
      {super.key, required this.selectedIndexFromOut});

  final int selectedIndexFromOut;
  @override
  State<GBSystemIndisponibiliterMainScreen> createState() =>
      _GBSystemIndisponibiliterMainScreenState();
}

class _GBSystemIndisponibiliterMainScreenState
    extends State<GBSystemIndisponibiliterMainScreen>
    with SingleTickerProviderStateMixin {
  final m = Get.put<GBSystemIndisponibiliterMainScreenController>(
      GBSystemIndisponibiliterMainScreenController());

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        floatingActionButton: Draggable(
          feedback: Transform.translate(
            offset: Offset(
                GBSystem_ScreenHelper.screenWidthPercentage(context, 0.8), 0),
            child: SizedBox(
              height: 56,
              width: 56,
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  FloatingActionBubble(
                    items: <Bubble>[
                      Bubble(
                        title:
                            GbsSystemStrings.str_indisponibiliter_ponctuelle.tr,
                        iconColor: GbsSystemStrings.str_primary_color,
                        bubbleColor: Colors.white,
                        icon: Icons.do_not_disturb_alt,
                        titleStyle: TextStyle(
                            fontSize: 16,
                            color: GbsSystemStrings.str_primary_color),
                        onPress: () {
                          m.currentIndex.value = 0;
                          _animationController.reverse();
                        },
                      ),
                      Bubble(
                        title: GbsSystemStrings
                            .str_indisponibiliter_recurrentes.tr,
                        iconColor: GbsSystemStrings.str_primary_color,
                        bubbleColor: Colors.white,
                        icon: Icons.not_interested,
                        titleStyle: TextStyle(
                            fontSize: 16,
                            color: GbsSystemStrings.str_primary_color),
                        onPress: () {
                          m.currentIndex.value = 1;
                          _animationController.reverse();
                        },
                      ),
                    ],
                    animation: _animation,
                    onPress: () => _animationController.isCompleted
                        ? _animationController.reverse()
                        : _animationController.forward(),
                    iconColor: GbsSystemStrings.str_primary_color,
                    iconData: Icons.pages,
                    backGroundColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          childWhenDragging: Container(),
          child: FloatingActionBubble(
            items: <Bubble>[
              Bubble(
                title: GbsSystemStrings.str_indisponibiliter_ponctuelle.tr,
                iconColor: GbsSystemStrings.str_primary_color,
                bubbleColor: Colors.white,
                icon: Icons.do_not_disturb_alt,
                titleStyle: TextStyle(
                    fontSize: 16, color: GbsSystemStrings.str_primary_color),
                onPress: () {
                  m.currentIndex.value = 0;
                  _animationController.reverse();
                },
              ),
              Bubble(
                title: GbsSystemStrings.str_indisponibiliter_recurrentes.tr,
                iconColor: GbsSystemStrings.str_primary_color,
                bubbleColor: Colors.white,
                icon: Icons.not_interested,
                titleStyle: TextStyle(
                    fontSize: 16, color: GbsSystemStrings.str_primary_color),
                onPress: () {
                  m.currentIndex.value = 1;
                  _animationController.reverse();
                },
              ),
            ],
            animation: _animation,
            onPress: () => _animationController.isCompleted
                ? _animationController.reverse()
                : _animationController.forward(),
            iconColor: GbsSystemStrings.str_primary_color,
            iconData: Icons.pages,
            backGroundColor: Colors.white,
          ),
        ),
        // floatingActionButton: FloatingActionBubble(
        //   items: <Bubble>[
        //     Bubble(
        //       title: GbsSystemStrings.str_indisponibiliter_ponctuelle.tr,
        //       iconColor: GbsSystemStrings.str_primary_color,
        //       bubbleColor: Colors.white,
        //       icon: Icons.do_not_disturb_alt,
        //       titleStyle: TextStyle(
        //           fontSize: 16, color: GbsSystemStrings.str_primary_color),
        //       onPress: () {
        //         m.currentIndex.value = 0;
        //         _animationController.reverse();
        //       },
        //     ),
        //     Bubble(
        //       title: GbsSystemStrings.str_indisponibiliter_recurrentes.tr,
        //       iconColor: GbsSystemStrings.str_primary_color,
        //       bubbleColor: Colors.white,
        //       icon: Icons.not_interested,
        //       titleStyle: TextStyle(
        //           fontSize: 16, color: GbsSystemStrings.str_primary_color),
        //       onPress: () {
        //         m.currentIndex.value = 1;
        //         _animationController.reverse();
        //       },
        //     ),
        //   ],
        //   animation: _animation,
        //   onPress: () => _animationController.isCompleted
        //       ? _animationController.reverse()
        //       : _animationController.forward(),
        //   iconColor: GbsSystemStrings.str_primary_color,
        //   iconData: Icons.pages,
        //   backGroundColor: Colors.white,
        // ),

        body:
            //  Column(
            //   children: [
            //     Expanded(child: m.screens[widget.selectedIndexFromOut]),
            //   ],
            // ),

            Obx(
          () => Column(
            children: [
              Expanded(child: m.screens[m.currentIndex.value]),
            ],
          ),
        ));
  }
}
