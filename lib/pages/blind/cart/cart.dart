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
    final tts = context.read<TtsProvider>();
    tts.speak("장바구니 페이지입니다. 메뉴를 두번 터치하면 메뉴가 삭제됩니다");
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
        boxDecoration: const BoxDecoration(color: Colors.white),
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.black),
      );
    } else {
      container1 = createButton(
        "이전페이지",
        onTap: () => setState(() {
          index -= 1;
        }),
        onLongPress: () => ttsHandler.speak("이전페이지"),
        boxDecoration: const BoxDecoration(color: Colors.white),
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.black),
      );
    }

    if ((index + 1) * 2 > cp.orderList.length - 1) {
      container2 = createButton(
        "마지막페이지",
        onTap: null,
        onLongPress: () => ttsHandler.speak("마지막페이지입니다"),
        boxDecoration: const BoxDecoration(color: Colors.black),
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.white),
      );
    } else {
      container2 = createButton(
        "다음페이지",
        onTap: () => setState(() {
          index += 1;
        }),
        onLongPress: () => ttsHandler.speak("다음페이지"),
        boxDecoration: const BoxDecoration(color: Colors.black),
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.white),
      );
    }

    final Container container3, container4;

    if (index * 2 >= cp.orderList.length) {
      container3 = createButton(
        "메뉴없음",
        onLongPress: () => ttsHandler.speak("메뉴없음"),
        boxDecoration: const BoxDecoration(color: Colors.black),
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.white),
      );
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
        boxDecoration: const BoxDecoration(color: Colors.black),
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.white),
      );
    }

    if (index * 2 + 1 >= cp.orderList.length) {
      container4 = createButton(
        "메뉴없음",
        onLongPress: () => ttsHandler.speak("메뉴없음"),
        boxDecoration: const BoxDecoration(color: Colors.white),
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.black),
      );
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
        boxDecoration: const BoxDecoration(color: Colors.white),
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.black),
      );
    }

    final Container container5, container6;
    container5 = createButton(
      '뒤로가기',
      onTap: () => Navigator.pop(context),
      onLongPress: () => ttsHandler.speak("뒤로가기"),
      boxDecoration: const BoxDecoration(color: Colors.white),
      textStyle:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
    );
    container6 = createButton(
      '결제하기',
      onTap: () => Navigator.pushNamed(context, '/blindpay'),
      onLongPress: () => ttsHandler.speak("결제하기"),
      boxDecoration: const BoxDecoration(color: Colors.black),
      textStyle:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
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
