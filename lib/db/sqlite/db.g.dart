// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $CategoryTable extends Category
    with TableInfo<$CategoryTable, CategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _parentMeta = const VerificationMeta('parent');
  @override
  late final GeneratedColumn<int> parent = GeneratedColumn<int>(
      'parent', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES category (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _keywordsMeta =
      const VerificationMeta('keywords');
  @override
  late final GeneratedColumn<String> keywords = GeneratedColumn<String>(
      'keywords', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, parent, name, description, keywords];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category';
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
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      parent: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      keywords: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}keywords']),
    );
  }

  @override
  $CategoryTable createAlias(String alias) {
    return $CategoryTable(attachedDatabase, alias);
  }
}

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
  CategoryData copyWithCompanion(CategoryCompanion data) {
    return CategoryData(
      id: data.id.present ? data.id.value : this.id,
      parent: data.parent.present ? data.parent.value : this.parent,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      keywords: data.keywords.present ? data.keywords.value : this.keywords,
    );
  }

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

class $PartTable extends Part with TableInfo<$PartTable, PartData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ipnMeta = const VerificationMeta('ipn');
  @override
  late final GeneratedColumn<String> ipn = GeneratedColumn<String>(
      'ipn', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<int> category = GeneratedColumn<int>(
      'category', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES category (id)'));
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _variantMeta =
      const VerificationMeta('variant');
  @override
  late final GeneratedColumn<int> variant = GeneratedColumn<int>(
      'variant', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES part (id)'));
  static const VerificationMeta _templateMeta =
      const VerificationMeta('template');
  @override
  late final GeneratedColumn<bool> template = GeneratedColumn<bool>(
      'template', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("template" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _assemblyMeta =
      const VerificationMeta('assembly');
  @override
  late final GeneratedColumn<bool> assembly = GeneratedColumn<bool>(
      'assembly', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("assembly" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _mpnMeta = const VerificationMeta('mpn');
  @override
  late final GeneratedColumn<String> mpn = GeneratedColumn<String>(
      'mpn', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        ipn,
        description,
        category,
        image,
        variant,
        template,
        assembly,
        sku,
        mpn
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'part';
  @override
  VerificationContext validateIntegrity(Insertable<PartData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('ipn')) {
      context.handle(
          _ipnMeta, ipn.isAcceptableOrUnknown(data['ipn']!, _ipnMeta));
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
    if (data.containsKey('assembly')) {
      context.handle(_assemblyMeta,
          assembly.isAcceptableOrUnknown(data['assembly']!, _assemblyMeta));
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
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      ipn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ipn']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
      variant: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}variant']),
      template: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}template'])!,
      assembly: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}assembly'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      mpn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mpn']),
    );
  }

  @override
  $PartTable createAlias(String alias) {
    return $PartTable(attachedDatabase, alias);
  }
}

class PartData extends DataClass implements Insertable<PartData> {
  final int id;
  final String name;
  final String? ipn;
  final String? description;
  final int category;
  final String? image;
  final int? variant;
  final bool template;
  final bool assembly;
  final String? sku;
  final String? mpn;
  const PartData(
      {required this.id,
      required this.name,
      this.ipn,
      this.description,
      required this.category,
      this.image,
      this.variant,
      required this.template,
      required this.assembly,
      this.sku,
      this.mpn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || ipn != null) {
      map['ipn'] = Variable<String>(ipn);
    }
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
    map['assembly'] = Variable<bool>(assembly);
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
      name: Value(name),
      ipn: ipn == null && nullToAbsent ? const Value.absent() : Value(ipn),
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
      assembly: Value(assembly),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      mpn: mpn == null && nullToAbsent ? const Value.absent() : Value(mpn),
    );
  }

  factory PartData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      ipn: serializer.fromJson<String?>(json['ipn']),
      description: serializer.fromJson<String?>(json['description']),
      category: serializer.fromJson<int>(json['category']),
      image: serializer.fromJson<String?>(json['image']),
      variant: serializer.fromJson<int?>(json['variant']),
      template: serializer.fromJson<bool>(json['template']),
      assembly: serializer.fromJson<bool>(json['assembly']),
      sku: serializer.fromJson<String?>(json['sku']),
      mpn: serializer.fromJson<String?>(json['mpn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'ipn': serializer.toJson<String?>(ipn),
      'description': serializer.toJson<String?>(description),
      'category': serializer.toJson<int>(category),
      'image': serializer.toJson<String?>(image),
      'variant': serializer.toJson<int?>(variant),
      'template': serializer.toJson<bool>(template),
      'assembly': serializer.toJson<bool>(assembly),
      'sku': serializer.toJson<String?>(sku),
      'mpn': serializer.toJson<String?>(mpn),
    };
  }

  PartData copyWith(
          {int? id,
          String? name,
          Value<String?> ipn = const Value.absent(),
          Value<String?> description = const Value.absent(),
          int? category,
          Value<String?> image = const Value.absent(),
          Value<int?> variant = const Value.absent(),
          bool? template,
          bool? assembly,
          Value<String?> sku = const Value.absent(),
          Value<String?> mpn = const Value.absent()}) =>
      PartData(
        id: id ?? this.id,
        name: name ?? this.name,
        ipn: ipn.present ? ipn.value : this.ipn,
        description: description.present ? description.value : this.description,
        category: category ?? this.category,
        image: image.present ? image.value : this.image,
        variant: variant.present ? variant.value : this.variant,
        template: template ?? this.template,
        assembly: assembly ?? this.assembly,
        sku: sku.present ? sku.value : this.sku,
        mpn: mpn.present ? mpn.value : this.mpn,
      );
  PartData copyWithCompanion(PartCompanion data) {
    return PartData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      ipn: data.ipn.present ? data.ipn.value : this.ipn,
      description:
          data.description.present ? data.description.value : this.description,
      category: data.category.present ? data.category.value : this.category,
      image: data.image.present ? data.image.value : this.image,
      variant: data.variant.present ? data.variant.value : this.variant,
      template: data.template.present ? data.template.value : this.template,
      assembly: data.assembly.present ? data.assembly.value : this.assembly,
      sku: data.sku.present ? data.sku.value : this.sku,
      mpn: data.mpn.present ? data.mpn.value : this.mpn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PartData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ipn: $ipn, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('image: $image, ')
          ..write('variant: $variant, ')
          ..write('template: $template, ')
          ..write('assembly: $assembly, ')
          ..write('sku: $sku, ')
          ..write('mpn: $mpn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, ipn, description, category, image,
      variant, template, assembly, sku, mpn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartData &&
          other.id == this.id &&
          other.name == this.name &&
          other.ipn == this.ipn &&
          other.description == this.description &&
          other.category == this.category &&
          other.image == this.image &&
          other.variant == this.variant &&
          other.template == this.template &&
          other.assembly == this.assembly &&
          other.sku == this.sku &&
          other.mpn == this.mpn);
}

class PartCompanion extends UpdateCompanion<PartData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> ipn;
  final Value<String?> description;
  final Value<int> category;
  final Value<String?> image;
  final Value<int?> variant;
  final Value<bool> template;
  final Value<bool> assembly;
  final Value<String?> sku;
  final Value<String?> mpn;
  const PartCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.ipn = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.image = const Value.absent(),
    this.variant = const Value.absent(),
    this.template = const Value.absent(),
    this.assembly = const Value.absent(),
    this.sku = const Value.absent(),
    this.mpn = const Value.absent(),
  });
  PartCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.ipn = const Value.absent(),
    this.description = const Value.absent(),
    required int category,
    this.image = const Value.absent(),
    this.variant = const Value.absent(),
    this.template = const Value.absent(),
    this.assembly = const Value.absent(),
    this.sku = const Value.absent(),
    this.mpn = const Value.absent(),
  })  : name = Value(name),
        category = Value(category);
  static Insertable<PartData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? ipn,
    Expression<String>? description,
    Expression<int>? category,
    Expression<String>? image,
    Expression<int>? variant,
    Expression<bool>? template,
    Expression<bool>? assembly,
    Expression<String>? sku,
    Expression<String>? mpn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (ipn != null) 'ipn': ipn,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (image != null) 'image': image,
      if (variant != null) 'variant': variant,
      if (template != null) 'template': template,
      if (assembly != null) 'assembly': assembly,
      if (sku != null) 'sku': sku,
      if (mpn != null) 'mpn': mpn,
    });
  }

  PartCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? ipn,
      Value<String?>? description,
      Value<int>? category,
      Value<String?>? image,
      Value<int?>? variant,
      Value<bool>? template,
      Value<bool>? assembly,
      Value<String?>? sku,
      Value<String?>? mpn}) {
    return PartCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      ipn: ipn ?? this.ipn,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      variant: variant ?? this.variant,
      template: template ?? this.template,
      assembly: assembly ?? this.assembly,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (ipn.present) {
      map['ipn'] = Variable<String>(ipn.value);
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
    if (assembly.present) {
      map['assembly'] = Variable<bool>(assembly.value);
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
          ..write('name: $name, ')
          ..write('ipn: $ipn, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('image: $image, ')
          ..write('variant: $variant, ')
          ..write('template: $template, ')
          ..write('assembly: $assembly, ')
          ..write('sku: $sku, ')
          ..write('mpn: $mpn')
          ..write(')'))
        .toString();
  }
}

class $BomPartTable extends BomPart with TableInfo<$BomPartTable, BomPartData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BomPartTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _parentMeta = const VerificationMeta('parent');
  @override
  late final GeneratedColumn<int> parent = GeneratedColumn<int>(
      'parent', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES part (id)'));
  static const VerificationMeta _partMeta = const VerificationMeta('part');
  @override
  late final GeneratedColumn<int> part = GeneratedColumn<int>(
      'part', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES part (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _referenceMeta =
      const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
      'reference', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _optionalMeta =
      const VerificationMeta('optional');
  @override
  late final GeneratedColumn<bool> optional = GeneratedColumn<bool>(
      'optional', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("optional" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _variantsMeta =
      const VerificationMeta('variants');
  @override
  late final GeneratedColumn<bool> variants = GeneratedColumn<bool>(
      'variants', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("variants" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [parent, part, amount, reference, optional, variants];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bom_part';
  @override
  VerificationContext validateIntegrity(Insertable<BomPartData> instance,
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
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    }
    if (data.containsKey('optional')) {
      context.handle(_optionalMeta,
          optional.isAcceptableOrUnknown(data['optional']!, _optionalMeta));
    }
    if (data.containsKey('variants')) {
      context.handle(_variantsMeta,
          variants.isAcceptableOrUnknown(data['variants']!, _variantsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {parent, part},
      ];
  @override
  BomPartData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BomPartData(
      parent: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent'])!,
      part: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}part'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      reference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference']),
      optional: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}optional'])!,
      variants: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}variants'])!,
    );
  }

  @override
  $BomPartTable createAlias(String alias) {
    return $BomPartTable(attachedDatabase, alias);
  }
}

class BomPartData extends DataClass implements Insertable<BomPartData> {
  final int parent;
  final int part;
  final int amount;
  final String? reference;
  final bool optional;
  final bool variants;
  const BomPartData(
      {required this.parent,
      required this.part,
      required this.amount,
      this.reference,
      required this.optional,
      required this.variants});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['parent'] = Variable<int>(parent);
    map['part'] = Variable<int>(part);
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    map['optional'] = Variable<bool>(optional);
    map['variants'] = Variable<bool>(variants);
    return map;
  }

  BomPartCompanion toCompanion(bool nullToAbsent) {
    return BomPartCompanion(
      parent: Value(parent),
      part: Value(part),
      amount: Value(amount),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      optional: Value(optional),
      variants: Value(variants),
    );
  }

  factory BomPartData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BomPartData(
      parent: serializer.fromJson<int>(json['parent']),
      part: serializer.fromJson<int>(json['part']),
      amount: serializer.fromJson<int>(json['amount']),
      reference: serializer.fromJson<String?>(json['reference']),
      optional: serializer.fromJson<bool>(json['optional']),
      variants: serializer.fromJson<bool>(json['variants']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'parent': serializer.toJson<int>(parent),
      'part': serializer.toJson<int>(part),
      'amount': serializer.toJson<int>(amount),
      'reference': serializer.toJson<String?>(reference),
      'optional': serializer.toJson<bool>(optional),
      'variants': serializer.toJson<bool>(variants),
    };
  }

  BomPartData copyWith(
          {int? parent,
          int? part,
          int? amount,
          Value<String?> reference = const Value.absent(),
          bool? optional,
          bool? variants}) =>
      BomPartData(
        parent: parent ?? this.parent,
        part: part ?? this.part,
        amount: amount ?? this.amount,
        reference: reference.present ? reference.value : this.reference,
        optional: optional ?? this.optional,
        variants: variants ?? this.variants,
      );
  BomPartData copyWithCompanion(BomPartCompanion data) {
    return BomPartData(
      parent: data.parent.present ? data.parent.value : this.parent,
      part: data.part.present ? data.part.value : this.part,
      amount: data.amount.present ? data.amount.value : this.amount,
      reference: data.reference.present ? data.reference.value : this.reference,
      optional: data.optional.present ? data.optional.value : this.optional,
      variants: data.variants.present ? data.variants.value : this.variants,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BomPartData(')
          ..write('parent: $parent, ')
          ..write('part: $part, ')
          ..write('amount: $amount, ')
          ..write('reference: $reference, ')
          ..write('optional: $optional, ')
          ..write('variants: $variants')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(parent, part, amount, reference, optional, variants);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BomPartData &&
          other.parent == this.parent &&
          other.part == this.part &&
          other.amount == this.amount &&
          other.reference == this.reference &&
          other.optional == this.optional &&
          other.variants == this.variants);
}

class BomPartCompanion extends UpdateCompanion<BomPartData> {
  final Value<int> parent;
  final Value<int> part;
  final Value<int> amount;
  final Value<String?> reference;
  final Value<bool> optional;
  final Value<bool> variants;
  final Value<int> rowid;
  const BomPartCompanion({
    this.parent = const Value.absent(),
    this.part = const Value.absent(),
    this.amount = const Value.absent(),
    this.reference = const Value.absent(),
    this.optional = const Value.absent(),
    this.variants = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BomPartCompanion.insert({
    required int parent,
    required int part,
    required int amount,
    this.reference = const Value.absent(),
    this.optional = const Value.absent(),
    this.variants = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : parent = Value(parent),
        part = Value(part),
        amount = Value(amount);
  static Insertable<BomPartData> custom({
    Expression<int>? parent,
    Expression<int>? part,
    Expression<int>? amount,
    Expression<String>? reference,
    Expression<bool>? optional,
    Expression<bool>? variants,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (parent != null) 'parent': parent,
      if (part != null) 'part': part,
      if (amount != null) 'amount': amount,
      if (reference != null) 'reference': reference,
      if (optional != null) 'optional': optional,
      if (variants != null) 'variants': variants,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BomPartCompanion copyWith(
      {Value<int>? parent,
      Value<int>? part,
      Value<int>? amount,
      Value<String?>? reference,
      Value<bool>? optional,
      Value<bool>? variants,
      Value<int>? rowid}) {
    return BomPartCompanion(
      parent: parent ?? this.parent,
      part: part ?? this.part,
      amount: amount ?? this.amount,
      reference: reference ?? this.reference,
      optional: optional ?? this.optional,
      variants: variants ?? this.variants,
      rowid: rowid ?? this.rowid,
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
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (optional.present) {
      map['optional'] = Variable<bool>(optional.value);
    }
    if (variants.present) {
      map['variants'] = Variable<bool>(variants.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BomPartCompanion(')
          ..write('parent: $parent, ')
          ..write('part: $part, ')
          ..write('amount: $amount, ')
          ..write('reference: $reference, ')
          ..write('optional: $optional, ')
          ..write('variants: $variants, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocationTable extends Location
    with TableInfo<$LocationTable, LocationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _parentMeta = const VerificationMeta('parent');
  @override
  late final GeneratedColumn<int> parent = GeneratedColumn<int>(
      'parent', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES location (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, parent, name, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'location';
  @override
  VerificationContext validateIntegrity(Insertable<LocationData> instance,
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
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocationData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      parent: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  $LocationTable createAlias(String alias) {
    return $LocationTable(attachedDatabase, alias);
  }
}

class LocationData extends DataClass implements Insertable<LocationData> {
  final int id;
  final int? parent;
  final String name;
  final String? description;
  const LocationData(
      {required this.id, this.parent, required this.name, this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || parent != null) {
      map['parent'] = Variable<int>(parent);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  LocationCompanion toCompanion(bool nullToAbsent) {
    return LocationCompanion(
      id: Value(id),
      parent:
          parent == null && nullToAbsent ? const Value.absent() : Value(parent),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory LocationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationData(
      id: serializer.fromJson<int>(json['id']),
      parent: serializer.fromJson<int?>(json['parent']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parent': serializer.toJson<int?>(parent),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
    };
  }

  LocationData copyWith(
          {int? id,
          Value<int?> parent = const Value.absent(),
          String? name,
          Value<String?> description = const Value.absent()}) =>
      LocationData(
        id: id ?? this.id,
        parent: parent.present ? parent.value : this.parent,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
      );
  LocationData copyWithCompanion(LocationCompanion data) {
    return LocationData(
      id: data.id.present ? data.id.value : this.id,
      parent: data.parent.present ? data.parent.value : this.parent,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocationData(')
          ..write('id: $id, ')
          ..write('parent: $parent, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, parent, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationData &&
          other.id == this.id &&
          other.parent == this.parent &&
          other.name == this.name &&
          other.description == this.description);
}

class LocationCompanion extends UpdateCompanion<LocationData> {
  final Value<int> id;
  final Value<int?> parent;
  final Value<String> name;
  final Value<String?> description;
  const LocationCompanion({
    this.id = const Value.absent(),
    this.parent = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  LocationCompanion.insert({
    this.id = const Value.absent(),
    this.parent = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
  }) : name = Value(name);
  static Insertable<LocationData> custom({
    Expression<int>? id,
    Expression<int>? parent,
    Expression<String>? name,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parent != null) 'parent': parent,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    });
  }

  LocationCompanion copyWith(
      {Value<int>? id,
      Value<int?>? parent,
      Value<String>? name,
      Value<String?>? description}) {
    return LocationCompanion(
      id: id ?? this.id,
      parent: parent ?? this.parent,
      name: name ?? this.name,
      description: description ?? this.description,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationCompanion(')
          ..write('id: $id, ')
          ..write('parent: $parent, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $StockTable extends Stock with TableInfo<$StockTable, StockData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _partMeta = const VerificationMeta('part');
  @override
  late final GeneratedColumn<int> part = GeneratedColumn<int>(
      'part', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES part (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<int> location = GeneratedColumn<int>(
      'location', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES location (id)'));
  static const VerificationMeta _modifiedMeta =
      const VerificationMeta('modified');
  @override
  late final GeneratedColumn<DateTime> modified = GeneratedColumn<DateTime>(
      'modified', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, part, amount, price, note, location, modified];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock';
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
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
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
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      part: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}part'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}location'])!,
      modified: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}modified'])!,
    );
  }

  @override
  $StockTable createAlias(String alias) {
    return $StockTable(attachedDatabase, alias);
  }
}

class StockData extends DataClass implements Insertable<StockData> {
  final int id;
  final int part;
  final int amount;
  final double? price;
  final String? note;
  final int location;
  final DateTime modified;
  const StockData(
      {required this.id,
      required this.part,
      required this.amount,
      this.price,
      this.note,
      required this.location,
      required this.modified});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['part'] = Variable<int>(part);
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['location'] = Variable<int>(location);
    map['modified'] = Variable<DateTime>(modified);
    return map;
  }

  StockCompanion toCompanion(bool nullToAbsent) {
    return StockCompanion(
      id: Value(id),
      part: Value(part),
      amount: Value(amount),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      location: Value(location),
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
      price: serializer.fromJson<double?>(json['price']),
      note: serializer.fromJson<String?>(json['note']),
      location: serializer.fromJson<int>(json['location']),
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
      'price': serializer.toJson<double?>(price),
      'note': serializer.toJson<String?>(note),
      'location': serializer.toJson<int>(location),
      'modified': serializer.toJson<DateTime>(modified),
    };
  }

  StockData copyWith(
          {int? id,
          int? part,
          int? amount,
          Value<double?> price = const Value.absent(),
          Value<String?> note = const Value.absent(),
          int? location,
          DateTime? modified}) =>
      StockData(
        id: id ?? this.id,
        part: part ?? this.part,
        amount: amount ?? this.amount,
        price: price.present ? price.value : this.price,
        note: note.present ? note.value : this.note,
        location: location ?? this.location,
        modified: modified ?? this.modified,
      );
  StockData copyWithCompanion(StockCompanion data) {
    return StockData(
      id: data.id.present ? data.id.value : this.id,
      part: data.part.present ? data.part.value : this.part,
      amount: data.amount.present ? data.amount.value : this.amount,
      price: data.price.present ? data.price.value : this.price,
      note: data.note.present ? data.note.value : this.note,
      location: data.location.present ? data.location.value : this.location,
      modified: data.modified.present ? data.modified.value : this.modified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockData(')
          ..write('id: $id, ')
          ..write('part: $part, ')
          ..write('amount: $amount, ')
          ..write('price: $price, ')
          ..write('note: $note, ')
          ..write('location: $location, ')
          ..write('modified: $modified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, part, amount, price, note, location, modified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockData &&
          other.id == this.id &&
          other.part == this.part &&
          other.amount == this.amount &&
          other.price == this.price &&
          other.note == this.note &&
          other.location == this.location &&
          other.modified == this.modified);
}

class StockCompanion extends UpdateCompanion<StockData> {
  final Value<int> id;
  final Value<int> part;
  final Value<int> amount;
  final Value<double?> price;
  final Value<String?> note;
  final Value<int> location;
  final Value<DateTime> modified;
  const StockCompanion({
    this.id = const Value.absent(),
    this.part = const Value.absent(),
    this.amount = const Value.absent(),
    this.price = const Value.absent(),
    this.note = const Value.absent(),
    this.location = const Value.absent(),
    this.modified = const Value.absent(),
  });
  StockCompanion.insert({
    this.id = const Value.absent(),
    required int part,
    required int amount,
    this.price = const Value.absent(),
    this.note = const Value.absent(),
    required int location,
    this.modified = const Value.absent(),
  })  : part = Value(part),
        amount = Value(amount),
        location = Value(location);
  static Insertable<StockData> custom({
    Expression<int>? id,
    Expression<int>? part,
    Expression<int>? amount,
    Expression<double>? price,
    Expression<String>? note,
    Expression<int>? location,
    Expression<DateTime>? modified,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (part != null) 'part': part,
      if (amount != null) 'amount': amount,
      if (price != null) 'price': price,
      if (note != null) 'note': note,
      if (location != null) 'location': location,
      if (modified != null) 'modified': modified,
    });
  }

  StockCompanion copyWith(
      {Value<int>? id,
      Value<int>? part,
      Value<int>? amount,
      Value<double?>? price,
      Value<String?>? note,
      Value<int>? location,
      Value<DateTime>? modified}) {
    return StockCompanion(
      id: id ?? this.id,
      part: part ?? this.part,
      amount: amount ?? this.amount,
      price: price ?? this.price,
      note: note ?? this.note,
      location: location ?? this.location,
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
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (location.present) {
      map['location'] = Variable<int>(location.value);
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
          ..write('price: $price, ')
          ..write('note: $note, ')
          ..write('location: $location, ')
          ..write('modified: $modified')
          ..write(')'))
        .toString();
  }
}

class $StockTrackingTable extends StockTracking
    with TableInfo<$StockTrackingTable, StockTrackingData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockTrackingTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
      'stock', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES stock (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, notes, date, amount, stock];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_tracking';
  @override
  VerificationContext validateIntegrity(Insertable<StockTrackingData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('stock')) {
      context.handle(
          _stockMeta, stock.isAcceptableOrUnknown(data['stock']!, _stockMeta));
    } else if (isInserting) {
      context.missing(_stockMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockTrackingData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockTrackingData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      stock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock'])!,
    );
  }

  @override
  $StockTrackingTable createAlias(String alias) {
    return $StockTrackingTable(attachedDatabase, alias);
  }
}

class StockTrackingData extends DataClass
    implements Insertable<StockTrackingData> {
  final int id;
  final String notes;
  final DateTime date;
  final int amount;
  final int stock;
  const StockTrackingData(
      {required this.id,
      required this.notes,
      required this.date,
      required this.amount,
      required this.stock});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['notes'] = Variable<String>(notes);
    map['date'] = Variable<DateTime>(date);
    map['amount'] = Variable<int>(amount);
    map['stock'] = Variable<int>(stock);
    return map;
  }

  StockTrackingCompanion toCompanion(bool nullToAbsent) {
    return StockTrackingCompanion(
      id: Value(id),
      notes: Value(notes),
      date: Value(date),
      amount: Value(amount),
      stock: Value(stock),
    );
  }

  factory StockTrackingData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockTrackingData(
      id: serializer.fromJson<int>(json['id']),
      notes: serializer.fromJson<String>(json['notes']),
      date: serializer.fromJson<DateTime>(json['date']),
      amount: serializer.fromJson<int>(json['amount']),
      stock: serializer.fromJson<int>(json['stock']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'notes': serializer.toJson<String>(notes),
      'date': serializer.toJson<DateTime>(date),
      'amount': serializer.toJson<int>(amount),
      'stock': serializer.toJson<int>(stock),
    };
  }

  StockTrackingData copyWith(
          {int? id, String? notes, DateTime? date, int? amount, int? stock}) =>
      StockTrackingData(
        id: id ?? this.id,
        notes: notes ?? this.notes,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        stock: stock ?? this.stock,
      );
  StockTrackingData copyWithCompanion(StockTrackingCompanion data) {
    return StockTrackingData(
      id: data.id.present ? data.id.value : this.id,
      notes: data.notes.present ? data.notes.value : this.notes,
      date: data.date.present ? data.date.value : this.date,
      amount: data.amount.present ? data.amount.value : this.amount,
      stock: data.stock.present ? data.stock.value : this.stock,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockTrackingData(')
          ..write('id: $id, ')
          ..write('notes: $notes, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('stock: $stock')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, notes, date, amount, stock);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockTrackingData &&
          other.id == this.id &&
          other.notes == this.notes &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.stock == this.stock);
}

class StockTrackingCompanion extends UpdateCompanion<StockTrackingData> {
  final Value<int> id;
  final Value<String> notes;
  final Value<DateTime> date;
  final Value<int> amount;
  final Value<int> stock;
  const StockTrackingCompanion({
    this.id = const Value.absent(),
    this.notes = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.stock = const Value.absent(),
  });
  StockTrackingCompanion.insert({
    this.id = const Value.absent(),
    required String notes,
    this.date = const Value.absent(),
    required int amount,
    required int stock,
  })  : notes = Value(notes),
        amount = Value(amount),
        stock = Value(stock);
  static Insertable<StockTrackingData> custom({
    Expression<int>? id,
    Expression<String>? notes,
    Expression<DateTime>? date,
    Expression<int>? amount,
    Expression<int>? stock,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (notes != null) 'notes': notes,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (stock != null) 'stock': stock,
    });
  }

  StockTrackingCompanion copyWith(
      {Value<int>? id,
      Value<String>? notes,
      Value<DateTime>? date,
      Value<int>? amount,
      Value<int>? stock}) {
    return StockTrackingCompanion(
      id: id ?? this.id,
      notes: notes ?? this.notes,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      stock: stock ?? this.stock,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockTrackingCompanion(')
          ..write('id: $id, ')
          ..write('notes: $notes, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('stock: $stock')
          ..write(')'))
        .toString();
  }
}

class $BuildOrderTable extends BuildOrder
    with TableInfo<$BuildOrderTable, BuildOrderData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BuildOrderTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _referenceMeta =
      const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
      'reference', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _partMeta = const VerificationMeta('part');
  @override
  late final GeneratedColumn<int> part = GeneratedColumn<int>(
      'part', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES part (id)'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _destinationMeta =
      const VerificationMeta('destination');
  @override
  late final GeneratedColumn<int> destination = GeneratedColumn<int>(
      'destination', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES location (id)'));
  static const VerificationMeta _createdMeta =
      const VerificationMeta('created');
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
      'created', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<DateTime> completed = GeneratedColumn<DateTime>(
      'completed', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        reference,
        part,
        description,
        amount,
        destination,
        created,
        completed
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'build_order';
  @override
  VerificationContext validateIntegrity(Insertable<BuildOrderData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('part')) {
      context.handle(
          _partMeta, part.isAcceptableOrUnknown(data['part']!, _partMeta));
    } else if (isInserting) {
      context.missing(_partMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('destination')) {
      context.handle(
          _destinationMeta,
          destination.isAcceptableOrUnknown(
              data['destination']!, _destinationMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BuildOrderData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BuildOrderData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      reference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference'])!,
      part: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}part'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      destination: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}destination']),
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created'])!,
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed']),
    );
  }

  @override
  $BuildOrderTable createAlias(String alias) {
    return $BuildOrderTable(attachedDatabase, alias);
  }
}

class BuildOrderData extends DataClass implements Insertable<BuildOrderData> {
  final int id;
  final String reference;
  final int part;
  final String? description;
  final int amount;
  final int? destination;
  final DateTime created;
  final DateTime? completed;
  const BuildOrderData(
      {required this.id,
      required this.reference,
      required this.part,
      this.description,
      required this.amount,
      this.destination,
      required this.created,
      this.completed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['reference'] = Variable<String>(reference);
    map['part'] = Variable<int>(part);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || destination != null) {
      map['destination'] = Variable<int>(destination);
    }
    map['created'] = Variable<DateTime>(created);
    if (!nullToAbsent || completed != null) {
      map['completed'] = Variable<DateTime>(completed);
    }
    return map;
  }

  BuildOrderCompanion toCompanion(bool nullToAbsent) {
    return BuildOrderCompanion(
      id: Value(id),
      reference: Value(reference),
      part: Value(part),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      amount: Value(amount),
      destination: destination == null && nullToAbsent
          ? const Value.absent()
          : Value(destination),
      created: Value(created),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
    );
  }

  factory BuildOrderData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BuildOrderData(
      id: serializer.fromJson<int>(json['id']),
      reference: serializer.fromJson<String>(json['reference']),
      part: serializer.fromJson<int>(json['part']),
      description: serializer.fromJson<String?>(json['description']),
      amount: serializer.fromJson<int>(json['amount']),
      destination: serializer.fromJson<int?>(json['destination']),
      created: serializer.fromJson<DateTime>(json['created']),
      completed: serializer.fromJson<DateTime?>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reference': serializer.toJson<String>(reference),
      'part': serializer.toJson<int>(part),
      'description': serializer.toJson<String?>(description),
      'amount': serializer.toJson<int>(amount),
      'destination': serializer.toJson<int?>(destination),
      'created': serializer.toJson<DateTime>(created),
      'completed': serializer.toJson<DateTime?>(completed),
    };
  }

  BuildOrderData copyWith(
          {int? id,
          String? reference,
          int? part,
          Value<String?> description = const Value.absent(),
          int? amount,
          Value<int?> destination = const Value.absent(),
          DateTime? created,
          Value<DateTime?> completed = const Value.absent()}) =>
      BuildOrderData(
        id: id ?? this.id,
        reference: reference ?? this.reference,
        part: part ?? this.part,
        description: description.present ? description.value : this.description,
        amount: amount ?? this.amount,
        destination: destination.present ? destination.value : this.destination,
        created: created ?? this.created,
        completed: completed.present ? completed.value : this.completed,
      );
  BuildOrderData copyWithCompanion(BuildOrderCompanion data) {
    return BuildOrderData(
      id: data.id.present ? data.id.value : this.id,
      reference: data.reference.present ? data.reference.value : this.reference,
      part: data.part.present ? data.part.value : this.part,
      description:
          data.description.present ? data.description.value : this.description,
      amount: data.amount.present ? data.amount.value : this.amount,
      destination:
          data.destination.present ? data.destination.value : this.destination,
      created: data.created.present ? data.created.value : this.created,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BuildOrderData(')
          ..write('id: $id, ')
          ..write('reference: $reference, ')
          ..write('part: $part, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('destination: $destination, ')
          ..write('created: $created, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, reference, part, description, amount,
      destination, created, completed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BuildOrderData &&
          other.id == this.id &&
          other.reference == this.reference &&
          other.part == this.part &&
          other.description == this.description &&
          other.amount == this.amount &&
          other.destination == this.destination &&
          other.created == this.created &&
          other.completed == this.completed);
}

class BuildOrderCompanion extends UpdateCompanion<BuildOrderData> {
  final Value<int> id;
  final Value<String> reference;
  final Value<int> part;
  final Value<String?> description;
  final Value<int> amount;
  final Value<int?> destination;
  final Value<DateTime> created;
  final Value<DateTime?> completed;
  const BuildOrderCompanion({
    this.id = const Value.absent(),
    this.reference = const Value.absent(),
    this.part = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.destination = const Value.absent(),
    this.created = const Value.absent(),
    this.completed = const Value.absent(),
  });
  BuildOrderCompanion.insert({
    this.id = const Value.absent(),
    required String reference,
    required int part,
    this.description = const Value.absent(),
    required int amount,
    this.destination = const Value.absent(),
    this.created = const Value.absent(),
    this.completed = const Value.absent(),
  })  : reference = Value(reference),
        part = Value(part),
        amount = Value(amount);
  static Insertable<BuildOrderData> custom({
    Expression<int>? id,
    Expression<String>? reference,
    Expression<int>? part,
    Expression<String>? description,
    Expression<int>? amount,
    Expression<int>? destination,
    Expression<DateTime>? created,
    Expression<DateTime>? completed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reference != null) 'reference': reference,
      if (part != null) 'part': part,
      if (description != null) 'description': description,
      if (amount != null) 'amount': amount,
      if (destination != null) 'destination': destination,
      if (created != null) 'created': created,
      if (completed != null) 'completed': completed,
    });
  }

  BuildOrderCompanion copyWith(
      {Value<int>? id,
      Value<String>? reference,
      Value<int>? part,
      Value<String?>? description,
      Value<int>? amount,
      Value<int?>? destination,
      Value<DateTime>? created,
      Value<DateTime?>? completed}) {
    return BuildOrderCompanion(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      part: part ?? this.part,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      destination: destination ?? this.destination,
      created: created ?? this.created,
      completed: completed ?? this.completed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (part.present) {
      map['part'] = Variable<int>(part.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (destination.present) {
      map['destination'] = Variable<int>(destination.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (completed.present) {
      map['completed'] = Variable<DateTime>(completed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BuildOrderCompanion(')
          ..write('id: $id, ')
          ..write('reference: $reference, ')
          ..write('part: $part, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('destination: $destination, ')
          ..write('created: $created, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }
}

class $StockAllocationTable extends StockAllocation
    with TableInfo<$StockAllocationTable, StockAllocationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockAllocationTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
      'stock', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES stock (id)'));
  static const VerificationMeta _buildOrderMeta =
      const VerificationMeta('buildOrder');
  @override
  late final GeneratedColumn<int> buildOrder = GeneratedColumn<int>(
      'build_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES build_order (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [stock, buildOrder, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_allocation';
  @override
  VerificationContext validateIntegrity(
      Insertable<StockAllocationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('stock')) {
      context.handle(
          _stockMeta, stock.isAcceptableOrUnknown(data['stock']!, _stockMeta));
    } else if (isInserting) {
      context.missing(_stockMeta);
    }
    if (data.containsKey('build_order')) {
      context.handle(
          _buildOrderMeta,
          buildOrder.isAcceptableOrUnknown(
              data['build_order']!, _buildOrderMeta));
    } else if (isInserting) {
      context.missing(_buildOrderMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  StockAllocationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockAllocationData(
      stock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock'])!,
      buildOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}build_order'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
    );
  }

  @override
  $StockAllocationTable createAlias(String alias) {
    return $StockAllocationTable(attachedDatabase, alias);
  }
}

class StockAllocationData extends DataClass
    implements Insertable<StockAllocationData> {
  final int stock;
  final int buildOrder;
  final int amount;
  const StockAllocationData(
      {required this.stock, required this.buildOrder, required this.amount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['stock'] = Variable<int>(stock);
    map['build_order'] = Variable<int>(buildOrder);
    map['amount'] = Variable<int>(amount);
    return map;
  }

  StockAllocationCompanion toCompanion(bool nullToAbsent) {
    return StockAllocationCompanion(
      stock: Value(stock),
      buildOrder: Value(buildOrder),
      amount: Value(amount),
    );
  }

  factory StockAllocationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockAllocationData(
      stock: serializer.fromJson<int>(json['stock']),
      buildOrder: serializer.fromJson<int>(json['buildOrder']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'stock': serializer.toJson<int>(stock),
      'buildOrder': serializer.toJson<int>(buildOrder),
      'amount': serializer.toJson<int>(amount),
    };
  }

  StockAllocationData copyWith({int? stock, int? buildOrder, int? amount}) =>
      StockAllocationData(
        stock: stock ?? this.stock,
        buildOrder: buildOrder ?? this.buildOrder,
        amount: amount ?? this.amount,
      );
  StockAllocationData copyWithCompanion(StockAllocationCompanion data) {
    return StockAllocationData(
      stock: data.stock.present ? data.stock.value : this.stock,
      buildOrder:
          data.buildOrder.present ? data.buildOrder.value : this.buildOrder,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockAllocationData(')
          ..write('stock: $stock, ')
          ..write('buildOrder: $buildOrder, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(stock, buildOrder, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockAllocationData &&
          other.stock == this.stock &&
          other.buildOrder == this.buildOrder &&
          other.amount == this.amount);
}

class StockAllocationCompanion extends UpdateCompanion<StockAllocationData> {
  final Value<int> stock;
  final Value<int> buildOrder;
  final Value<int> amount;
  final Value<int> rowid;
  const StockAllocationCompanion({
    this.stock = const Value.absent(),
    this.buildOrder = const Value.absent(),
    this.amount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockAllocationCompanion.insert({
    required int stock,
    required int buildOrder,
    required int amount,
    this.rowid = const Value.absent(),
  })  : stock = Value(stock),
        buildOrder = Value(buildOrder),
        amount = Value(amount);
  static Insertable<StockAllocationData> custom({
    Expression<int>? stock,
    Expression<int>? buildOrder,
    Expression<int>? amount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (stock != null) 'stock': stock,
      if (buildOrder != null) 'build_order': buildOrder,
      if (amount != null) 'amount': amount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockAllocationCompanion copyWith(
      {Value<int>? stock,
      Value<int>? buildOrder,
      Value<int>? amount,
      Value<int>? rowid}) {
    return StockAllocationCompanion(
      stock: stock ?? this.stock,
      buildOrder: buildOrder ?? this.buildOrder,
      amount: amount ?? this.amount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    if (buildOrder.present) {
      map['build_order'] = Variable<int>(buildOrder.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockAllocationCompanion(')
          ..write('stock: $stock, ')
          ..write('buildOrder: $buildOrder, ')
          ..write('amount: $amount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $CategoryTable category = $CategoryTable(this);
  late final $PartTable part = $PartTable(this);
  late final $BomPartTable bomPart = $BomPartTable(this);
  late final $LocationTable location = $LocationTable(this);
  late final $StockTable stock = $StockTable(this);
  late final $StockTrackingTable stockTracking = $StockTrackingTable(this);
  late final $BuildOrderTable buildOrder = $BuildOrderTable(this);
  late final $StockAllocationTable stockAllocation =
      $StockAllocationTable(this);
  Selectable<String> getParentCategoryNames(int var1) {
    return customSelect(
        'WITH RECURSIVE ParentCategory (i, p, n) AS (SELECT id, parent, name FROM category WHERE id = ?1 UNION ALL SELECT id, parent, name FROM category JOIN ParentCategory ON ParentCategory.p = category.id) SELECT n AS name FROM ParentCategory ORDER BY p',
        variables: [
          Variable<int>(var1)
        ],
        readsFrom: {
          category,
        }).map((QueryRow row) => row.read<String>('name'));
  }

  Selectable<CategoryData> getParentCategories(int var1) {
    return customSelect(
        'WITH RECURSIVE ParentCategory (i, p, n, d, k) AS (SELECT id, parent, name, description, keywords FROM category WHERE id = ?1 UNION ALL SELECT id, parent, name, description, keywords FROM category JOIN ParentCategory ON ParentCategory.p = category.id) SELECT i AS id, p AS parent, n AS name, d AS description, k AS keywords FROM ParentCategory ORDER BY p',
        variables: [
          Variable<int>(var1)
        ],
        readsFrom: {
          category,
        }).asyncMap(category.mapFromRow);
  }

  Selectable<GetPartsOfChildCategoriesResult> getPartsOfChildCategories(
      int var1) {
    return customSelect(
        'WITH RECURSIVE ParentCategory (i, p, n) AS (SELECT id, parent, name FROM category WHERE id = ?1 UNION ALL SELECT id, parent, name FROM category JOIN ParentCategory ON ParentCategory.i = category.parent) SELECT p.*, c.id AS cId, c.parent AS cParent, c.name AS cName, c.description AS cDescription, c.keywords AS cKeywords FROM part AS p JOIN category AS c ON p.category = c.id WHERE p.category IN (SELECT i FROM ParentCategory) ORDER BY p.category',
        variables: [
          Variable<int>(var1)
        ],
        readsFrom: {
          category,
          part,
        }).map((QueryRow row) => GetPartsOfChildCategoriesResult(
          id: row.read<int>('id'),
          name: row.read<String>('name'),
          ipn: row.readNullable<String>('ipn'),
          description: row.readNullable<String>('description'),
          category: row.read<int>('category'),
          image: row.readNullable<String>('image'),
          variant: row.readNullable<int>('variant'),
          template: row.read<bool>('template'),
          assembly: row.read<bool>('assembly'),
          sku: row.readNullable<String>('sku'),
          mpn: row.readNullable<String>('mpn'),
          cId: row.read<int>('cId'),
          cParent: row.readNullable<int>('cParent'),
          cName: row.read<String>('cName'),
          cDescription: row.read<String>('cDescription'),
          cKeywords: row.readNullable<String>('cKeywords'),
        ));
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        category,
        part,
        bomPart,
        location,
        stock,
        stockTracking,
        buildOrder,
        stockAllocation
      ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$CategoryTableCreateCompanionBuilder = CategoryCompanion Function({
  Value<int> id,
  Value<int?> parent,
  required String name,
  required String description,
  Value<String?> keywords,
});
typedef $$CategoryTableUpdateCompanionBuilder = CategoryCompanion Function({
  Value<int> id,
  Value<int?> parent,
  Value<String> name,
  Value<String> description,
  Value<String?> keywords,
});

final class $$CategoryTableReferences
    extends BaseReferences<_$Database, $CategoryTable, CategoryData> {
  $$CategoryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoryTable _parentTable(_$Database db) => db.category
      .createAlias($_aliasNameGenerator(db.category.parent, db.category.id));

  $$CategoryTableProcessedTableManager? get parent {
    final $_column = $_itemColumn<int>('parent');
    if ($_column == null) return null;
    final manager = $$CategoryTableTableManager($_db, $_db.category)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PartTable, List<PartData>> _partRefsTable(
          _$Database db) =>
      MultiTypedResultKey.fromTable(db.part,
          aliasName: $_aliasNameGenerator(db.category.id, db.part.category));

  $$PartTableProcessedTableManager get partRefs {
    final manager = $$PartTableTableManager($_db, $_db.part)
        .filter((f) => f.category.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_partRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoryTableFilterComposer
    extends Composer<_$Database, $CategoryTable> {
  $$CategoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get keywords => $composableBuilder(
      column: $table.keywords, builder: (column) => ColumnFilters(column));

  $$CategoryTableFilterComposer get parent {
    final $$CategoryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parent,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableFilterComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> partRefs(
      Expression<bool> Function($$PartTableFilterComposer f) f) {
    final $$PartTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.category,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableFilterComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoryTableOrderingComposer
    extends Composer<_$Database, $CategoryTable> {
  $$CategoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get keywords => $composableBuilder(
      column: $table.keywords, builder: (column) => ColumnOrderings(column));

  $$CategoryTableOrderingComposer get parent {
    final $$CategoryTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parent,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableOrderingComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CategoryTableAnnotationComposer
    extends Composer<_$Database, $CategoryTable> {
  $$CategoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get keywords =>
      $composableBuilder(column: $table.keywords, builder: (column) => column);

  $$CategoryTableAnnotationComposer get parent {
    final $$CategoryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parent,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableAnnotationComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> partRefs<T extends Object>(
      Expression<T> Function($$PartTableAnnotationComposer a) f) {
    final $$PartTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.category,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableAnnotationComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoryTableTableManager extends RootTableManager<
    _$Database,
    $CategoryTable,
    CategoryData,
    $$CategoryTableFilterComposer,
    $$CategoryTableOrderingComposer,
    $$CategoryTableAnnotationComposer,
    $$CategoryTableCreateCompanionBuilder,
    $$CategoryTableUpdateCompanionBuilder,
    (CategoryData, $$CategoryTableReferences),
    CategoryData,
    PrefetchHooks Function({bool parent, bool partRefs})> {
  $$CategoryTableTableManager(_$Database db, $CategoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> parent = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String?> keywords = const Value.absent(),
          }) =>
              CategoryCompanion(
            id: id,
            parent: parent,
            name: name,
            description: description,
            keywords: keywords,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> parent = const Value.absent(),
            required String name,
            required String description,
            Value<String?> keywords = const Value.absent(),
          }) =>
              CategoryCompanion.insert(
            id: id,
            parent: parent,
            name: name,
            description: description,
            keywords: keywords,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CategoryTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({parent = false, partRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (partRefs) db.part],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (parent) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.parent,
                    referencedTable: $$CategoryTableReferences._parentTable(db),
                    referencedColumn:
                        $$CategoryTableReferences._parentTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (partRefs)
                    await $_getPrefetchedData<CategoryData, $CategoryTable,
                            PartData>(
                        currentTable: table,
                        referencedTable:
                            $$CategoryTableReferences._partRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoryTableReferences(db, table, p0).partRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.category == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CategoryTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $CategoryTable,
    CategoryData,
    $$CategoryTableFilterComposer,
    $$CategoryTableOrderingComposer,
    $$CategoryTableAnnotationComposer,
    $$CategoryTableCreateCompanionBuilder,
    $$CategoryTableUpdateCompanionBuilder,
    (CategoryData, $$CategoryTableReferences),
    CategoryData,
    PrefetchHooks Function({bool parent, bool partRefs})>;
typedef $$PartTableCreateCompanionBuilder = PartCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> ipn,
  Value<String?> description,
  required int category,
  Value<String?> image,
  Value<int?> variant,
  Value<bool> template,
  Value<bool> assembly,
  Value<String?> sku,
  Value<String?> mpn,
});
typedef $$PartTableUpdateCompanionBuilder = PartCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> ipn,
  Value<String?> description,
  Value<int> category,
  Value<String?> image,
  Value<int?> variant,
  Value<bool> template,
  Value<bool> assembly,
  Value<String?> sku,
  Value<String?> mpn,
});

final class $$PartTableReferences
    extends BaseReferences<_$Database, $PartTable, PartData> {
  $$PartTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoryTable _categoryTable(_$Database db) => db.category
      .createAlias($_aliasNameGenerator(db.part.category, db.category.id));

  $$CategoryTableProcessedTableManager get category {
    final $_column = $_itemColumn<int>('category')!;

    final manager = $$CategoryTableTableManager($_db, $_db.category)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PartTable _variantTable(_$Database db) =>
      db.part.createAlias($_aliasNameGenerator(db.part.variant, db.part.id));

  $$PartTableProcessedTableManager? get variant {
    final $_column = $_itemColumn<int>('variant');
    if ($_column == null) return null;
    final manager = $$PartTableTableManager($_db, $_db.part)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_variantTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$BomPartTable, List<BomPartData>> _parentTable(
          _$Database db) =>
      MultiTypedResultKey.fromTable(db.bomPart,
          aliasName: $_aliasNameGenerator(db.part.id, db.bomPart.parent));

  $$BomPartTableProcessedTableManager get parent {
    final manager = $$BomPartTableTableManager($_db, $_db.bomPart)
        .filter((f) => f.parent.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_parentTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BomPartTable, List<BomPartData>> _partTable(
          _$Database db) =>
      MultiTypedResultKey.fromTable(db.bomPart,
          aliasName: $_aliasNameGenerator(db.part.id, db.bomPart.part));

  $$BomPartTableProcessedTableManager get part {
    final manager = $$BomPartTableTableManager($_db, $_db.bomPart)
        .filter((f) => f.part.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_partTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$StockTable, List<StockData>> _stockRefsTable(
          _$Database db) =>
      MultiTypedResultKey.fromTable(db.stock,
          aliasName: $_aliasNameGenerator(db.part.id, db.stock.part));

  $$StockTableProcessedTableManager get stockRefs {
    final manager = $$StockTableTableManager($_db, $_db.stock)
        .filter((f) => f.part.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BuildOrderTable, List<BuildOrderData>>
      _buildOrderRefsTable(_$Database db) =>
          MultiTypedResultKey.fromTable(db.buildOrder,
              aliasName: $_aliasNameGenerator(db.part.id, db.buildOrder.part));

  $$BuildOrderTableProcessedTableManager get buildOrderRefs {
    final manager = $$BuildOrderTableTableManager($_db, $_db.buildOrder)
        .filter((f) => f.part.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_buildOrderRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PartTableFilterComposer extends Composer<_$Database, $PartTable> {
  $$PartTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ipn => $composableBuilder(
      column: $table.ipn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get template => $composableBuilder(
      column: $table.template, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get assembly => $composableBuilder(
      column: $table.assembly, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mpn => $composableBuilder(
      column: $table.mpn, builder: (column) => ColumnFilters(column));

  $$CategoryTableFilterComposer get category {
    final $$CategoryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.category,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableFilterComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PartTableFilterComposer get variant {
    final $$PartTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.variant,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableFilterComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> parent(
      Expression<bool> Function($$BomPartTableFilterComposer f) f) {
    final $$BomPartTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bomPart,
        getReferencedColumn: (t) => t.parent,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BomPartTableFilterComposer(
              $db: $db,
              $table: $db.bomPart,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> part(
      Expression<bool> Function($$BomPartTableFilterComposer f) f) {
    final $$BomPartTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bomPart,
        getReferencedColumn: (t) => t.part,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BomPartTableFilterComposer(
              $db: $db,
              $table: $db.bomPart,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> stockRefs(
      Expression<bool> Function($$StockTableFilterComposer f) f) {
    final $$StockTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stock,
        getReferencedColumn: (t) => t.part,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StockTableFilterComposer(
              $db: $db,
              $table: $db.stock,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> buildOrderRefs(
      Expression<bool> Function($$BuildOrderTableFilterComposer f) f) {
    final $$BuildOrderTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.buildOrder,
        getReferencedColumn: (t) => t.part,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BuildOrderTableFilterComposer(
              $db: $db,
              $table: $db.buildOrder,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PartTableOrderingComposer extends Composer<_$Database, $PartTable> {
  $$PartTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ipn => $composableBuilder(
      column: $table.ipn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get template => $composableBuilder(
      column: $table.template, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get assembly => $composableBuilder(
      column: $table.assembly, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mpn => $composableBuilder(
      column: $table.mpn, builder: (column) => ColumnOrderings(column));

  $$CategoryTableOrderingComposer get category {
    final $$CategoryTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.category,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableOrderingComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PartTableOrderingComposer get variant {
    final $$PartTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.variant,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableOrderingComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PartTableAnnotationComposer extends Composer<_$Database, $PartTable> {
  $$PartTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get ipn =>
      $composableBuilder(column: $table.ipn, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<bool> get template =>
      $composableBuilder(column: $table.template, builder: (column) => column);

  GeneratedColumn<bool> get assembly =>
      $composableBuilder(column: $table.assembly, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get mpn =>
      $composableBuilder(column: $table.mpn, builder: (column) => column);

  $$CategoryTableAnnotationComposer get category {
    final $$CategoryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.category,
        referencedTable: $db.category,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableAnnotationComposer(
              $db: $db,
              $table: $db.category,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PartTableAnnotationComposer get variant {
    final $$PartTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.variant,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableAnnotationComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> parent<T extends Object>(
      Expression<T> Function($$BomPartTableAnnotationComposer a) f) {
    final $$BomPartTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bomPart,
        getReferencedColumn: (t) => t.parent,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BomPartTableAnnotationComposer(
              $db: $db,
              $table: $db.bomPart,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> part<T extends Object>(
      Expression<T> Function($$BomPartTableAnnotationComposer a) f) {
    final $$BomPartTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bomPart,
        getReferencedColumn: (t) => t.part,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BomPartTableAnnotationComposer(
              $db: $db,
              $table: $db.bomPart,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> stockRefs<T extends Object>(
      Expression<T> Function($$StockTableAnnotationComposer a) f) {
    final $$StockTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stock,
        getReferencedColumn: (t) => t.part,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StockTableAnnotationComposer(
              $db: $db,
              $table: $db.stock,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> buildOrderRefs<T extends Object>(
      Expression<T> Function($$BuildOrderTableAnnotationComposer a) f) {
    final $$BuildOrderTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.buildOrder,
        getReferencedColumn: (t) => t.part,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BuildOrderTableAnnotationComposer(
              $db: $db,
              $table: $db.buildOrder,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PartTableTableManager extends RootTableManager<
    _$Database,
    $PartTable,
    PartData,
    $$PartTableFilterComposer,
    $$PartTableOrderingComposer,
    $$PartTableAnnotationComposer,
    $$PartTableCreateCompanionBuilder,
    $$PartTableUpdateCompanionBuilder,
    (PartData, $$PartTableReferences),
    PartData,
    PrefetchHooks Function(
        {bool category,
        bool variant,
        bool parent,
        bool part,
        bool stockRefs,
        bool buildOrderRefs})> {
  $$PartTableTableManager(_$Database db, $PartTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PartTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PartTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PartTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> ipn = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> category = const Value.absent(),
            Value<String?> image = const Value.absent(),
            Value<int?> variant = const Value.absent(),
            Value<bool> template = const Value.absent(),
            Value<bool> assembly = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<String?> mpn = const Value.absent(),
          }) =>
              PartCompanion(
            id: id,
            name: name,
            ipn: ipn,
            description: description,
            category: category,
            image: image,
            variant: variant,
            template: template,
            assembly: assembly,
            sku: sku,
            mpn: mpn,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> ipn = const Value.absent(),
            Value<String?> description = const Value.absent(),
            required int category,
            Value<String?> image = const Value.absent(),
            Value<int?> variant = const Value.absent(),
            Value<bool> template = const Value.absent(),
            Value<bool> assembly = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<String?> mpn = const Value.absent(),
          }) =>
              PartCompanion.insert(
            id: id,
            name: name,
            ipn: ipn,
            description: description,
            category: category,
            image: image,
            variant: variant,
            template: template,
            assembly: assembly,
            sku: sku,
            mpn: mpn,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PartTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {category = false,
              variant = false,
              parent = false,
              part = false,
              stockRefs = false,
              buildOrderRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (parent) db.bomPart,
                if (part) db.bomPart,
                if (stockRefs) db.stock,
                if (buildOrderRefs) db.buildOrder
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (category) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.category,
                    referencedTable: $$PartTableReferences._categoryTable(db),
                    referencedColumn:
                        $$PartTableReferences._categoryTable(db).id,
                  ) as T;
                }
                if (variant) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.variant,
                    referencedTable: $$PartTableReferences._variantTable(db),
                    referencedColumn:
                        $$PartTableReferences._variantTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (parent)
                    await $_getPrefetchedData<PartData, $PartTable,
                            BomPartData>(
                        currentTable: table,
                        referencedTable: $$PartTableReferences._parentTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PartTableReferences(db, table, p0).parent,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.parent == item.id),
                        typedResults: items),
                  if (part)
                    await $_getPrefetchedData<PartData, $PartTable,
                            BomPartData>(
                        currentTable: table,
                        referencedTable: $$PartTableReferences._partTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PartTableReferences(db, table, p0).part,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) =>
                                referencedItems.where((e) => e.part == item.id),
                        typedResults: items),
                  if (stockRefs)
                    await $_getPrefetchedData<PartData, $PartTable, StockData>(
                        currentTable: table,
                        referencedTable:
                            $$PartTableReferences._stockRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PartTableReferences(db, table, p0).stockRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) =>
                                referencedItems.where((e) => e.part == item.id),
                        typedResults: items),
                  if (buildOrderRefs)
                    await $_getPrefetchedData<PartData, $PartTable,
                            BuildOrderData>(
                        currentTable: table,
                        referencedTable:
                            $$PartTableReferences._buildOrderRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PartTableReferences(db, table, p0).buildOrderRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) =>
                                referencedItems.where((e) => e.part == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PartTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $PartTable,
    PartData,
    $$PartTableFilterComposer,
    $$PartTableOrderingComposer,
    $$PartTableAnnotationComposer,
    $$PartTableCreateCompanionBuilder,
    $$PartTableUpdateCompanionBuilder,
    (PartData, $$PartTableReferences),
    PartData,
    PrefetchHooks Function(
        {bool category,
        bool variant,
        bool parent,
        bool part,
        bool stockRefs,
        bool buildOrderRefs})>;
typedef $$BomPartTableCreateCompanionBuilder = BomPartCompanion Function({
  required int parent,
  required int part,
  required int amount,
  Value<String?> reference,
  Value<bool> optional,
  Value<bool> variants,
  Value<int> rowid,
});
typedef $$BomPartTableUpdateCompanionBuilder = BomPartCompanion Function({
  Value<int> parent,
  Value<int> part,
  Value<int> amount,
  Value<String?> reference,
  Value<bool> optional,
  Value<bool> variants,
  Value<int> rowid,
});

final class $$BomPartTableReferences
    extends BaseReferences<_$Database, $BomPartTable, BomPartData> {
  $$BomPartTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PartTable _parentTable(_$Database db) =>
      db.part.createAlias($_aliasNameGenerator(db.bomPart.parent, db.part.id));

  $$PartTableProcessedTableManager get parent {
    final $_column = $_itemColumn<int>('parent')!;

    final manager = $$PartTableTableManager($_db, $_db.part)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PartTable _partTable(_$Database db) =>
      db.part.createAlias($_aliasNameGenerator(db.bomPart.part, db.part.id));

  $$PartTableProcessedTableManager get part {
    final $_column = $_itemColumn<int>('part')!;

    final manager = $$PartTableTableManager($_db, $_db.part)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BomPartTableFilterComposer extends Composer<_$Database, $BomPartTable> {
  $$BomPartTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get optional => $composableBuilder(
      column: $table.optional, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get variants => $composableBuilder(
      column: $table.variants, builder: (column) => ColumnFilters(column));

  $$PartTableFilterComposer get parent {
    final $$PartTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parent,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableFilterComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PartTableFilterComposer get part {
    final $$PartTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.part,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableFilterComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BomPartTableOrderingComposer
    extends Composer<_$Database, $BomPartTable> {
  $$BomPartTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get optional => $composableBuilder(
      column: $table.optional, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get variants => $composableBuilder(
      column: $table.variants, builder: (column) => ColumnOrderings(column));

  $$PartTableOrderingComposer get parent {
    final $$PartTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parent,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableOrderingComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PartTableOrderingComposer get part {
    final $$PartTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.part,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableOrderingComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BomPartTableAnnotationComposer
    extends Composer<_$Database, $BomPartTable> {
  $$BomPartTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<bool> get optional =>
      $composableBuilder(column: $table.optional, builder: (column) => column);

  GeneratedColumn<bool> get variants =>
      $composableBuilder(column: $table.variants, builder: (column) => column);

  $$PartTableAnnotationComposer get parent {
    final $$PartTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parent,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableAnnotationComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PartTableAnnotationComposer get part {
    final $$PartTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.part,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableAnnotationComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BomPartTableTableManager extends RootTableManager<
    _$Database,
    $BomPartTable,
    BomPartData,
    $$BomPartTableFilterComposer,
    $$BomPartTableOrderingComposer,
    $$BomPartTableAnnotationComposer,
    $$BomPartTableCreateCompanionBuilder,
    $$BomPartTableUpdateCompanionBuilder,
    (BomPartData, $$BomPartTableReferences),
    BomPartData,
    PrefetchHooks Function({bool parent, bool part})> {
  $$BomPartTableTableManager(_$Database db, $BomPartTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BomPartTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BomPartTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BomPartTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> parent = const Value.absent(),
            Value<int> part = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<String?> reference = const Value.absent(),
            Value<bool> optional = const Value.absent(),
            Value<bool> variants = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BomPartCompanion(
            parent: parent,
            part: part,
            amount: amount,
            reference: reference,
            optional: optional,
            variants: variants,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int parent,
            required int part,
            required int amount,
            Value<String?> reference = const Value.absent(),
            Value<bool> optional = const Value.absent(),
            Value<bool> variants = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BomPartCompanion.insert(
            parent: parent,
            part: part,
            amount: amount,
            reference: reference,
            optional: optional,
            variants: variants,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BomPartTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({parent = false, part = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (parent) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.parent,
                    referencedTable: $$BomPartTableReferences._parentTable(db),
                    referencedColumn:
                        $$BomPartTableReferences._parentTable(db).id,
                  ) as T;
                }
                if (part) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.part,
                    referencedTable: $$BomPartTableReferences._partTable(db),
                    referencedColumn:
                        $$BomPartTableReferences._partTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BomPartTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $BomPartTable,
    BomPartData,
    $$BomPartTableFilterComposer,
    $$BomPartTableOrderingComposer,
    $$BomPartTableAnnotationComposer,
    $$BomPartTableCreateCompanionBuilder,
    $$BomPartTableUpdateCompanionBuilder,
    (BomPartData, $$BomPartTableReferences),
    BomPartData,
    PrefetchHooks Function({bool parent, bool part})>;
typedef $$LocationTableCreateCompanionBuilder = LocationCompanion Function({
  Value<int> id,
  Value<int?> parent,
  required String name,
  Value<String?> description,
});
typedef $$LocationTableUpdateCompanionBuilder = LocationCompanion Function({
  Value<int> id,
  Value<int?> parent,
  Value<String> name,
  Value<String?> description,
});

final class $$LocationTableReferences
    extends BaseReferences<_$Database, $LocationTable, LocationData> {
  $$LocationTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocationTable _parentTable(_$Database db) => db.location
      .createAlias($_aliasNameGenerator(db.location.parent, db.location.id));

  $$LocationTableProcessedTableManager? get parent {
    final $_column = $_itemColumn<int>('parent');
    if ($_column == null) return null;
    final manager = $$LocationTableTableManager($_db, $_db.location)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$StockTable, List<StockData>> _stockRefsTable(
          _$Database db) =>
      MultiTypedResultKey.fromTable(db.stock,
          aliasName: $_aliasNameGenerator(db.location.id, db.stock.location));

  $$StockTableProcessedTableManager get stockRefs {
    final manager = $$StockTableTableManager($_db, $_db.stock)
        .filter((f) => f.location.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BuildOrderTable, List<BuildOrderData>>
      _buildOrderRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
          db.buildOrder,
          aliasName:
              $_aliasNameGenerator(db.location.id, db.buildOrder.destination));

  $$BuildOrderTableProcessedTableManager get buildOrderRefs {
    final manager = $$BuildOrderTableTableManager($_db, $_db.buildOrder)
        .filter((f) => f.destination.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_buildOrderRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LocationTableFilterComposer
    extends Composer<_$Database, $LocationTable> {
  $$LocationTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  $$LocationTableFilterComposer get parent {
    final $$LocationTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parent,
        referencedTable: $db.location,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationTableFilterComposer(
              $db: $db,
              $table: $db.location,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> stockRefs(
      Expression<bool> Function($$StockTableFilterComposer f) f) {
    final $$StockTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stock,
        getReferencedColumn: (t) => t.location,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StockTableFilterComposer(
              $db: $db,
              $table: $db.stock,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> buildOrderRefs(
      Expression<bool> Function($$BuildOrderTableFilterComposer f) f) {
    final $$BuildOrderTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.buildOrder,
        getReferencedColumn: (t) => t.destination,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BuildOrderTableFilterComposer(
              $db: $db,
              $table: $db.buildOrder,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LocationTableOrderingComposer
    extends Composer<_$Database, $LocationTable> {
  $$LocationTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  $$LocationTableOrderingComposer get parent {
    final $$LocationTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parent,
        referencedTable: $db.location,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationTableOrderingComposer(
              $db: $db,
              $table: $db.location,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LocationTableAnnotationComposer
    extends Composer<_$Database, $LocationTable> {
  $$LocationTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  $$LocationTableAnnotationComposer get parent {
    final $$LocationTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parent,
        referencedTable: $db.location,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationTableAnnotationComposer(
              $db: $db,
              $table: $db.location,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> stockRefs<T extends Object>(
      Expression<T> Function($$StockTableAnnotationComposer a) f) {
    final $$StockTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stock,
        getReferencedColumn: (t) => t.location,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StockTableAnnotationComposer(
              $db: $db,
              $table: $db.stock,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> buildOrderRefs<T extends Object>(
      Expression<T> Function($$BuildOrderTableAnnotationComposer a) f) {
    final $$BuildOrderTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.buildOrder,
        getReferencedColumn: (t) => t.destination,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BuildOrderTableAnnotationComposer(
              $db: $db,
              $table: $db.buildOrder,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LocationTableTableManager extends RootTableManager<
    _$Database,
    $LocationTable,
    LocationData,
    $$LocationTableFilterComposer,
    $$LocationTableOrderingComposer,
    $$LocationTableAnnotationComposer,
    $$LocationTableCreateCompanionBuilder,
    $$LocationTableUpdateCompanionBuilder,
    (LocationData, $$LocationTableReferences),
    LocationData,
    PrefetchHooks Function(
        {bool parent, bool stockRefs, bool buildOrderRefs})> {
  $$LocationTableTableManager(_$Database db, $LocationTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> parent = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
          }) =>
              LocationCompanion(
            id: id,
            parent: parent,
            name: name,
            description: description,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> parent = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
          }) =>
              LocationCompanion.insert(
            id: id,
            parent: parent,
            name: name,
            description: description,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$LocationTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {parent = false, stockRefs = false, buildOrderRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (stockRefs) db.stock,
                if (buildOrderRefs) db.buildOrder
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (parent) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.parent,
                    referencedTable: $$LocationTableReferences._parentTable(db),
                    referencedColumn:
                        $$LocationTableReferences._parentTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (stockRefs)
                    await $_getPrefetchedData<LocationData, $LocationTable,
                            StockData>(
                        currentTable: table,
                        referencedTable:
                            $$LocationTableReferences._stockRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocationTableReferences(db, table, p0).stockRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.location == item.id),
                        typedResults: items),
                  if (buildOrderRefs)
                    await $_getPrefetchedData<LocationData, $LocationTable,
                            BuildOrderData>(
                        currentTable: table,
                        referencedTable:
                            $$LocationTableReferences._buildOrderRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocationTableReferences(db, table, p0)
                                .buildOrderRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.destination == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LocationTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $LocationTable,
    LocationData,
    $$LocationTableFilterComposer,
    $$LocationTableOrderingComposer,
    $$LocationTableAnnotationComposer,
    $$LocationTableCreateCompanionBuilder,
    $$LocationTableUpdateCompanionBuilder,
    (LocationData, $$LocationTableReferences),
    LocationData,
    PrefetchHooks Function({bool parent, bool stockRefs, bool buildOrderRefs})>;
typedef $$StockTableCreateCompanionBuilder = StockCompanion Function({
  Value<int> id,
  required int part,
  required int amount,
  Value<double?> price,
  Value<String?> note,
  required int location,
  Value<DateTime> modified,
});
typedef $$StockTableUpdateCompanionBuilder = StockCompanion Function({
  Value<int> id,
  Value<int> part,
  Value<int> amount,
  Value<double?> price,
  Value<String?> note,
  Value<int> location,
  Value<DateTime> modified,
});

final class $$StockTableReferences
    extends BaseReferences<_$Database, $StockTable, StockData> {
  $$StockTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PartTable _partTable(_$Database db) =>
      db.part.createAlias($_aliasNameGenerator(db.stock.part, db.part.id));

  $$PartTableProcessedTableManager get part {
    final $_column = $_itemColumn<int>('part')!;

    final manager = $$PartTableTableManager($_db, $_db.part)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $LocationTable _locationTable(_$Database db) => db.location
      .createAlias($_aliasNameGenerator(db.stock.location, db.location.id));

  $$LocationTableProcessedTableManager get location {
    final $_column = $_itemColumn<int>('location')!;

    final manager = $$LocationTableTableManager($_db, $_db.location)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_locationTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$StockTrackingTable, List<StockTrackingData>>
      _stockTrackingRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
          db.stockTracking,
          aliasName: $_aliasNameGenerator(db.stock.id, db.stockTracking.stock));

  $$StockTrackingTableProcessedTableManager get stockTrackingRefs {
    final manager = $$StockTrackingTableTableManager($_db, $_db.stockTracking)
        .filter((f) => f.stock.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockTrackingRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$StockAllocationTable, List<StockAllocationData>>
      _stockAllocationRefsTable(_$Database db) =>
          MultiTypedResultKey.fromTable(db.stockAllocation,
              aliasName:
                  $_aliasNameGenerator(db.stock.id, db.stockAllocation.stock));

  $$StockAllocationTableProcessedTableManager get stockAllocationRefs {
    final manager =
        $$StockAllocationTableTableManager($_db, $_db.stockAllocation)
            .filter((f) => f.stock.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_stockAllocationRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$StockTableFilterComposer extends Composer<_$Database, $StockTable> {
  $$StockTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get modified => $composableBuilder(
      column: $table.modified, builder: (column) => ColumnFilters(column));

  $$PartTableFilterComposer get part {
    final $$PartTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.part,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableFilterComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocationTableFilterComposer get location {
    final $$LocationTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.location,
        referencedTable: $db.location,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationTableFilterComposer(
              $db: $db,
              $table: $db.location,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> stockTrackingRefs(
      Expression<bool> Function($$StockTrackingTableFilterComposer f) f) {
    final $$StockTrackingTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stockTracking,
        getReferencedColumn: (t) => t.stock,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StockTrackingTableFilterComposer(
              $db: $db,
              $table: $db.stockTracking,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> stockAllocationRefs(
      Expression<bool> Function($$StockAllocationTableFilterComposer f) f) {
    final $$StockAllocationTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stockAllocation,
        getReferencedColumn: (t) => t.stock,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StockAllocationTableFilterComposer(
              $db: $db,
              $table: $db.stockAllocation,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StockTableOrderingComposer extends Composer<_$Database, $StockTable> {
  $$StockTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get modified => $composableBuilder(
      column: $table.modified, builder: (column) => ColumnOrderings(column));

  $$PartTableOrderingComposer get part {
    final $$PartTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.part,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableOrderingComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocationTableOrderingComposer get location {
    final $$LocationTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.location,
        referencedTable: $db.location,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationTableOrderingComposer(
              $db: $db,
              $table: $db.location,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StockTableAnnotationComposer extends Composer<_$Database, $StockTable> {
  $$StockTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get modified =>
      $composableBuilder(column: $table.modified, builder: (column) => column);

  $$PartTableAnnotationComposer get part {
    final $$PartTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.part,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableAnnotationComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocationTableAnnotationComposer get location {
    final $$LocationTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.location,
        referencedTable: $db.location,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationTableAnnotationComposer(
              $db: $db,
              $table: $db.location,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> stockTrackingRefs<T extends Object>(
      Expression<T> Function($$StockTrackingTableAnnotationComposer a) f) {
    final $$StockTrackingTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stockTracking,
        getReferencedColumn: (t) => t.stock,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StockTrackingTableAnnotationComposer(
              $db: $db,
              $table: $db.stockTracking,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> stockAllocationRefs<T extends Object>(
      Expression<T> Function($$StockAllocationTableAnnotationComposer a) f) {
    final $$StockAllocationTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stockAllocation,
        getReferencedColumn: (t) => t.stock,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StockAllocationTableAnnotationComposer(
              $db: $db,
              $table: $db.stockAllocation,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StockTableTableManager extends RootTableManager<
    _$Database,
    $StockTable,
    StockData,
    $$StockTableFilterComposer,
    $$StockTableOrderingComposer,
    $$StockTableAnnotationComposer,
    $$StockTableCreateCompanionBuilder,
    $$StockTableUpdateCompanionBuilder,
    (StockData, $$StockTableReferences),
    StockData,
    PrefetchHooks Function(
        {bool part,
        bool location,
        bool stockTrackingRefs,
        bool stockAllocationRefs})> {
  $$StockTableTableManager(_$Database db, $StockTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> part = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<double?> price = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> location = const Value.absent(),
            Value<DateTime> modified = const Value.absent(),
          }) =>
              StockCompanion(
            id: id,
            part: part,
            amount: amount,
            price: price,
            note: note,
            location: location,
            modified: modified,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int part,
            required int amount,
            Value<double?> price = const Value.absent(),
            Value<String?> note = const Value.absent(),
            required int location,
            Value<DateTime> modified = const Value.absent(),
          }) =>
              StockCompanion.insert(
            id: id,
            part: part,
            amount: amount,
            price: price,
            note: note,
            location: location,
            modified: modified,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$StockTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {part = false,
              location = false,
              stockTrackingRefs = false,
              stockAllocationRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (stockTrackingRefs) db.stockTracking,
                if (stockAllocationRefs) db.stockAllocation
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (part) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.part,
                    referencedTable: $$StockTableReferences._partTable(db),
                    referencedColumn: $$StockTableReferences._partTable(db).id,
                  ) as T;
                }
                if (location) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.location,
                    referencedTable: $$StockTableReferences._locationTable(db),
                    referencedColumn:
                        $$StockTableReferences._locationTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (stockTrackingRefs)
                    await $_getPrefetchedData<StockData, $StockTable,
                            StockTrackingData>(
                        currentTable: table,
                        referencedTable:
                            $$StockTableReferences._stockTrackingRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StockTableReferences(db, table, p0)
                                .stockTrackingRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.stock == item.id),
                        typedResults: items),
                  if (stockAllocationRefs)
                    await $_getPrefetchedData<StockData, $StockTable,
                            StockAllocationData>(
                        currentTable: table,
                        referencedTable: $$StockTableReferences
                            ._stockAllocationRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StockTableReferences(db, table, p0)
                                .stockAllocationRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.stock == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$StockTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $StockTable,
    StockData,
    $$StockTableFilterComposer,
    $$StockTableOrderingComposer,
    $$StockTableAnnotationComposer,
    $$StockTableCreateCompanionBuilder,
    $$StockTableUpdateCompanionBuilder,
    (StockData, $$StockTableReferences),
    StockData,
    PrefetchHooks Function(
        {bool part,
        bool location,
        bool stockTrackingRefs,
        bool stockAllocationRefs})>;
typedef $$StockTrackingTableCreateCompanionBuilder = StockTrackingCompanion
    Function({
  Value<int> id,
  required String notes,
  Value<DateTime> date,
  required int amount,
  required int stock,
});
typedef $$StockTrackingTableUpdateCompanionBuilder = StockTrackingCompanion
    Function({
  Value<int> id,
  Value<String> notes,
  Value<DateTime> date,
  Value<int> amount,
  Value<int> stock,
});

final class $$StockTrackingTableReferences
    extends BaseReferences<_$Database, $StockTrackingTable, StockTrackingData> {
  $$StockTrackingTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $StockTable _stockTable(_$Database db) => db.stock
      .createAlias($_aliasNameGenerator(db.stockTracking.stock, db.stock.id));

  $$StockTableProcessedTableManager get stock {
    final $_column = $_itemColumn<int>('stock')!;

    final manager = $$StockTableTableManager($_db, $_db.stock)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_stockTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$StockTrackingTableFilterComposer
    extends Composer<_$Database, $StockTrackingTable> {
  $$StockTrackingTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  $$StockTableFilterComposer get stock {
    final $$StockTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.stock,
        referencedTable: $db.stock,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StockTableFilterComposer(
              $db: $db,
              $table: $db.stock,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StockTrackingTableOrderingComposer
    extends Composer<_$Database, $StockTrackingTable> {
  $$StockTrackingTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  $$StockTableOrderingComposer get stock {
    final $$StockTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.stock,
        referencedTable: $db.stock,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StockTableOrderingComposer(
              $db: $db,
              $table: $db.stock,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StockTrackingTableAnnotationComposer
    extends Composer<_$Database, $StockTrackingTable> {
  $$StockTrackingTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  $$StockTableAnnotationComposer get stock {
    final $$StockTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.stock,
        referencedTable: $db.stock,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StockTableAnnotationComposer(
              $db: $db,
              $table: $db.stock,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StockTrackingTableTableManager extends RootTableManager<
    _$Database,
    $StockTrackingTable,
    StockTrackingData,
    $$StockTrackingTableFilterComposer,
    $$StockTrackingTableOrderingComposer,
    $$StockTrackingTableAnnotationComposer,
    $$StockTrackingTableCreateCompanionBuilder,
    $$StockTrackingTableUpdateCompanionBuilder,
    (StockTrackingData, $$StockTrackingTableReferences),
    StockTrackingData,
    PrefetchHooks Function({bool stock})> {
  $$StockTrackingTableTableManager(_$Database db, $StockTrackingTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockTrackingTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockTrackingTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockTrackingTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<int> stock = const Value.absent(),
          }) =>
              StockTrackingCompanion(
            id: id,
            notes: notes,
            date: date,
            amount: amount,
            stock: stock,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String notes,
            Value<DateTime> date = const Value.absent(),
            required int amount,
            required int stock,
          }) =>
              StockTrackingCompanion.insert(
            id: id,
            notes: notes,
            date: date,
            amount: amount,
            stock: stock,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$StockTrackingTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({stock = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (stock) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.stock,
                    referencedTable:
                        $$StockTrackingTableReferences._stockTable(db),
                    referencedColumn:
                        $$StockTrackingTableReferences._stockTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$StockTrackingTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $StockTrackingTable,
    StockTrackingData,
    $$StockTrackingTableFilterComposer,
    $$StockTrackingTableOrderingComposer,
    $$StockTrackingTableAnnotationComposer,
    $$StockTrackingTableCreateCompanionBuilder,
    $$StockTrackingTableUpdateCompanionBuilder,
    (StockTrackingData, $$StockTrackingTableReferences),
    StockTrackingData,
    PrefetchHooks Function({bool stock})>;
typedef $$BuildOrderTableCreateCompanionBuilder = BuildOrderCompanion Function({
  Value<int> id,
  required String reference,
  required int part,
  Value<String?> description,
  required int amount,
  Value<int?> destination,
  Value<DateTime> created,
  Value<DateTime?> completed,
});
typedef $$BuildOrderTableUpdateCompanionBuilder = BuildOrderCompanion Function({
  Value<int> id,
  Value<String> reference,
  Value<int> part,
  Value<String?> description,
  Value<int> amount,
  Value<int?> destination,
  Value<DateTime> created,
  Value<DateTime?> completed,
});

final class $$BuildOrderTableReferences
    extends BaseReferences<_$Database, $BuildOrderTable, BuildOrderData> {
  $$BuildOrderTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PartTable _partTable(_$Database db) =>
      db.part.createAlias($_aliasNameGenerator(db.buildOrder.part, db.part.id));

  $$PartTableProcessedTableManager get part {
    final $_column = $_itemColumn<int>('part')!;

    final manager = $$PartTableTableManager($_db, $_db.part)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $LocationTable _destinationTable(_$Database db) =>
      db.location.createAlias(
          $_aliasNameGenerator(db.buildOrder.destination, db.location.id));

  $$LocationTableProcessedTableManager? get destination {
    final $_column = $_itemColumn<int>('destination');
    if ($_column == null) return null;
    final manager = $$LocationTableTableManager($_db, $_db.location)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_destinationTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$StockAllocationTable, List<StockAllocationData>>
      _stockAllocationRefsTable(_$Database db) =>
          MultiTypedResultKey.fromTable(db.stockAllocation,
              aliasName: $_aliasNameGenerator(
                  db.buildOrder.id, db.stockAllocation.buildOrder));

  $$StockAllocationTableProcessedTableManager get stockAllocationRefs {
    final manager =
        $$StockAllocationTableTableManager($_db, $_db.stockAllocation)
            .filter((f) => f.buildOrder.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_stockAllocationRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BuildOrderTableFilterComposer
    extends Composer<_$Database, $BuildOrderTable> {
  $$BuildOrderTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get created => $composableBuilder(
      column: $table.created, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnFilters(column));

  $$PartTableFilterComposer get part {
    final $$PartTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.part,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableFilterComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocationTableFilterComposer get destination {
    final $$LocationTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.destination,
        referencedTable: $db.location,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationTableFilterComposer(
              $db: $db,
              $table: $db.location,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> stockAllocationRefs(
      Expression<bool> Function($$StockAllocationTableFilterComposer f) f) {
    final $$StockAllocationTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stockAllocation,
        getReferencedColumn: (t) => t.buildOrder,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StockAllocationTableFilterComposer(
              $db: $db,
              $table: $db.stockAllocation,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BuildOrderTableOrderingComposer
    extends Composer<_$Database, $BuildOrderTable> {
  $$BuildOrderTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get created => $composableBuilder(
      column: $table.created, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnOrderings(column));

  $$PartTableOrderingComposer get part {
    final $$PartTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.part,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableOrderingComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocationTableOrderingComposer get destination {
    final $$LocationTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.destination,
        referencedTable: $db.location,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationTableOrderingComposer(
              $db: $db,
              $table: $db.location,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BuildOrderTableAnnotationComposer
    extends Composer<_$Database, $BuildOrderTable> {
  $$BuildOrderTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<DateTime> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  $$PartTableAnnotationComposer get part {
    final $$PartTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.part,
        referencedTable: $db.part,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartTableAnnotationComposer(
              $db: $db,
              $table: $db.part,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocationTableAnnotationComposer get destination {
    final $$LocationTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.destination,
        referencedTable: $db.location,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationTableAnnotationComposer(
              $db: $db,
              $table: $db.location,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> stockAllocationRefs<T extends Object>(
      Expression<T> Function($$StockAllocationTableAnnotationComposer a) f) {
    final $$StockAllocationTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stockAllocation,
        getReferencedColumn: (t) => t.buildOrder,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StockAllocationTableAnnotationComposer(
              $db: $db,
              $table: $db.stockAllocation,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BuildOrderTableTableManager extends RootTableManager<
    _$Database,
    $BuildOrderTable,
    BuildOrderData,
    $$BuildOrderTableFilterComposer,
    $$BuildOrderTableOrderingComposer,
    $$BuildOrderTableAnnotationComposer,
    $$BuildOrderTableCreateCompanionBuilder,
    $$BuildOrderTableUpdateCompanionBuilder,
    (BuildOrderData, $$BuildOrderTableReferences),
    BuildOrderData,
    PrefetchHooks Function(
        {bool part, bool destination, bool stockAllocationRefs})> {
  $$BuildOrderTableTableManager(_$Database db, $BuildOrderTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BuildOrderTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BuildOrderTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BuildOrderTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> reference = const Value.absent(),
            Value<int> part = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<int?> destination = const Value.absent(),
            Value<DateTime> created = const Value.absent(),
            Value<DateTime?> completed = const Value.absent(),
          }) =>
              BuildOrderCompanion(
            id: id,
            reference: reference,
            part: part,
            description: description,
            amount: amount,
            destination: destination,
            created: created,
            completed: completed,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String reference,
            required int part,
            Value<String?> description = const Value.absent(),
            required int amount,
            Value<int?> destination = const Value.absent(),
            Value<DateTime> created = const Value.absent(),
            Value<DateTime?> completed = const Value.absent(),
          }) =>
              BuildOrderCompanion.insert(
            id: id,
            reference: reference,
            part: part,
            description: description,
            amount: amount,
            destination: destination,
            created: created,
            completed: completed,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BuildOrderTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {part = false,
              destination = false,
              stockAllocationRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (stockAllocationRefs) db.stockAllocation
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (part) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.part,
                    referencedTable: $$BuildOrderTableReferences._partTable(db),
                    referencedColumn:
                        $$BuildOrderTableReferences._partTable(db).id,
                  ) as T;
                }
                if (destination) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.destination,
                    referencedTable:
                        $$BuildOrderTableReferences._destinationTable(db),
                    referencedColumn:
                        $$BuildOrderTableReferences._destinationTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (stockAllocationRefs)
                    await $_getPrefetchedData<BuildOrderData, $BuildOrderTable,
                            StockAllocationData>(
                        currentTable: table,
                        referencedTable: $$BuildOrderTableReferences
                            ._stockAllocationRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BuildOrderTableReferences(db, table, p0)
                                .stockAllocationRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.buildOrder == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BuildOrderTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $BuildOrderTable,
    BuildOrderData,
    $$BuildOrderTableFilterComposer,
    $$BuildOrderTableOrderingComposer,
    $$BuildOrderTableAnnotationComposer,
    $$BuildOrderTableCreateCompanionBuilder,
    $$BuildOrderTableUpdateCompanionBuilder,
    (BuildOrderData, $$BuildOrderTableReferences),
    BuildOrderData,
    PrefetchHooks Function(
        {bool part, bool destination, bool stockAllocationRefs})>;
typedef $$StockAllocationTableCreateCompanionBuilder = StockAllocationCompanion
    Function({
  required int stock,
  required int buildOrder,
  required int amount,
  Value<int> rowid,
});
typedef $$StockAllocationTableUpdateCompanionBuilder = StockAllocationCompanion
    Function({
  Value<int> stock,
  Value<int> buildOrder,
  Value<int> amount,
  Value<int> rowid,
});

final class $$StockAllocationTableReferences extends BaseReferences<_$Database,
    $StockAllocationTable, StockAllocationData> {
  $$StockAllocationTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $StockTable _stockTable(_$Database db) => db.stock
      .createAlias($_aliasNameGenerator(db.stockAllocation.stock, db.stock.id));

  $$StockTableProcessedTableManager get stock {
    final $_column = $_itemColumn<int>('stock')!;

    final manager = $$StockTableTableManager($_db, $_db.stock)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_stockTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BuildOrderTable _buildOrderTable(_$Database db) =>
      db.buildOrder.createAlias($_aliasNameGenerator(
          db.stockAllocation.buildOrder, db.buildOrder.id));

  $$BuildOrderTableProcessedTableManager get buildOrder {
    final $_column = $_itemColumn<int>('build_order')!;

    final manager = $$BuildOrderTableTableManager($_db, $_db.buildOrder)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_buildOrderTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$StockAllocationTableFilterComposer
    extends Composer<_$Database, $StockAllocationTable> {
  $$StockAllocationTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  $$StockTableFilterComposer get stock {
    final $$StockTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.stock,
        referencedTable: $db.stock,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StockTableFilterComposer(
              $db: $db,
              $table: $db.stock,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BuildOrderTableFilterComposer get buildOrder {
    final $$BuildOrderTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.buildOrder,
        referencedTable: $db.buildOrder,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BuildOrderTableFilterComposer(
              $db: $db,
              $table: $db.buildOrder,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StockAllocationTableOrderingComposer
    extends Composer<_$Database, $StockAllocationTable> {
  $$StockAllocationTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  $$StockTableOrderingComposer get stock {
    final $$StockTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.stock,
        referencedTable: $db.stock,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StockTableOrderingComposer(
              $db: $db,
              $table: $db.stock,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BuildOrderTableOrderingComposer get buildOrder {
    final $$BuildOrderTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.buildOrder,
        referencedTable: $db.buildOrder,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BuildOrderTableOrderingComposer(
              $db: $db,
              $table: $db.buildOrder,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StockAllocationTableAnnotationComposer
    extends Composer<_$Database, $StockAllocationTable> {
  $$StockAllocationTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  $$StockTableAnnotationComposer get stock {
    final $$StockTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.stock,
        referencedTable: $db.stock,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StockTableAnnotationComposer(
              $db: $db,
              $table: $db.stock,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BuildOrderTableAnnotationComposer get buildOrder {
    final $$BuildOrderTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.buildOrder,
        referencedTable: $db.buildOrder,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BuildOrderTableAnnotationComposer(
              $db: $db,
              $table: $db.buildOrder,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StockAllocationTableTableManager extends RootTableManager<
    _$Database,
    $StockAllocationTable,
    StockAllocationData,
    $$StockAllocationTableFilterComposer,
    $$StockAllocationTableOrderingComposer,
    $$StockAllocationTableAnnotationComposer,
    $$StockAllocationTableCreateCompanionBuilder,
    $$StockAllocationTableUpdateCompanionBuilder,
    (StockAllocationData, $$StockAllocationTableReferences),
    StockAllocationData,
    PrefetchHooks Function({bool stock, bool buildOrder})> {
  $$StockAllocationTableTableManager(_$Database db, $StockAllocationTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockAllocationTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockAllocationTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockAllocationTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> stock = const Value.absent(),
            Value<int> buildOrder = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StockAllocationCompanion(
            stock: stock,
            buildOrder: buildOrder,
            amount: amount,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int stock,
            required int buildOrder,
            required int amount,
            Value<int> rowid = const Value.absent(),
          }) =>
              StockAllocationCompanion.insert(
            stock: stock,
            buildOrder: buildOrder,
            amount: amount,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$StockAllocationTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({stock = false, buildOrder = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (stock) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.stock,
                    referencedTable:
                        $$StockAllocationTableReferences._stockTable(db),
                    referencedColumn:
                        $$StockAllocationTableReferences._stockTable(db).id,
                  ) as T;
                }
                if (buildOrder) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.buildOrder,
                    referencedTable:
                        $$StockAllocationTableReferences._buildOrderTable(db),
                    referencedColumn: $$StockAllocationTableReferences
                        ._buildOrderTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$StockAllocationTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $StockAllocationTable,
    StockAllocationData,
    $$StockAllocationTableFilterComposer,
    $$StockAllocationTableOrderingComposer,
    $$StockAllocationTableAnnotationComposer,
    $$StockAllocationTableCreateCompanionBuilder,
    $$StockAllocationTableUpdateCompanionBuilder,
    (StockAllocationData, $$StockAllocationTableReferences),
    StockAllocationData,
    PrefetchHooks Function({bool stock, bool buildOrder})>;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$CategoryTableTableManager get category =>
      $$CategoryTableTableManager(_db, _db.category);
  $$PartTableTableManager get part => $$PartTableTableManager(_db, _db.part);
  $$BomPartTableTableManager get bomPart =>
      $$BomPartTableTableManager(_db, _db.bomPart);
  $$LocationTableTableManager get location =>
      $$LocationTableTableManager(_db, _db.location);
  $$StockTableTableManager get stock =>
      $$StockTableTableManager(_db, _db.stock);
  $$StockTrackingTableTableManager get stockTracking =>
      $$StockTrackingTableTableManager(_db, _db.stockTracking);
  $$BuildOrderTableTableManager get buildOrder =>
      $$BuildOrderTableTableManager(_db, _db.buildOrder);
  $$StockAllocationTableTableManager get stockAllocation =>
      $$StockAllocationTableTableManager(_db, _db.stockAllocation);
}

class GetPartsOfChildCategoriesResult {
  final int id;
  final String name;
  final String? ipn;
  final String? description;
  final int category;
  final String? image;
  final int? variant;
  final bool template;
  final bool assembly;
  final String? sku;
  final String? mpn;
  final int cId;
  final int? cParent;
  final String cName;
  final String cDescription;
  final String? cKeywords;
  GetPartsOfChildCategoriesResult({
    required this.id,
    required this.name,
    this.ipn,
    this.description,
    required this.category,
    this.image,
    this.variant,
    required this.template,
    required this.assembly,
    this.sku,
    this.mpn,
    required this.cId,
    this.cParent,
    required this.cName,
    required this.cDescription,
    this.cKeywords,
  });
}
