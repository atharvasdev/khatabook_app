import '../models/customer_model.dart';
import '../models/entry_model.dart';

List<Customer> customers = [
  Customer(id: '1', name: 'Rahul', balance: 500),
  Customer(id: '2', name: 'Anjali', balance: 1200),
  Customer(id: '3', name: 'Rohit', balance: 800),
];

Map<String, List<Entry>> customerEntries = {
  '1': [
    Entry(id: 'e1', amount: 500, isCredit: true, date: DateTime.now()),
  ],
  '2': [
    Entry(id: 'e2', amount: 700, isCredit: true, date: DateTime.now()),
    Entry(id: 'e3', amount: 200, isCredit: false, date: DateTime.now()),
  ],
  '3': [
    Entry(id: 'e4', amount: 800, isCredit: true, date: DateTime.now()),
  ],
};