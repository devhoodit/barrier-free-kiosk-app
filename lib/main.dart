import 'package:barrier_free_kiosk/pages/blind/cart/cart.dart';
import 'package:barrier_free_kiosk/pages/blind/detail/detail.dart';
import 'package:barrier_free_kiosk/pages/blind/order/order.dart';
import 'package:barrier_free_kiosk/pages/blind/pay/pay.dart';
import 'package:barrier_free_kiosk/pages/default/cart/cart.dart';
import 'package:barrier_free_kiosk/pages/default/pay/pay.dart';
import 'package:barrier_free_kiosk/provider/cart_provider.dart';
import 'package:barrier_free_kiosk/provider/detail_provider.dart';
import 'package:barrier_free_kiosk/provider/tts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:headset_connection_event/headset_event.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'provider/config_provider.dart';

import 'pages/start.dart';
import 'pages/settings/settings.dart';
import 'pages/default/order/order.dart';
import 'pages/default/detail/detail.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ConfigProvider>(
        create: (_) => ConfigProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => DetailProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => TtsProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // HeadsetEvent headsetPlugin = HeadsetEvent();
    // headsetPlugin.requestPermission();
    // headsetPlugin.getCurrentState.then((value) => print(value));
    // headsetPlugin.setListener((val) {
    //   Navigator.pushNamedAndRemoveUntil(context, '/pay', (route) => false);
    // });

    return MaterialApp(
      title: 'Kiosk',
      initialRoute: '/',
      routes: {
        '/': (context) => const InitialPage(),
        '/settings': (context) => const Settings(),
        '/detail': (context) => const Detail(),
        '/order': (context) => const Order(),
        '/cart': (context) => const Cart(),
        '/pay': (context) => const Pay(),
        '/blinddetail': (context) => const BlindDetail(),
        '/blindorder': (context) => const BlindOrder(),
        '/blindcart': (context) => const BlindCart(),
        '/blindpay': (context) => const BlindPay(),
      },
    );
  }
}
