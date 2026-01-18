import 'package:flutter/material.dart';
import '../models/customer_model.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;

  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(customer.name),
        subtitle: Text('Balance: ₹${customer.balance}'),
      ),
    );
  }
}