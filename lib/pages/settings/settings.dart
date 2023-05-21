import 'dart:io';

import 'package:barrier_free_kiosk/main.dart';
import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void configFileOnPress() async {
      final cp = context.read<ConfigProvider>();
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        cp.changeConfig(result);
      }
    }

    void imagePathOnPress() async {
      final cp = context.read<ConfigProvider>();
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      selectedDirectory = selectedDirectory ?? "";
      cp.gluePath(selectedDirectory);
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
    }

    return Material(
      color: Theme.of(context).colorScheme.secondary,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Consumer<ConfigProvider>(
              builder: (context, value, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    createButton(context, "Config File",
                        value.isConfigInitialized, configFileOnPress),
                    const SizedBox(height: 30),
                    const Icon(
                      Icons.arrow_downward,
                      color: Colors.white,
                      size: 50,
                    ),
                    const SizedBox(height: 30),
                    createButton(
                      context,
                      "Image Path",
                      value.isConfigComplete,
                      value.isReadyForImagePath ? imagePathOnPress : null,
                    )
                  ],
                );
              },
            ),
          ),
          Positioned.fill(
            bottom: 100,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Text(
                    "뒤로가기",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget createButton(BuildContext context, String text, bool isCompleted,
    void Function()? onPressed) {
  final checkMark = isCompleted
      ? Positioned.fill(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
              child: Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.complete,
                size: 60,
              ),
            ),
          ),
        )
      : Container();
  return TextButton(
    onPressed: onPressed,
    child: Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: onPressed == null
            ? Theme.of(context).colorScheme.warning
            : Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 60, color: Colors.white),
            ),
          ),
          checkMark,
        ],
      ),
    ),
  );
}
