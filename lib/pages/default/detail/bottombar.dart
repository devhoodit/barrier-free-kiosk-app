import 'package:barrier_free_kiosk/lib/menu.dart';
import 'package:barrier_free_kiosk/provider/cart_provider.dart';
import 'package:barrier_free_kiosk/provider/detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
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
      height: 200,
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          "뒤로가기",
          style: TextStyle(
            color: Colors.black,
            fontSize: 50,
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
      height: 200,
      color: Colors.amber,
      child: TextButton(
        onPressed: () {
          final detailIndex = context.read<DetailProvider>().radio;
          final menuInfo = CartInfo(args.categoryId, args.menuId, detailIndex);
          cartProvider.add(menuInfo);
          Navigator.pushNamedAndRemoveUntil(
              context, '/order', (route) => false);
        },
        child: const Text(
          "담기",
          style: TextStyle(
            color: Colors.black,
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}
