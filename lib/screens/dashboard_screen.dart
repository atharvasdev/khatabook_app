import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import 'add_customer_screen.dart';
import '../widgets/customer_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await loadCustomersFromLocal();
    if (mounted) setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Khatabook')),
      body: customers.isEmpty
          ? const Center(child: Text('No customers found. Add one!'))
          : ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                return CustomerCard(customer: customers[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigates to your screen and refreshes when you come back
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  AddCustomerScreen()),
          );
          _loadData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}