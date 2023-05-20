import 'package:flutter/material.dart';
import 'package:barrier_free_kiosk/lib/config.dart';

class DetailProvider extends ChangeNotifier {
  List<int> radio = [];

  void initializeRadio(List<DetailCategory> detailCategories) {
    radio = [for (var i = 0; i < detailCategories.length; i++) 0];
  }

  void changeRadio(i, k) {
    radio[i] = k;
    notifyListeners();
  }
}
