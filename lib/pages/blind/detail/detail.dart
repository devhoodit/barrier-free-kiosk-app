import 'package:barrier_free_kiosk/lib/menu.dart';
import 'package:barrier_free_kiosk/pages/blind/blindUI.dart';
import 'package:barrier_free_kiosk/provider/cart_provider.dart';
import 'package:barrier_free_kiosk/provider/detail_provider.dart';
import 'package:barrier_free_kiosk/provider/tts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlindDetail extends StatelessWidget {
  const BlindDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MenuInfo;
    final details = args.detailCategories;
    final dp = context.read<DetailProvider>();
    dp.initializeRadio(args);
    final tts = context.read<TtsProvider>();
    tts.speak("상세메뉴 페이지입니다.");
    return Material(
      child: BDetail(),
    );
  }
}

class BDetail extends StatefulWidget {
  BDetail({Key? key}) : super(key: key);

  @override
  State<BDetail> createState() => _BDetailState();
}

class _BDetailState extends State<BDetail> {
  int row = 0;
  int col = 0;

  @override
  Widget build(BuildContext context) {
    final ttsHandler = context.read<TtsProvider>();
    final args = ModalRoute.of(context)!.settings.arguments as MenuInfo;
    final details = args.detailCategories;
    if (details.isEmpty) {
      final detailIndex = context.read<DetailProvider>().radio;
      final menuInfo = CartInfo(args.item, args.detailCategories, detailIndex);
      context.read<CartProvider>().add(menuInfo);
      Navigator.pushNamedAndRemoveUntil(
          context, '/blindorder', (route) => false);
    }
    final container1 = createButton(
      "이전선택지",
      onTap: () {
        if (col <= 0) return;
        setState(() {
          col -= 1;
        });
      },
      onLongPress: () => ttsHandler.speak("이전선택지"),
      boxDecoration: const BoxDecoration(color: Colors.black),
      textStyle:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
    );

    final container2 = createButton(
      "다음선택지",
      onTap: () {
        if (col >= (details[row].details.length - 1) ~/ 2) return;
        setState(() {
          col += 1;
        });
      },
      onLongPress: () => ttsHandler.speak("다음선택지"),
      boxDecoration: const BoxDecoration(color: Colors.white),
      textStyle:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
    );

    final curDetailRow = details[row];

    final leftDetailName = curDetailRow.details[col * 2].name;
    final leftPrice = curDetailRow.details[col * 2].price;
    final leftTTS = "$leftDetailName $leftPrice원";
    final container3 = createButton(
      leftTTS,
      onTap: () {
        context.read<DetailProvider>().changeRadio(row, col * 2);
        ttsHandler.speak("$leftDetailName 선택됨");
      },
      onLongPress: () => ttsHandler.speak(leftTTS),
      boxDecoration: const BoxDecoration(color: Colors.white),
      textStyle:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
    );

    void Function()? rightOnTap;
    final String rightTTS;
    if (curDetailRow.details.length - 1 < col * 2 + 1) {
      rightTTS = "선택지없음";
      rightOnTap = null;
    } else {
      final String rightDetailName;
      final double rightPrice;
      rightDetailName = curDetailRow.details[col * 2 + 1].name;
      rightPrice = curDetailRow.details[col * 2 + 1].price;
      rightTTS = "$rightDetailName $rightPrice원";
      rightOnTap = () {
        context.read<DetailProvider>().changeRadio(row, col * 2 + 1);
        ttsHandler.speak("$rightTTS 선택됨");
      };
    }
    final container4 = createButton(
      rightTTS,
      onTap: rightOnTap,
      onLongPress: () => ttsHandler.speak(rightTTS),
      boxDecoration: const BoxDecoration(color: Colors.black),
      textStyle:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
    );

    final Container container5, container6;

    if (row <= 0) {
      container5 = createButton(
        "뒤로가기",
        onTap: () => Navigator.pop(context),
        onLongPress: () => ttsHandler.speak("뒤로가기"),
        boxDecoration: const BoxDecoration(color: Colors.black),
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.white),
      );
    } else {
      container5 = createButton(
        "이전",
        onTap: () => setState(() {
          row -= 1;
          col = 0;
        }),
        onLongPress: () => ttsHandler.speak("이전"),
        boxDecoration: const BoxDecoration(color: Colors.black),
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.white),
      );
    }

    if (row >= details.length - 1) {
      container6 = createButton(
        "담기",
        onTap: () {
          final detailIndex = context.read<DetailProvider>().radio;
          final menuInfo =
              CartInfo(args.item, args.detailCategories, detailIndex);
          context.read<CartProvider>().add(menuInfo);
          Navigator.pushNamedAndRemoveUntil(
              context, '/blindorder', (route) => false);
        },
        onLongPress: () => ttsHandler.speak("담기"),
        boxDecoration: const BoxDecoration(color: Colors.white),
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.black),
      );
    } else {
      container6 = createButton(
        "다음",
        onTap: () => setState(() {
          row += 1;
          col = 0;
        }),
        onLongPress: () => ttsHandler.speak("다음"),
        boxDecoration: const BoxDecoration(color: Colors.white),
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.black),
      );
    }

    return BlindUI(
      container1: container1,
      container2: container2,
      container3: container3,
      container4: container4,
      container5: container5,
      container6: container6,
    );
  }
}
