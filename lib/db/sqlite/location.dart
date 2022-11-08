part of db;

class Location extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parent => integer().nullable().references(Location, #id)();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
}
