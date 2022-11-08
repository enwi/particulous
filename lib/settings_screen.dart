import 'package:flutter/material.dart';
import 'package:particulous/data/application_directories.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _switch = true;

  @override
  Widget build(BuildContext context) {
    final dirs = Provider.of<ApplicationDirectories>(context);
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
                enabled: false,
                value: Text(
                    join(dirs.documentsDir.path, 'particulous', 'db.sqlite')),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.image),
                title: const Text('Images'),
                enabled: false,
                value: Text(dirs.imageDir.path),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
