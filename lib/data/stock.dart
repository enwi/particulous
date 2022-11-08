/// Represents the stock of a [part]
class Stock {
  /// Unique stock identifier
  final int id;

  /// Part stock refers to
  final int part;

  /// Amount of parts the stock has
  final int amount;

  /// Price per part
  final double? price;

  /// Note about stock
  final String? note;

  /// Last time stock was modified
  final DateTime modified;

  Stock({
    required this.id,
    required this.part,
    required this.amount,
    this.price,
    this.note,
    required this.modified,
  });
}
