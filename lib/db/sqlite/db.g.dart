// GENERATED CODE - DO NOT MODIFY BY HAND

part of db;

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class CategoryData extends DataClass implements Insertable<CategoryData> {
  final int id;
  final int? parent;
  final String name;
  final String description;
  final String? keywords;
  const CategoryData(
      {required this.id,
      this.parent,
      required this.name,
      required this.description,
      this.keywords});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || parent != null) {
      map['parent'] = Variable<int>(parent);
    }
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || keywords != null) {
      map['keywords'] = Variable<String>(keywords);
    }
    return map;
  }

  CategoryCompanion toCompanion(bool nullToAbsent) {
    return CategoryCompanion(
      id: Value(id),
      parent:
          parent == null && nullToAbsent ? const Value.absent() : Value(parent),
      name: Value(name),
      description: Value(description),
      keywords: keywords == null && nullToAbsent
          ? const Value.absent()
          : Value(keywords),
    );
  }

  factory CategoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryData(
      id: serializer.fromJson<int>(json['id']),
      parent: serializer.fromJson<int?>(json['parent']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      keywords: serializer.fromJson<String?>(json['keywords']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parent': serializer.toJson<int?>(parent),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'keywords': serializer.toJson<String?>(keywords),
    };
  }

  CategoryData copyWith(
          {int? id,
          Value<int?> parent = const Value.absent(),
          String? name,
          String? description,
          Value<String?> keywords = const Value.absent()}) =>
      CategoryData(
        id: id ?? this.id,
        parent: parent.present ? parent.value : this.parent,
        name: name ?? this.name,
        description: description ?? this.description,
        keywords: keywords.present ? keywords.value : this.keywords,
      );
  @override
  String toString() {
    return (StringBuffer('CategoryData(')
          ..write('id: $id, ')
          ..write('parent: $parent, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('keywords: $keywords')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, parent, name, description, keywords);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryData &&
          other.id == this.id &&
          other.parent == this.parent &&
          other.name == this.name &&
          other.description == this.description &&
          other.keywords == this.keywords);
}

class CategoryCompanion extends UpdateCompanion<CategoryData> {
  final Value<int> id;
  final Value<int?> parent;
  final Value<String> name;
  final Value<String> description;
  final Value<String?> keywords;
  const CategoryCompanion({
    this.id = const Value.absent(),
    this.parent = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.keywords = const Value.absent(),
  });
  CategoryCompanion.insert({
    this.id = const Value.absent(),
    this.parent = const Value.absent(),
    required String name,
    required String description,
    this.keywords = const Value.absent(),
  })  : name = Value(name),
        description = Value(description);
  static Insertable<CategoryData> custom({
    Expression<int>? id,
    Expression<int>? parent,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? keywords,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parent != null) 'parent': parent,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (keywords != null) 'keywords': keywords,
    });
  }

  CategoryCompanion copyWith(
      {Value<int>? id,
      Value<int?>? parent,
      Value<String>? name,
      Value<String>? description,
      Value<String?>? keywords}) {
    return CategoryCompanion(
      id: id ?? this.id,
      parent: parent ?? this.parent,
      name: name ?? this.name,
      description: description ?? this.description,
      keywords: keywords ?? this.keywords,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (parent.present) {
      map['parent'] = Variable<int>(parent.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (keywords.present) {
      map['keywords'] = Variable<String>(keywords.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryCompanion(')
          ..write('id: $id, ')
          ..write('parent: $parent, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('keywords: $keywords')
          ..write(')'))
        .toString();
  }
}

class $CategoryTable extends Category
    with TableInfo<$CategoryTable, CategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _parentMeta = const VerificationMeta('parent');
  @override
  late final GeneratedColumn<int> parent = GeneratedColumn<int>(
      'parent', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES "category" ("id")');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 1024),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _keywordsMeta = const VerificationMeta('keywords');
  @override
  late final GeneratedColumn<String> keywords = GeneratedColumn<String>(
      'keywords', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, parent, name, description, keywords];
  @override
  String get aliasedName => _alias ?? 'category';
  @override
  String get actualTableName => 'category';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('parent')) {
      context.handle(_parentMeta,
          parent.isAcceptableOrUnknown(data['parent']!, _parentMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('keywords')) {
      context.handle(_keywordsMeta,
          keywords.isAcceptableOrUnknown(data['keywords']!, _keywordsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      parent: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}parent']),
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      keywords: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}keywords']),
    );
  }

  @override
  $CategoryTable createAlias(String alias) {
    return $CategoryTable(attachedDatabase, alias);
  }
}

class PartData extends DataClass implements Insertable<PartData> {
  final int id;
  final String? ipn;
  final String name;
  final String? description;
  final int category;
  final String? image;
  final int? variant;
  final bool template;
  final String? sku;
  final String? mpn;
  const PartData(
      {required this.id,
      this.ipn,
      required this.name,
      this.description,
      required this.category,
      this.image,
      this.variant,
      required this.template,
      this.sku,
      this.mpn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || ipn != null) {
      map['ipn'] = Variable<String>(ipn);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['category'] = Variable<int>(category);
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || variant != null) {
      map['variant'] = Variable<int>(variant);
    }
    map['template'] = Variable<bool>(template);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    if (!nullToAbsent || mpn != null) {
      map['mpn'] = Variable<String>(mpn);
    }
    return map;
  }

  PartCompanion toCompanion(bool nullToAbsent) {
    return PartCompanion(
      id: Value(id),
      ipn: ipn == null && nullToAbsent ? const Value.absent() : Value(ipn),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      category: Value(category),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      variant: variant == null && nullToAbsent
          ? const Value.absent()
          : Value(variant),
      template: Value(template),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      mpn: mpn == null && nullToAbsent ? const Value.absent() : Value(mpn),
    );
  }

  factory PartData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartData(
      id: serializer.fromJson<int>(json['id']),
      ipn: serializer.fromJson<String?>(json['ipn']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      category: serializer.fromJson<int>(json['category']),
      image: serializer.fromJson<String?>(json['image']),
      variant: serializer.fromJson<int?>(json['variant']),
      template: serializer.fromJson<bool>(json['template']),
      sku: serializer.fromJson<String?>(json['sku']),
      mpn: serializer.fromJson<String?>(json['mpn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ipn': serializer.toJson<String?>(ipn),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'category': serializer.toJson<int>(category),
      'image': serializer.toJson<String?>(image),
      'variant': serializer.toJson<int?>(variant),
      'template': serializer.toJson<bool>(template),
      'sku': serializer.toJson<String?>(sku),
      'mpn': serializer.toJson<String?>(mpn),
    };
  }

  PartData copyWith(
          {int? id,
          Value<String?> ipn = const Value.absent(),
          String? name,
          Value<String?> description = const Value.absent(),
          int? category,
          Value<String?> image = const Value.absent(),
          Value<int?> variant = const Value.absent(),
          bool? template,
          Value<String?> sku = const Value.absent(),
          Value<String?> mpn = const Value.absent()}) =>
      PartData(
        id: id ?? this.id,
        ipn: ipn.present ? ipn.value : this.ipn,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        category: category ?? this.category,
        image: image.present ? image.value : this.image,
        variant: variant.present ? variant.value : this.variant,
        template: template ?? this.template,
        sku: sku.present ? sku.value : this.sku,
        mpn: mpn.present ? mpn.value : this.mpn,
      );
  @override
  String toString() {
    return (StringBuffer('PartData(')
          ..write('id: $id, ')
          ..write('ipn: $ipn, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('image: $image, ')
          ..write('variant: $variant, ')
          ..write('template: $template, ')
          ..write('sku: $sku, ')
          ..write('mpn: $mpn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, ipn, name, description, category, image, variant, template, sku, mpn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartData &&
          other.id == this.id &&
          other.ipn == this.ipn &&
          other.name == this.name &&
          other.description == this.description &&
          other.category == this.category &&
          other.image == this.image &&
          other.variant == this.variant &&
          other.template == this.template &&
          other.sku == this.sku &&
          other.mpn == this.mpn);
}

class PartCompanion extends UpdateCompanion<PartData> {
  final Value<int> id;
  final Value<String?> ipn;
  final Value<String> name;
  final Value<String?> description;
  final Value<int> category;
  final Value<String?> image;
  final Value<int?> variant;
  final Value<bool> template;
  final Value<String?> sku;
  final Value<String?> mpn;
  const PartCompanion({
    this.id = const Value.absent(),
    this.ipn = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.image = const Value.absent(),
    this.variant = const Value.absent(),
    this.template = const Value.absent(),
    this.sku = const Value.absent(),
    this.mpn = const Value.absent(),
  });
  PartCompanion.insert({
    this.id = const Value.absent(),
    this.ipn = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required int category,
    this.image = const Value.absent(),
    this.variant = const Value.absent(),
    this.template = const Value.absent(),
    this.sku = const Value.absent(),
    this.mpn = const Value.absent(),
  })  : name = Value(name),
        category = Value(category);
  static Insertable<PartData> custom({
    Expression<int>? id,
    Expression<String>? ipn,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? category,
    Expression<String>? image,
    Expression<int>? variant,
    Expression<bool>? template,
    Expression<String>? sku,
    Expression<String>? mpn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ipn != null) 'ipn': ipn,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (image != null) 'image': image,
      if (variant != null) 'variant': variant,
      if (template != null) 'template': template,
      if (sku != null) 'sku': sku,
      if (mpn != null) 'mpn': mpn,
    });
  }

  PartCompanion copyWith(
      {Value<int>? id,
      Value<String?>? ipn,
      Value<String>? name,
      Value<String?>? description,
      Value<int>? category,
      Value<String?>? image,
      Value<int?>? variant,
      Value<bool>? template,
      Value<String?>? sku,
      Value<String?>? mpn}) {
    return PartCompanion(
      id: id ?? this.id,
      ipn: ipn ?? this.ipn,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      variant: variant ?? this.variant,
      template: template ?? this.template,
      sku: sku ?? this.sku,
      mpn: mpn ?? this.mpn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ipn.present) {
      map['ipn'] = Variable<String>(ipn.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (variant.present) {
      map['variant'] = Variable<int>(variant.value);
    }
    if (template.present) {
      map['template'] = Variable<bool>(template.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (mpn.present) {
      map['mpn'] = Variable<String>(mpn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartCompanion(')
          ..write('id: $id, ')
          ..write('ipn: $ipn, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('image: $image, ')
          ..write('variant: $variant, ')
          ..write('template: $template, ')
          ..write('sku: $sku, ')
          ..write('mpn: $mpn')
          ..write(')'))
        .toString();
  }
}

class $PartTable extends Part with TableInfo<$PartTable, PartData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _ipnMeta = const VerificationMeta('ipn');
  @override
  late final GeneratedColumn<String> ipn = GeneratedColumn<String>(
      'ipn', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumn<int> category = GeneratedColumn<int>(
      'category', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "category" ("id")');
  final VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _variantMeta = const VerificationMeta('variant');
  @override
  late final GeneratedColumn<int> variant = GeneratedColumn<int>(
      'variant', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES "part" ("id")');
  final VerificationMeta _templateMeta = const VerificationMeta('template');
  @override
  late final GeneratedColumn<bool> template = GeneratedColumn<bool>(
      'template', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK ("template" IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _mpnMeta = const VerificationMeta('mpn');
  @override
  late final GeneratedColumn<String> mpn = GeneratedColumn<String>(
      'mpn', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        ipn,
        name,
        description,
        category,
        image,
        variant,
        template,
        sku,
        mpn
      ];
  @override
  String get aliasedName => _alias ?? 'part';
  @override
  String get actualTableName => 'part';
  @override
  VerificationContext validateIntegrity(Insertable<PartData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ipn')) {
      context.handle(
          _ipnMeta, ipn.isAcceptableOrUnknown(data['ipn']!, _ipnMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('variant')) {
      context.handle(_variantMeta,
          variant.isAcceptableOrUnknown(data['variant']!, _variantMeta));
    }
    if (data.containsKey('template')) {
      context.handle(_templateMeta,
          template.isAcceptableOrUnknown(data['template']!, _templateMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('mpn')) {
      context.handle(
          _mpnMeta, mpn.isAcceptableOrUnknown(data['mpn']!, _mpnMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PartData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ipn: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}ipn']),
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      category: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}category'])!,
      image: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
      variant: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}variant']),
      template: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}template'])!,
      sku: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      mpn: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}mpn']),
    );
  }

  @override
  $PartTable createAlias(String alias) {
    return $PartTable(attachedDatabase, alias);
  }
}

class PartBOMData extends DataClass implements Insertable<PartBOMData> {
  final int parent;
  final int part;
  final int amount;
  final bool optional;
  const PartBOMData(
      {required this.parent,
      required this.part,
      required this.amount,
      required this.optional});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['parent'] = Variable<int>(parent);
    map['part'] = Variable<int>(part);
    map['amount'] = Variable<int>(amount);
    map['optional'] = Variable<bool>(optional);
    return map;
  }

  PartBOMCompanion toCompanion(bool nullToAbsent) {
    return PartBOMCompanion(
      parent: Value(parent),
      part: Value(part),
      amount: Value(amount),
      optional: Value(optional),
    );
  }

  factory PartBOMData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartBOMData(
      parent: serializer.fromJson<int>(json['parent']),
      part: serializer.fromJson<int>(json['part']),
      amount: serializer.fromJson<int>(json['amount']),
      optional: serializer.fromJson<bool>(json['optional']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'parent': serializer.toJson<int>(parent),
      'part': serializer.toJson<int>(part),
      'amount': serializer.toJson<int>(amount),
      'optional': serializer.toJson<bool>(optional),
    };
  }

  PartBOMData copyWith({int? parent, int? part, int? amount, bool? optional}) =>
      PartBOMData(
        parent: parent ?? this.parent,
        part: part ?? this.part,
        amount: amount ?? this.amount,
        optional: optional ?? this.optional,
      );
  @override
  String toString() {
    return (StringBuffer('PartBOMData(')
          ..write('parent: $parent, ')
          ..write('part: $part, ')
          ..write('amount: $amount, ')
          ..write('optional: $optional')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(parent, part, amount, optional);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartBOMData &&
          other.parent == this.parent &&
          other.part == this.part &&
          other.amount == this.amount &&
          other.optional == this.optional);
}

class PartBOMCompanion extends UpdateCompanion<PartBOMData> {
  final Value<int> parent;
  final Value<int> part;
  final Value<int> amount;
  final Value<bool> optional;
  const PartBOMCompanion({
    this.parent = const Value.absent(),
    this.part = const Value.absent(),
    this.amount = const Value.absent(),
    this.optional = const Value.absent(),
  });
  PartBOMCompanion.insert({
    required int parent,
    required int part,
    required int amount,
    this.optional = const Value.absent(),
  })  : parent = Value(parent),
        part = Value(part),
        amount = Value(amount);
  static Insertable<PartBOMData> custom({
    Expression<int>? parent,
    Expression<int>? part,
    Expression<int>? amount,
    Expression<bool>? optional,
  }) {
    return RawValuesInsertable({
      if (parent != null) 'parent': parent,
      if (part != null) 'part': part,
      if (amount != null) 'amount': amount,
      if (optional != null) 'optional': optional,
    });
  }

  PartBOMCompanion copyWith(
      {Value<int>? parent,
      Value<int>? part,
      Value<int>? amount,
      Value<bool>? optional}) {
    return PartBOMCompanion(
      parent: parent ?? this.parent,
      part: part ?? this.part,
      amount: amount ?? this.amount,
      optional: optional ?? this.optional,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (parent.present) {
      map['parent'] = Variable<int>(parent.value);
    }
    if (part.present) {
      map['part'] = Variable<int>(part.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (optional.present) {
      map['optional'] = Variable<bool>(optional.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartBOMCompanion(')
          ..write('parent: $parent, ')
          ..write('part: $part, ')
          ..write('amount: $amount, ')
          ..write('optional: $optional')
          ..write(')'))
        .toString();
  }
}

class $PartBOMTable extends PartBOM with TableInfo<$PartBOMTable, PartBOMData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartBOMTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _parentMeta = const VerificationMeta('parent');
  @override
  late final GeneratedColumn<int> parent = GeneratedColumn<int>(
      'parent', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "part" ("id")');
  final VerificationMeta _partMeta = const VerificationMeta('part');
  @override
  late final GeneratedColumn<int> part = GeneratedColumn<int>(
      'part', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "part" ("id")');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _optionalMeta = const VerificationMeta('optional');
  @override
  late final GeneratedColumn<bool> optional = GeneratedColumn<bool>(
      'optional', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK ("optional" IN (0, 1))',
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [parent, part, amount, optional];
  @override
  String get aliasedName => _alias ?? 'part_b_o_m';
  @override
  String get actualTableName => 'part_b_o_m';
  @override
  VerificationContext validateIntegrity(Insertable<PartBOMData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('parent')) {
      context.handle(_parentMeta,
          parent.isAcceptableOrUnknown(data['parent']!, _parentMeta));
    } else if (isInserting) {
      context.missing(_parentMeta);
    }
    if (data.containsKey('part')) {
      context.handle(
          _partMeta, part.isAcceptableOrUnknown(data['part']!, _partMeta));
    } else if (isInserting) {
      context.missing(_partMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('optional')) {
      context.handle(_optionalMeta,
          optional.isAcceptableOrUnknown(data['optional']!, _optionalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {parent, part},
      ];
  @override
  PartBOMData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartBOMData(
      parent: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}parent'])!,
      part: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}part'])!,
      amount: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      optional: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}optional'])!,
    );
  }

  @override
  $PartBOMTable createAlias(String alias) {
    return $PartBOMTable(attachedDatabase, alias);
  }
}

class StockData extends DataClass implements Insertable<StockData> {
  final int id;
  final int part;
  final int amount;
  final DateTime modified;
  const StockData(
      {required this.id,
      required this.part,
      required this.amount,
      required this.modified});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['part'] = Variable<int>(part);
    map['amount'] = Variable<int>(amount);
    map['modified'] = Variable<DateTime>(modified);
    return map;
  }

  StockCompanion toCompanion(bool nullToAbsent) {
    return StockCompanion(
      id: Value(id),
      part: Value(part),
      amount: Value(amount),
      modified: Value(modified),
    );
  }

  factory StockData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockData(
      id: serializer.fromJson<int>(json['id']),
      part: serializer.fromJson<int>(json['part']),
      amount: serializer.fromJson<int>(json['amount']),
      modified: serializer.fromJson<DateTime>(json['modified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'part': serializer.toJson<int>(part),
      'amount': serializer.toJson<int>(amount),
      'modified': serializer.toJson<DateTime>(modified),
    };
  }

  StockData copyWith({int? id, int? part, int? amount, DateTime? modified}) =>
      StockData(
        id: id ?? this.id,
        part: part ?? this.part,
        amount: amount ?? this.amount,
        modified: modified ?? this.modified,
      );
  @override
  String toString() {
    return (StringBuffer('StockData(')
          ..write('id: $id, ')
          ..write('part: $part, ')
          ..write('amount: $amount, ')
          ..write('modified: $modified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, part, amount, modified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockData &&
          other.id == this.id &&
          other.part == this.part &&
          other.amount == this.amount &&
          other.modified == this.modified);
}

class StockCompanion extends UpdateCompanion<StockData> {
  final Value<int> id;
  final Value<int> part;
  final Value<int> amount;
  final Value<DateTime> modified;
  const StockCompanion({
    this.id = const Value.absent(),
    this.part = const Value.absent(),
    this.amount = const Value.absent(),
    this.modified = const Value.absent(),
  });
  StockCompanion.insert({
    this.id = const Value.absent(),
    required int part,
    required int amount,
    this.modified = const Value.absent(),
  })  : part = Value(part),
        amount = Value(amount);
  static Insertable<StockData> custom({
    Expression<int>? id,
    Expression<int>? part,
    Expression<int>? amount,
    Expression<DateTime>? modified,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (part != null) 'part': part,
      if (amount != null) 'amount': amount,
      if (modified != null) 'modified': modified,
    });
  }

  StockCompanion copyWith(
      {Value<int>? id,
      Value<int>? part,
      Value<int>? amount,
      Value<DateTime>? modified}) {
    return StockCompanion(
      id: id ?? this.id,
      part: part ?? this.part,
      amount: amount ?? this.amount,
      modified: modified ?? this.modified,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (part.present) {
      map['part'] = Variable<int>(part.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (modified.present) {
      map['modified'] = Variable<DateTime>(modified.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockCompanion(')
          ..write('id: $id, ')
          ..write('part: $part, ')
          ..write('amount: $amount, ')
          ..write('modified: $modified')
          ..write(')'))
        .toString();
  }
}

class $StockTable extends Stock with TableInfo<$StockTable, StockData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _partMeta = const VerificationMeta('part');
  @override
  late final GeneratedColumn<int> part = GeneratedColumn<int>(
      'part', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "part" ("id")');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _modifiedMeta = const VerificationMeta('modified');
  @override
  late final GeneratedColumn<DateTime> modified = GeneratedColumn<DateTime>(
      'modified', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, part, amount, modified];
  @override
  String get aliasedName => _alias ?? 'stock';
  @override
  String get actualTableName => 'stock';
  @override
  VerificationContext validateIntegrity(Insertable<StockData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('part')) {
      context.handle(
          _partMeta, part.isAcceptableOrUnknown(data['part']!, _partMeta));
    } else if (isInserting) {
      context.missing(_partMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('modified')) {
      context.handle(_modifiedMeta,
          modified.isAcceptableOrUnknown(data['modified']!, _modifiedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      part: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}part'])!,
      amount: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      modified: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}modified'])!,
    );
  }

  @override
  $StockTable createAlias(String alias) {
    return $StockTable(attachedDatabase, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $CategoryTable category = $CategoryTable(this);
  late final $PartTable part = $PartTable(this);
  late final $PartBOMTable partBOM = $PartBOMTable(this);
  late final $StockTable stock = $StockTable(this);
  Selectable<String> getParentCategoryNames(int var1) {
    return customSelect(
        'WITH RECURSIVE ParentCategory(p) AS (SELECT parent FROM category WHERE id = ?1 UNION ALL SELECT parent FROM category,ParentCategory WHERE ParentCategory.p = category.id) SELECT name FROM category',
        variables: [
          Variable<int>(var1)
        ],
        readsFrom: {
          category,
        }).map((QueryRow row) => row.read<String>('name'));
  }

  Selectable<CategoryData> getParentCategories(int var1) {
    return customSelect(
        'WITH RECURSIVE ParentCategory(p) AS (SELECT parent FROM category WHERE id = ?1 UNION ALL SELECT parent FROM category,ParentCategory WHERE ParentCategory.p = category.id) SELECT * FROM category',
        variables: [
          Variable<int>(var1)
        ],
        readsFrom: {
          category,
        }).asyncMap(category.mapFromRow);
  }

  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [category, part, partBOM, stock];
}
