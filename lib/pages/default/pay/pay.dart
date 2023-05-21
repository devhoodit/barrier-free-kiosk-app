import 'package:barrier_free_kiosk/main.dart';
import 'package:barrier_free_kiosk/pages/default/topbar.dart';
import 'package:barrier_free_kiosk/provider/cart_provider.dart';
import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pay extends StatelessWidget {
  const Pay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondary,
      child: const Column(
        children: [
          TopProcessBar(curProcess: 0, processes: ["결제하기"]),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PayCost(),
              ],
            ),
          ),
          BottomBar(),
        ],
      ),
    );
  }
}

class PayCost extends StatelessWidget {
  static const fontsize = 50.0;
  const PayCost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = context.read<ConfigProvider>().config;
    final cartProvider = context.read<CartProvider>();

    double allCost = 0;

    for (final cart in cartProvider.orderList) {
      allCost += cart.getPrice();
    }

    return Container(
      // pay cost
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(30, 30, 100, 30),
            child: Text(
              "$allCost",
              style: const TextStyle(
                fontSize: 60,
                color: Colors.white,
              ),
            ),
          ),
          const Positioned(
            bottom: -70,
            right: -30,
            child: Text(
              "₩",
              style: TextStyle(fontSize: 120),
            ),
          )
        ],
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Center(
                  child: Text(
                    "뒤로가기",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.complete),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                child: const Center(
                  child: Text(
                    "결제하기",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
