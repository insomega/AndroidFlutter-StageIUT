// class Launcher extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final splashManager = SplashManager(
//       allSteps: [WelcomeStep(), CheckApiStep()],
//       onFinished: () {
//         Get.offAll(() => const MainForm());
//       },
//     );

//     Future.microtask(() => splashManager.start());

//     return const Scaffold(body: Center(child: CircularProgressIndicator()));
//   }
// }
