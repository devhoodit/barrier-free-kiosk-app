import 'package:barrier_free_kiosk/provider/cart_provider.dart';
import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:barrier_free_kiosk/provider/tts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlindPay extends StatelessWidget {
  const BlindPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
            child: Cost(),
          ),
          Container(
            child: TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              child: Text("결제하기"),
            ),
          )
        ],
      ),
    );
  }
}

class Cost extends StatelessWidget {
  const Cost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ttsHandler = context.read<TtsProvider>();
    final config = context.read<ConfigProvider>().config;
    final cartProvider = context.read<CartProvider>();

    double allCost = 0;

    for (final cart in cartProvider.orderList) {
      allCost += cart.getPrice();
    }

    return GestureDetector(
      onLongPress: () => ttsHandler.speak("$allCost 원"),
      child: Container(
        color: Colors.white,
        constraints: BoxConstraints.expand(),
        child: Center(
          child: Text(
            "$allCost 원",
            style: const TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
