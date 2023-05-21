import 'package:barrier_free_kiosk/lib/menu.dart';
import 'package:barrier_free_kiosk/pages/blind/blindUI.dart';
import 'package:barrier_free_kiosk/pages/default/pay/pay.dart';
import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:barrier_free_kiosk/provider/tts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlindOrder extends StatelessWidget {
  const BlindOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tts = context.read<TtsProvider>();
    tts.speak("주문 페이지입니다.");
    return Material(
      child: Column(children: [
        Expanded(
          flex: 2,
          child: OrderList(),
        ),
        const Expanded(
          flex: 1,
          child: BottomBar(),
        ),
      ]),
    );
  }
}

class OrderList extends StatefulWidget {
  OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  int categoryIndex = 0;
  int menuIndex = 0;

  @override
  Widget build(BuildContext context) {
    final config = context.read<ConfigProvider>().config;
    final tts = context.read<TtsProvider>();

    final isFirstCategory = categoryIndex == 0;
    final isLastCategory = config.categories.length - 1 == categoryIndex;
    final isFirstMenu = menuIndex == 0;
    final isLastMenu =
        (config.categories[categoryIndex].items.length - 1) ~/ 2 == menuIndex;

    GestureDetector leftMenu, rightMenu;
    final leftMenuItem = config.categories[categoryIndex].items[menuIndex * 2];
    final leftMenuDetail =
        config.categories[categoryIndex].detailCategories[menuIndex * 2];
    final rightMenuItem =
        menuIndex * 2 + 1 >= config.categories[categoryIndex].items.length
            ? null
            : config.categories[categoryIndex].items[menuIndex * 2 + 1];
    final rightMenuDetail = menuIndex * 2 + 1 >=
            config.categories[categoryIndex].items.length
        ? null
        : config.categories[categoryIndex].detailCategories[menuIndex * 2 + 1];

    leftMenu = GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/blinddetail',
        arguments:
            MenuInfo(item: leftMenuItem, detailCategories: leftMenuDetail),
      ),
      onLongPress: () {
        tts.speak("${leftMenuItem.name} ${leftMenuItem.price} 원");
      },
      child: createTextContainer(
          context,
          "${leftMenuItem.name}\n${leftMenuItem.price} 원",
          Colors.black,
          Colors.white),
    );

    rightMenu = GestureDetector(
      onTap: () {
        if (rightMenuItem != null) {
          Navigator.pushNamed(
            context,
            '/blinddetail',
            arguments: MenuInfo(
                item: rightMenuItem, detailCategories: rightMenuDetail!),
          );
        }
      },
      onLongPress: () {
        if (rightMenuItem != null) {
          tts.speak("${rightMenuItem.name} ${rightMenuItem.price} 원");
        } else {
          tts.speak("메뉴없음");
        }
      },
      child: createTextContainer(
          context,
          rightMenuItem == null
              ? "메뉴없음"
              : "${rightMenuItem.name}\n${rightMenuItem.price} 원",
          Colors.white,
          Colors.black),
    );

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (isFirstMenu) {
                      if (!isFirstCategory) {
                        setState(() {
                          categoryIndex -= 1;
                          menuIndex =
                              (config.categories[categoryIndex].items.length -
                                      1) ~/
                                  2;
                        });
                      }
                    } else {
                      setState(() {
                        menuIndex -= 1;
                      });
                    }
                  },
                  onLongPress: () {
                    tts.speak("이전");
                  },
                  onDoubleTap: () {
                    if (isFirstCategory) {
                      tts.speak("첫 페이지입니다.");
                    } else {
                      setState(() {
                        categoryIndex -= 1;
                        menuIndex = 0;
                      });
                      tts.speak(config.categories[categoryIndex].name);
                    }
                  },
                  child: createTextContainer(
                      context, "이전", Colors.white, Colors.black),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.black,
                  child: GestureDetector(
                    onTap: () {
                      if (isLastMenu) {
                        if (isLastCategory) {
                          tts.speak("마지막 페이지입니다.");
                        } else {
                          setState(() {
                            categoryIndex += 1;
                            menuIndex = 0;
                          });
                          tts.speak(config.categories[categoryIndex].name);
                        }
                      } else {
                        setState(() {
                          menuIndex += 1;
                        });
                      }
                    },
                    onDoubleTap: () {
                      if (isLastCategory) {
                        tts.speak("마지막 카테고리 입니다.");
                      } else {
                        setState(() {
                          categoryIndex += 1;
                          menuIndex = 0;
                        });
                        tts.speak(config.categories[categoryIndex].name);
                      }
                    },
                    onLongPress: () {
                      tts.speak("다음");
                    },
                    child: createTextContainer(
                        context, "다음", Colors.black, Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(color: Colors.black, child: leftMenu),
              ),
              Expanded(
                child: Container(color: Colors.white, child: rightMenu),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

const cartText = "장바구니";
const payText = "결제하기";

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tts = context.read<TtsProvider>();
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/blindcart');
              },
              onLongPress: () {
                tts.speak(cartText);
              },
              child: createTextContainer(
                  context, cartText, Colors.white, Colors.black),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/blindpay');
              },
              onLongPress: () {
                tts.speak(payText);
              },
              child: createTextContainer(
                  context, payText, Colors.black, Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

Widget createTextContainer(
    BuildContext context, String text, Color backgroundColor, Color textColor) {
  return Container(
    color: backgroundColor,
    child: Center(
      child: Text(
        text,
        style:
            Theme.of(context).textTheme.titleLarge!.copyWith(color: textColor),
      ),
    ),
  );
}
