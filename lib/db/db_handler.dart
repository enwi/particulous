import 'package:particulous/db/db_strategy.dart';

import '../data/category.dart';
import '../data/part.dart';

class DBHandler {
  final DBStrategy strategy;
  DBHandler({required this.strategy});

  void close() {
    strategy.close();
  }

  /// Fetch all parts from the database
  Future<List<Part>> fetchParts() => strategy.fetchParts();

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
}