import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:particulous/data/settings.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final dbSettings = Provider.of<DBSettings>(context);
    final settings = Provider.of<Settings>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Storage'),
            tiles: [
              SettingsTile.navigation(
                leading: const Icon(Icons.storage),
                title: const Text('Database'),
                description: Text(
                  dbSettings.database,
                  overflow: TextOverflow.clip,
                ),
                onPressed: (context) => FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  lockParentWindow: true,
                  type: FileType.custom,
                  allowedExtensions: ['sqlite'],
                ).then((result) {
                  if (result == null ||
                      result.count != 1 ||
                      result.files.first.path == null) {
                    log('No database files have been picked');
                    return;
                  }
                  dbSettings.setDatabase(result.files.first.path!);
                }),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.image),
                title: const Text('Images'),
                description: Text(settings.imageDir),
                onPressed: (context) => FilePicker.platform
                    .getDirectoryPath(
                      lockParentWindow: true,
                    )
                    .then(settings.setImageDir),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
