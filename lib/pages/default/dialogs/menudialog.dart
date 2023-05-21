import 'dart:io';

import 'package:barrier_free_kiosk/lib/config.dart';
import 'package:flutter/material.dart';

Future<void> menuDialogBuilder(
    BuildContext context, Item item, List<DetailCategory> detailCategory) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(item.gluedPath)),
                            ),
                          ),
                        ),
                        Text(
                          item.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          "${item.price} 원",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 55),
                        Padding(
                          padding: const EdgeInsets.all(60.0),
                          child: Text(
                            item.description,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Theme.of(context).colorScheme.primary),
                    height: 100,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "뒤로가기",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        )),
                  ),
                ],
              )),
        );
      });
}
