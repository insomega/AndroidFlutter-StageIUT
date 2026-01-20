import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';

class GBSystemWaitingWidgetQuickAccess extends StatelessWidget {
  const GBSystemWaitingWidgetQuickAccess({super.key, this.text});
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 300,
          // decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpinKitWave(
                  size: 20,
                  duration: const Duration(milliseconds: 1500),
                  itemBuilder: (BuildContext context, int index) {
                    return const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                text != null
                    ? GBSystem_TextHelper().smallText(text: text!)
                    : Container()
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GBSystemWaitingWidgetFiltred extends StatelessWidget {
  const GBSystemWaitingWidgetFiltred({super.key, this.text});
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            width: 300,
            height: 300,
          ),
        ),
        Center(
          child: SpinKitWave(
            size: 20,
            duration: const Duration(milliseconds: 1500),
            itemBuilder: (BuildContext context, int index) {
              return const DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
