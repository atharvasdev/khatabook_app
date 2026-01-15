import 'package:hive/hive.dart';
import '../models/customer_model.dart';

class LocalDbService {
  static const String customerBoxName = 'customersBox';

  static Future<void> saveCustomers(List<Customer> customers) async {
    final box = await Hive.openBox(customerBoxName);

    final data = customers
        .map((c) => {
              'id': c.id,
              'name': c.name,
              'balance': c.balance,
            })
        .toList();

    await box.put('customers', data);
  }

  static Future<List<Customer>> loadCustomers() async {
    final box = await Hive.openBox(customerBoxName);

    final data = box.get('customers', defaultValue: []);

    return (data as List)
        .map(
          (c) => Customer(
            id: c['id'],
            name: c['name'],
            balance: c['balance'],
          ),
        )
        .toList();
  }
}