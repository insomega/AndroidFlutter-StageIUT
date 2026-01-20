import 'package:flutter/material.dart';

class GBSystem_LogWriter {
  static void write(String errorMessage, {bool isError = false}) {
    Future.microtask(() => debugPrint('--**$errorMessage. isError:[$isError]'));
  }
}
