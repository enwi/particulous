class Category {
  int identifier;
  String name;
  String description;
  String? keywords;

  int? parent;

  Category(
      {required this.identifier,
      required this.name,
      required this.description,
      this.keywords,
      this.parent});
}
