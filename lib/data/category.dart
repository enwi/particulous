/// Category data class
class Category {
  /// Category identifier
  int identifier;

  /// Category name
  String name;

  /// Category description
  String description;

  /// Optional categpry keywords
  String? keywords;

  /// Optional parent category
  int? parent;

  Category({
    required this.identifier,
    required this.name,
    required this.description,
    this.keywords,
    this.parent,
  });
}
