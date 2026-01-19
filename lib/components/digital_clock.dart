import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DigitalClockFooter extends StatefulWidget {
  const DigitalClockFooter({super.key});

  @override
  State<DigitalClockFooter> createState() => _DigitalClockFooterState();
}

class _DigitalClockFooterState extends State<DigitalClockFooter> {
  late DateTime _now;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: Colors.grey[200],
      child: Center(
        child: Text(
          "BMSoft • ${DateFormat('dd/MM/yyyy HH:mm:ss').format(_now)}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blueGrey),
        ),
      ),
    );
  }
}