import 'dart:io';

import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () async {
              final cp = context.read<ConfigProvider>();
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                cp.changeConfig(result);
              }
            },
            child: const Text(
              "ConfigFile",
              style: TextStyle(fontSize: 50),
            ),
          ),
          TextButton(
            onPressed: () async {
              final cp = context.read<ConfigProvider>();
              String? selectedDirectory =
                  await FilePicker.platform.getDirectoryPath();
              selectedDirectory = selectedDirectory ?? "";
              cp.gluePath(selectedDirectory);
              var status = await Permission.storage.status;
              if (!status.isGranted) {
                await Permission.storage.request();
              }
            },
            child: const Text(
              "ImagePath",
              style: TextStyle(fontSize: 50),
            ),
          )
        ],
      ),
    );
  }
}

void filePick() async {}
