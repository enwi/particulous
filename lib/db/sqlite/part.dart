part of db;

class Part extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(max: 1024)();
  TextColumn get ipn => text().nullable()(); // internal part number
  TextColumn get description => text().nullable()();
  IntColumn get category => integer().references(Category, #id)();
  TextColumn get image => text().nullable()();

  IntColumn get variant => integer().nullable().references(Part, #id)();

  BoolColumn get template => boolean().withDefault(const Constant(false))();
  BoolColumn get assembly => boolean().withDefault(const Constant(false))();

  TextColumn get sku => text().nullable()(); // stock keeping unit
  // IntColumn get supplier => integer().references(supplier, #id)();
  TextColumn get mpn => text().nullable()(); // manufacturer part number
  // IntColumn get manufacturer => integer().references(manufacturer, #id)();
}

class PartBom extends Table {
  IntColumn get parent => integer().references(Part, #id)();
  IntColumn get part => integer().references(Part, #id)();
  IntColumn get amount => integer()();
  TextColumn get reference => text().nullable()();
  BoolColumn get optional => boolean().withDefault(const Constant(false))();
  BoolColumn get variants => boolean().withDefault(const Constant(false))();

  @override
  List<Set<Column>> get uniqueKeys => [
        {parent, part}
      ];
}
