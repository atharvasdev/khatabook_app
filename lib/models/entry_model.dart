class Entry {
  final String id;
  final int amount;
  final bool isCredit;
  final DateTime date;

  Entry({
    required this.id,
    required this.amount,
    required this.isCredit,
    required this.date,
  });
}