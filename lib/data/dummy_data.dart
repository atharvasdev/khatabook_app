import '../models/customer_model.dart';
import '../services/local_db_service.dart'; //

List<Customer> customers = [];

Future<void> loadCustomersFromLocal() async {
  // This calls the static method you wrote in local_db_services.dart
  customers = await LocalDbService.loadCustomers(); 
}