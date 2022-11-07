import 'dart:io';

import 'package:particulous/data/category.dart';
import 'package:path/path.dart';

class Part {
  /// Database identifier
  int identifier;

  /// Internal part number
  String? ipn;

  /// Name
  String name;

  /// Part description
  String? description;

  /// Part category
  Category category;

  /// Name of image file
  String? image;

  /// Part identifier of part this part is variant of
  int? variant;

  /// Is this part a template part
  bool template;

  /// Can this part be assembled from other parts
  bool assembly;

  /// Stock keeping unit
  String? sku;

  /// Manufacturer part number
  String? mpn;

  Part({
    required this.identifier,
    this.ipn,
    required this.name,
    this.description,
    required this.category,
    this.image,
    this.variant,
    required this.template,
    required this.assembly,
    this.sku,
    this.mpn,
  });

  File? getImageFile(final String imageDir) {
    return image != null ? File(join(imageDir, image!)) : null;
  }
}

class BomPart {
  /// Parent part identifier
  int parent;

  /// Part identifier
  Part part;

  /// Amount of [part]s needed to build [parent]
  int amount;

  /// Reference
  String? reference;

  /// Is this [part] optional to build [parent]
  bool optional;

  /// Are variants of this [part] allowed
  bool variants;

  BomPart({
    required this.parent,
    required this.part,
    required this.amount,
    required this.optional,
    required this.variants,
    this.reference,
  });
}
