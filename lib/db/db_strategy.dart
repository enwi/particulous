import '../data/category.dart';
import '../data/part.dart';

abstract class DBStrategy {
  /// Close all connections and db
  void close();

  /// Get a future list of all parts
  Future<List<Part>> fetchParts();

  /// Observe and get a stream list of all parts
  Stream<List<Part>> watchParts();

  /// Watch parts of a speciifc category
  Stream<List<Part>> watchPartsOfCategory(final int category);

  /// Get a future list of all categories
  Future<List<Category>> fetchCategories();

  /// Get all parent category names of the given [category]
  Future<List<String>> getParentCategoryNames(final int category);

  /// Get all parent categories of the given [category]
  Future<List<Category>> getParentCategories(final int category);

  /// Insert a new [category] into the database
  Future<int> insertCategory(final Category category);

  /// Insert a new [part] into the database
  Future<int> insertPart(final Part part);

  Future<Category> fetchCategory(final int category);
}
