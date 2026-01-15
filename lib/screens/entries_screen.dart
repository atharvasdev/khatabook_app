import 'package:flutter/material.dart';
import '../models/customer_model.dart';
import '../models/entry_model.dart';

class EntriesScreen extends StatefulWidget {
  final Customer customer;

  const EntriesScreen({super.key, required this.customer});

  @override
  State<EntriesScreen> createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  List<Entry> entries = [];

  void addEntry(double amount, String type) {
    setState(() {
      entries.insert(
        0,
        Entry(
          id: DateTime.now().toString(),
          amount: amount,
          type: type,
          date: DateTime.now(),
        ),
      );

      if (type == 'credit') {
        widget.customer.balance += amount;
      } else {
        widget.customer.balance -= amount;
      }
    });
  }

  void showAddEntryDialog(String type) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(type == 'credit' ? 'Add Credit' : 'Add Debit'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Amount'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final amount = double.tryParse(controller.text);
              if (amount != null) {
                addEntry(amount, type);
              }
              Navigator.pop(context);
            },
            child: const Text('ADD'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer.name),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Balance: ₹ ${widget.customer.balance}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: widget.customer.balance >= 0
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final e = entries[index];
                return ListTile(
                  title: Text(
                    '${e.type.toUpperCase()}  ₹${e.amount}',
                    style: TextStyle(
                      color: e.type == 'credit'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  subtitle: Text(e.date.toString()),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'credit',
            backgroundColor: Colors.green,
            onPressed: () => showAddEntryDialog('credit'),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'debit',
            backgroundColor: Colors.red,
            onPressed: () => showAddEntryDialog('debit'),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}