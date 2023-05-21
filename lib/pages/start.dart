import 'package:barrier_free_kiosk/lib/config.dart';
import 'package:barrier_free_kiosk/provider/cart_provider.dart';
import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:barrier_free_kiosk/provider/tts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CartProvider>().initialize();
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                context.read<ConfigProvider>().initialize(menuCountInOne: 4);
                Navigator.pushNamed(context, '/order');
              },
              child: const Text(
                "주문하기",
                style: TextStyle(
                  fontSize: 60,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<ConfigProvider>().initialize(menuCountInOne: 2);
                Navigator.pushNamed(context, '/blindhelp');
              },
              child: const Text(
                "시각장애인용",
                style: TextStyle(
                  fontSize: 60,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              child: const Text(
                "Setting",
                style: TextStyle(
                  fontSize: 60,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
