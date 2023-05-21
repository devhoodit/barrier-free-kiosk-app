import 'dart:io';
import 'dart:math';

import 'package:barrier_free_kiosk/lib/config.dart';
import 'package:barrier_free_kiosk/lib/menu.dart';
import 'package:barrier_free_kiosk/main.dart';
import 'package:barrier_free_kiosk/pages/default/dialogs/menudialog.dart';
import 'package:barrier_free_kiosk/pages/default/order/menu.dart';
import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const gridCount = 4;

Future<void> recommendDialogBuilder(
    BuildContext context, Item item, List<DetailCategory> detailCategories) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        int randomCount;
        List<Item> recommandItems = [];
        if (item.metadata == null) {
          randomCount = gridCount;
        } else {
          randomCount = gridCount - min(item.metadata!.ranks.length, gridCount);
          recommandItems = item.metadata!.ranks
              .sublist(0, min(item.metadata!.ranks.length, gridCount));
        }
        final random = Random();
        final config = context.read<ConfigProvider>().config;
        for (int i = 0; i < randomCount; i++) {
          recommandItems.add(config.items[random.nextInt(config.items.length)]);
        }
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 50),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Text(
                          "이런 메뉴 어떠세요?",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 50),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                            ),
                            itemCount: gridCount,
                            itemBuilder: (BuildContext context, int index) {
                              final item = recommandItems[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/detail',
                                    arguments: MenuInfo(
                                      item: item,
                                      detailCategories: detailCategories,
                                    ),
                                  );
                                },
                                onLongPress: () {
                                  menuDialogBuilder(
                                      context, item, detailCategories);
                                },
                                child: MenuLayout(
                                  item: item,
                                  detailCategories: detailCategories,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Theme.of(context).colorScheme.warning),
                  height: 100,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "닫기",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
