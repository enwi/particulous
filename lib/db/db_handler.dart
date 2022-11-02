import 'package:particulous/db/db_strategy.dart';

import '../data/category.dart';
import '../data/part.dart';

class DBHandler {
  final DBStrategy strategy;
  DBHandler({required this.strategy});

  void close() {
    strategy.close();
  }

  Future<List<Part>> fetchParts() => strategy.fetchParts();

  Future<List<Category>> fetchCategories() => strategy.fetchCategories();

  Future<List<String>> getParentCategoryNames(final int category) =>
      strategy.getParentCategoryNames(category);

  Future<int> insertCategory(final Category category) =>
      strategy.insertCategory(category);

  Future<int> insertPart(final Part part) => strategy.insertPart(part);
}
