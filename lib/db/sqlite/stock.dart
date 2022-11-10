part of db;

class Stock extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get part => integer().references(Part, #id)();
  IntColumn get amount => integer()();
  RealColumn get price => real().nullable()();
  // IntColumn get currency => integer().references(Currency, #id)();
  TextColumn get note => text().nullable()();
  IntColumn get location => integer().references(Location, #id)();
  DateTimeColumn get modified => dateTime().withDefault(currentDateAndTime)();
  // IntColumn get supplier => integer().references(supplier, #id)();
  // TODO order, supplier
}

class StockTracking extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get notes => text()();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  IntColumn get amount => integer()();
  IntColumn get stock => integer().references(Stock, #id)();
  // TODO user
}

class BuildOrder extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get reference => text()();
  IntColumn get part => integer().references(Part, #id)();
  TextColumn get description => text().nullable()();
  IntColumn get amount => integer()();
  IntColumn get destination => integer().nullable().references(Location, #id)();
  DateTimeColumn get created => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completed => dateTime().nullable()();
}

class StockAllocation extends Table {
  IntColumn get stock => integer().references(Stock, #id)();
  IntColumn get buildOrder => integer().references(BuildOrder, #id)();
  IntColumn get amount => integer()();
}
