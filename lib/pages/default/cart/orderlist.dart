import 'dart:io';

import 'package:barrier_free_kiosk/main.dart';
import 'package:barrier_free_kiosk/provider/cart_provider.dart';
import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orderlist extends StatelessWidget {
  Orderlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = context.read<ConfigProvider>().config;
    return Consumer<CartProvider>(
      builder: (context, value, child) {
        return ListView.separated(
          itemCount: value.orderList.length,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              height: 2,
              color: Theme.of(context).colorScheme.primary,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            final cartInfo = value.orderList[index];
            final title = cartInfo.item.name;
            final price = cartInfo.getPrice();
            return Container(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              height: 150,
              child: GestureDetector(
                onLongPress: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    FileImage(File(cartInfo.item.gluedPath))),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          title,
                          style: Theme.of(context).textTheme.detailLarge,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "$price 원",
                          style: Theme.of(context).textTheme.detailLarge,
                        ),
                        const SizedBox(width: 25),
                        IconButton(
                          color: Theme.of(context).colorScheme.warning,
                          onPressed: () {
                            value.remove(index);
                          },
                          icon: Icon(
                            Icons.delete_forever_outlined,
                            size: Theme.of(context)
                                    .textTheme
                                    .detailLarge
                                    .fontSize! *
                                1.5,
                          ),
                        ),
                        const SizedBox(width: 30)
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
