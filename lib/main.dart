import 'dart:io';

import 'package:flutter/material.dart';
import 'package:particulous/category_screen.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/db/sqlite/sqlite_strategy.dart';
import 'package:particulous/search_bar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ApplicationDirectories {
  final Directory documentsDir;
  final Directory imageDir;
  ApplicationDirectories(this.documentsDir)
      : imageDir = Directory(join(documentsDir.path, 'particulous', 'image')) {
    imageDir.create(recursive: true);
  }
}

Future<void> main() async {
  final directories =
      await getApplicationDocumentsDirectory().then(ApplicationDirectories.new);

  runApp(
    MultiProvider(
      providers: [
        Provider<DBHandler>(
          create: (context) => DBHandler(strategy: SQLiteStrategy()),
          dispose: (context, dbh) => dbh.close(),
        ),
        Provider<ApplicationDirectories>(
          create: (context) => directories,
        ),
      ],
      child: const Particoulus(),
    ),
  );
}

class Particoulus extends StatelessWidget {
  const Particoulus({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Particulous',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: const SearchBar(),
      routes: {
        CategoryScreen.route: (context) => const CategoryScreen(),
      },
    );
  }
}
