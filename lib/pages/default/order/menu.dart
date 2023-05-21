import 'dart:io';
import 'dart:ui';

import 'package:barrier_free_kiosk/lib/config.dart';
import 'package:barrier_free_kiosk/lib/menu.dart';
import 'package:barrier_free_kiosk/pages/default/dialogs/menudialog.dart';
import 'package:barrier_free_kiosk/pages/default/order/bottombar.dart';
import 'package:barrier_free_kiosk/pages/default/topbar.dart';
import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int categoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final config = context.read<ConfigProvider>().config;
    List<Widget> tabs = [];
    List<Widget> tabViews = [];
    for (int i = 0; i < config.categories.length; i++) {
      tabs.add(Container(
        child: Text(
          config.categories[i].name,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ));
      tabViews.add(MenuList(categoryIndex: i));
    }
    return Material(
      child: Column(
        children: [
          const TopProcessBar(curProcess: 0, processes: ["메뉴선택"]),
          Expanded(
            child: DefaultTabController(
              length: config.categories.length,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: TabBar(
                      unselectedLabelColor: Colors.white,
                      labelColor: Colors.white,
                      indicatorColor: Colors.white,
                      isScrollable: true,
                      labelPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      tabs: tabs,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary),
                      child: TabBarView(
                        children: tabViews,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomBar()
        ],
      ),
    );
  }
}

class MenuList extends StatelessWidget {
  final int categoryIndex;

  const MenuList({Key? key, required this.categoryIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = context.read<ConfigProvider>().config;
    return ListView.builder(
      itemCount: (config.categories[categoryIndex].items.length + 1) ~/ 2,
      itemBuilder: (BuildContext context, int index) {
        final Item? leftItem, rightItem;
        final List<DetailCategory>? leftDetails, rightDetails;
        leftItem = config.categories[categoryIndex].items[index * 2];
        leftDetails =
            config.categories[categoryIndex].detailCategories[index * 2];
        if (config.categories[categoryIndex].items.length - 1 >=
            index * 2 + 1) {
          rightItem = config.categories[categoryIndex].items[index * 2 + 1];
          rightDetails =
              config.categories[categoryIndex].detailCategories[index * 2 + 1];
        } else {
          rightItem = null;
          rightDetails = null;
        }
        final Widget leftMenuComponent, rightMenuComponent;
        leftMenuComponent = Expanded(
            child: MenuComponent(
          item: leftItem,
          detailCategories: leftDetails,
        ));
        rightMenuComponent = rightItem == null
            ? Expanded(child: Container())
            : Expanded(
                child: MenuComponent(
                    item: rightItem, detailCategories: rightDetails!));
        return SizedBox(
          height: MediaQuery.of(context).size.width / 2,
          child: Row(
            children: [
              leftMenuComponent,
              rightMenuComponent,
            ],
          ),
        );
      },
    );
  }
}

class MenuComponent extends StatelessWidget {
  final Item item;
  final List<DetailCategory> detailCategories;

  const MenuComponent({
    Key? key,
    required this.item,
    required this.detailCategories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          menuDialogBuilder(context, item, detailCategories);
        },
        child: MenuLayout(
          item: item,
          detailCategories: detailCategories,
        ));
  }
}

class MenuLayout extends StatelessWidget {
  final Item item;
  final List<DetailCategory> detailCategories;
  const MenuLayout({
    Key? key,
    required this.item,
    required this.detailCategories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(item.gluedPath)),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 30,
                  sigmaY: 30,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    item.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
