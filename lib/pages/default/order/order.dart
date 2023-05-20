import 'package:barrier_free_kiosk/pages/default/order/menu.dart';
import 'package:barrier_free_kiosk/pages/default/order/topbar.dart';
import 'package:barrier_free_kiosk/pages/default/order/bottombar.dart';
import 'package:barrier_free_kiosk/provider/tts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const TopBar(),
          Container(
            color: Colors.black,
            height: 2,
          ),
          Menu(),
          Container(
            color: Colors.black,
            height: 2,
          ),
          const BottomBar(),
        ],
      ),
    );
  }
}
