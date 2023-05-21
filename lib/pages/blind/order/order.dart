import 'package:barrier_free_kiosk/lib/menu.dart';
import 'package:barrier_free_kiosk/pages/blind/blindUI.dart';
import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:barrier_free_kiosk/provider/tts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlindOrder extends StatelessWidget {
  const BlindOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ConfigProvider>(
      builder: (context, value, child) {
        final ttsHandler = context.read<TtsProvider>();
        final cp = context.read<ConfigProvider>();
        final config = cp.config;

        void Function()? leftGestureDetectorOnTap, rightGestureDetectorOnTap;
        if (cp.menuIndex == 0) {
          // first menu in current category, prev category if exist
          if (cp.categoryIndex != 0) {
            leftGestureDetectorOnTap = () => cp.prevCateSlide();
          }
        } else {
          leftGestureDetectorOnTap = () => cp.prevMenu();
        }
        if (cp.maxMenuIndex == cp.menuIndex) {
          // last menu in current category, next category if exist
          if (cp.categoryIndex != cp.maxCategoryIndex) {
            rightGestureDetectorOnTap = () => cp.nextCate();
          }
        } else {
          // next menu
          rightGestureDetectorOnTap = () => cp.nextMenu();
        }

        final container1 = createButton(
          "left",
          onTap: leftGestureDetectorOnTap,
          onDoubleTap: () => cp.prevCate(),
        );
        final container2 = createButton(
          "right",
          onTap: rightGestureDetectorOnTap,
          onDoubleTap: () => cp.nextCate(),
        );

        final leftMenu =
            config.categories[cp.categoryIndex].items[cp.menuIndex * 2];
        final leftDetail = config
            .categories[cp.categoryIndex].detailCategories[cp.menuIndex * 2];

        final Container container3;
        {
          container3 = createButton(
            leftMenu.name,
            onTap: () => Navigator.pushNamed(
              context,
              '/blinddetail',
              arguments: MenuInfo(item: leftMenu, detailCategories: leftDetail),
            ),
            onLongPress: () => ttsHandler.speak(leftMenu.name),
          );
        }

        final String rightMenuName;
        void Function()? rightMenuOnTap;
        if (config.categories.length ~/ 2 == 1 &&
            cp.menuIndex == cp.maxMenuIndex) {
          rightMenuName = "메뉴없음";
          rightMenuOnTap = null;
        } else {
          rightMenuName = config
              .categories[cp.categoryIndex].items[cp.menuIndex * 2 + 1].name;
          final rightMenu =
              config.categories[cp.categoryIndex].items[cp.menuIndex * 2 + 1];
          final rightDetails = config.categories[cp.categoryIndex]
              .detailCategories[cp.menuIndex * 2 + 1];
          rightMenuOnTap = () {
            Navigator.pushNamed(
              context,
              '/blinddetail',
              arguments:
                  MenuInfo(item: rightMenu, detailCategories: rightDetails),
            );
          };
        }
        final container4 = createButton(
          rightMenuName,
          onTap: rightMenuOnTap,
          onLongPress: () => ttsHandler.speak(rightMenuName),
        );

        final container5 = createButton(
          "장바구니",
          onTap: () => Navigator.pushNamed(context, '/blindcart'),
          onLongPress: () => ttsHandler.speak('장바구니'),
        );

        final container6 = createButton(
          '결제하기',
          onTap: () => Navigator.pushNamed(context, '/blindpay'),
          onLongPress: () => ttsHandler.speak('결제하기'),
        );
        return BlindUI(
          container1: container1,
          container2: container2,
          container3: container3,
          container4: container4,
          container5: container5,
          container6: container6,
        );
      },
    );
  }
}
