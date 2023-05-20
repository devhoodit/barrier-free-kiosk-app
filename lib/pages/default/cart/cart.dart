import 'package:barrier_free_kiosk/pages/default/cart/orderlist.dart';
import 'package:barrier_free_kiosk/pages/default/cart/bottombar.dart';
import 'package:barrier_free_kiosk/pages/default/cart/topbar.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Column(
        children: [
          TopBar(),
          Expanded(child: Orderlist()),
          BottomBar(),
        ],
      ),
    );
  }
}
