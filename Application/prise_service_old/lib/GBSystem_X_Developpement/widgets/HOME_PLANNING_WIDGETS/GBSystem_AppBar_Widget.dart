import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GBSystemCustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const GBSystemCustomAppBarWidget({
    super.key,
    this.trailingBool = false,
    this.titleBool = false,
    required this.leadingIcon,
    this.trailingIcon = const Icon(CupertinoIcons.arrow_right),
    this.title = "title",
    this.onLeadingTap,
    this.onTrailingTap,
    this.isDrawerOpened = false,
    this.openDrawerWithLeading = false,
    this.customTrailingBool = false,
    this.customTrailing = const SizedBox(),
    this.leadingBool = true,
  });
  final Widget customTrailing;
  final bool isDrawerOpened;
  final bool trailingBool, titleBool;
  final Icon leadingIcon, trailingIcon;
  final String title;
  final bool openDrawerWithLeading, customTrailingBool, leadingBool;
  final void Function()? onLeadingTap, onTrailingTap;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
          child: SizedBox(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: leadingBool,
                  child: InkWell(
                    onTap: openDrawerWithLeading
                        ? () {
                            Scaffold.of(context).openDrawer();
                          }
                        : onLeadingTap,
                    child: Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: Container(
                          width: size.height * 0.07,
                          height: size.height * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: -15,
                                blurRadius: 18,
                                offset: const Offset(
                                    10, 20), // changes the shadow position
                              ),
                            ],
                          ),
                          child: leadingIcon),
                    ),
                  ),
                ),
                Visibility(
                  visible: titleBool,
                  child: Container(
                    width: size.height * 0.25,
                    height: size.height * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: -15,
                          blurRadius: 18,
                          offset: const Offset(
                              10, 20), // changes the shadow position
                        ),
                      ],
                    ),
                    child: Center(
                        child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
                Visibility(
                  visible: trailingBool,
                  child: customTrailingBool
                      ? customTrailing
                      : InkWell(
                          onTap: onTrailingTap,
                          child: Padding(
                            padding: EdgeInsets.only(right: size.width * 0.05),
                            child: Container(
                                width: size.height * 0.07,
                                height: size.height * 0.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: -15,
                                      blurRadius: 18,
                                      offset: const Offset(10,
                                          20), // changes the shadow position
                                    ),
                                  ],
                                ),
                                child: trailingIcon),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: isDrawerOpened,
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 5, sigmaY: 5), // Adjust the blur intensity
            child: Container(
              color: Colors.transparent,
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
