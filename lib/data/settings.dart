import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings with ChangeNotifier {
  static const String kImageDir = 'imageDir';

  String imageDir;

  Settings({
    required this.imageDir,
  });

  void setImageDir(final String? dir) {
    if (dir == null) {
      return;
    }

    imageDir = dir;
    notifyListeners();
  }

  static Future<Settings> load() async {
    final pref = await SharedPreferences.getInstance();

    final documentsDir = (await getApplicationDocumentsDirectory()).path;

    final imageDir = pref.getString(Settings.kImageDir) ??
        join(documentsDir, 'particulous', 'image');

    return Settings(
      imageDir: imageDir,
    );
  }
}

class DBSettings with ChangeNotifier {
  static const String kDatabase = 'database';

  String database;

  DBSettings({
    required this.database,
  });

  static Future<DBSettings> load() async {
    final pref = await SharedPreferences.getInstance();

    final documentsDir = (await getApplicationDocumentsDirectory()).path;

    final database = pref.getString(DBSettings.kDatabase) ??
        join(documentsDir, 'particulous', 'db.sqlite');

    return DBSettings(
      database: database,
    );
  }

  void setDatabase(final String? database) {
    if (database == null) {
      return;
    }

    this.database = database;
    notifyListeners();
  }
}
