class Entry {
  final String id;
  final double amount;
  final String type; // credit or debit
  final DateTime date;

  Entry({
    required this.id,
    required this.amount,
    required this.type,
    required this.date,
  });
}