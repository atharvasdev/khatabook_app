import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../widgets/customer_card.dart';
import 'customer_screen.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      CustomerScreen(customerId: customer.id),
                ),
              );
            },
            child: CustomerCard(customer: customer),
          );
        },
      ),
    );
  }
}