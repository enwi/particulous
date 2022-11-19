class BuildOrder {
  int id;
  String reference;
  int part;
  String? description;
  int amount;
  int? destination;
  DateTime created;
  DateTime? completed;

  BuildOrder({
    required this.id,
    required this.reference,
    required this.part,
    this.description,
    required this.amount,
    this.destination,
    required this.created,
    this.completed,
  });
}
