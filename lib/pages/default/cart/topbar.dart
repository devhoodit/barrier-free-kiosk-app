import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(color: Colors.amber),
      child: const Center(
        child: Text(
          "장바구니",
          style: TextStyle(
            fontSize: 48,
          ),
        ),
      ),
    );
  }
}
