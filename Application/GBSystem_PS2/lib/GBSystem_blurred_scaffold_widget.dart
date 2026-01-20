import 'dart:ui';
import 'package:flutter/material.dart';

/// Scaffold avec effet de flou dynamique et overlay optionnel.
///
/// Utilisation :
/// ```dart
/// GBSystemBlurredScaffoldWidget(
///   appBarTitle: "Mes Vacations",
///   shouldBlur: true,
///   overlay: MyOverlayWidget(),
///   body: MyMainContent(),
/// )
/// ```
class GBSystemBlurredScaffoldWidget extends StatelessWidget {
  final String appBarTitle;
  final bool shouldBlur;
  final Widget body;
  final Widget? overlay;
  final PreferredSizeWidget? customAppBar;
  final Color? backgroundColor;

  const GBSystemBlurredScaffoldWidget({super.key, required this.appBarTitle, required this.shouldBlur, required this.body, this.overlay, this.customAppBar, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar:
          customAppBar ??
          AppBar(
            title: Text(appBarTitle, style: const TextStyle(fontWeight: FontWeight.w600)),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          body,

          // Si shouldBlur == true → applique un effet de flou
          if (shouldBlur)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(color: Colors.black.withOpacity(0.3)),
              ),
            ),

          // Overlay optionnel au-dessus du blur
          if (overlay != null) overlay!,
        ],
      ),
    );
  }
}
