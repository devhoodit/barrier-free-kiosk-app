import 'package:barrier_free_kiosk/pages/blind/blindUI.dart';
import 'package:barrier_free_kiosk/provider/cart_provider.dart';
import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:barrier_free_kiosk/provider/tts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlindCart extends StatelessWidget {
  const BlindCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: OrderList(),
    );
  }
}

class OrderList extends StatefulWidget {
  OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final ttsHandler = context.read<TtsProvider>();
    final cp = context.read<CartProvider>();
    final config = context.read<ConfigProvider>().config;
    final Container container1, container2;
    if (index <= 0) {
      container1 = createButton(
        "첫페이지",
        onTap: null,
        onLongPress: () => ttsHandler.speak("첫페이지입니다"),
      );
    } else {
      container1 = createButton(
        "이전페이지",
        onTap: () => setState(() {
          index -= 1;
        }),
        onLongPress: () => ttsHandler.speak("이전페이지"),
      );
    }

    if ((index + 1) * 2 > cp.orderList.length - 1) {
      container2 = createButton(
        "마지막페이지",
        onTap: null,
        onLongPress: () => ttsHandler.speak("마지막페이지입니다"),
      );
    } else {
      container2 = createButton(
        "다음페이지",
        onTap: () => setState(() {
          index += 1;
        }),
        onLongPress: () => ttsHandler.speak("다음페이지"),
      );
    }

    final Container container3, container4;

    if (index * 2 >= cp.orderList.length) {
      container3 =
          createButton("메뉴없음", onLongPress: () => ttsHandler.speak("메뉴없음"));
    } else {
      final menuName = cp.orderList[index * 2].item.name;
      final menuPrice = cp.orderList[index * 2].getPrice();

      container3 = createButton(
        "$menuName $menuPrice원",
        onLongPress: () => ttsHandler.speak("$menuName $menuPrice원"),
        onDoubleTap: () {
          cp.remove(index * 2);
          setState(() {});
        },
      );
    }

    if (index * 2 + 1 >= cp.orderList.length) {
      container4 =
          createButton("메뉴없음", onLongPress: () => ttsHandler.speak("메뉴없음"));
    } else {
      final menuName = cp.orderList[index * 2 + 1].item.name;
      final menuPrice = cp.orderList[index * 2 + 1].getPrice();

      container4 = createButton(
        "$menuName $menuPrice원",
        onLongPress: () => ttsHandler.speak("$menuName $menuPrice원"),
        onDoubleTap: () {
          cp.remove(index * 2 + 1);
          setState(() {});
        },
      );
    }

    final Container container5, container6;
    container5 = createButton(
      '뒤로가기',
      onTap: () => Navigator.pop(context),
      onLongPress: () => ttsHandler.speak("뒤로가기"),
    );
    container6 = createButton(
      '결제하기',
      onTap: () => Navigator.pushNamed(context, '/blindpay'),
      onLongPress: () => ttsHandler.speak("결제하기"),
    );

    return BlindUI(
        container1: container1,
        container2: container2,
        container3: container3,
        container4: container4,
        container5: container5,
        container6: container6);
  }
}
