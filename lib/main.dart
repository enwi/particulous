import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:particulous/category_screen.dart';
import 'package:particulous/data/settings.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/locations_screen.dart';
import 'package:particulous/part/part_detail_screen.dart';
import 'package:particulous/parts_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settings = await Settings.load();
  final dbSettings = await DBSettings.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: dbSettings),
        ChangeNotifierProvider.value(value: settings),
        ChangeNotifierProvider(
            create: (context) => DBHandler(settings: dbSettings)),
        FutureProvider.value(
            value: PackageInfo.fromPlatform(), initialData: null),
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const PartsScreen(),
      routes: {
        CategoryScreen.route: (context) => const CategoryScreen(),
        LocationsScreen.route: (context) => const LocationsScreen(),
        // TODO LocationScreen
        PartsScreen.route: (context) => const PartsScreen(),
        // TODO PartScreen
      },
      onGenerateRoute: (settings) {
        if (settings.name?.startsWith('/parts/') ?? false) {
          final partId = int.tryParse(settings.name!.split('/').last);
          if (partId == null) {
            return null;
          }

          final DBHandler dbh = Provider.of<DBHandler>(context, listen: false);
          return MaterialPageRoute(
              builder: (context) => FutureBuilder(
                  future: dbh.fetchPart(partId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return PartDetailScreen(dbh: dbh, part: snapshot.data!);
                    }
                    return const Center(child: CircularProgressIndicator());
                  }));
        }
        return null;
      },
    );
  }
}
