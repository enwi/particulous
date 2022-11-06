import 'package:particulous/data/alter_stock.dart';
import 'package:particulous/db/db_strategy.dart';

import '../data/category.dart';
import '../data/part.dart';
import '../data/stock.dart';

class DBHandler {
  final DBStrategy strategy;
  DBHandler({required this.strategy});

  void close() {
    strategy.close();
  }

  /// Fetch all parts from the database
  Future<List<Part>> fetchParts() => strategy.fetchParts();

  /// Fetch all parts from the database that are a template
  Future<List<Part>> fetchTemplateParts() => strategy.fetchTemplateParts();

  /// Watch all parts from the database.
  /// Like [fetchParts], but observes and notifies changes
  Stream<List<Part>> watchParts() => strategy.watchParts();

  /// Watch all parts of a specific category
  Stream<List<Part>> watchPartsOfCategory(final int category) =>
      strategy.watchPartsOfCategory(category);

  Future<List<Category>> fetchCategories() => strategy.fetchCategories();

  Future<List<String>> getParentCategoryNames(final int category) =>
      strategy.getParentCategoryNames(category);

  Future<List<Category>> getParentCategories(final int category) =>
      strategy.getParentCategories(category);

  Future<int> insertCategory(final Category category) =>
      strategy.insertCategory(category);

  Future<int> insertPart(final Part part) => strategy.insertPart(part);

  Future<Category> fetchCategory(final int category) =>
      strategy.fetchCategory(category);

  Future<int> fetchStockCountOfPart(final int part) =>
      strategy.fetchStockCountOfPart(part);

  Stream<int> watchStockCountOfPart(final int part) =>
      strategy.watchStockCountOfPart(part);

  Stream<List<Stock>> watchStockOfPart(final int part) =>
      strategy.watchStockOfPart(part);

  Future<int> alterStock(final AlterStock? alter) => strategy.alterStock(alter);

  Future<List<String>> fetchSearchSuggestions(final String query) =>
      strategy.fetchSearchSuggestions(query);
  Future<List<Part>> fetchSearchParts(final String query) =>
      strategy.fetchSearchParts(query);

  Future<int> insertStock(final Stock stock) => strategy.insertStock(stock);

  Future<void> insertBomPart(final BomPart partBom) =>
      strategy.insertPartBom(partBom);

  Stream<List<BomPart>> watchBOMOfPart(final int part) =>
      strategy.watchBOMOfPart(part);

  Future<void> updateImageOfPart(final String image, final int part) =>
      strategy.updateImageOfPart(image, part);
}
