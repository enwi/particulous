import 'package:flutter/material.dart';
import 'package:particulous/category_screen.dart';
import 'package:particulous/data/settings.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/search_bar.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  final settings = await Settings.load();
  final dbSettings = await DBSettings.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: dbSettings),
        ChangeNotifierProvider.value(value: settings),
        ChangeNotifierProvider(
            create: (context) => DBHandler(settings: dbSettings))
      ],
      child: const Particoulus(),
    ),
  );
}

class Particoulus extends StatelessWidget {
  const Particoulus({super.key});

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
