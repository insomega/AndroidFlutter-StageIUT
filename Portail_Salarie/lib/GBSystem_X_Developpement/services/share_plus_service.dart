import 'package:share_plus/share_plus.dart';
import 'dart:io';

class SharePlusService {
  void shareFile(String filePath) {
    File file = File(filePath);

    if (file.existsSync()) {
      Share.shareXFiles([XFile(filePath)], text: "Check out this file!");
    } else {
      print("File not found!");
    }
  }
}
