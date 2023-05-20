import 'package:barrier_free_kiosk/pages/default/detail/detailorder.dart';
import 'package:barrier_free_kiosk/pages/default/detail/topbar.dart';
import 'package:barrier_free_kiosk/pages/default/detail/bottombar.dart';
import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Column(
        children: [
          TopBar(),
          DetailOrder(),
          BottomBar(),
        ],
      ),
    );
  }
}
