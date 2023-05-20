import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:barrier_free_kiosk/lib/config.dart';

class ConfigProvider extends ChangeNotifier {
  Map<String, dynamic> _map = {};
  late Config _config = Config({});
  Config get config => _config;

  int categoryIndex = 0;
  int maxCategoryIndex = 0;
  int menuIndex = 0;
  int maxMenuIndex = 0;

  int menuCountInOne = 4;

  void changeConfig(FilePickerResult result) async {
    File file = File(result.files.single.path!);
    final fs = await file.readAsString();
    _map = jsonDecode(fs);
    _config = Config(_map);
    categoryIndex = 0;
    menuIndex = 0;
    maxCategoryIndex = config.categories.length - 1;
    maxMenuIndex =
        (config.categories[categoryIndex].items.length - 1) ~/ menuCountInOne;
  }

  void gluePath(String basePath) {
    config.gluePath(basePath);
  }

  void initialize({required int menuCountInOne}) {
    this.menuCountInOne = menuCountInOne;
    categoryIndex = 0;
    menuIndex = 0;
    maxCategoryIndex = config.categories.length - 1;
    maxMenuIndex =
        (config.categories[categoryIndex].items.length - 1) ~/ menuCountInOne;
  }

  void nextCate() {
    if (maxCategoryIndex <= categoryIndex) return;
    categoryIndex += 1;
    menuIndex = 0;
    maxMenuIndex =
        (config.categories[categoryIndex].items.length - 1) ~/ menuCountInOne;
    notifyListeners();
  }

  void prevCate() {
    if (categoryIndex <= 0) return;
    categoryIndex -= 1;
    menuIndex = 0;
    maxMenuIndex =
        (config.categories[categoryIndex].items.length - 1) ~/ menuCountInOne;
    notifyListeners();
  }

  void prevCateSlide() {
    if (categoryIndex <= 0) return;
    categoryIndex -= 1;
    maxMenuIndex =
        (config.categories[categoryIndex].items.length - 1) ~/ menuCountInOne;
    menuIndex = maxMenuIndex;
    notifyListeners();
  }

  void nextMenu() {
    if (maxMenuIndex <= menuIndex) return;
    menuIndex += 1;
    notifyListeners();
  }

  void prevMenu() {
    if (menuIndex <= 0) return;
    menuIndex -= 1;
    notifyListeners();
  }
}
