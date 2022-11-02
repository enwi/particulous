import 'package:drift/drift.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_strategy.dart';
import 'package:particulous/db/sqlite/db.dart' as db;

import '../../data/category.dart';

extension SQLitePart on Part {
  static Part fromResult(final TypedResult result) {
    final rawData = result.rawData;
    return Part(
        identifier: rawData.read('part.id'),
        name: rawData.read('part.name'),
        category: Category(
          identifier: rawData.read('category.id'),
          name: rawData.read('category.name'),
          description: rawData.read('category.description'),
        ));
  }
}

// extension SQLiteCategory on Category {
//   static Category fromResult(final TypedResult result) {
//     final rawData = result.rawData;
//     return Category(
//         name: rawData.read('part.name'),
//         category: Category(name: rawData.read('category.name')));
//   }
// }

class SQLiteStrategy implements DBStrategy {
  final _db = db.Database();

  @override
  void close() {
    _db.close();
  }

  @override
  Future<List<Part>> fetchParts() {
    return _db
        .select(_db.part)
        .join([innerJoin(_db.category, _db.part.id.equalsExp(_db.category.id))])
        .get()
        .then((results) => results.map(SQLitePart.fromResult).toList());
  }

  @override
  Future<List<Category>> fetchCategories() {
    return _db.select(_db.category).get().then((results) => results
        .map((result) => Category(
            identifier: result.id,
            name: result.name,
            description: result.description,
            keywords: result.keywords,
            parent: result.parent))
        .toList());
  }

  @override
  Future<List<String>> getParentCategoryNames(final int category) {
    return _db.getParentCategoryNames(category).get();
  }

  @override
  Future<int> insertCategory(Category category) {
    return _db
        .into(_db.category)
        .insertReturning(db.CategoryCompanion.insert(
          name: category.name,
          description: category.description,
          parent: Value(category.parent),
          keywords: Value(category.keywords),
        ))
        .then((value) => value.id);
  }

  @override
  Future<int> insertPart(Part part) {
    return _db
        .into(_db.part)
        .insertReturning(db.PartCompanion.insert(
          name: part.name,
          category: part.category.identifier,
        ))
        .then((value) => value.id);
  }
}
