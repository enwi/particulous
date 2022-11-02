library db;

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'db.g.dart';
part 'category.dart';
part 'part.dart';
part 'stock.dart';

@DriftDatabase(
  tables: [
    Part,
    Category,
    PartBOM,
    Stock,
  ],
  queries: {
    'getParentCategoryNames': 'WITH RECURSIVE ParentCategory(p) AS ('
        'SELECT parent FROM category WHERE id = ? '
        'UNION ALL '
        'SELECT parent FROM category, ParentCategory '
        'WHERE ParentCategory.p=category.id'
        ')'
        'SELECT name FROM category;',
    'getParentCategories': 'WITH RECURSIVE ParentCategory(p) AS ('
        'SELECT parent FROM category WHERE id = ? '
        'UNION ALL '
        'SELECT parent FROM category, ParentCategory '
        'WHERE ParentCategory.p=category.id'
        ')'
        'SELECT * FROM category;',
  },
)
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final path = join(dbFolder.path, 'particulous', 'db.sqlite');
    final file = File(path);
    return NativeDatabase(file);
  });
}
