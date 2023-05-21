import 'package:barrier_free_kiosk/provider/cart_provider.dart';
import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:barrier_free_kiosk/provider/tts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlindPay extends StatelessWidget {
  const BlindPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tts = context.read<TtsProvider>();
    tts.speak("결제 페이지입니다.");
    return Material(
      child: Column(
        children: [
          const Expanded(
            flex: 2,
            child: Cost(),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    onLongPress: () => tts.speak("뒤로가기"),
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          "뒤로가기",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    },
                    onLongPress: () => tts.speak("결제하기"),
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          "결제하기",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
