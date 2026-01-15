import 'package:flutter/material.dart';
import '../models/customer_model.dart';
import '../screens/entries_screen.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;

  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(
          customer.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          '₹ ${customer.balance}',
          style: TextStyle(
            color: customer.balance >= 0 ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => EntriesScreen(customer: customer),
    ),
  );
},
      ),
    );
  }
}