import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/customer_model.dart';
import '../models/entry_model.dart';

class CustomerScreen extends StatefulWidget {
  final String customerId;

  const CustomerScreen({super.key, required this.customerId});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  late Customer customer;
  late List<Entry> entries;

  @override
  void initState() {
    super.initState();
    customer = customers.firstWhere((c) => c.id == widget.customerId);
    entries = customerEntries[widget.customerId] ?? [];
  }

  void _addTransaction() {
    final amountController = TextEditingController();
    bool isCredit = true;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Transaction'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Type: '),
                const SizedBox(width: 10),
                DropdownButton<bool>(
                  value: isCredit,
                  items: const [
                    DropdownMenuItem(
                      value: true,
                      child: Text('Credit'),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Text('Debit'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        isCredit = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () {
                final amount = int.tryParse(amountController.text);
                if (amount != null) {
                  // Add entry
                  final newEntry = Entry(
                    id: DateTime.now().toString(),
                    amount: amount,
                    isCredit: isCredit,
                    date: DateTime.now(),
                  );

                  setState(() {
                    entries.add(newEntry);
                    // Update balance
                    if (isCredit) {
                      customer = Customer(
                          id: customer.id,
                          name: customer.name,
                          balance: customer.balance + amount);
                      customers[customers.indexWhere(
                          (c) => c.id == customer.id)] = customer;
                    } else {
                      customer = Customer(
                          id: customer.id,
                          name: customer.name,
                          balance: customer.balance - amount);
                      customers[customers.indexWhere(
                          (c) => c.id == customer.id)] = customer;
                    }
                    // Save to map
                    customerEntries[customer.id] = entries;
                  });

                  Navigator.of(ctx).pop();
                }
              },
              child: const Text('Add')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hello, ${customer.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Balance: ₹${customer.balance}',
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Divider(),
            Expanded(
              child: entries.isEmpty
                  ? const Center(child: Text('No transactions yet'))
                  : ListView.builder(
                      itemCount: entries.length,
                      itemBuilder: (ctx, index) {
                        final e = entries[index];
                        return ListTile(
                          leading: Icon(
                            e.isCredit
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: e.isCredit ? Colors.green : Colors.red,
                          ),
                          title: Text(
                              '${e.isCredit ? 'Credit' : 'Debit'} ₹${e.amount}'),
                          subtitle: Text(
                              '${e.date.day}-${e.date.month}-${e.date.year}'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTransaction,
        child: const Icon(Icons.add),
      ),
    );
  }
}