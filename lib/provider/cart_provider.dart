import 'package:barrier_free_kiosk/lib/config.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<CartInfo> orderList = [];
  CartProvider();
  void initialize() {
    orderList = [];
  }

  void add(CartInfo menuInfo) {
    orderList.add(menuInfo);
  }

  void remove(int index) {
    orderList.removeAt(index);
    notifyListeners();
  }
}

class CartInfo {
  final Item item;
  final List<DetailCategory> detailCategories;
  final List<int> detailIndex;
  CartInfo(this.item, this.detailCategories, this.detailIndex);

  double getPrice() {
    double cost = 0;
    cost += item.price;
    for (int i = 0; i < detailIndex.length; i++) {
      cost += detailCategories[i].details[detailIndex[i]].price;
    }
    return cost;
  }
}
