import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:particulous/data/alter_stock.dart';
import 'package:particulous/data/bom_part.dart';
import 'package:particulous/data/category.dart';
import 'package:particulous/data/location.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/data/stock.dart';
import 'package:particulous/db/db_strategy.dart';
import 'package:particulous/db/sqlite/db.dart' as db;

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
      assembly: rawData.read('part.assembly'),
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
      assembly: result.assembly,
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

extension SQLiteStock on Stock {
  static Stock fromTypedResult(final TypedResult result) {
    final rawData = result.rawData;
    return Stock(
      id: rawData.read('stock.id'),
      part: rawData.read('stock.part'),
      amount: rawData.read('stock.amount'),
      price: rawData.read('stock.price'),
      note: rawData.read('stock.note'),
      modified: rawData.read('stock.modified'),
      location: SQLiteLocation.fromTypedResult(result),
    );
  }
}

extension SQLitePartBom on BomPart {
  static BomPart fromTypedResult(final TypedResult result) {
    final rawData = result.rawData;
    return BomPart(
      parent: rawData.read('bom_part.parent'),
      part: SQLitePart.fromResult(result),
      amount: rawData.read('bom_part.amount'),
      reference: rawData.read('bom_part.reference'),
      optional: rawData.read('bom_part.optional'),
      variants: rawData.read('bom_part.variants'),
    );
  }
}

extension SQLiteLocation on Location {
  static Location fromLocationData(final db.LocationData data) {
    return Location(
      id: data.id,
      name: data.name,
      parent: data.parent,
      description: data.description,
    );
  }

  static Location fromTypedResult(final TypedResult result) {
    final rawData = result.rawData;
    return Location(
      id: rawData.read('location.id'),
      name: rawData.read('location.name'),
      parent: rawData.read('location.parent'),
      description: rawData.read('location.description'),
    );
  }
}

class SQLiteStrategy implements DBStrategy {
  final db.Database _db;

  SQLiteStrategy(final File file) : _db = db.Database(NativeDatabase(file)) {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  }

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
  Future<List<Part>> fetchTemplateParts() {
    return (_db.select(_db.part)..where((tbl) => tbl.template.equals(true)))
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
          assembly: Value(part.assembly),
          sku: Value(part.sku),
          mpn: Value(part.mpn),
        ))
        .then((value) => value.id);
  }

  @override
  Future<int> fetchStockCountOfPart(final int part) {
    final sum = _db.stock.amount.sum();
    return (_db.selectOnly(_db.stock)
          ..addColumns([sum])
          ..where(_db.stock.part.equals(part)))
        .map((row) => row.read(sum))
        .getSingle()
        .then((value) => value ?? 0);
  }

  @override
  Stream<int> watchStockCountOfPart(final int part) {
    final sum = _db.stock.amount.sum();
    return (_db.selectOnly(_db.stock)
          ..addColumns([sum])
          ..where(_db.stock.part.equals(part)))
        .map((row) => row.read(sum))
        .watchSingle()
        .map((value) => value ?? 0);
  }

  @override
  Stream<List<Stock>> watchStockOfPart(final int part) {
    return (_db.select(_db.stock).join([
      innerJoin(_db.location, _db.location.id.equalsExp(_db.stock.location))
    ])
          ..where(_db.stock.part.equals(part))
          ..orderBy([OrderingTerm.desc(_db.stock.amount)]))
        .watch()
        .map((result) => result.map(SQLiteStock.fromTypedResult).toList());
  }

  @override
  Future<int> alterStock(AlterStock? alter) {
    if (alter == null) {
      return Future.error(Exception('AlterStock cannot be null'));
    }
    return _db.transaction<int>(() async {
      final newStockTracking = await _db
          .into(_db.stockTracking)
          .insertReturning(db.StockTrackingCompanion.insert(
              notes: alter.notes, amount: alter.amount, stock: alter.stock));
      await (_db.update(_db.stock)..where((tbl) => tbl.id.equals(alter.stock)))
          .write(db.StockCompanion.custom(
        amount: _db.stock.amount + Variable(alter.amount),
        modified: Variable(newStockTracking.date),
      ));
      return newStockTracking.id;
    });
  }

  @override
  Future<List<String>> fetchSearchSuggestions(final String query) {
    return (_db.selectOnly(_db.part)
          ..addColumns([_db.part.name])
          ..join([
            innerJoin(
                _db.category, _db.part.category.equalsExp(_db.category.id))
          ])
          ..where(query
              .split(' ')
              .map(generatePartSearch)
              .reduce((value, element) => value & element))
          // ..orderBy(terms)
          ..limit(25))
        .get()
        .then((result) =>
            result.map((e) => e.rawData.read<String>('part.name')).toList());
  }

  @override
  Future<List<Part>> fetchSearchParts(final String query) {
    return (_db.select(_db.part).join([
      innerJoin(_db.category, _db.part.category.equalsExp(_db.category.id))
    ])
          ..where(query
              .split(' ')
              .map(generatePartSearch)
              .reduce((value, element) => value & element)))
        .get()
        .then((result) => result.map(SQLitePart.fromResult).toList());
  }

  Expression<bool> generatePartSearch(String query) {
    return _db.category.keywords.contains(query) |
        _db.category.name.contains(query) |
        _db.part.name.contains(query) |
        _db.part.description.contains(query);
  }

  @override
  Future<int> insertStock(Stock stock) {
    return _db
        .into(_db.stock)
        .insertReturning(db.StockCompanion.insert(
          part: stock.part,
          amount: stock.amount,
          price: Value(stock.price),
          note: Value(stock.note),
          location: stock.location.id,
        ))
        .then((value) => value.id);
  }

  @override
  Future<void> insertPartBom(final BomPart part) {
    return _db
        .into(_db.bomPart)
        .insertReturning(db.BomPartCompanion.insert(
          parent: part.parent,
          part: part.part.identifier,
          amount: part.amount,
          reference: Value(part.reference),
          optional: Value(part.optional),
          variants: Value(part.variants),
        ))
        .then((value) => null);
  }

  @override
  Stream<List<BomPart>> watchBOMOfPart(final int part) {
    return (_db.select(_db.bomPart)..where((tbl) => tbl.parent.equals(part)))
        .join([
          innerJoin(_db.part, _db.part.id.equalsExp(_db.bomPart.part)),
          innerJoin(_db.category, _db.part.category.equalsExp(_db.category.id)),
        ])
        .watch()
        .map((result) => result.map(SQLitePartBom.fromTypedResult).toList());
  }

  @override
  Future<void> updateImageOfPart(final String image, final int part) {
    return (_db.update(_db.part)..where((tbl) => tbl.id.equals(part)))
        .writeReturning(db.PartCompanion.custom(image: Variable(image)));
  }

  @override
  Future<List<Location>> fetchLocations() {
    return _db
        .select(_db.location)
        .get()
        .then((result) => result.map(SQLiteLocation.fromLocationData).toList());
  }

  @override
  Stream<List<Location>> watchLocations() {
    return _db
        .select(_db.location)
        .watch()
        .map((result) => result.map(SQLiteLocation.fromLocationData).toList());
  }

  @override
  Future<int> insertLocation(Location location) {
    return _db
        .into(_db.location)
        .insertReturning(db.LocationCompanion.insert(
          name: location.name,
          description: Value(location.description),
          parent: Value(location.parent),
        ))
        .then((value) => value.id);
  }
}
