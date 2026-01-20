// import 'package:get/get.dart';
// import 'splash_step.dart';

// class SplashManager {
//   final List<SplashStep> allSteps;
//   final VoidCallback onFinished;

//   final List<SplashStep> _stepsToRun = [];
//   int _currentIndex = 0;

//   SplashManager({required this.allSteps, required this.onFinished});

//   Future<void> start() async {
//     _stepsToRun.clear();
//     for (var step in allSteps) {
//       final shouldShow = await step.shouldDisplay();
//       if (shouldShow) _stepsToRun.add(step);
//     }

//     if (_stepsToRun.isEmpty) {
//       onFinished();
//     } else {
//       _currentIndex = 0;
//       _goToCurrentStep();
//     }
//   }

//   void _goToCurrentStep() {
//     final step = _stepsToRun[_currentIndex];
//     Get.to(() => step.buildView(_completeCurrentStep));
//   }

//   void _completeCurrentStep() {
//     if (_currentIndex < _stepsToRun.length - 1) {
//       _currentIndex++;
//       _goToCurrentStep();
//     } else {
//       onFinished();
//     }
//   }
// }
