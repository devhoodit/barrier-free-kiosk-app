import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);
  static const height = 150.0;
  static const fontsize = 50.0;

  @override
  Widget build(BuildContext context) {
    const double width = 150;
    return SizedBox(
      height: height,
      child: Consumer<ConfigProvider>(
        builder: (context, value, index) {
          Expanded leftCategory, rightCategory;
          final config = value.config;

          // category navigate button
          const buttonHeight = 200.0;
          const buttonWidth = 200.0;
          const focusedIconColor = Color.fromARGB(255, 26, 26, 26);
          const outFocusedIconColor = Color.fromARGB(255, 128, 128, 128);
          const buttonColor = Color.fromARGB(255, 179, 179, 179);

          // build side buttons
          Container leftButtonContainer, rightButtonContainer;
          void Function()? onPressedLeft, onPressedRight;
          if (value.categoryIndex <= 0) {
            onPressedLeft = null;
          } else {
            onPressedLeft = () => value.prevCate();
          }
          leftButtonContainer = Container(
            height: height,
            width: width,
            child: IconButton(
              onPressed: onPressedLeft,
              icon: const Icon(
                Icons.arrow_left_outlined,
                size: 50,
              ),
            ),
          );

          if (value.categoryIndex >= value.maxCategoryIndex) {
            onPressedRight = null;
          } else {
            onPressedRight = () => value.nextCate();
          }
          rightButtonContainer = Container(
            height: height,
            width: width,
            child: IconButton(
              onPressed: onPressedRight,
              icon: const Icon(
                Icons.arrow_right_outlined,
                size: 50,
              ),
            ),
          );

          // build category containers
          var categoryFocusDecoration = BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              border: Border.all(color: Colors.black, width: 8));
          const categoryDecoration = BoxDecoration();
          BoxDecoration leftBoxDecoration, rightBoxDecoration;
          if (value.categoryIndex % 2 == 0) {
            leftBoxDecoration = categoryFocusDecoration;
            rightBoxDecoration = categoryDecoration;
          } else {
            leftBoxDecoration = categoryDecoration;
            rightBoxDecoration = categoryFocusDecoration;
          }

          const textStyle = TextStyle(color: Colors.black, fontSize: fontsize);
          leftCategory = Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              decoration: leftBoxDecoration,
              child: Center(
                child: Text(
                  config.categories[value.categoryIndex ~/ 2 * 2].title,
                  style: textStyle,
                ),
              ),
            ),
          );

          if (value.categoryIndex != value.maxCategoryIndex) {
            rightCategory = Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                decoration: rightBoxDecoration,
                child: Center(
                  child: Text(
                    config.categories[value.categoryIndex ~/ 2 * 2 + 1].title,
                    style: textStyle,
                  ),
                ),
              ),
            );
          } else {
            rightCategory = Expanded(child: Container());
          }

          return SizedBox(
            height: height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                leftButtonContainer,
                leftCategory,
                rightCategory,
                rightButtonContainer,
              ],
            ),
          );
        },
      ),
    );
  }
}
