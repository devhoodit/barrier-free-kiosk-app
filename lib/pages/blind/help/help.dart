import 'package:barrier_free_kiosk/provider/tts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const detail =
    "설명 페이지 입니다. 화면은 6분할되어 있습니다. 짧게 터치시 선택, 길게 누를시 음성안내가 됩니다. 다음 페이지로 넘어가시려면 화면을 한번 터치해주세요.";

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tts = context.read<TtsProvider>();
    tts.speak(detail);
    return Material(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/blindorder');
        },
        onLongPress: () {
          tts.speak(detail);
        },
        child: Container(
          padding: const EdgeInsets.all(50),
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "설명",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                  detail,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
