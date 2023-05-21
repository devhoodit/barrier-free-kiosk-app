import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:barrier_free_kiosk/lib/config.dart';

class ConfigProvider extends ChangeNotifier {
  Map<String, dynamic> _map = {};
  late Config _config = Config({});
  Config get config => _config;
  bool _isConfigComplete = false;
  bool get isConfigComplete => _isConfigComplete;
  bool _isReadyForImagePath = false;
  bool get isReadyForImagePath => _isReadyForImagePath;
  bool _isConfigInitialized = false;
  bool get isConfigInitialized => _isConfigInitialized;

  void changeConfig(FilePickerResult result) async {
    File file = File(result.files.single.path!);
    final fs = await file.readAsString();
    _map = jsonDecode(fs);
    _config = Config(_map);
    _isConfigComplete = false;
    _isConfigInitialized = true;
    _isReadyForImagePath = true;
    notifyListeners();
  }

  void gluePath(String basePath) {
    if (_isReadyForImagePath) {
      config.gluePath(basePath);
      _isConfigComplete = true;
    }
    notifyListeners();
  }
}
