class AlterStock {
  /// Stock identifier
  final int stock;

  /// Amount to alter (+ add, - remove)
  final int amount;

  /// User notes
  final String notes;

  AlterStock({required this.stock, required this.amount, required this.notes});

  @override
  String toString() {
    return 'AlterStock($stock,$amount,$notes)';
  }
}
