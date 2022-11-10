import 'package:particulous/data/alter_stock.dart';
import 'package:particulous/data/bom_part.dart';
import 'package:particulous/data/category.dart';
import 'package:particulous/data/location.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/data/stock.dart';

abstract class DBStrategy {
  /// Close all connections and db
  void close();

  /// Get a future list of all parts
  Future<List<Part>> fetchParts();

  /// Get a future list of all parts that are marked as template
  Future<List<Part>> fetchTemplateParts();

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

  Future<int> fetchStockCountOfPart(final int part);
  Stream<int> watchStockCountOfPart(final int part);
  Stream<List<Stock>> watchStockOfPart(final int part);

  Future<int> alterStock(final AlterStock? alter);
  Future<List<String>> fetchSearchSuggestions(final String query);
  Future<List<Part>> fetchSearchParts(final String query);

  Future<int> insertStock(final Stock stock);

  Future<void> insertPartBom(BomPart part);
  Stream<List<BomPart>> watchBOMOfPart(final int part);

  Future<void> updateImageOfPart(final String image, final int part);

  Future<List<Location>> fetchLocations();
  Stream<List<Location>> watchLocations();
  Future<int> insertLocation(final Location location);
}
