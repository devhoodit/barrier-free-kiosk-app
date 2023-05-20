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
  final int categoryId;
  final int menuId;
  final List<int> detailIndex;
  CartInfo(this.categoryId, this.menuId, this.detailIndex);
}
