library db;

import 'package:drift/drift.dart';

part 'db.g.dart';
part 'category.dart';
part 'part.dart';
part 'stock.dart';
part 'location.dart';

@DriftDatabase(
  tables: [
    Part,
    Category,
    BomPart,
    Stock,
    StockTracking,
    Location,
    BuildOrder,
    StockAllocation,
  ],
  queries: {
    'getParentCategoryNames': 'WITH RECURSIVE ParentCategory(i,p,n) AS ('
        'SELECT id, parent, name FROM category WHERE id = ? '
        'UNION ALL '
        'SELECT id, parent, name FROM category '
        'JOIN ParentCategory '
        'ON ParentCategory.p=category.id '
        ')'
        'SELECT n AS name FROM ParentCategory ORDER BY p;',
    'getParentCategories': 'WITH RECURSIVE ParentCategory(i,p,n,d,k) AS ('
        'SELECT id, parent, name, description, keywords FROM category WHERE id = ? '
        'UNION ALL '
        'SELECT id, parent, name, description, keywords FROM category '
        'JOIN ParentCategory '
        'ON ParentCategory.p=category.id '
        ')'
        'SELECT i AS id, p AS parent, n AS name, d AS description, k AS keywords FROM ParentCategory ORDER BY p;',
    'getPartsOfChildCategories': 'WITH RECURSIVE ParentCategory(i, p, n) AS ('
        'SELECT id, parent, name FROM category WHERE id = ? '
        'UNION ALL '
        'SELECT id, parent, name FROM category '
        'JOIN ParentCategory '
        'ON ParentCategory.i=category.parent '
        ')'
        'SELECT p.*, c.id AS cId, c.parent AS cParent, c.name AS cName, c.description AS cDescription, c.keywords AS cKeywords '
        'FROM part p '
        'JOIN category c ON p.category=c.id '
        'WHERE p.category IN (SELECT i FROM ParentCategory)'
        'ORDER BY p.category;',
  },
)
class Database extends _$Database {
  Database(final QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;
}

// LazyDatabase _openConnection() {
//   return LazyDatabase(() async {
//     final dbFolder = await getApplicationDocumentsDirectory();
//     final path = join(dbFolder.path, 'particulous', 'db.sqlite');
//     final file = File(path);
//     return NativeDatabase(file);
//   });
// }
