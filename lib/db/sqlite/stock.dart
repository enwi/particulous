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
