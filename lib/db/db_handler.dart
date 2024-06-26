import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:particulous/data/alter_stock.dart';
import 'package:particulous/data/bom_part.dart';
import 'package:particulous/data/build_order.dart';
import 'package:particulous/data/category.dart';
import 'package:particulous/data/location.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/data/settings.dart';
import 'package:particulous/data/stock.dart';
import 'package:particulous/db/db_strategy.dart';

import 'sqlite/sqlite_strategy.dart';

class DBHandler with ChangeNotifier {
  DBStrategy _strategy;

  DBHandler({required DBSettings settings})
      : _strategy = SQLiteStrategy(File(settings.database)) {
    settings.addListener(() {
      close();
      _strategy = SQLiteStrategy(File(settings.database));
      notifyListeners();
    });
  }

  @override
  void dispose() {
    close();
    super.dispose();
  }

  void close() {
    log('close', name: 'DBHandler');
    _strategy.close();
  }

  /// Fetch a part with the given identifier from the database
  Future<Part?> fetchPart(final int part) => _strategy.fetchPart(part);

  /// Fetch all parts from the database
  Future<List<Part>> fetchParts() => _strategy.fetchParts();

  /// Fetch all parts from the database that are a template
  Future<List<Part>> fetchTemplateParts() => _strategy.fetchTemplateParts();

  /// Fetch all parts from the database that can be assembled
  Future<List<Part>> fetchAssemblyParts() => _strategy.fetchAssemblyParts();

  /// Watch all parts from the database.
  /// Like [fetchParts], but observes and notifies changes
  Stream<List<Part>> watchParts() => _strategy.watchParts();

  /// Watch all parts of a specific category
  Stream<List<Part>> watchPartsOfCategory(final int category) =>
      _strategy.watchPartsOfCategory(category);

  Future<List<Category>> fetchCategories() => _strategy.fetchCategories();
  Stream<List<Category>> watchCategories() => _strategy.watchCategories();

  Future<List<String>> getParentCategoryNames(final int category) =>
      _strategy.getParentCategoryNames(category);

  Future<List<Category>> getParentCategories(final int category) =>
      _strategy.getParentCategories(category);

  Future<int> insertCategory(final Category category) =>
      _strategy.insertCategory(category);

  Future<int> insertPart(final Part part) => _strategy.insertPart(part);

  Future<Category> fetchCategory(final int category) =>
      _strategy.fetchCategory(category);

  Future<int> fetchStockCountOfPart(final int part) =>
      _strategy.fetchStockCountOfPart(part);

  Stream<int> watchStockCountOfPart(final int part) =>
      _strategy.watchStockCountOfPart(part);

  Stream<List<Stock>> watchStockOfPart(final int part) =>
      _strategy.watchStockOfPart(part);

  Future<List<Stock>> fetchTemplateStockOfPart(final int part) =>
      _strategy.fetchTemplateStockOfPart(part);

  Stream<List<Stock>> watchTemplateStockOfPart(final int part) =>
      _strategy.watchTemplateStockOfPart(part);

  Future<int> alterStock(final AlterStock? alter) =>
      _strategy.alterStock(alter);

  Future<List<String>> fetchSearchSuggestions(final String query) =>
      _strategy.fetchSearchSuggestions(query);
  Future<List<Part>> fetchSearchParts(final String query) =>
      _strategy.fetchSearchParts(query);

  Future<int> insertStock(final Stock stock) => _strategy.insertStock(stock);

  Future<void> insertBomPart(final BomPart part) =>
      _strategy.insertPartBom(part);

  Stream<List<BomPart>> watchBOMOfPart(final int part) =>
      _strategy.watchBOMOfPart(part);

  Future<void> updateImageOfPart(final String image, final int part) =>
      _strategy.updateImageOfPart(image, part);

  Future<List<Location>> fetchLocations() => _strategy.fetchLocations();
  Stream<List<Location>> watchLocations() => _strategy.watchLocations();
  Future<int> insertLocation(final Location location) =>
      _strategy.insertLocation(location);

  Future<int> insertBuildOrder(final BuildOrder order) =>
      _strategy.insertBuildOrder(order);

  Future<BuildOrder?> getLatestBuildOrder() => _strategy.getLatestBuildOrder();
  Stream<List<BuildOrder>> watchBuildOrdersOfPart(final int part) =>
      _strategy.watchBuildOrdersOfPart(part);

  Stream<List<StockAllocation>> watchStockAllocationsOfBuildOrder(
          final int order) =>
      _strategy.watchStockAllocationsOfBuildOrder(order);
}
