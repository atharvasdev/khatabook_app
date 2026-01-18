import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  String name = '';
  String phone = '';

  // Dummy data for now (later comes from Firebase)
  int balance = 500;

  final List<Map<String, dynamic>> transactions = [
    {
      'amount': 500,
      'isCredit': true,
      'date': '18 Jan 2026',
    },
    {
      'amount': 200,
      'isCredit': false,
      'date': '17 Jan 2026',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadCustomerData();
  }

  Future<void> _loadCustomerData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      phone = prefs.getString('phone') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KhataBook'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Info
            Text(
              name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              phone,
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // Balance Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Current Balance',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '₹ $balance',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: balance >= 0
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Divider(),

            // Transactions List
            Expanded(
              child: transactions.isEmpty
                  ? const Center(
                      child: Text('No transactions yet'),
                    )
                  : ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final tx = transactions[index];
                        return ListTile(
                          leading: Icon(
                            tx['isCredit']
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: tx['isCredit']
                                ? Colors.green
                                : Colors.red,
                          ),
                          title: Text(
                            tx['isCredit']
                                ? 'Credit ₹${tx['amount']}'
                                : 'Debit ₹${tx['amount']}',
                          ),
                          subtitle: Text(tx['date']),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 10),

            // Info text
            const Center(
              child: Text(
                'Only admin can update transactions',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}