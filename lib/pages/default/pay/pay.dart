import 'package:barrier_free_kiosk/pages/default/detail/topbar.dart';
import 'package:barrier_free_kiosk/provider/cart_provider.dart';
import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pay extends StatelessWidget {
  const Pay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TopBar(),
                PayCost(),
              ],
            ),
          ),
          Container(
            height: 2,
            color: Colors.black,
          ),
          SizedBox(
            height: 200,
            child: Row(
              children: [
                const Expanded(
                  child: BackButton(),
                ),
                Container(
                  color: Colors.black,
                  width: 2,
                ),
                const Expanded(
                  child: PayButton(),
                ),
              ],
            ),
          ),
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
      // calculate all costs in cart
      final categoryId = cart.categoryId;
      final menuId = cart.menuId;
      final details = cart.detailIndex;
      double defaultCost = config.categories[categoryId].items[menuId].price;
      for (var i = 0; i < details.length; i++) {
        final detail = config.categories[categoryId].details[menuId][i];
        defaultCost += detail.details[cart.detailIndex[i]].price;
      }
      allCost += defaultCost;
    }

    return Container(
      // pay cost
      height: 200,
      child: Text(
        "$allCost 원",
        style: const TextStyle(fontSize: fontsize),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  static const fontsize = 50.0;
  const BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Center(
          child: Text(
            "뒤로가기",
            style: TextStyle(
              color: Colors.black,
              fontSize: fontsize,
            ),
          ),
        ),
      ),
    );
  }
}

class PayButton extends StatelessWidget {
  const PayButton({Key? key}) : super(key: key);
  static const fontsize = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        },
        child: const Center(
          child: Text(
            "결제하기",
            style: TextStyle(
              color: Colors.black,
              fontSize: fontsize,
            ),
          ),
        ),
      ),
    );
  }
}
