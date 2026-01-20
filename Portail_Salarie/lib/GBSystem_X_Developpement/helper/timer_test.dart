class TimerTest {
  final DateTime myVar;
  final String name;
  TimerTest({
    required this.myVar,
    required this.name,
  });

  void showTime_BB() {
    Duration diffirence = DateTime.now().difference(myVar);
    // print("date debut $myVar , $name : $diffirence , date fin ${DateTime.now()}");
  }
}
