import 'package:barrier_free_kiosk/lib/menu.dart';
import 'package:flutter/material.dart';
import 'package:barrier_free_kiosk/lib/config.dart';

class DetailProvider extends ChangeNotifier {
  MenuInfo? menu;
  List<int> radio = [];

  void initializeRadio(MenuInfo menu) {
    this.menu = menu;
    radio = [for (var i = 0; i < menu.detailCategories.length; i++) 0];
  }

  void changeRadio(i, k) {
    radio[i] = k;
    notifyListeners();
  }

  double getDefaultPrice() {
    return menu == null ? 0 : menu!.item.price;
  }

  double getDetailPrice() {
    double detailPrice = 0;
    if (menu != null) {
      for (int i = 0; i < radio.length; i++) {
        detailPrice += menu!.detailCategories[i].details[radio[i]].price;
      }
    }
    return detailPrice;
  }

  double getTotalPrcie() {
    return getDefaultPrice() + getDetailPrice();
  }
}
