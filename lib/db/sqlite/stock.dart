part of db;

class Stock extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get part => integer().references(Part, #id)();
  IntColumn get amount => integer()();
  DateTimeColumn get modified => dateTime().withDefault(currentDateAndTime)();
  // IntColumn get supplier => integer().references(supplier, #id)();
  // TODO Location
  // TODO price
  // TODO order
}

class StockTracking extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get notes => text()();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  IntColumn get amount => integer()();
  IntColumn get stock => integer().references(Stock, #id)();
  // TODO user
}
