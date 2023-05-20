import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsProvider extends ChangeNotifier {
  final ttsHandler = FlutterTts();
  static const defaultLanguage = 'ko-KR';

  void initialize({language}) async {
    if (await ttsHandler
        .isLanguageAvailable(language ? language : defaultLanguage)) {
      ttsHandler.setLanguage(language ? language : defaultLanguage);
    }
  }

  void speak(String text) async {
    final result = await ttsHandler.speak(text);
  }

  void printLanguage() async {
    print(await ttsHandler.getLanguages);
  }
}
