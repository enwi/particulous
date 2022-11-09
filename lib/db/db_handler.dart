import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:particulous/data/alter_stock.dart';
import 'package:particulous/data/category.dart';
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

  /// Fetch all parts from the database
  Future<List<Part>> fetchParts() => _strategy.fetchParts();

  /// Fetch all parts from the database that are a template
  Future<List<Part>> fetchTemplateParts() => _strategy.fetchTemplateParts();

  /// Watch all parts from the database.
  /// Like [fetchParts], but observes and notifies changes
  Stream<List<Part>> watchParts() => _strategy.watchParts();

  /// Watch all parts of a specific category
  Stream<List<Part>> watchPartsOfCategory(final int category) =>
      _strategy.watchPartsOfCategory(category);

  Future<List<Category>> fetchCategories() => _strategy.fetchCategories();

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

  Future<int> alterStock(final AlterStock? alter) =>
      _strategy.alterStock(alter);

  Future<List<String>> fetchSearchSuggestions(final String query) =>
      _strategy.fetchSearchSuggestions(query);
  Future<List<Part>> fetchSearchParts(final String query) =>
      _strategy.fetchSearchParts(query);

  Future<int> insertStock(final Stock stock) => _strategy.insertStock(stock);

  Future<void> insertBomPart(final BomPart partBom) =>
      _strategy.insertPartBom(partBom);

  Stream<List<BomPart>> watchBOMOfPart(final int part) =>
      _strategy.watchBOMOfPart(part);

  Future<void> updateImageOfPart(final String image, final int part) =>
      _strategy.updateImageOfPart(image, part);
}
