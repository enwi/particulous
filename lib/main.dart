import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:particulous/add_category_form.dart';
import 'package:particulous/add_part_form.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/db/sqlite/sqlite_strategy.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // final db = Database();
  // db.into(db.category).insert(CategoryCompanion.insert(
  //       name: 'Cat 1',
  //       description: 'My category 1',
  //       keywords: const drift.Value('Hallal'),
  //     ));
  // db.into(db.part).insert(PartCompanion.insert(name: 'Part 1', category: 1));
  // final allCategories = await db.select(db.part).get();
  // log('Categories in database: $allCategories');

  runApp(
    Provider<DBHandler>(
      create: (context) => DBHandler(strategy: SQLiteStrategy()),
      child: const MyApp(),
      dispose: (context, dbh) => dbh.close(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Particulous',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DBHandler dbh = Provider.of<DBHandler>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parts'),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.category),
            label: 'Category',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: const Text('New Category'),
                  ),
                  body: Center(
                    child: SizedBox(
                      width: 500,
                      child: AddCategoryForm(
                        dbHandler: dbh,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SpeedDialChild(
            child: const Icon(Icons.article),
            label: 'Part',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: const Text('New Part'),
                  ),
                  body: Center(
                    child: SizedBox(
                      width: 500,
                      child: AddPartForm(
                        dbHandler: dbh,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Part>>(
        future: dbh.fetchParts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final part = snapshot.data![index];
                return ListTile(
                  title: Text(part.name),
                  subtitle: FutureBuilder<String>(
                    future: dbh
                        .getParentCategoryNames(part.category.identifier)
                        .then((value) => value.fold(
                            '',
                            (previousValue, element) =>
                                '$previousValue -> $element')),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!);
                      }
                      return const LinearProgressIndicator();
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
