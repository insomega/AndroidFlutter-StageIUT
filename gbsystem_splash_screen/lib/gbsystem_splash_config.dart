import 'package:flutter/material.dart';

class GBSystem_SplashStep {
  final String label;
  final Future<void> Function() action;

  GBSystem_SplashStep({required this.label, required this.action});
}

class GBSystem_SplashConfig {
  final String logoAsset;
  final Color backgroundColor;
  final List<GBSystem_SplashStep> steps;
  final String fallbackRoute;

  GBSystem_SplashConfig({required this.logoAsset, required this.backgroundColor, required this.steps, required this.fallbackRoute});
}
