import 'package:barrier_free_kiosk/main.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);
  static const height = 130.0;
  static const fontsize = 50.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                child: const Center(
                  child: Text(
                    "뒤로가기",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontsize,
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
                  Navigator.pushNamed(context, '/cart');
                },
                child: const Center(
                  child: Text(
                    "장바구니",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontsize,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
