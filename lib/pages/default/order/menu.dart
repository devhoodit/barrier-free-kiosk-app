import 'dart:io';

import 'package:barrier_free_kiosk/lib/config.dart';
import 'package:barrier_free_kiosk/lib/menu.dart';
import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  static const height = 150.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<ConfigProvider>(
      builder: (context, value, child) {
        final config = value.config;
        final categoryIndex = value.categoryIndex;
        final menuIndex = value.menuIndex;
        List<Widget> menuContainers = [];
        int fillCount = 4;
        if (value.maxMenuIndex == menuIndex) {
          fillCount = config.categories[categoryIndex].items.length -
              value.maxMenuIndex * 4;
        }
        for (int i = 0; i < fillCount; i++) {
          // filled menu
          final menuId = menuIndex * 4 + i;
          menuContainers.add(MenuContainer(
            menuName: config.categories[categoryIndex].items[menuId].name,
            imagepath: config.categories[categoryIndex].items[menuId].gluedPath,
            categoryId: categoryIndex,
            menuId: menuId,
            detailCategories: config.categories[categoryIndex].details[menuId],
          ));
        }
        for (int i = fillCount; i < 4; i++) {
          menuContainers.add(Container());
        }

        Widget prevButton, nextButton;

        void Function()? prevButtonOnPressed, nextButtonOnPressed;
        if (value.menuIndex <= 0) {
          prevButtonOnPressed = null;
        } else {
          prevButtonOnPressed = () => value.prevMenu();
        }
        prevButton = Container(
          child: IconButton(
            onPressed: prevButtonOnPressed,
            icon: const Icon(
              Icons.arrow_left_rounded,
              size: 50,
            ),
          ),
        );

        if (value.menuIndex >= value.maxMenuIndex) {
          nextButtonOnPressed = null;
        } else {
          nextButtonOnPressed = () => value.nextMenu();
        }
        nextButton = Container(
          child: IconButton(
            onPressed: nextButtonOnPressed,
            icon: const Icon(
              Icons.arrow_right_outlined,
              size: 50,
            ),
          ),
        );

        return Expanded(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: menuContainers[0]),
                    Container(
                      width: 2,
                      color: Colors.black,
                    ),
                    Expanded(child: menuContainers[1]),
                  ],
                ),
              ),
              Container(
                height: 2,
                color: Colors.black,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: menuContainers[2]),
                    Container(
                      width: 2,
                      color: Colors.black,
                    ),
                    Expanded(child: menuContainers[3]),
                  ],
                ),
              ),
              Container(
                color: Colors.black,
                height: 2,
              ),
              SizedBox(
                height: height,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: prevButton),
                    Container(
                      color: Colors.black,
                      width: 2,
                    ),
                    Expanded(child: nextButton),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class MenuContainer extends StatelessWidget {
  static const fontsize = 50.0;
  final int categoryId;
  final int menuId;
  final String menuName;
  final String imagepath;
  final List<DetailCategory> detailCategories;
  const MenuContainer({
    Key? key,
    required this.menuName,
    required this.imagepath,
    required this.categoryId,
    required this.menuId,
    required this.detailCategories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageFile = File(imagepath);
    return GestureDetector(
      onTap: () => {
        Navigator.pushNamed(
          context,
          '/detail',
          arguments: MenuInfo(
            categoryId: categoryId,
            menuId: menuId,
            detailCategories: detailCategories,
          ),
        )
      }, // on tap
      onLongPress: () => print("long press"), // long press
      child: Container(
        decoration: BoxDecoration(),
        child: Stack(
          children: [
            Image(image: FileImage(imageFile)),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                decoration: BoxDecoration(),
                child: Text(
                  menuName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: fontsize),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<File> getImageFile(String imagepath) async {
    print(await getExternalStorageDirectories());
    File file = File('');
    return file;
  }
}
