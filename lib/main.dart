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
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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
    // SystemChrome.setEnabledSystemUIMode(
    //   SystemUiMode.manual,
    //   overlays: [
    //     SystemUiOverlay.bottom,
    //   ],
    // );
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // HeadsetEvent headsetPlugin = HeadsetEvent();
    // headsetPlugin.requestPermission();
    // headsetPlugin.getCurrentState.then((value) => print(value));
    // headsetPlugin.setListener((val) {
    //   Navigator.pushNamedAndRemoveUntil(context, '/pay', (route) => false);
    // });
    return MaterialApp(
      title: 'Kiosk',
      initialRoute: '/',
      theme: ThemeData(
        fontFamily: 'Pretendard',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: const Color.fromARGB(255, 35, 35, 35),
          secondary: const Color.fromARGB(255, 55, 55, 55),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 50, color: Colors.white),
          titleMedium: TextStyle(fontSize: 30, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 45, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
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
      onGenerateRoute: (settings) {
        if (animatedRoutes.containsKey(settings.name)) {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                animatedRoutes[settings.name]!,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1, 0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          );
        } else if (routes.containsKey(settings.name)) {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                animatedRoutes[settings.name]!,
          );
        }
        return null;
      },
    );
  }
}

Map<String, Widget> animatedRoutes = {
  '/detail': const Detail(),
  '/order': const Order(),
  '/cart': const Cart(),
  '/pay': const Pay()
};

Map<String, Widget> routes = {
  '/': const InitialPage(),
  '/settings': const Settings(),
  '/detail': const Detail(),
  '/order': const Order(),
  '/cart': const Cart(),
  '/pay': const Pay(),
  '/blinddetail': const BlindDetail(),
  '/blindorder': const BlindOrder(),
  '/blindcart': const BlindCart(),
  '/blindpay': const BlindPay(),
};

extension ExtendedColorscheme on ColorScheme {
  Color get warning => this.brightness == Brightness.light
      ? const Color.fromARGB(255, 174, 41, 56)
      : const Color.fromARGB(255, 174, 41, 56);
  Color get complete => this.brightness == Brightness.light
      ? const Color.fromARGB(255, 41, 174, 100)
      : const Color.fromARGB(255, 41, 174, 100);
}

extension ExtendedTextTheme on TextTheme {
  TextStyle get menuLarge => const TextStyle(fontSize: 45);
  TextStyle get menuMedium => const TextStyle(fontSize: 30);
  TextStyle get detailLarge => const TextStyle(fontSize: 40);
  TextStyle get detailMedium => const TextStyle(fontSize: 30);
}
