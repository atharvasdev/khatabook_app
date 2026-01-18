import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Screens
import 'screens/customer_register_screen.dart';
import 'screens/customer_home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool isRegistered = prefs.getBool('isRegistered') ?? false;

  runApp(MyApp(isRegistered: isRegistered));
}

class MyApp extends StatelessWidget {
  final bool isRegistered;

  const MyApp({super.key, required this.isRegistered});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KhataBook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: isRegistered
          ? const CustomerHomeScreen()
          : const CustomerRegisterScreen(),
      routes: {
        '/register': (context) => const CustomerRegisterScreen(),
        '/customerHome': (context) => const CustomerHomeScreen(),
      },
    );
  }
}