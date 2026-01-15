import 'package:flutter/material.dart';
import '../models/customer_model.dart';
import '../services/local_db_service.dart';
import '../data/dummy_data.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  void _save() async {
    if (_nameController.text.isEmpty) return;

    final newCustomer = Customer(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      // phone: _phoneController.text,
      balance: 0.0, 
    );

    customers.add(newCustomer);
    await LocalDbService.saveCustomers(customers); //
    
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Customer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _save, child: const Text('Save Customer')),
          ],
        ),
      ),
    );
  }
}