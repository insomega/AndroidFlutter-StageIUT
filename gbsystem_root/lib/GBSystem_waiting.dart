import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:gbsystem_root/GBSystem_text_helper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Waiting extends StatelessWidget {
  Waiting({
    super.key,
    this.height, //
    this.width,
    this.borderRaduis,
    this.text,
    this.colorBackground,
    this.loadingLottieSize,
    this.textColor,
    this.loadingLottieColor,
  });

  final double? height, width, borderRaduis, loadingLottieSize;
  final String? text;
  final Color? colorBackground, textColor, loadingLottieColor;

  final spinkit = SpinKitChasingDots(
    size: 80,
    duration: const Duration(milliseconds: 1500),
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(decoration: BoxDecoration(color: GBSystem_Application_Strings.str_primary_color.withOpacity(0.8)));
    },
  );

  final newLoading = LoadingAnimationWidget.fourRotatingDots(color: GBSystem_Application_Strings.str_primary_color, size: 50);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(borderRadius: borderRaduis != null ? BorderRadius.circular(borderRaduis!) : null, color: colorBackground ?? Colors.grey.withOpacity(0.3)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.fourRotatingDots(color: loadingLottieColor ?? GBSystem_Application_Strings.str_primary_color, size: loadingLottieSize ?? 50),
              // newLoading
            ],
          ),
          text != null ? GBSystem_TextHelper().smallText(text: text!, textColor: textColor ?? Colors.black, fontWeight: FontWeight.bold) : Container(),
        ],
      ),
    );
  }
}

class WaitingWidgets extends StatelessWidget {
  const WaitingWidgets({super.key, this.size, this.color});

  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.fourRotatingDots(color: color ?? GBSystem_Application_Strings.str_primary_color, size: size ?? 20);

    // SpinKitFoldingCube(
    //   size: 20,
    //   duration: const Duration(milliseconds: 1500),
    //   itemBuilder: (BuildContext context, int index) {
    //     return const DecoratedBox(
    //       decoration: BoxDecoration(
    //         color: GBSystem_Application_Strings.str_primary_color,
    //       ),
    //     );
    //   },
    // );
  }
}
