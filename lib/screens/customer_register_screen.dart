import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerRegisterScreen extends StatefulWidget {
  const CustomerRegisterScreen({super.key});

  @override
  State<CustomerRegisterScreen> createState() =>
      _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState extends State<CustomerRegisterScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passkeyController = TextEditingController();

  static const String adminPasskey = "123";

  Future<void> _register() async {
    if (_passkeyController.text != adminPasskey) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid passkey")),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isRegistered", true);
    await prefs.setString("name", _nameController.text);
    await prefs.setString("phone", _phoneController.text);

    Navigator.pushReplacementNamed(context, "/customerHome");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customer Registration")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
            TextField(
              controller: _passkeyController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Passkey"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}