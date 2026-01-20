import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class TabBarWidget extends StatefulWidget {
  TabBarWidget(
      {Key? key,
      required this.items,
      required this.pageController,
      this.color1,
      required this.current,
      required this.scrollController,
      this.color2})
      : super(key: key);
  final List<String> items;
  PageController pageController;
  Rx<ScrollController> scrollController;
  RxInt current;
  final Color? color1, color2;

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: double.infinity,
          margin: const EdgeInsets.all(5),
          child: SizedBox(
            width: double.infinity,
            height: 80,
            child: ListView.builder(
                controller: widget.scrollController.value,
                physics: const BouncingScrollPhysics(),
                itemCount: widget.items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.current.value = index;
                          widget.pageController.animateToPage(
                            widget.current.value,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.ease,
                          );
                        },
                        child: Obx(
                          () => AnimatedContainer(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(5),
                            height: 55,
                            width: 220,
                            decoration: BoxDecoration(
                              color: widget.current.value == index
                                  ? widget.color1 ??
                                      GbsSystemStrings.str_primary_color
                                  : Colors.grey.shade200,
                              borderRadius: widget.current.value == index
                                  ? BorderRadius.circular(12)
                                  : BorderRadius.circular(7),
                              border: widget.current.value == index
                                  ? Border.all(
                                      color: GbsSystemStrings.str_primary_color,
                                      width: 2.5)
                                  : Border.all(
                                      color: Colors.grey.shade300, width: 2),
                            ),
                            child: Center(
                                child: GBSystem_TextHelper().smallText(
                              text: widget.items[index],
                              fontWeight: FontWeight.w500,
                              maxLines: 2,
                              textColor: widget.current.value == index
                                  ? Colors.white
                                  : Colors.black45,
                            )),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                              color: GbsSystemStrings.str_primary_color,
                              shape: BoxShape.circle),
                        ),
                      )
                    ],
                  );
                }),
          ),
        ));
  }
}
