import 'package:flutter/material.dart';
import 'customers_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KhataBook')),
      body: Center(
        child: ElevatedButton(
          child: const Text('View Customers'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CustomersScreen()),
            );
          },
        ),
      ),
    );
  }
}