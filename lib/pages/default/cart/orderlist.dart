import 'package:barrier_free_kiosk/provider/cart_provider.dart';
import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orderlist extends StatelessWidget {
  const Orderlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = context.read<ConfigProvider>().config;
    return Consumer<CartProvider>(builder: (context, value, child) {
      return Container(
        child: ListView.separated(
          itemCount: value.orderList.length,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 2,
              color: Colors.grey,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            final cartInfo = value.orderList[index];
            final categoryId = cartInfo.categoryId;
            final menuId = cartInfo.menuId;
            final details = cartInfo.detailIndex;

            final title = config.getName(categoryId, menuId);
            final price = config.getPrice(categoryId, menuId, details);
            return Container(
              height: 180,
              child: Row(
                children: [
                  Text(
                    "$title",
                    style: const TextStyle(fontSize: 48),
                  ),
                  Text(
                    "$price 원",
                    style: const TextStyle(fontSize: 48),
                  )
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
