part of db;

class Category extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parent => integer().nullable().references(Category, #id)();
  TextColumn get name => text().withLength(max: 1024)();
  TextColumn get description => text()();
  TextColumn get keywords => text().nullable()();
}
