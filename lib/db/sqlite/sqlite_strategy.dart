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
      ipn: rawData.read('part.ipn'),
      name: rawData.read('part.name'),
      description: rawData.read('part.description'),
      category: Category(
        identifier: rawData.read('category.id'),
        name: rawData.read('category.name'),
        description: rawData.read('category.description'),
        keywords: rawData.read('category.keywords'),
        parent: rawData.read('category.parent'),
      ),
      image: rawData.read('part.image'),
      variant: rawData.read('part.variant'),
      template: rawData.read('part.template'),
      sku: rawData.read('part.sku'),
      mpn: rawData.read('part.mpn'),
    );
  }

  static Part fromPartResult(final db.GetPartsOfChildCategoriesResult result) {
    return Part(
      identifier: result.id,
      ipn: result.ipn,
      name: result.name,
      description: result.description,
      category: Category(
        identifier: result.cId,
        name: result.cName,
        description: result.cDescription,
        keywords: result.cKeywords,
        parent: result.cParent,
      ),
      image: result.image,
      variant: result.variant,
      template: result.template,
      sku: result.sku,
      mpn: result.mpn,
    );
  }
}

extension SQLiteCategory on Category {
  static Category fromCategoryData(final db.CategoryData data) {
    return Category(
      identifier: data.id,
      name: data.name,
      description: data.description,
      keywords: data.keywords,
      parent: data.parent,
    );
  }
}

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
        .join([
          innerJoin(_db.category, _db.part.category.equalsExp(_db.category.id))
        ])
        .get()
        .then((results) => results.map(SQLitePart.fromResult).toList());
  }

  @override
  Stream<List<Part>> watchParts() {
    return (_db.select(_db.part).join([
      innerJoin(_db.category, _db.part.category.equalsExp(_db.category.id))
    ])
          ..orderBy([OrderingTerm.asc(_db.category.id)]))
        .watch()
        .map((results) => results.map(SQLitePart.fromResult).toList());
  }

  @override
  Stream<List<Part>> watchPartsOfCategory(final int category) {
    // return (_db.select(_db.part)..where((tbl) => tbl.category.equals(category)))
    //     .join([
    //       innerJoin(_db.category, _db.part.category.equalsExp(_db.category.id))
    //     ])
    //     .watch()
    //     .map((results) => results.map(SQLitePart.fromResult).toList());
    return _db
        .getPartsOfChildCategories(category)
        .watch()
        .map((results) => results.map(SQLitePart.fromPartResult).toList());
  }

  @override
  Future<List<Category>> fetchCategories() {
    return _db.select(_db.category).get().then(
        (results) => results.map(SQLiteCategory.fromCategoryData).toList());
  }

  @override
  Future<Category> fetchCategory(int category) {
    return (_db.select(_db.category)..where((tbl) => tbl.id.equals(category)))
        .getSingle()
        .then(SQLiteCategory.fromCategoryData);
  }

  @override
  Future<List<Category>> getParentCategories(final int category) {
    return _db
        .getParentCategories(category)
        .get()
        .then((value) => value.map(SQLiteCategory.fromCategoryData).toList());
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
          ipn: Value(part.ipn),
          description: Value(part.description),
          category: part.category.identifier,
          image: Value(part.image),
          variant: Value(part.variant),
          template: Value(part.template),
          sku: Value(part.sku),
          mpn: Value(part.mpn),
        ))
        .then((value) => value.id);
  }
}
