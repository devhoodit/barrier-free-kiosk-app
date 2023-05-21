import 'package:barrier_free_kiosk/main.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    "뒤로가기",
                    style: Theme.of(context)
                        .textTheme
                        .menuLarge
                        .copyWith(color: Colors.white),
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
                  Navigator.pushNamed(context, '/pay');
                },
                child: Center(
                  child: Text(
                    "결제하기",
                    style: Theme.of(context)
                        .textTheme
                        .menuLarge
                        .copyWith(color: Colors.white),
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
