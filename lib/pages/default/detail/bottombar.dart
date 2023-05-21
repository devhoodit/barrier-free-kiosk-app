import 'package:barrier_free_kiosk/lib/menu.dart';
import 'package:barrier_free_kiosk/main.dart';
import 'package:barrier_free_kiosk/provider/cart_provider.dart';
import 'package:barrier_free_kiosk/provider/detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Row(
        children: [
          Expanded(child: BackButton()),
          Expanded(child: AddToCart()),
        ],
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.warning),
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Text(
            "뒤로가기",
            style: TextStyle(
              color: Colors.black,
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}

class AddToCart extends StatelessWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MenuInfo;
    final cartProvider = context.read<CartProvider>();
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.complete),
      child: TextButton(
        onPressed: () {
          final detailIndex = context.read<DetailProvider>().radio;
          final menuInfo =
              CartInfo(args.item, args.detailCategories, detailIndex);
          cartProvider.add(menuInfo);
          Navigator.pushNamedAndRemoveUntil(
              context, '/order', (route) => false);
        },
        child: Center(
          child: Text(
            "담기",
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}
