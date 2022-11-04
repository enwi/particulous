import 'package:flutter/material.dart';
import 'package:particulous/data/category.dart';
import 'package:particulous/error_widget.dart' as err;
import 'package:particulous/part_widget.dart';
import 'package:provider/provider.dart';

import 'db/db_handler.dart';

class CategoryScreenArgs {
  final int categoryId;
  final Category? category;

  CategoryScreenArgs({required this.categoryId, this.category});
}

class CategoryScreen extends StatelessWidget {
  static const String route = '/category';

  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as CategoryScreenArgs;
    final DBHandler dbh = Provider.of<DBHandler>(context);
    final Future<Category> category = args.category != null
        ? Future.value(args.category)
        : dbh.fetchCategory(args.categoryId);

    return FutureBuilder<Category>(
      future: category,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title:
                  Text('${snapshot.data!.name} (${snapshot.data!.identifier})'),
            ),
            body: Column(
              children: [
                Column(
                  children: [
                    Text('Description: ${snapshot.data!.description}'),
                    Text('Keywords: ${snapshot.data!.keywords}'),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: StreamBuilder(
                    stream: dbh.watchPartsOfCategory(snapshot.data!.identifier),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) => PartWidget(
                            dbh: dbh,
                            part: snapshot.data![index],
                          ),
                        );
                      }
                      return const LinearProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
          );
        }
        if (snapshot.hasError) {
          return err.ErrorWidget(
            title: 'Error loading category ${args.categoryId}',
            error: snapshot.error!.toString(),
          );
        }
        return const LinearProgressIndicator();
      },
    );
  }
}
