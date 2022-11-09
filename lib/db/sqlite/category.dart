part of db;

class Category extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parent => integer().nullable().references(Category, #id)();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get keywords => text().nullable()();
}
