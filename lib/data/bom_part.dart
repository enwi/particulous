import 'package:particulous/data/part.dart';

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
