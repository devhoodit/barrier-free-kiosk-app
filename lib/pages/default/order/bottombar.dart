import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);
  static const height = 150.0;
  static const fontsize = 50.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              child: const Center(
                child: Text(
                  "장바구니",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontsize,
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black,
            width: 2,
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pay');
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
          )
        ],
      ),
    );
  }
}
