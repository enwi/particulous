/// Represents a [Location] where parts can be stored
class Location {
  /// Unique location identifier
  int id;

  /// Optional parent [Location] identifier
  int? parent;

  /// Location name
  String name;

  /// Location description
  String? description;

  Location({
    required this.id,
    required this.parent,
    required this.name,
    this.description,
  });
}
