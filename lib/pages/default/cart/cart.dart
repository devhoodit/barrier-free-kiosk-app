import 'package:barrier_free_kiosk/pages/default/cart/orderlist.dart';
import 'package:barrier_free_kiosk/pages/default/cart/bottombar.dart';
import 'package:barrier_free_kiosk/pages/default/topbar.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const TopProcessBar(curProcess: 0, processes: ["장바구니"]),
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.secondary),
              child: Orderlist(),
            ),
          ),
          const BottomBar(),
        ],
      ),
    );
  }
}
